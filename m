Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00D1268CA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgINN50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:57:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39184 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgINNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:55:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EC0iP5130965;
        Mon, 14 Sep 2020 07:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600084844;
        bh=RDHuKPy8mKrjcYu0NQ4FQ0Fc7xmwGprvqmX5xWjnGbs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=muxrOerW8n3EOwJDD2MGefnErXTaO9jA4+nkbijtWShwHXrIZpKabH4P5LwpnPnxW
         PwTo198QOZVtGJfnDgEZL/Owge2250TuFghQhkl4hvw4Ufdw5QSNFFqtsMiQRtmBXx
         vhIvM4BfR6f0P9m9K0A+gpkxnbts72fS8vfV1lPY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08EC0icu121790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Sep 2020 07:00:44 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 07:00:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 07:00:43 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EC0dgP075243;
        Mon, 14 Sep 2020 07:00:40 -0500
Subject: Re: [PATCH 1/3] mtd: spi-nor: sst: fix write support for SST_WRITE
 marked devices
To:     Marco Felsch <m.felsch@pengutronix.de>,
        <tudor.ambarus@microchip.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <sergei.shtylyov@cogentembedded.com>,
        <boris.brezillon@collabora.com>, <michael@walle.cc>,
        <j.neuschaefer@gmx.net>
CC:     <linux-mtd@lists.infradead.org>, <kernel@pengutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20200911144703.25409-1-m.felsch@pengutronix.de>
 <20200911144703.25409-2-m.felsch@pengutronix.de>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <dc80d00a-27a3-6c75-5820-97ad2e297d8e@ti.com>
Date:   Mon, 14 Sep 2020 17:30:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911144703.25409-2-m.felsch@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/20 8:17 PM, Marco Felsch wrote:
> The sst write support for devices using the special SST_WRITE routine
> is broken since commit commit df5c21002cf4 ("mtd: spi-nor: use spi-mem
> dirmap API") because the spi_nor_create_write_dirmap() function checks
> SPINOR_OP_AAI_WP and sst_write_second. These checks are not valid during
> probe. The check seems also to be broken since the "op->addr.nbytes = 0"
> causes the devm_spi_mem_dirmap_create() function to return
> PTR_ERR(-EINVAL) and the probe() function will fail.
> 
> It seems that the commit only copy'n'pasted the existing logic. Use the
> correct SST_WRITE flag and return 0 to fix both issues.
> 
> Fixes: df5c21002cf4 ("mtd: spi-nor: use spi-mem dirmap API")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/mtd/spi-nor/core.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 65eff4ce6ab1..31869ac245a8 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3289,15 +3289,21 @@ static int spi_nor_create_write_dirmap(struct spi_nor *nor)
>  	};
>  	struct spi_mem_op *op = &info.op_tmpl;
>  
> +	/*
> +	 * Most SST SPI-NOR's have a special write routine.which should so

s/SPI-NOR/SPI NOR.

> +	 * dirmap.wdesc is not supported for these.

Or How about more readable version:

"Most SST flashes have special sequence for writing data to the flash
and therefore cannot support writes through direct mapping APIs."

> +	 */
> +	if (nor->info->flags & SST_WRITE) {
> +		nor->dirmap.wdesc = NULL;

nor->dirmap.wdesc is known to be NULL at this point. So no need to set
to NULL again.

> +		return 0;
> +	}
> +
>  	/* get transfer protocols. */
>  	op->cmd.buswidth = spi_nor_get_protocol_inst_nbits(nor->write_proto);
>  	op->addr.buswidth = spi_nor_get_protocol_addr_nbits(nor->write_proto);
>  	op->dummy.buswidth = op->addr.buswidth;
>  	op->data.buswidth = spi_nor_get_protocol_data_nbits(nor->write_proto);
>  
> -	if (nor->program_opcode == SPINOR_OP_AAI_WP && nor->sst_write_second)
> -		op->addr.nbytes = 0;
> -
>  	nor->dirmap.wdesc = devm_spi_mem_dirmap_create(nor->dev, nor->spimem,
>  						       &info);
>  	return PTR_ERR_OR_ZERO(nor->dirmap.wdesc);
> 
