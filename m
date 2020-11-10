Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866A62AD164
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKJIik convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 03:38:40 -0500
Received: from aposti.net ([89.234.176.197]:60570 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJIik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:38:40 -0500
Date:   Tue, 10 Nov 2020 08:38:24 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] mtd: rawnand: ingenic: remove redundant get_device() in
 ingenic_ecc_get()
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     harveyhuntnexus@gmail.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Message-Id: <00OKJQ.IYM95XDRFCZI3@crapouillou.net>
In-Reply-To: <20201031105439.2304211-1-yukuai3@huawei.com>
References: <20201031105439.2304211-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 31 oct. 2020 à 18:54, Yu Kuai <yukuai3@huawei.com> a écrit :
> of_find_device_by_node() already takes a reference to the device, and
> ingenic_ecc_release() will drop the reference. So, the get_device() in
> ingenic_ecc_get() is redundand.
> 
> Fixes: 15de8c6efd0e("mtd: rawnand: ingenic: Separate top-level and 
> SoC specific code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks,
-Paul

> ---
>  drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c 
> b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> index 8e22cd6ec71f..efe0ffe4f1ab 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> @@ -71,8 +71,6 @@ static struct ingenic_ecc *ingenic_ecc_get(struct 
> device_node *np)
>  	if (!pdev || !platform_get_drvdata(pdev))
>  		return ERR_PTR(-EPROBE_DEFER);
> 
> -	get_device(&pdev->dev);
> -
>  	ecc = platform_get_drvdata(pdev);
>  	clk_prepare_enable(ecc->clk);
> 
> --
> 2.25.4
> 


