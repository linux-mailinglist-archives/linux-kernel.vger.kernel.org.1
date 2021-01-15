Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63F2F7645
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbhAOKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbhAOKJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:09:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC156235F9;
        Fri, 15 Jan 2021 10:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610705345;
        bh=YCRZKjGo3NDgltH8jfVaWbxpdMEgmomysgm2ySjJCXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HzkAYhpP09odiKK+VngzvyjbYmCoR1/6+xHXHiRYhb4t3DW0J17pVDYtLkK9loq9I
         JuC6Sw16OQQfdLdn9Ea5ryydsPEV7/2zyv0Y3RZkynP7Sohyn04y+4niT2F20RZL0t
         djBEgWLHyNj/VtX6B41Jk7d1iwNNpi4BIRMkXK9g=
Date:   Fri, 15 Jan 2021 11:09:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: Use bitwise instead of arithmetic operator
 for flags
Message-ID: <YAFpvgfsR/QSTAg+@kroah.com>
References: <1610705031-20332-1-git-send-email-abaci-bugfix@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1610705031-20332-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 06:03:51PM +0800, Jiapeng Zhong wrote:
> Fix the following coccicheck warning:
> 
> ./drivers/tty/synclink_gt.c:4384:15-16: WARNING: sum of probable
> bitmasks, consider |
> ./drivers/tty/synclink_gt.c:4342:39-40: WARNING: sum of probable
> bitmasks, consider |
> ./drivers/tty/synclink_gt.c:4280:48-49: WARNING: sum of probable
> bitmasks, consider |
> ./drivers/tty/synclink_gt.c:2221:20-21: WARNING: sum of probable
> bitmasks, consider |
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  drivers/tty/synclink_gt.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
> index c0b384e..d302c08 100644
> --- a/drivers/tty/synclink_gt.c
> +++ b/drivers/tty/synclink_gt.c
> @@ -2219,7 +2219,7 @@ static void isr_tdma(struct slgt_info *info)
>  	 */
>  	wr_reg32(info, TDCSR, status);	/* clear pending */
>  
> -	if (status & (BIT5 + BIT4 + BIT3)) {
> +	if (status & (BIT5 | BIT4 | BIT3)) {
>  		// another transmit buffer has completed
>  		// run bottom half to get more send data from user
>  		info->pending_bh |= BH_TRANSMIT;
> @@ -4265,7 +4265,9 @@ static void sync_mode(struct slgt_info *info)
>  	case MGSL_MODE_XSYNC:
>  		val |= BIT15 + BIT13;

Why didn't you also change this line?


>  		break;
> -	case MGSL_MODE_MONOSYNC: val |= BIT14 + BIT13; break;
> +	case MGSL_MODE_MONOSYNC:
> +		val |= BIT14 | BIT13;
> +		break;
>  	case MGSL_MODE_BISYNC:   val |= BIT15; break;
>  	case MGSL_MODE_RAW:      val |= BIT13; break;
>  	}
> @@ -4278,7 +4280,9 @@ static void sync_mode(struct slgt_info *info)
>  	case HDLC_ENCODING_NRZI_MARK:     val |= BIT11; break;
>  	case HDLC_ENCODING_NRZI:          val |= BIT11 + BIT10; break;

Or this line?

Seems like you only changed some of these "warnings", why?

Either fix them all or none :)

thanks,

greg k-h
