Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABB2F6540
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbhANPyK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Jan 2021 10:54:10 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:46091 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhANPyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:54:09 -0500
X-Originating-IP: 86.201.233.230
Received: from xps13 (lfbn-tou-1-151-230.w86-201.abo.wanadoo.fr [86.201.233.230])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4CA576000D;
        Thu, 14 Jan 2021 15:53:26 +0000 (UTC)
Date:   Thu, 14 Jan 2021 16:53:25 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     manivannan.sadhasivam@linaro.org, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
Message-ID: <20210114165325.3d510355@xps13>
In-Reply-To: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
09:31:45 +0530:

> From QPIC version 2.0 onwards new register got added to

                                a

> read last codeword. This change will update the same.

       the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                      Please reword this sentence.

> For first three code word READ_LOCATION_n register will be
> use.For last code word READ_LOCATION_LAST_CW_n register will be
> use.

"For the first three codewords, READ_LOCATION_n registers will be used.
The last codeword register will be accessed through
READ_LOCATION_LAST_CW_n."

Also, please specify what these registers store.

> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>

Could someone please test this patch?

> ---
> [V3]
>  * Added else condition for last code word in update_rw_regs().
>  drivers/mtd/nand/raw/qcom_nandc.c | 84 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 70 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 667e4bf..50ff6e3 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -48,6 +48,10 @@
>  #define	NAND_READ_LOCATION_1		0xf24
>  #define	NAND_READ_LOCATION_2		0xf28
>  #define	NAND_READ_LOCATION_3		0xf2c
> +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
> +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
> +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
> +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
>  
>  /* dummy register offsets, used by write_reg_dma */
>  #define	NAND_DEV_CMD1_RESTORE		0xdead
> @@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
>  	      ((size) << READ_LOCATION_SIZE) |			\
>  	      ((is_last) << READ_LOCATION_LAST))
>  
> +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
> +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
> +	      ((offset) << READ_LOCATION_OFFSET) |		\
> +	      ((size) << READ_LOCATION_SIZE) |			\
> +	      ((is_last) << READ_LOCATION_LAST))
> +
>  /*
>   * Returns the actual register address for all NAND_DEV_ registers
>   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
> @@ -316,6 +326,10 @@ struct nandc_regs {
>  	__le32 read_location1;
>  	__le32 read_location2;
>  	__le32 read_location3;
> +	__le32 read_location_last0;
> +	__le32 read_location_last1;
> +	__le32 read_location_last2;
> +	__le32 read_location_last3;
>  
>  	__le32 erased_cw_detect_cfg_clr;
>  	__le32 erased_cw_detect_cfg_set;
> @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
>  		return &regs->read_location2;
>  	case NAND_READ_LOCATION_3:
>  		return &regs->read_location3;
> +	case NAND_READ_LOCATION_LAST_CW_0:
> +		return &regs->read_location_last0;
> +	case NAND_READ_LOCATION_LAST_CW_1:
> +		return &regs->read_location_last1;
> +	case NAND_READ_LOCATION_LAST_CW_2:
> +		return &regs->read_location_last2;
> +	case NAND_READ_LOCATION_LAST_CW_3:
> +		return &regs->read_location_last3;
>  	default:
>  		return NULL;
>  	}
> @@ -719,9 +741,14 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>  
> -	if (read)
> -		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> -				   host->cw_data : host->cw_size, 1);
> +	if (read) {
> +		if (nandc->props->qpic_v2)
> +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
> +					host->cw_data : host->cw_size, 1);
> +		else
> +			nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> +					host->cw_data : host->cw_size, 1);
> +	}
>  }
>  
>  /*
> @@ -1096,9 +1123,13 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
>  static void
>  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>  {
> -	if (nandc->props->is_bam)
> +	if (nandc->props->is_bam) {
> +		if (nandc->props->qpic_v2)
> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> +				      1, NAND_BAM_NEXT_SGL);
>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>  			      NAND_BAM_NEXT_SGL);
> +	}
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> @@ -1633,16 +1664,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	}
>  
>  	if (nandc->props->is_bam) {
> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> +		else
> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);

You repeat many times this logic, a helper to avoid this extra
indentation level with the if/else block is needed.

>  		read_loc += data_size1;
>  
> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
> +		else
> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>  		read_loc += oob_size1;
>  
> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
> +		else
> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>  		read_loc += data_size2;
>  
> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
> +		else
> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>  	}

Thanks,
Miquèl
