Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5D1F3D78
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 16:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgFIOCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 9 Jun 2020 10:02:23 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:32987 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:02:22 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E1290240020;
        Tue,  9 Jun 2020 14:02:18 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:02:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
Cc:     richard@nod.at, vigneshr@ti.com, peter.ujfalusi@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] mtd: rawnand: qcom: remove write to unavailable
 register
Message-ID: <20200609160217.0b111883@xps13>
In-Reply-To: <1591701056-3944-2-git-send-email-sivaprak@codeaurora.org>
References: <1591701056-3944-1-git-send-email-sivaprak@codeaurora.org>
        <1591701056-3944-2-git-send-email-sivaprak@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sivaprakash,

Sivaprakash Murugesan <sivaprak@codeaurora.org> wrote on Tue,  9 Jun
2020 16:40:55 +0530:

> SFLASHC_BURST_CFG register is not available on all ipq nand platforms,
> it is available only on ipq8064 devices and the nand controller works
> without configuring these registers in this platform, so register write
> to this can be removed.

Maybe it works because the bootloader is setting the register itself.
What if you use a different bootloader, or the same bootloader without
NAND support?

I don't think this is a proper fix, you should instead have a different
compatible if the IP is not the same and depending on this compatible
do the write, or not.

> 
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 5b11c70..e0afa2c 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -36,7 +36,6 @@
>  #define	NAND_DEV_CMD1			0xa4
>  #define	NAND_DEV_CMD2			0xa8
>  #define	NAND_DEV_CMD_VLD		0xac
> -#define	SFLASHC_BURST_CFG		0xe0
>  #define	NAND_ERASED_CW_DETECT_CFG	0xe8
>  #define	NAND_ERASED_CW_DETECT_STATUS	0xec
>  #define	NAND_EBI2_ECC_BUF_CFG		0xf0
> @@ -2774,7 +2773,6 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  	u32 nand_ctrl;
>  
>  	/* kill onenand */
> -	nandc_write(nandc, SFLASHC_BURST_CFG, 0);
>  	nandc_write(nandc, dev_cmd_reg_addr(nandc, NAND_DEV_CMD_VLD),
>  		    NAND_DEV_CMD_VLD_VAL);
>  

Thanks,
Miquèl
