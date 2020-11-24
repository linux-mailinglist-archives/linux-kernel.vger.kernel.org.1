Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30912C20F2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 10:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgKXJNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbgKXJNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:13:52 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDA4C0613D6;
        Tue, 24 Nov 2020 01:13:51 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so27866481lfc.4;
        Tue, 24 Nov 2020 01:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fIukb1V/mzn93MU1dQnXMsPLeNbtxaANkhBLdUp3br0=;
        b=Cs3k1SZ7ifHsNVz0CZW36NkPQFd0rGwgER9f8cZGQQko1ikOKhr4QWnWr7eWc7Yzfc
         MDtohI4WKe5AtxCJOwRVbfnbEqWzt6iwZKRcsWl6Zntdve4L6np4Ltdc8UA1Ybq4Vx+f
         jkTbfww4FtxD1tOa71zcmihcXFm1DoAyCkty0gzyYBGMpTbPJHxtlmGYgnyZCvOg7WwG
         /OEiGh7E4T52ddQQ33opkEjHCbtbasseciyiYlm9rrkUzHsQog+59kJpgL/e/JVl9bZ2
         Q9bgzkKdhB0y23+hR20ySeSipeqIN5ffi6/V9lvozoC6G/epREtERZS8gD3NrAhsfq5E
         gy1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=fIukb1V/mzn93MU1dQnXMsPLeNbtxaANkhBLdUp3br0=;
        b=A5/2/CYeKhVCmukyL2KJH50MYdLk5UbvMDpN2DmjzCk5PLTJyn62IsgKEZJUo3lKI6
         ISvRvUu3c/Gpdbl8rq1eS61nhVRZO3H5xkSzlMS/WSY3KTz1K/sPSH5M9CkTmYKxT08v
         mcsaKHsFqk/0kgnJa7VnjcuriYyw44apCBFza+2Hes4QUC/Q6SJ3J5gXmYmvIIaA+C3z
         08IA9giUMgGwD4R7Rj1mNdApyEO0FltV/T+kQfXBSVjRrCCOifbBf4VVHsjcnFjDk02y
         O7OTdXQTpwo05rfT7Fw8i9GvF7ga3y309dSNChVpcwIMoES1v2E6bY4SZ5lvMHAmDPmX
         rbtQ==
X-Gm-Message-State: AOAM533gNbsz9I4NHmbIdHlaTF2pf7OtSxUAe8Dj5/81JozTgv/x5lPt
        zyIovb/uWYQvBQDlqqEpWTs=
X-Google-Smtp-Source: ABdhPJxbyG0352c86lWvNDZnJDqhA2YOWXcRsyfKquJjBhPyD4Ni9BJBwtvNNPtm+8dxHSAwjj+CPw==
X-Received: by 2002:a19:7b06:: with SMTP id w6mr1484289lfc.260.1606209230293;
        Tue, 24 Nov 2020 01:13:50 -0800 (PST)
Received: from ?IPv6:2a00:1fa0:42b3:ccad:a982:d97f:90ed:ada1? ([2a00:1fa0:42b3:ccad:a982:d97f:90ed:ada1])
        by smtp.gmail.com with ESMTPSA id 6sm253081ljr.127.2020.11.24.01.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:13:49 -0800 (PST)
Subject: Re: [PATCH v3] usb: musb: remove unused variable 'devctl'
To:     min.guo@mediatek.com, Bin Liu <b-liu@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20201124084955.30270-1-min.guo@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <c2f3f643-8514-5c4a-dd52-7abc8a6dc501@gmail.com>
Date:   Tue, 24 Nov 2020 12:13:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201124084955.30270-1-min.guo@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24.11.2020 11:49, min.guo@mediatek.com wrote:

> From: Min Guo <min.guo@mediatek.com>
> 
> Remove unused 'devctl' variable to fix compile warnings:
> 
>      drivers/usb/musb/musbhsdma.c: In function 'dma_controller_irq':
>      drivers/usb/musb/musbhsdma.c:324:8: warning: variable 'devctl' set
>      but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v3
> suggested by Greg Kroah-Hartman:
> Add a comment.
> 
> changes in v2
> suggested by Alan Stern:
> Add void before musb_read to indicate that the register MUSB_DEVCTL
> was intended to be read and discarded.
> ---
>   drivers/usb/musb/musbhsdma.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musbhsdma.c b/drivers/usb/musb/musbhsdma.c
> index 0aacfc8be5a1..2a345b4ad015 100644
> --- a/drivers/usb/musb/musbhsdma.c
> +++ b/drivers/usb/musb/musbhsdma.c
[...]
> @@ -336,7 +334,11 @@ irqreturn_t dma_controller_irq(int irq, void *private_data)
>   						< musb_channel->len) ?
>   					"=> reconfig 0" : "=> complete");
>   
> -				devctl = musb_readb(mbase, MUSB_DEVCTL);
> +				/*
> +				 * Some hardware may need to read the
> +				 * MUSB_DEVCTL register once to take effect.
> +				 */
> +				(void)musb_readb(mbase, MUSB_DEVCTL);

    Hm, forcibly reading DevCtl in the DMA driver... sounds quite 
nonsensically. Lemme take a look...

[...]

MBR, Sergei
