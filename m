Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E03572CA89A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgLAQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:46:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgLAQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:46:56 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E422C206B7;
        Tue,  1 Dec 2020 16:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1606841175;
        bh=FEcMdC/imqGYEoBFQmrLruQ8oKTT6w6fjIK3QuHiCKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sOsRnpBlr1TBXAGXAxUjdCR+P4hY6oK1ZCsLJQC2fcUaQV2Bc9cuSp7mAazuVKDK/
         K9nhhGnww/wn4mHNqKGhb/kFta+Zgl53VVLjqHQH1AHGc3zuBs0Dy+xyIune4A5t52
         T8WbJAkvei1L7QjUwN9wMEPP4/zIyCUMXmTr/Mf0=
Date:   Tue, 1 Dec 2020 17:47:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jiladahe1997 <jiladahe1997@gmail.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, 972931182@qq.com
Subject: Re: [PATCH RESEND] tty/serial/imx: Enable TXEN bit in
 imx_poll_init().
Message-ID: <X8Zznz7950E8R+Ol@kroah.com>
References: <20201201230307.5738-1-972931182@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201230307.5738-1-972931182@qq.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:03:08AM +0800, jiladahe1997 wrote:
> From: Mingrui Ren <jiladahe1997@gmail.com>
> 
> As described in Documentation, poll_init() is called by kgdb to initialize
> hardware which supports both poll_put_char() and poll_get_char().
> 
> It's necessary to enable TXEN bit, otherwise, it will cause hardware fault
> and kernel panic when calling imx_poll_put_char().
> 
> Generally, if use /dev/ttymxc0 as kgdb console as well as system
> console, ttymxc0 is initialized early by system console which does enable
> TXEN bit.But when use /dev/ttymxc1 as kgbd console, ttymxc1 is only
> initialized by imx_poll_init() cannot enable the TXEN bit, which will
> cause kernel panic.
> 
> Signed-off-by: Mingrui Ren <jiladahe1997@gmail.com>
> ---
> Hi, thanks for your reply, and sorry for sending two identical emails.
> The email service I used before seems to have some problems, 
> so I switched to gmail.This is the "correct" version, please check.
> 
>  drivers/tty/serial/imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 43c6d7142fdd..7c665db3d897 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1829,7 +1829,7 @@ static int imx_uart_poll_init(struct uart_port *port)
>  	ucr1 |= UCR1_UARTEN;
>  	ucr1 &= ~(UCR1_TRDYEN | UCR1_RTSDEN | UCR1_RRDYEN);
>  
> -	ucr2 |= UCR2_RXEN;
> +	ucr2 |= UCR2_RXEN|UCR2_TXEN;

Didn't checkpatch complain about this?  Please use ' ' characters around
the '|' character.

thanks,

greg k-h
