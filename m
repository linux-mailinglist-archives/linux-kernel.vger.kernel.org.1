Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE601E0411
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 02:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbgEYAEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 20:04:51 -0400
Received: from einhorn-mail.in-berlin.de ([217.197.80.20]:47289 "EHLO
        einhorn-mail.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388149AbgEYAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 20:04:51 -0400
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 May 2020 20:04:49 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 04ONtZBW010868
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 25 May 2020 01:55:37 +0200
Date:   Mon, 25 May 2020 01:55:32 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Greg KH <greg@kroah.com>
Cc:     Takashi Sakamoto <o-takashi@sakamocchi.jp>, oscar.carter@gmx.com,
        keescook@chromium.org, kernel-hardening@lists.openwall.com,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, clemens@ladisch.de
Subject: Re: [PATCH v2] firewire-core: remove cast of function callback
Message-ID: <20200525015532.0055f9df@kant>
In-Reply-To: <20200524152301.GB21163@kroah.com>
References: <20200524132048.243223-1-o-takashi@sakamocchi.jp>
        <20200524152301.GB21163@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24 Greg KH wrote:
> On Sun, May 24, 2020 at 10:20:48PM +0900, Takashi Sakamoto wrote:
> > In 1394 OHCI specification, Isochronous Receive DMA context has several
> > modes. One of mode is 'BufferFill' and Linux FireWire stack uses it to
> > receive isochronous packets for multiple isochronous channel as
> > FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL.
> > 
> > The mode is not used by in-kernel driver, while it's available for
> > userspace. The character device driver in firewire-core includes
> > cast of function callback for the mode since the type of callback
> > function is different from the other modes. The case is inconvenient
> > to effort of Control Flow Integrity builds due to
> > -Wcast-function-type warning.
> > 
> > This commit removes the cast. A inline helper function is newly added
> > to initialize isochronous context for the mode. The helper function
> > arranges isochronous context to assign specific callback function
> > after call of existent kernel API. It's noticeable that the number of
> > isochronous channel, speed, the size of header are not required for the
> > mode. The helper function is used for the mode by character device
> > driver instead of direct call of existent kernel API.
> > 
> > Changes in v2:
> >  - unexport helper function
> >  - use inline for helper function
> >  - arrange arguments for helper function
> >  - tested by libhinoko
> > 
> > Reported-by: Oscar Carter <oscar.carter@gmx.com>
> > Reference: https://lore.kernel.org/lkml/20200519173425.4724-1-oscar.carter@gmx.com/
> > Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> > ---
> >  drivers/firewire/core-cdev.c | 40 +++++++++++++++---------------------
> >  include/linux/firewire.h     | 16 +++++++++++++++
> >  2 files changed, 33 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> > index 6e291d8f3a27..7cbf6df34b43 100644
> > --- a/drivers/firewire/core-cdev.c
> > +++ b/drivers/firewire/core-cdev.c
> > @@ -957,7 +957,6 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
> >  {
> >  	struct fw_cdev_create_iso_context *a = &arg->create_iso_context;
> >  	struct fw_iso_context *context;
> > -	fw_iso_callback_t cb;
> >  	int ret;
> >  
> >  	BUILD_BUG_ON(FW_CDEV_ISO_CONTEXT_TRANSMIT != FW_ISO_CONTEXT_TRANSMIT ||
> > @@ -965,32 +964,27 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
> >  		     FW_CDEV_ISO_CONTEXT_RECEIVE_MULTICHANNEL !=
> >  					FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL);
> >  
> > -	switch (a->type) {
> > -	case FW_ISO_CONTEXT_TRANSMIT:
> > -		if (a->speed > SCODE_3200 || a->channel > 63)
> > -			return -EINVAL;
> > -
> > -		cb = iso_callback;
> > -		break;
> > -
> > -	case FW_ISO_CONTEXT_RECEIVE:
> > -		if (a->header_size < 4 || (a->header_size & 3) ||
> > -		    a->channel > 63)
> > -			return -EINVAL;
> > -
> > -		cb = iso_callback;
> > -		break;
> > -
> > -	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
> > -		cb = (fw_iso_callback_t)iso_mc_callback;
> > -		break;
> > +	if (a->type == FW_ISO_CONTEXT_TRANSMIT ||
> > +	    a->type == FW_ISO_CONTEXT_RECEIVE) {
> > +		if (a->type == FW_ISO_CONTEXT_TRANSMIT) {
> > +			if (a->speed > SCODE_3200 || a->channel > 63)
> > +				return -EINVAL;
> > +		} else {
> > +			if (a->header_size < 4 || (a->header_size & 3) ||
> > +			    a->channel > 63)
> > +				return -EINVAL;
> > +		}
> >  
> > -	default:
> > +		context = fw_iso_context_create(client->device->card, a->type,
> > +					a->channel, a->speed, a->header_size,
> > +					iso_callback, client);
> > +	} else if (a->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL) {
> > +		context = fw_iso_mc_context_create(client->device->card,
> > +						   iso_mc_callback, client);
> > +	} else {
> >  		return -EINVAL;
> >  	}
> >  
> > -	context = fw_iso_context_create(client->device->card, a->type,
> > -			a->channel, a->speed, a->header_size, cb, client);
> >  	if (IS_ERR(context))
> >  		return PTR_ERR(context);
> >  	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
> > diff --git a/include/linux/firewire.h b/include/linux/firewire.h
> > index aec8f30ab200..bff08118baaf 100644
> > --- a/include/linux/firewire.h
> > +++ b/include/linux/firewire.h
> > @@ -453,6 +453,22 @@ struct fw_iso_context {
> >  struct fw_iso_context *fw_iso_context_create(struct fw_card *card,
> >  		int type, int channel, int speed, size_t header_size,
> >  		fw_iso_callback_t callback, void *callback_data);
> > +
> > +static inline struct fw_iso_context *fw_iso_mc_context_create(
> > +						struct fw_card *card,
> > +						fw_iso_mc_callback_t callback,
> > +						void *callback_data)
> > +{
> > +	struct fw_iso_context *ctx;
> > +
> > +	ctx = fw_iso_context_create(card, FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL,
> > +				    0, 0, 0, NULL, callback_data);
> > +	if (!IS_ERR(ctx))
> > +		ctx->callback.mc = callback;
> > +
> > +	return ctx;
> > +}  
> 
> Why is this in a .h file?  What's wrong with just putting it in the .c
> file as a static function?  There's no need to make this an inline,
> right?

There is no need for this in a header.
Furthermore, I prefer the original switch statement over the nested if/else.

Here is another proposal; I will resend it later as a proper patch.

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index 719791819c24..bece1b69b43f 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -957,7 +957,6 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 {
 	struct fw_cdev_create_iso_context *a = &arg->create_iso_context;
 	struct fw_iso_context *context;
-	fw_iso_callback_t cb;
 	int ret;
 
 	BUILD_BUG_ON(FW_CDEV_ISO_CONTEXT_TRANSMIT != FW_ISO_CONTEXT_TRANSMIT ||
@@ -969,20 +968,15 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 	case FW_ISO_CONTEXT_TRANSMIT:
 		if (a->speed > SCODE_3200 || a->channel > 63)
 			return -EINVAL;
-
-		cb = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE:
 		if (a->header_size < 4 || (a->header_size & 3) ||
 		    a->channel > 63)
 			return -EINVAL;
-
-		cb = iso_callback;
 		break;
 
 	case FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL:
-		cb = (fw_iso_callback_t)iso_mc_callback;
 		break;
 
 	default:
@@ -990,9 +984,15 @@ static int ioctl_create_iso_context(struct client *client, union ioctl_arg *arg)
 	}
 
 	context = fw_iso_context_create(client->device->card, a->type,
-			a->channel, a->speed, a->header_size, cb, client);
+			a->channel, a->speed, a->header_size, NULL, client);
 	if (IS_ERR(context))
 		return PTR_ERR(context);
+
+	if (a->type == FW_ISO_CONTEXT_RECEIVE_MULTICHANNEL)
+		context->callback.mc = iso_mc_callback;
+	else
+		context->callback.sc = iso_callback;
+
 	if (client->version < FW_CDEV_VERSION_AUTO_FLUSH_ISO_OVERFLOW)
 		context->drop_overflow_headers = true;
 

-- 
Stefan Richter
-======--=-- -=-= ==--=
http://arcgraph.de/sr/
