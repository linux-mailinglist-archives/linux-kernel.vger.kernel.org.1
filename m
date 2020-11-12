Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB5A2B0085
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKLHv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:51:25 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A374721D40;
        Thu, 12 Nov 2020 07:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605167485;
        bh=H++voLjw8gNQ+Dq+Pow/iwcpS4sbWJ++caecK3Ys/3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+ARMDQEcHkGj5PIN204gzzNtScCtTqBgH2jXcRHbEmjDx1BCZRQowhKbjrY6gSlJ
         tLfnLOx11RxPTzK6hNvzqiRdvtTha0029SEYqgCYpUUXR32C9OOpy7jO9EzTlu6Edr
         1a99BcmAONXdbuKTK1gjcvgaxSXLj1SySQ7nLDqo=
Date:   Thu, 12 Nov 2020 08:52:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Junyong Sun <sunjy516@gmail.com>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ttyprintk: optimize tpk_close flush code
Message-ID: <X6zptw9Fbd3AKbPy@kroah.com>
References: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604469744-8708-1-git-send-email-sunjunyong@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:02:24PM +0800, Junyong Sun wrote:
> tpk_printk(NULL,0) do nothing but call tpk_flush to
> flush buffer, so why don't use tpk_flush diretcly?
> this is a small optimization.
> 
> Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> ---
>  drivers/char/ttyprintk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 6a0059e..2ce78b3 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -104,7 +104,7 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
>  
>  	spin_lock_irqsave(&tpkp->spinlock, flags);
>  	/* flush tpk_printk buffer */
> -	tpk_printk(NULL, 0);
> +	tpk_flush();

If you do this, then please remove the logic in tpk_flush() that handles
NULL as now that logic will not be needed at all, right?

Also the comment here wouldn't be needed as the code obviously does that
based on the function call being made :)

thanks,

greg k-h
