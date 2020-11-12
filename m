Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02BD2B0EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 21:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKLUNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgKLUNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 15:13:01 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78A2C0613D1;
        Thu, 12 Nov 2020 12:13:00 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id p12so5031945qtp.7;
        Thu, 12 Nov 2020 12:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jSLiwf45DctnZlDAuzdiBpZq++0HKZoLZ6SkMPPn0Lc=;
        b=T0m21NbnuzVFIlMwyubECMfP9v2p6loVrpJFqHZnT9DLrqu99Qddv9vw4pgOyrXD5x
         2P8Kgh6qTZ4akl7IKVAXVTVnZtNpjD8v8eSapzD+wwXWhX+bF4bKPu86XOYM1HeyoS3I
         ABG39Klv2C3qmEG6YMQYcIJcODxqT7+eZvGXRMFQQS94e94HuRoaEwC+9wgygVhO93OW
         NGiOjtdJ1Tb1ID9UK1NsjXyGzibOVvqbhI4mu0q+k7/w/8iFi+ioW3Nxht1kw7ZbuBqH
         loKv5LTYSJlTxwWEVYpibJO0LbJYLF1yjOdGokCcRpKihGlUYFvnABQdjd4Nyi11djmQ
         WWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSLiwf45DctnZlDAuzdiBpZq++0HKZoLZ6SkMPPn0Lc=;
        b=Q9FNrNd+f9zuU2yI8Xc2jL+I/m1/zJe3DXYRElGQvm1HAMCo8rE6e3bsJVmRADlEJQ
         Kk54nsglo/xif6by/evw3oQpKSyUtF74oRfwTzK4ovLXbx258TreWQS8WE72ris0T4tv
         6Gwz/yXxSWLOTsywz+ysQKQtvrNdY4o5T/1HxYVMb/Y35xpdRNX1FBfWmBzfJxr8sgY4
         ZqZrg+/thDVeAyk0vcGIGxGW+6C7MGNtc/sneNWnYh1quVFerYPAlLNvRkoxJX0DaFLC
         WniNlkLnpWbfwAjeYuqRJV5sNOg+VyndlL7YbmA3laKyjHSAIDEZ0T1GPYXF56yD0q+0
         bUMQ==
X-Gm-Message-State: AOAM532mGOxRiy3xBugjt6dmqzBgxhvVyeknyikWBPSJsNS+4I/je510
        HuPR8NF2OdFynaaVg/XGOgk=
X-Google-Smtp-Source: ABdhPJyww+5zAVmXn72kJFjtR3QIx2kTV6PHDyJEmNwoMrp7p2o5iZ4kKYJgx3pPMDma1yO7B7hWEA==
X-Received: by 2002:ac8:6898:: with SMTP id m24mr901388qtq.157.1605211980076;
        Thu, 12 Nov 2020 12:13:00 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id z26sm5147041qki.40.2020.11.12.12.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:12:58 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:12:57 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: storage: avoid use of uninitialized values in error
 path
Message-ID: <20201112201257.GA1665022@ubuntu-m3-large-x86>
References: <20201112191255.13372-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112191255.13372-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 08:12:55PM +0100, Lukas Bulwahn wrote:
> When usb_stor_bulk_transfer_sglist() returns with USB_STOR_XFER_ERROR, it
> returns without writing to its parameter *act_len.
> 
> Further, the two callers of usb_stor_bulk_transfer_sglist():
> 
>     usb_stor_bulk_srb() and
>     usb_stor_bulk_transfer_sg(),
> 
> use the passed variable partial without checking the return value. Hence,
> the uninitialized value of partial is then used in the further execution
> of those two functions.
> 
> Clang-analyzer detects this potential control and data flow and warns:
> 
>   drivers/usb/storage/transport.c:469:40:
>     warning: The right operand of '-' is a garbage value
>     [clang-analyzer-core.UndefinedBinaryOperatorResult]
>           scsi_set_resid(srb, scsi_bufflen(srb) - partial);
>                                                 ^
> 
>   drivers/usb/storage/transport.c:495:15:
>     warning: Assigned value is garbage or undefined
>     [clang-analyzer-core.uninitialized.Assign]
>                   length_left -= partial;
>                               ^
> 
> When a transfer error occurs, the *act_len value is probably ignored by the
> higher layers. But it won't hurt to set it to a valid number, just in case.
> 
> For the two early-return paths in usb_stor_bulk_transfer_sglist(), the
> amount of data transferred is 0.  So if act_len is not NULL, set *act_len
> to 0 in those paths. That makes clang-analyzer happy.
> 
> Proposal was discussed in this mail thread:
> 
> Link: https://lore.kernel.org/linux-usb/alpine.DEB.2.21.2011112146110.13119@felia/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Assuming that setting it to zero is okay (sounds like it is based on the
other thread), this is a reasonable fix.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on current master and next-20201112
> 
> I did some basic compile testing...
> 
> Alan, Greg, please pick this minor non-urgent clean-up patch.
> 
>  drivers/usb/storage/transport.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> index 238a8088e17f..5eb895b19c55 100644
> --- a/drivers/usb/storage/transport.c
> +++ b/drivers/usb/storage/transport.c
> @@ -416,7 +416,7 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>  
>  	/* don't submit s-g requests during abort processing */
>  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
> -		return USB_STOR_XFER_ERROR;
> +		goto usb_stor_xfer_error;
>  
>  	/* initialize the scatter-gather request block */
>  	usb_stor_dbg(us, "xfer %u bytes, %d entries\n", length, num_sg);
> @@ -424,7 +424,7 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>  			sg, num_sg, length, GFP_NOIO);
>  	if (result) {
>  		usb_stor_dbg(us, "usb_sg_init returned %d\n", result);
> -		return USB_STOR_XFER_ERROR;
> +		goto usb_stor_xfer_error;
>  	}
>  
>  	/*
> @@ -452,6 +452,11 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
>  		*act_len = us->current_sg.bytes;
>  	return interpret_urb_result(us, pipe, length, result,
>  			us->current_sg.bytes);
> +
> +usb_stor_xfer_error:
> +	if (act_len)
> +		*act_len = 0;
> +	return USB_STOR_XFER_ERROR;
>  }
>  
>  /*
> -- 
> 2.17.1
> 
