Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ED02DFBBF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 13:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgLUMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 07:12:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgLUMMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 07:12:30 -0500
Date:   Mon, 21 Dec 2020 13:13:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1608552710;
        bh=lKlYUX1oZ4W0fvXWJJFlZMZRGAtGzH8EwXYJaUKAq5o=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=oq4Wsg0pxlW4i1vtgb9fn+hl8S0mwsBvfvOJytEGqSItmYvtQm8Y3KqKiKiyTR+wh
         RHoi28+KX3e/qwOWfnLk9Ck14eUMkAyeXM1v7nlFj1zJMenrFzHVZYFxArajBk4EMA
         /DcU3vxfqb1tnOnrNISDD/hZewe/GtmmAi0cgKIY=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     zhangqiumiao1@huwei.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        zhangqiumiao <zhangqiumiao1@huawei.com>
Subject: Re: [PATCH] tty: add a check for NULL in con_init
Message-ID: <X+CRTqDQwVYSZQBi@kroah.com>
References: <1608551264-26117-1-git-send-email-zhangqiumiao1@huwei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608551264-26117-1-git-send-email-zhangqiumiao1@huwei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 07:47:44PM +0800, zhangqiumiao1@huwei.com wrote:
> From: zhangqiumiao <zhangqiumiao1@huawei.com>
> 
> Add a check for NULL in con_init in order to make sure kzalloc succeeds.
> 
> Signed-off-by: zhangqiumiao <zhangqiumiao1@huawei.com>
> ---
>  drivers/tty/vt/vt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index d04a162939a4..916f3370a136 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -3486,11 +3486,15 @@ static int __init con_init(void)
> 
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
>  		vc_cons[currcons].d = vc = kzalloc(sizeof(struct vc_data), GFP_NOWAIT);
> +		if (!vc)
> +			return -ENOMEM;
>  		INIT_WORK(&vc_cons[currcons].SAK_work, vc_SAK);
>  		tty_port_init(&vc->port);
>  		visual_init(vc, currcons, 1);
>  		/* Assuming vc->vc_{cols,rows,screenbuf_size} are sane here. */
>  		vc->vc_screenbuf = kzalloc(vc->vc_screenbuf_size, GFP_NOWAIT);
> +		if (!vc->vc_screenbuf)
> +			return -ENOMEM;

Did you try to see what happens if you ever trigger this?

Did you trigger this in real-world situations?

Have you read the old email threads about where people tried to "fix"
this and the problems that ended up happening?  If not, please do so...

Hint, I can not take this as you will NEVER hit this in a real system.

thanks,

greg k-h
