Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8888D2E7F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 11:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgLaKxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 05:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 05:53:52 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CD3C061573
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 02:53:12 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id j13so5180238pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 02:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FK38+lBYH46YbkwWKBfh4GZnY66BJTZOsbK6+7PCcwk=;
        b=WRd7o+JxNxw3zd3rxugJpx4wKHEQeW+AAaoMFCc5bmI9TyT7jhB1Kv1pCU2jpk6V1/
         jCrw5gS2gDjTVa95BGcwsZexQIIx3Sor2Xo8Ue+cb37MnJGeaFp4WZtoz9Yt+pLaV9zZ
         TKoEk0Y5VvCu4TYvUCdTJs4OwTQ0K1JIxgD1p4oLacKfsSE2UFFyS+ZF8Cf7mqrouxHR
         Y1vzKbsDEkyJcUhaiVgNE06oJjf4kUdMNzNFIRjoe3B6itObMDFKgJlnpiY8aZEPGHWS
         kOPH1qUZI2r/sdVWOssgZ7JzhSiaqOCXrEvBs5Nuf4Fz2nFdvNhND5paAbsNHOa/TxEr
         pSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FK38+lBYH46YbkwWKBfh4GZnY66BJTZOsbK6+7PCcwk=;
        b=fo7r0BKOBhMKXn0uUEPOqIDWEFbbsSAN8l/mK/O02yMMG9M8tWLVKxh67r+OTZWEBS
         AyeeBrE56hf4TOH7RquuSbOpCiPnr3MwieYifpmZLuouMZJ4jrOJZ7+ZtK+1zeQZafi5
         deTmIyJE5liWhy27O95dfbe95lqVBGHW0DfVMa5RRmAqMdAEn+dO4+QLpOpnvggZBHEL
         mgbq/XeuXzifFzG4qqljI2f894Q1DaO0/dp41JWdOgSNUV/bP/OIUZdRhZBoOQSTn3TD
         9qMOHX7A8ATCPokUvio/QYf9U7DyBzUiw/4ISz0eNg9wmKEUei+BDhb/mDZwroGKgR4Z
         5RNQ==
X-Gm-Message-State: AOAM530BFMDpL1XvJbq7DEhC4TdRqEUaLg0l9Uk44wSp+lDnevwPU6rG
        kVHI3EM/xOFw+nJUMMezhCLv6tikFPWM
X-Google-Smtp-Source: ABdhPJyP7cCiZntjBKc5iJucBEdLRlk2Gw58FYRcaCTStMZIiA/e/ulPOwvI/Kc8ic7TR1zoNzRx2w==
X-Received: by 2002:a17:902:b415:b029:dc:42b1:9b26 with SMTP id x21-20020a170902b415b02900dc42b19b26mr41828184plr.71.1609411992055;
        Thu, 31 Dec 2020 02:53:12 -0800 (PST)
Received: from thinkpad ([2409:4072:6d1f:be3b:71a9:d2bf:a32d:897d])
        by smtp.gmail.com with ESMTPSA id 82sm46540887pfv.117.2020.12.31.02.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 02:53:11 -0800 (PST)
Date:   Thu, 31 Dec 2020 16:23:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Md Sadre Alam <mdalam@codeaurora.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20201231105303.GI7345@thinkpad>
References: <1608213776-19584-1-git-send-email-mdalam@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1608213776-19584-1-git-send-email-mdalam@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 07:32:56PM +0530, Md Sadre Alam wrote:
> From QPIC version 2.0 onwards new register got added to
> read last codeword. This change will update the same.
> 
> For first three code word READ_LOCATION_n register will be
> use.For last code wrod READ_LOCATION_LAST_CW_n register will be
> use.
> 
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 79 +++++++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 667e4bf..eaef51d 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -48,6 +48,10 @@
>  #define	NAND_READ_LOCATION_1		0xf24
>  #define	NAND_READ_LOCATION_2		0xf28
>  #define	NAND_READ_LOCATION_3		0xf2c
> +#define NAND_READ_LOCATION_LAST_CW_0    0xf40
> +#define NAND_READ_LOCATION_LAST_CW_1    0xf44
> +#define NAND_READ_LOCATION_LAST_CW_2    0xf48
> +#define NAND_READ_LOCATION_LAST_CW_3    0xf4c

Please keep the alignment as before.

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
> @@ -719,9 +741,13 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>  
> -	if (read)
> +	if (read) {
> +		if (nandc->props->qpic_v2)
> +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
> +					host->cw_data : host->cw_size, 1);

Forgot to add else? Otherwise both NAND_READ_LOCATION_n and NAND_READ_LOCATION_LAST_CW_n
will be used.

>  		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
>  				   host->cw_data : host->cw_size, 1);
> +	}
>  }
>  
>  /*
> @@ -1096,9 +1122,13 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
>  static void
>  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>  {
> -	if (nandc->props->is_bam)
> +	if (nandc->props->is_bam) {
> +		if (nandc->props->qpic_v2)
> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> +				      4, NAND_BAM_NEXT_SGL);
>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>  			      NAND_BAM_NEXT_SGL);

Don't you need to modify the number of registers to write? It can't be 4 all the
time if NAND_READ_LOCATION_LAST_CW_0 is used.

> +	}
>  
>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> @@ -1633,16 +1663,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>  	}
>  
>  	if (nandc->props->is_bam) {
> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> +		else
> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);

IIUC nandc_set_read_loc_last() is only needed to read the last codeword which is
handled by the last command in this function:

nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);

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
>  
>  	config_nand_cw_read(nandc, false);
> @@ -1873,14 +1915,27 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  
>  		if (nandc->props->is_bam) {
>  			if (data_buf && oob_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> -				nandc_set_read_loc(nandc, 1, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);

Why do you need this? Can't you use nandc_set_read_loc()? Same for below cases.

Thanks,
Mani

> +					nandc_set_read_loc_last(nandc, 1, data_size,
> +								oob_size, 1);
> +				} else {
> +					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> +					nandc_set_read_loc(nandc, 1, data_size,
> +							   oob_size, 1);
> +				}
>  			} else if (data_buf) {
> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
> +				else
> +					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>  			} else {
> -				nandc_set_read_loc(nandc, 0, data_size,
> -						   oob_size, 1);
> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> +					nandc_set_read_loc_last(nandc, 0, data_size,
> +								oob_size, 1);
> +				else
> +					nandc_set_read_loc(nandc, 0, data_size,
> +							   oob_size, 1);
>  			}
>  		}
>  
> -- 
> 2.7.4
> 
