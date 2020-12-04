Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160812CEFE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgLDOlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:41:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42009 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgLDOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:41:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so7915276lfd.9;
        Fri, 04 Dec 2020 06:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ln9r0T1F2OcwQjbj1D1NhN77qdiGK2MbPyg3XcSXKac=;
        b=fF4tvRS2FqZq+G+VANKlvuGuPy051H8/5Ejs8H+bvGf4d8b0NuRvuYRhGrKV1y1C7m
         QBDxySMeN2N1oQdY8uOO25IoPqnVG3xKlyBNpOgxZrjFQWA1dFsARM5tnTiufbTJOCvS
         8W92BecuKyyBuEdmjlHf0WMkSG1b2NCwVNsF0jp4gABj+F4jr63dsAMo85jfj4dLKOEj
         GIJRqHBABUvOyr2pydwoin47vcNat6bpp67r+W0Pj74YRZ0n2cOJ44Ex6SxDM37HMnir
         r0u7DMceRNUnQnhu5zGuaooUvR/TdnEt0X7frn6kEtWHAzoh1tfdpZu3ZCa4SKuyz4Ve
         yXRw==
X-Gm-Message-State: AOAM532dziSZuHalD9IZbtn7/DlytH8+Nms2aXHIMEiLK/AWpa8Yc8jA
        3uPiN/pwGWFYUv1aQCw2PC9xQAW0NP0wyg==
X-Google-Smtp-Source: ABdhPJxTwGN3a80WQjzN5utWFowJQyCZfOUEgGPCmcO1RAWk2xkMbjXumn7+vBubJCXvlTcVgPO3jg==
X-Received: by 2002:a19:ac07:: with SMTP id g7mr3469715lfc.125.1607092857473;
        Fri, 04 Dec 2020 06:40:57 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id m13sm1739396lfb.14.2020.12.04.06.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:40:56 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1klCH4-0005LJ-TA; Fri, 04 Dec 2020 15:41:30 +0100
Date:   Fri, 4 Dec 2020 15:41:30 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/15] usb: misc: emi26: update to use
 usb_control_msg_send()
Message-ID: <X8pKmmdvO0cIQXnL@localhost>
References: <20201130011819.2576481-1-anant.thazhemadam@gmail.com>
 <20201130012847.2579463-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130012847.2579463-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 06:58:47AM +0530, Anant Thazhemadam wrote:
> The newer usb_control_msg_{send|recv}() API are an improvement on the
> existing usb_control_msg() as it ensures that a short read/write is treated
> as an error,

Short writes have always been treated as an error. The new send helper
only changes the return value from the transfer size to 0.

And this driver never reads.

Try to describe the motivation for changing this driver which is to
avoid the explicit kmemdup().

> data can be used off the stack, and raw usb pipes need not be
> created in the calling functions.
> For this reason, the instance of usb_control_msg() has been replaced with
> usb_control_msg_send() appropriately.
> 
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---
>  drivers/usb/misc/emi26.c | 31 ++++++++-----------------------
>  1 file changed, 8 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/usb/misc/emi26.c b/drivers/usb/misc/emi26.c
> index 24d841850e05..1dd024507f40 100644
> --- a/drivers/usb/misc/emi26.c
> +++ b/drivers/usb/misc/emi26.c
> @@ -27,7 +27,7 @@
>  #define INTERNAL_RAM(address)   (address <= MAX_INTERNAL_ADDRESS)
>  
>  static int emi26_writememory( struct usb_device *dev, int address,
> -			      const unsigned char *data, int length,
> +			      const void *data, int length,

Why is this needed?

>  			      __u8 bRequest);
>  static int emi26_set_reset(struct usb_device *dev, unsigned char reset_bit);
>  static int emi26_load_firmware (struct usb_device *dev);
> @@ -35,22 +35,12 @@ static int emi26_probe(struct usb_interface *intf, const struct usb_device_id *i
>  static void emi26_disconnect(struct usb_interface *intf);
>  
>  /* thanks to drivers/usb/serial/keyspan_pda.c code */
> -static int emi26_writememory (struct usb_device *dev, int address,
> -			      const unsigned char *data, int length,
> +static int emi26_writememory(struct usb_device *dev, int address,
> +			      const void *data, int length,
>  			      __u8 request)
>  {
> -	int result;
> -	unsigned char *buffer =  kmemdup(data, length, GFP_KERNEL);
> -
> -	if (!buffer) {
> -		dev_err(&dev->dev, "kmalloc(%d) failed.\n", length);
> -		return -ENOMEM;
> -	}
> -	/* Note: usb_control_msg returns negative value on error or length of the
> -	 * 		 data that was written! */
> -	result = usb_control_msg (dev, usb_sndctrlpipe(dev, 0), request, 0x40, address, 0, buffer, length, 300);
> -	kfree (buffer);
> -	return result;
> +	return usb_control_msg_send(dev, 0, request, 0x40, address, 0,
> +				    data, length, 300, GFP_KERNEL);

So you're changing the return value on success from length to 0 here.
Did you make sure that all callers can handle that?

>  }
>  
>  /* thanks to drivers/usb/serial/keyspan_pda.c code */
> @@ -77,11 +67,7 @@ static int emi26_load_firmware (struct usb_device *dev)
>  	int err = -ENOMEM;
>  	int i;
>  	__u32 addr;	/* Address to write */
> -	__u8 *buf;
> -
> -	buf = kmalloc(FW_LOAD_SIZE, GFP_KERNEL);
> -	if (!buf)
> -		goto wraperr;
> +	__u8 buf[FW_LOAD_SIZE];

As the build bots reported, you must not put large structures like this
on the stack.

>  
>  	err = request_ihex_firmware(&loader_fw, "emi26/loader.fw", &dev->dev);
>  	if (err)
> @@ -133,11 +119,11 @@ static int emi26_load_firmware (struct usb_device *dev)
>  
>  		/* intel hex records are terminated with type 0 element */
>  		while (rec && (i + be16_to_cpu(rec->len) < FW_LOAD_SIZE)) {
> -			memcpy(buf + i, rec->data, be16_to_cpu(rec->len));
> +			memcpy(&buf[i], rec->data, be16_to_cpu(rec->len));
>  			i += be16_to_cpu(rec->len);
>  			rec = ihex_next_binrec(rec);
>  		}
> -		err = emi26_writememory(dev, addr, buf, i, ANCHOR_LOAD_FPGA);
> +		err = emi26_writememory(dev, addr, &buf, i, ANCHOR_LOAD_FPGA);
>  		if (err < 0)
>  			goto wraperr;
>  	} while (rec);
> @@ -211,7 +197,6 @@ static int emi26_load_firmware (struct usb_device *dev)
>  	release_firmware(bitstream_fw);
>  	release_firmware(firmware_fw);
>  
> -	kfree(buf);
>  	return err;
>  }

Looks good otherwise.

Johan
