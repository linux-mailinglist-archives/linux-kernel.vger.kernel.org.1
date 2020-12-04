Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1271B2CEBE2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgLDKKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:10:51 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35741 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgLDKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:10:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id r18so5981654ljc.2;
        Fri, 04 Dec 2020 02:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Scw0ub4ve9KprT/1LKilbX5flPNn+/KfNgLbs+ev0ro=;
        b=qPR4dBHRWtBktBmNmxPA7axLkSKMv7UkyWY/i5LW3WK/Q4+1bZ85gVEU+HP++gDB7h
         F2+RI5ua8sipNu2bdq5dJk/UVieV29Jyse0WPlD5IFCQPP1o+swhioTr4tkMC/K2sIob
         Uwzhh2PyRc2CTbgFC8YOf4RMIj8VPEpB4g/XfG5Vp6cFXNMFFYX6HnoGuL/hKPVTX0tn
         LERXlVghW8xcAs9X1IMKaq3W2DnW06CZJ8oG9sMIJmDK3I/SsGP0sCbVKHhg/x7hIilR
         OYHcDRk92ozJ//zmmFKTAqGr6zVx0058g5DqmYmz7Cy+eNJuzqjwbienXcZHedQG9ZzK
         retw==
X-Gm-Message-State: AOAM531kcKIcxuRbyU9Ue7Vd9OoS6yGdj8Mjdpp8yHCTIKkH+b63qcwX
        0ahA3tx0AhONHwxSt5S2cjLrkgBP6/UFbg==
X-Google-Smtp-Source: ABdhPJyPorb0Anq450t8S8hFFFtaafSD0yKRf2ssqk/+h9mGf77P+6iaYQ/lpbfszkQxGCALOWdreg==
X-Received: by 2002:a2e:1606:: with SMTP id w6mr3271570ljd.57.1607076601623;
        Fri, 04 Dec 2020 02:10:01 -0800 (PST)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id d19sm1545050lfc.139.2020.12.04.02.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:10:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1kl82r-0005Sp-VL; Fri, 04 Dec 2020 11:10:34 +0100
Date:   Fri, 4 Dec 2020 11:10:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 09/15] usb: serial: io_edgeport: use
 usb_control_msg_recv() and usb_control_msg_send()
Message-ID: <X8oLGdtViazqIKDX@localhost>
References: <20201104064703.15123-1-himadrispandya@gmail.com>
 <20201104064703.15123-10-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104064703.15123-10-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 12:16:57PM +0530, Himadri Pandya wrote:
