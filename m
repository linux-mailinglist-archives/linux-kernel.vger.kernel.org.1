Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE732EBFD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbhAFOuk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Jan 2021 09:50:40 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56615 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbhAFOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:50:39 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 388DC60006;
        Wed,  6 Jan 2021 14:49:55 +0000 (UTC)
Date:   Wed, 6 Jan 2021 15:49:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] mtd: use resource_size
Message-ID: <20210106154954.4f85ed76@xps13>
In-Reply-To: <20210106131831.301-1-zhengyongjun3@huawei.com>
References: <20210106131831.301-1-zhengyongjun3@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Zheng Yongjun <zhengyongjun3@huawei.com> wrote on Wed, 6 Jan 2021
21:18:31 +0800:

> Use resource_size rather than a verbose computation on
> the end and start fields.

The commit message and the patch content do not match.
  
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/mtd/maps/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/maps/pci.c b/drivers/mtd/maps/pci.c
> index 377ef0fc4e3e..ca00d211e73e 100644
> --- a/drivers/mtd/maps/pci.c
> +++ b/drivers/mtd/maps/pci.c
> @@ -90,8 +90,8 @@ intel_iq80310_init(struct pci_dev *dev, struct map_pci_info *map)
>  	u32 win_base;
>  
>  	map->map.bankwidth = 1;
> -	map->map.read = mtd_pci_read8,
> -	map->map.write = mtd_pci_write8,
> +	map->map.read = mtd_pci_read8;
> +	map->map.write = mtd_pci_write8;
>  
>  	map->map.size     = 0x00800000;
>  	map->base         = ioremap(pci_resource_start(dev, 0),
> @@ -185,8 +185,8 @@ intel_dc21285_init(struct pci_dev *dev, struct map_pci_info *map)
>  		return -ENXIO;
>  
>  	map->map.bankwidth = 4;
> -	map->map.read = mtd_pci_read32,
> -	map->map.write = mtd_pci_write32,
> +	map->map.read = mtd_pci_read32;
> +	map->map.write = mtd_pci_write32;
>  	map->map.size     = len;
>  	map->base         = ioremap(base, len);
>  

Thanks,
Miquèl
