Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9FC2EABF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbhAENco convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Jan 2021 08:32:44 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:39497 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAENco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:32:44 -0500
Received: from xps13 (lfbn-tou-1-1535-bdcst.w90-89.abo.wanadoo.fr [90.89.98.255])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id A9B69100018;
        Tue,  5 Jan 2021 13:31:58 +0000 (UTC)
Date:   Tue, 5 Jan 2021 14:31:57 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
        vigneshr@ti.com, sricharan@codeaurora.org
Subject: Re: [PATCH V2] mtd: rawnand: qcom: update last code word register
Message-ID: <20210105143157.6262f7d5@xps13>
In-Reply-To: <1609785078-22310-1-git-send-email-mdalam@codeaurora.org>
References: <1609785078-22310-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Tue,  5 Jan 2021
00:01:18 +0530:

> From QPIC version 2.0 onwards new register got added to
> read last codeword. This change will update the same.
> 
> For first three code word READ_LOCATION_n register will be
> use.For last code wrod READ_LOCATION_LAST_CW_n register will be

s/wrod/word

> use.
> 

Please add a Fixes tag here

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
> [V2]
>  * Fixed alignment for NAND_READ_LOCATION_LAST_CW_n reg macro
>  * Changed number of register write to 1 when NAND_READ_LOCATION_LAST_CW_n register will use
>  drivers/mtd/nand/raw/qcom_nandc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index eaef51d..9e89236 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -48,10 +48,10 @@
>  #define	NAND_READ_LOCATION_1		0xf24
>  #define	NAND_READ_LOCATION_2		0xf28
>  #define	NAND_READ_LOCATION_3		0xf2c
> -#define NAND_READ_LOCATION_LAST_CW_0    0xf40
> -#define NAND_READ_LOCATION_LAST_CW_1    0xf44
> -#define NAND_READ_LOCATION_LAST_CW_2    0xf48
> -#define NAND_READ_LOCATION_LAST_CW_3    0xf4c
> +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
> +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
> +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
> +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c

It looks like you forgot to squash this to you original patch :)

>  
>  /* dummy register offsets, used by write_reg_dma */
>  #define	NAND_DEV_CMD1_RESTORE		0xdead
> @@ -1125,7 +1125,7 @@ config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>  	if (nandc->props->is_bam) {
>  		if (nandc->props->qpic_v2)
>  			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> -				      4, NAND_BAM_NEXT_SGL);
> +				      1, NAND_BAM_NEXT_SGL);
>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>  			      NAND_BAM_NEXT_SGL);
>  	}

Thanks,
Miquèl