> The new usb_control_msg_recv() and usb_control_msg_send() nicely wraps
> usb_control_msg() with proper error check. Hence use the wrappers
> instead of calling usb_control_msg() directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
>  drivers/usb/serial/io_edgeport.c | 73 ++++++++++++--------------------
>  1 file changed, 27 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
> index ba5d8df69518..8479d5684af7 100644
> --- a/drivers/usb/serial/io_edgeport.c
> +++ b/drivers/usb/serial/io_edgeport.c
> @@ -568,34 +568,29 @@ static int get_epic_descriptor(struct edgeport_serial *ep)
>  	int result;
>  	struct usb_serial *serial = ep->serial;
>  	struct edgeport_product_info *product_info = &ep->product_info;
> -	struct edge_compatibility_descriptor *epic;
> +	struct edge_compatibility_descriptor epic;
>  	struct edge_compatibility_bits *bits;
>  	struct device *dev = &serial->dev->dev;
>  
>  	ep->is_epic = 0;
>  
> -	epic = kmalloc(sizeof(*epic), GFP_KERNEL);
> -	if (!epic)
> -		return -ENOMEM;
> -
> -	result = usb_control_msg(serial->dev, usb_rcvctrlpipe(serial->dev, 0),
> -				 USB_REQUEST_ION_GET_EPIC_DESC,
> -				 0xC0, 0x00, 0x00,
> -				 epic, sizeof(*epic),
> -				 300);
> -	if (result == sizeof(*epic)) {
> +	result = usb_control_msg_recv(serial->dev, 0,
> +				      USB_REQUEST_ION_GET_EPIC_DESC, 0xC0,
> +				      0x00, 0x00, &epic, sizeof(epic), 300,
> +				      GFP_KERNEL);
> +	if (result) {

Here's another logical error due to the test being inverted, which
results in the uninitialised stack-allocated buffer to be used for debug
printks (potentially leaking stack data) in case of errors.

>  		ep->is_epic = 1;
> -		memcpy(&ep->epic_descriptor, epic, sizeof(*epic));
> +		memcpy(&ep->epic_descriptor, &epic, sizeof(epic));
>  		memset(product_info, 0, sizeof(struct edgeport_product_info));
>  
> -		product_info->NumPorts = epic->NumPorts;
> +		product_info->NumPorts = epic.NumPorts;
>  		product_info->ProdInfoVer = 0;
> -		product_info->FirmwareMajorVersion = epic->MajorVersion;
> -		product_info->FirmwareMinorVersion = epic->MinorVersion;
> -		product_info->FirmwareBuildNumber = epic->BuildNumber;
> -		product_info->iDownloadFile = epic->iDownloadFile;
> -		product_info->EpicVer = epic->EpicVer;
> -		product_info->Epic = epic->Supports;
> +		product_info->FirmwareMajorVersion = epic.MajorVersion;
> +		product_info->FirmwareMinorVersion = epic.MinorVersion;
> +		product_info->FirmwareBuildNumber = epic.BuildNumber;
> +		product_info->iDownloadFile = epic.iDownloadFile;
> +		product_info->EpicVer = epic.EpicVer;
> +		product_info->Epic = epic.Supports;
>  		product_info->ProductId = ION_DEVICE_ID_EDGEPORT_COMPATIBLE;
>  		dump_product_info(ep, product_info);
>  
> @@ -614,16 +609,12 @@ static int get_epic_descriptor(struct edgeport_serial *ep)
>  		dev_dbg(dev, "  IOSPWriteLCR     : %s\n", bits->IOSPWriteLCR	? "TRUE": "FALSE");
>  		dev_dbg(dev, "  IOSPSetBaudRate  : %s\n", bits->IOSPSetBaudRate	? "TRUE": "FALSE");
>  		dev_dbg(dev, "  TrueEdgeport     : %s\n", bits->TrueEdgeport	? "TRUE": "FALSE");
> -
> -		result = 0;
> -	} else if (result >= 0) {
> +	} else {
>  		dev_warn(&serial->interface->dev, "short epic descriptor received: %d\n",
>  			 result);
>  		result = -EIO;

...and the driver now always fails to probe with -EIO.

>  	}
>  
> -	kfree(epic);
> -
>  	return result;
>  }
>  
> @@ -2168,11 +2159,6 @@ static int rom_read(struct usb_serial *serial, __u16 extAddr,
>  {
>  	int result;
>  	__u16 current_length;
> -	unsigned char *transfer_buffer;
> -
> -	transfer_buffer =  kmalloc(64, GFP_KERNEL);
> -	if (!transfer_buffer)
> -		return -ENOMEM;
>  
>  	/* need to split these reads up into 64 byte chunks */
>  	result = 0;
> @@ -2181,25 +2167,18 @@ static int rom_read(struct usb_serial *serial, __u16 extAddr,
>  			current_length = 64;
>  		else
>  			current_length = length;
> -		result = usb_control_msg(serial->dev,
> -					usb_rcvctrlpipe(serial->dev, 0),
> -					USB_REQUEST_ION_READ_ROM,
> -					0xC0, addr, extAddr, transfer_buffer,
> -					current_length, 300);
> -		if (result < current_length) {
> -			if (result >= 0)
> -				result = -EIO;
> +		result = usb_control_msg_recv(serial->dev, 0,
> +					      USB_REQUEST_ION_READ_ROM, 0xC0,
> +					      addr, extAddr, data,
> +					      current_length, 300, GFP_KERNEL);
> +		if (result)
>  			break;
> -		}
> -		memcpy(data, transfer_buffer, current_length);
> +
>  		length -= current_length;
>  		addr += current_length;
>  		data += current_length;
>  
> -		result = 0;
>  	}
> -
> -	kfree(transfer_buffer);
>  	return result;
>  }

Here a single allocation of a buffer that get's used repeatedly is
replaced with one allocation per iteration. I suggest leaving this as
is.

Please just drop this patch.

Johan
