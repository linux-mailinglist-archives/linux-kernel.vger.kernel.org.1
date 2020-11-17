Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48CB22B5A03
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKQHDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:03:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQHDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:03:47 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364C3241A7;
        Tue, 17 Nov 2020 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605596626;
        bh=cRePH6Nm3raiXQTH7vJXeE6RGULZOaB6FuGTJ6mWU/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWTiqqkxLdREQx9EBE5d/pls6OCiksEky6lQTcOeAlNo1FZI6zmP3Yj23WHeOZfIE
         ADi95zcSVMwDOy11/ZrJkY+sS/orLBxb4FFZqD9M7ntwoQcqpfP9Mcu0Nhe63MCBko
         inMxYPi9pi5wyUSI+ng3628C0plETDvzOA4O716M=
Date:   Tue, 17 Nov 2020 08:04:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Junyong Sun <sunjy516@gmail.com>
Cc:     arnd@arndb.de, sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ttyprintk: optimize tpk_close flush code
Message-ID: <X7N2A+i22d6sC0lH@kroah.com>
References: <1605579667-16573-1-git-send-email-sunjunyong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605579667-16573-1-git-send-email-sunjunyong@xiaomi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:21:07AM +0800, Junyong Sun wrote:
> tpk_printk(NULL,0) do nothing but call tpk_flush to
> flush buffer, so why don't use tpk_flush diretcly?
> this is a small optimization.
> 
> Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> ---
> changes in v2:
> - rm the flush comment as tpk_flush makes it obvious.
> ---
> ---
>  drivers/char/ttyprintk.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/char/ttyprintk.c b/drivers/char/ttyprintk.c
> index 6a0059e..1f82742 100644
> --- a/drivers/char/ttyprintk.c
> +++ b/drivers/char/ttyprintk.c
> @@ -103,8 +103,7 @@ static void tpk_close(struct tty_struct *tty, struct file *filp)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&tpkp->spinlock, flags);
> -	/* flush tpk_printk buffer */
> -	tpk_printk(NULL, 0);
> +	tpk_flush();
>  	spin_unlock_irqrestore(&tpkp->spinlock, flags);

Why did you not make the change to tpk_printk() as well that I asked you
to?

It is a static function, you control the callers, so the extra "is this
NULL, if so flush" logic makes no sense to keep around anymore, right?

thanks,

greg k-h
