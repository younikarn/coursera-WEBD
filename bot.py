from telegram import Update,Message,ParseMode
from telegram.ext import Updater, CommandHandler, MessageHandler, Filters, CallbackContext
import os
import requests, logging

logging.basicConfig(
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s', level=logging.INFO
)

logger = logging.getLogger(__name__)





def start(update: Update, context: CallbackContext) -> None:
    """Send a message when the command /start is issued."""
    update.message.reply_text("Welcome "+str(update.message['chat']['first_name'])+' Send any Movie/Series name or Press /help to see how to get the magnet link')
    print(update.message)


def help_command(update: Update, context: CallbackContext) -> None:
    """Send a message when the command /help is issued."""
    update.message.reply_text('You can send any movie or series you want like:\n\nAvengers \nThor 2011 \nBreaking Bad S03 \nBreaking Bad S02E03')


def echo(update: Update, context: CallbackContext) -> None:
    """Echo the user message."""
    while True:
        try:
            update.message.reply_text("Searching!!!")
            x = update.message
            y = x['text']
            url = "https://api.sumanjay.cf/torrent/?query=" + str(y)
            z=x['chat']['first_name']
            r = requests.get(url).json()
            break
        except:
            update.message.reply_text("I couldn't find this movie/series please enter again")
            return 
       
    
        
   
    update.message.reply_text(f"{z} Here's Your Search Result for <b>{update.message.text}</b>", parse_mode=ParseMode.HTML)
    # for i in r:
    #     update.message.reply_text(f"Name : {i['name']}  \nmagnet: {i['magnet']} \nsize: {i['size']} ")
    m=0
    
    for i in r:
        if (i['nsfw'] is True):
          
            pass
        elif m <10:
            update.message.reply_text(f"<b>Name</b> :{i['name']} \n\n<b>Size</b>:{i['size']} \n\n<b>Seeder/Leecher</b>: {i['seeder']}/{i['leecher']}\n\n<b>Magnet</b>: <code>{i['magnet']} </code>. ",parse_mode=ParseMode.HTML)
            # update.message.reply_text(text=f"<code> Magnet: {i['magnet']} </code>.", 
            #      parse_mode=ParseMode.HTML)
            m+=1
        else:
            break    
    
    print(update.message)

def capture_image(update: Update , context: CallbackContext ) -> None:
    filename="pic.jpg"
    file_id = update.message.photo[-1].file_id
    newFile = context.bot.get_file(file_id)
    newFile.download(filename)
    
    update.message.reply_text("Yeah i got you image biro")


    
 


def main():
    """Start the bot."""
 
    updater = Updater("1488276379:AAHbb6m7r84E78srPZvFNFqBcfik6wBb-CE", use_context=True)

    dispatcher = updater.dispatcher

    
    dispatcher.add_handler(CommandHandler("start", start))
    dispatcher.add_handler(CommandHandler("help", help_command))

   
    dispatcher.add_handler(MessageHandler(Filters.text & ~Filters.command, echo))
    dispatcher.add_handler(MessageHandler(Filters.photo, capture_image))

    # Start the Bot
    updater.start_polling()

    # Run the bot until you press Ctrl-C or the process receives SIGINT,
    # SIGTERM or SIGABRT. This should be used most of the time, since
    # start_polling() is non-blocking and will stop the bot gracefully.
    updater.idle()


if __name__ == '__main__':
    main()
