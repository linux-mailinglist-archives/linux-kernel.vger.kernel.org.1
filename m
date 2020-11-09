Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 113222AB9BC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbgKINMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 08:12:16 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7437 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732554AbgKINMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 08:12:13 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CVBGr1K1Jz756Y;
        Mon,  9 Nov 2020 21:12:04 +0800 (CST)
Received: from [10.174.179.62] (10.174.179.62) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 21:12:03 +0800
Subject: Re: [PATCH] mtd: rawnand: ingenic: remove redundant get_device() in
 ingenic_ecc_get()
To:     <paul@crapouillou.net>, <harveyhuntnexus@gmail.com>,
        <miquel.raynal@bootlin.com>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20201031105439.2304211-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <5d14a96d-3815-c485-46e9-3c580d68f1e4@huawei.com>
Date:   Mon, 9 Nov 2020 21:12:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20201031105439.2304211-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.62]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping..

On 2020/10/31 18:54, Yu Kuai wrote:
> of_find_device_by_node() already takes a reference to the device, and
> ingenic_ecc_release() will drop the reference. So, the get_device() in
> ingenic_ecc_get() is redundand.
> 
> Fixes: 15de8c6efd0e("mtd: rawnand: ingenic: Separate top-level and SoC specific code")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/mtd/nand/raw/ingenic/ingenic_ecc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> index 8e22cd6ec71f..efe0ffe4f1ab 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_ecc.c
> @@ -71,8 +71,6 @@ static struct ingenic_ecc *ingenic_ecc_get(struct device_node *np)
>   	if (!pdev || !platform_get_drvdata(pdev))
>   		return ERR_PTR(-EPROBE_DEFER);
>   
> -	get_device(&pdev->dev);
> -
>   	ecc = platform_get_drvdata(pdev);
>   	clk_prepare_enable(ecc->clk);
>   
> 
