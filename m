Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0C62F463C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAMIOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbhAMIOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:14:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 226E72333B;
        Wed, 13 Jan 2021 08:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610525646;
        bh=l6CuHq4+9qsep0eDFA7g1NKtLaA3YingdmHMtCFBEqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JT8pMbqIqd4+nyaVucfSvDJlKZ9G9ZAiG5qxM7XCTsGDj/4zBguw0AzgCPC8lDJ+X
         /ZZShJWvRL9KGvTq8aEOOnU1DbWmrEKahy+9N3/hyAV26w38wj3I3jzlOCp+s8T2EZ
         MCLen7gKBgQUquO7anVgIeUA3uZQPCyjuxK33qSk=
Date:   Wed, 13 Jan 2021 09:14:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jin Chen Xin <cx.jin@cn.digi-group.com>
Cc:     Johan Hovold <johan@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
Message-ID: <X/6ryenJBM+seTiw@kroah.com>
References: <HK0PR06MB38255C7062AD2A1F578AE7459FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR06MB38255C7062AD2A1F578AE7459FA90@HK0PR06MB3825.apcprd06.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 08:02:33AM +0000, Jin Chen Xin wrote:
> 
> From 1df119cfa105383a0e047a68602b3a9dc4f81c3c Mon Sep 17 00:00:00 2001
> From: Jin Chen-Xin <cx.jin@cn.digi-group.com>
> Date: Wed, 13 Jan 2021 14:09:07 +0800
> Subject: [PATCH] drivers: add new VID/PID for supporting Teraoka AD2000
> 
> Teraoka AD2000 uses the CP210x driver, but the chip VID/PID is
> customized with 0988/0578. We need the driver to support the new VID/PID.
> 
> Signed-off-by: Jin Chen-Xin <cx.jin@cn.digi-group.com>
> ---
>  drivers/usb/serial/cp210x.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10df..c274cc3 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -234,6 +234,7 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  { USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
>  { USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
>  { USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
> +{ USB_DEVICE(0x0988, 0x0578) }, /* Teraoka AD2000 */
>  { } /* Terminating Entry */
>  };
> 
> --
> 1.8.3.1
> 
> 
> 
> 
> Best Regards,
> 
> Jin Chen-Xin
> Software Development Dept.
> Shanghai Teraoka Electronic Co., Ltd.
> 
> * The information contained in this message is intended for the use of the individuals to whom it is addressed and may contain information that is privileged and confidential. If you have received this email by mistake, please discard this email immediately. Do not disclose, forward or copy.
> * 信息安全声明：本邮件(包括其任何附件）的信息，仅用于邮件列出的接收者使用，并且可能包含有特许和机密的信息。如果您误收到这封电子邮件，请通知发件人，并立即删除它，请勿透露、转发或复制。

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
