Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0881FB154
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 14:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgFPM6B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 16 Jun 2020 08:58:01 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:40599 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgFPM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:58:01 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0462820011;
        Tue, 16 Jun 2020 12:57:57 +0000 (UTC)
Date:   Tue, 16 Jun 2020 14:57:56 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] mtd: rawnand: qcom: fix incorrect masking
 operator, used & instead of |
Message-ID: <20200616145756.4875d0c6@xps13>
In-Reply-To: <20200616115125.74298-1-colin.king@canonical.com>
References: <20200616115125.74298-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Tue, 16 Jun 2020
12:51:25 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the expression (nand_ctrl | BAM_MODE_EN) is always true no
> matter the value of nand_ctrl because the incorrect masking operator
> is being used.  Fix this by using bit-wise & instead of |.

I saw it when reviewing and marked it to solve before applying but it
looks like I forgot to do so. If you don't mind I'll merge this with
the original commit.

> 
> Addresses-Coverity: ("Wrong operator used")
> Fixes: dd0c1fc8de12 ("mtd: rawnand: qcom: set BAM mode only if not set already")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index a3ef4288be27..37d95532ba7e 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2790,7 +2790,7 @@ static int qcom_nandc_setup(struct qcom_nand_controller *nandc)
>  		 * only if it is not in BAM mode. In most cases BAM
>  		 * mode will be enabled in bootloader
>  		 */
> -		if (!(nand_ctrl | BAM_MODE_EN))
> +		if (!(nand_ctrl & BAM_MODE_EN))
>  			nandc_write(nandc, NAND_CTRL, nand_ctrl | BAM_MODE_EN);
>  	} else {
>  		nandc_write(nandc, NAND_FLASH_CHIP_SELECT, DM_EN);

Thanks,
Miquèl
