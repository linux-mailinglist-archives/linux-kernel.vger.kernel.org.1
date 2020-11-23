Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADB2C0EC6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgKWP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:26:55 -0500
Received: from netrider.rowland.org ([192.131.102.5]:44181 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S2389490AbgKWP0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:26:55 -0500
Received: (qmail 710166 invoked by uid 1000); 23 Nov 2020 10:26:54 -0500
Date:   Mon, 23 Nov 2020 10:26:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Boero <boeroboy@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <20201123152654.GB708586@rowland.harvard.edu>
References: <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
 <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
 <20201112192524.GB287229@rowland.harvard.edu>
 <CAO5W59hXOHAd_D0K3HnvJmf883e_u+s6oM+DGJMqpr392N5Gww@mail.gmail.com>
 <20201113163449.GB322940@rowland.harvard.edu>
 <CAO5W59iqXGeAQTP7hzzRmbqwZUcK=vwuJ7pFzzNzZ9o11_k2tw@mail.gmail.com>
 <20201113171658.GF322940@rowland.harvard.edu>
 <CAO5W59hRNB0xH1Z2cd17ckYuHp38zL366K_3AuMoH8WTZYatow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59hRNB0xH1Z2cd17ckYuHp38zL366K_3AuMoH8WTZYatow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To recap: The problem is that uvcvideo tries to change an interface 
altsetting (from within uvc_video_start_streaming -> 
uvc_video_start_transfer) after the driver has been unbound from the 
device.  This triggers an invalid memory reference.

On Sun, Nov 22, 2020 at 08:03:43PM +0000, John Boero wrote:
> Thanks Alan
> I just spent some more time investigating and playing with different patches,
> locks, mutexes, and sleeps, and I think I see exactly what's happening now.
> I now understand why it:
> A) seems to happen randomly during uvc start_stream
> B) affects multiple device vendors
> C) has been reported in RaspberryPi and IoT threads
> 
> I put a trace on usb/core/hub.c:usb_disconnect to identify why the device was
> disconnecting and it seems this is a low power issue.  An idle webcam appears
> fine to usbcore but as soon as you initialize it or uvc starts a stream, it
> consumes more power, might find the cable can't supply it, and then disconnects
> via interrupt. In my case I can reproduce this consistently with a cheap USB
> extension cable, but this issue appears common to passive hubs, and IoT or SBCs
> that don't always supply clean power over USB.  My simplified patch can at least
> protect usbcore from crashing on a bad device:
> 
> From 73019d79fe4fd8b2c945005f8a067f528d8056fd Mon Sep 17 00:00:00 2001
> From: jboero <boeroboy@gmail.com>
> Date: Sun, 22 Nov 2020 19:30:41 +0000
> Subject: [PATCH] USBCore NULL interface deref fix
> 
> ---
> drivers/usb/core/usb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
> index bafc113f2b3e..da46c84c87ce 100644
> --- a/drivers/usb/core/usb.c
> +++ b/drivers/usb/core/usb.c
> @@ -278,7 +278,7 @@ struct usb_interface *usb_ifnum_to_if(const struct
> usb_device *dev,
>        if (!config)
>                return NULL;
>        for (i = 0; i < config->desc.bNumInterfaces; i++)
> -               if (config->interface[i]->altsetting[0]
> +               if (config->interface[i] && config->interface[i]->altsetting[0]
>                                .desc.bInterfaceNumber == ifnum)
>                        return config->interface[i];

I really dislike the idea of papering over a problem instead of fixing 
it properly.

> This protects ongoing USB functionality including lsusb, and prevents a hang on
> reboot after error.  It doesn't help a user diagnose the error on the UVC side.
> A fix from the uvc side is a little trickier and I'd like an opinion on how
> best to handle locks in uvc_video_start_transfer. I've tried a few options
> around uvcvideo.c:1874
> 
> ret = usb_set_interface(stream->dev->udev, intfnum, altsetting);
> 
> I've even used multiple msleeps and checked for NULL interfaces but that feels
> like a cheap trick and I was wondering what lock solution might help best here?

Laurent Pinchart is the person to ask.  He is the maintainer of the 
uvcvideo driver.  I know very little about it.

Alan Stern
