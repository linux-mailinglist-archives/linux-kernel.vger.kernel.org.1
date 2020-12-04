Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988B12CEBE1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgLDKK1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Dec 2020 05:10:27 -0500
Received: from aposti.net ([89.234.176.197]:35670 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729386AbgLDKK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:10:27 -0500
Date:   Fri, 04 Dec 2020 10:09:31 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] memory: jz4780_nemc: Fix potential NULL dereference in
 jz4780_nemc_probe()
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Smith <alex.smith@imgtec.com>,
        linux-kernel@vger.kernel.org
Message-Id: <V78TKQ.5OK7KZA7B4H31@crapouillou.net>
In-Reply-To: <1607070717-32880-1-git-send-email-zhangchangzhong@huawei.com>
References: <1607070717-32880-1-git-send-email-zhangchangzhong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhang,

Le ven. 4 déc. 2020 à 16:31, Zhang Changzhong 
<zhangchangzhong@huawei.com> a écrit :
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t,
> n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
> 
> Fixes: 911a88829725 ("memory: jz4780-nemc: driver for the NEMC on 
> JZ4780 SoCs")
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>  drivers/memory/jz4780-nemc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/memory/jz4780-nemc.c 
> b/drivers/memory/jz4780-nemc.c
> index 3ec5cb0..465ea92 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -291,6 +291,8 @@ static int jz4780_nemc_probe(struct 
> platform_device *pdev)
>  	nemc->dev = dev;
> 
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> 
>  	/*
>  	 * The driver currently only uses the registers up to offset
> --
> 2.9.5
> 


