Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC9A2EAF2B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbhAEPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbhAEPp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:45:58 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 07:45:17 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id h186so18569933pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 07:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wmdq60s18Orob2M8R2n5V4KYQtdV3Yib3WAUX7XuCRA=;
        b=EPG8M9AvrhYIpee+SbG1huXyAy7IrVcW7HAb94w8S4MHsDV4hteSdVk+SDoYNWUbC8
         I3F9JsKXpl3Cr6RR+b4cZkQ6p95idKhI2Yz6EjOl1bwnH11ST2SkT6XSsVgYJq8eNQwI
         icluhOe2Cz+B9z4gIhCPZUzuNtg7fCWdj/WPXckWoUCpo9AXNGRln8bxMO2wgJcDTg5a
         npXs3BSCKeTcoBm9MjfGOj5vgepcHI/3bpNGApLYPoN9kh9VnRbUd3lGDk0H+DWMlJd+
         M5bLKdHYc60m+Qbqn+bUdNoMVRBtKBFY9J1JD3H+kt3hwzMbaQe1SXibpZnIHHZo5qh1
         Tafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wmdq60s18Orob2M8R2n5V4KYQtdV3Yib3WAUX7XuCRA=;
        b=TwAvYMLphK+9a3++is/LfGPd/rjlFh1TtVW0z/P20R1gw/f8kLv/MEVrIJ/NgXIpTq
         DO0VypOMFEZL7xAaLqAjKkO2+/TBRBYLZXrcwZKH3xEwoafaDmJeDVuYGtWaIrBO7xFR
         +l8STDVLOpzoQLjX11YsAIAUfQDwIdXTo3jhZEGe1lincjXqUDNl2pZeDjzWc/UJqUBt
         P/1K+8g8X6y6mhMVk0qcSvXLJi62067AIKzFp97Mixn8nOKxjoqHcxcaCZBHpXLZqD38
         SHygAz+ahApAc18VpOVGUtcec/rNcNDewD+HC9rrARS591O+MZPmnmn8aVSWIt/sEidf
         m9tg==
X-Gm-Message-State: AOAM530nAk17mDf4dOrkTx/lUNgtVaMkP09Rv/7EfQUIDXb2Ze7EjqsC
        QLtqfkhU7Nk74QBjPAi+/o8R
X-Google-Smtp-Source: ABdhPJzORfhImBjPmxTt1LF1joW/a5t1awLr7bRLYIOTk+m8wxsNFjVtWFlAK4mlDeMiMu52703p5w==
X-Received: by 2002:a63:6fce:: with SMTP id k197mr49707959pgc.423.1609861517189;
        Tue, 05 Jan 2021 07:45:17 -0800 (PST)
Received: from thinkpad ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id q9sm186131pgb.82.2021.01.05.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 07:45:16 -0800 (PST)
Date:   Tue, 5 Jan 2021 21:15:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     mdalam@codeaurora.org
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
Message-ID: <20210105154512.GC14794@thinkpad>
References: <1608213776-19584-1-git-send-email-mdalam@codeaurora.org>
 <20201231105303.GI7345@thinkpad>
 <84dbe5ba193e0da45add2f74d6787bb5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84dbe5ba193e0da45add2f74d6787bb5@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 12:24:45AM +0530, mdalam@codeaurora.org wrote:
> On 2020-12-31 16:23, Manivannan Sadhasivam wrote:
> > On Thu, Dec 17, 2020 at 07:32:56PM +0530, Md Sadre Alam wrote:
> > > From QPIC version 2.0 onwards new register got added to
> > > read last codeword. This change will update the same.
> > > 
> > > For first three code word READ_LOCATION_n register will be
> > > use.For last code wrod READ_LOCATION_LAST_CW_n register will be
> > > use.
> > > 
> > > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> > > ---
> > >  drivers/mtd/nand/raw/qcom_nandc.c | 79
> > > +++++++++++++++++++++++++++++++++------
> > >  1 file changed, 67 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> > > b/drivers/mtd/nand/raw/qcom_nandc.c
> > > index 667e4bf..eaef51d 100644
> > > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > > @@ -48,6 +48,10 @@
> > >  #define	NAND_READ_LOCATION_1		0xf24
> > >  #define	NAND_READ_LOCATION_2		0xf28
> > >  #define	NAND_READ_LOCATION_3		0xf2c
> > > +#define NAND_READ_LOCATION_LAST_CW_0    0xf40
> > > +#define NAND_READ_LOCATION_LAST_CW_1    0xf44
> > > +#define NAND_READ_LOCATION_LAST_CW_2    0xf48
> > > +#define NAND_READ_LOCATION_LAST_CW_3    0xf4c
> > 
> > Please keep the alignment as before.
> > 
>  Fixed alignment in V2 patch
> > > 
> > >  /* dummy register offsets, used by write_reg_dma */
> > >  #define	NAND_DEV_CMD1_RESTORE		0xdead
> > > @@ -187,6 +191,12 @@ nandc_set_reg(nandc,
> > > NAND_READ_LOCATION_##reg,			\
> > >  	      ((size) << READ_LOCATION_SIZE) |			\
> > >  	      ((is_last) << READ_LOCATION_LAST))
> > > 
> > > +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
> > > +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
> > > +	      ((offset) << READ_LOCATION_OFFSET) |		\
> > > +	      ((size) << READ_LOCATION_SIZE) |			\
> > > +	      ((is_last) << READ_LOCATION_LAST))
> > > +
> > >  /*
> > >   * Returns the actual register address for all NAND_DEV_ registers
> > >   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and
> > > NAND_DEV_CMD_VLD)
> > > @@ -316,6 +326,10 @@ struct nandc_regs {
> > >  	__le32 read_location1;
> > >  	__le32 read_location2;
> > >  	__le32 read_location3;
> > > +	__le32 read_location_last0;
> > > +	__le32 read_location_last1;
> > > +	__le32 read_location_last2;
> > > +	__le32 read_location_last3;
> > > 
> > >  	__le32 erased_cw_detect_cfg_clr;
> > >  	__le32 erased_cw_detect_cfg_set;
> > > @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct
> > > nandc_regs *regs, int offset)
> > >  		return &regs->read_location2;
> > >  	case NAND_READ_LOCATION_3:
> > >  		return &regs->read_location3;
> > > +	case NAND_READ_LOCATION_LAST_CW_0:
> > > +		return &regs->read_location_last0;
> > > +	case NAND_READ_LOCATION_LAST_CW_1:
> > > +		return &regs->read_location_last1;
> > > +	case NAND_READ_LOCATION_LAST_CW_2:
> > > +		return &regs->read_location_last2;
> > > +	case NAND_READ_LOCATION_LAST_CW_3:
> > > +		return &regs->read_location_last3;
> > >  	default:
> > >  		return NULL;
> > >  	}
> > > @@ -719,9 +741,13 @@ static void update_rw_regs(struct
> > > qcom_nand_host *host, int num_cw, bool read)
> > >  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
> > >  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
> > > 
> > > -	if (read)
> > > +	if (read) {
> > > +		if (nandc->props->qpic_v2)
> > > +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
> > > +					host->cw_data : host->cw_size, 1);
> > 
> > Forgot to add else? Otherwise both NAND_READ_LOCATION_n and
> > NAND_READ_LOCATION_LAST_CW_n
> > will be used.
> 
>   Here else is not needed , because to read last code word we need to
> configure
>   NAND_READ_LOCATION_LAST_CW_n register. Any way here we are doing only
> register configuration.
>   for all the code words. Earlier version of QPIC we were using
> nandc_set_read_loc()
>   for all the code words, but in qpic V2 onwards for last code word we have
> to use
>   NAND_READ_LOCATION_LAST_CW_n register. So configuring here the same.
> 

nandc_set_read_loc() has the last argument "is_last". This is used to convey
whether we need to set READ_LOCATION_LAST bit or not. This is fine for QPIC
IP < 2, but for >=2 we need to use nandc_set_read_loc_last() only. My point
is why do you need to still use nandc_set_read_loc() here for QPIC v2? That's
why I asked you about using else().

> 
> > 
> > >  		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> > >  				   host->cw_data : host->cw_size, 1);
> > > +	}
> > >  }
> > > 
> > >  /*
> > > @@ -1096,9 +1122,13 @@ static void config_nand_page_read(struct
> > > qcom_nand_controller *nandc)
> > >  static void
> > >  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
> > >  {
> > > -	if (nandc->props->is_bam)
> > > +	if (nandc->props->is_bam) {
> > > +		if (nandc->props->qpic_v2)
> > > +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> > > +				      4, NAND_BAM_NEXT_SGL);
> > >  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> > >  			      NAND_BAM_NEXT_SGL);
> > 
> > Don't you need to modify the number of registers to write? It can't be 4
> > all the
> > time if NAND_READ_LOCATION_LAST_CW_0 is used.
> 
>   Changed number of registers to write from 4 to 1 in V2 patch for register
> NAND_READ_LOCATION_LAST_CW_0 .
> > 
> > > +	}
> > > 
> > >  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> > >  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> > > @@ -1633,16 +1663,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd,
> > > struct nand_chip *chip,
> > >  	}
> > > 
> > >  	if (nandc->props->is_bam) {
> > > -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> > > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > > +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> > > +		else
> > > +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> > 
> > IIUC nandc_set_read_loc_last() is only needed to read the last codeword
> > which is
> > handled by the last command in this function:
> 
>   Function qcom_nandc_read_cw_raw() is getting called for each code word for
> raw read and its reading
>   one code word at a time. So to read last code word when condition cw ==
> (ecc->steps - 1) will match, we have
>   to configure NAND_READ_LOCATION_LAST_CW_n register. Because below piece of
> code is doing one code word
>   read for first three code word so same logic will also apply for last code
> word as well.
> 

Fine, but still "cw == (ecc->steps - 1)" will stay same for all comparisions
in this function, right? So why can't you use it only for the last command?

> > 
> > nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> > 
> > >  		read_loc += data_size1;
> > > 
> > > -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> > > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > > +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
> > > +		else
> > > +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> > >  		read_loc += oob_size1;
> > > 
> > > -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> > > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > > +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
> > > +		else
> > > +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> > >  		read_loc += data_size2;
> > > 
> > > -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> > > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > > +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
> > > +		else
> > > +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> > >  	}
> > > 
> > >  	config_nand_cw_read(nandc, false);
> > > @@ -1873,14 +1915,27 @@ static int read_page_ecc(struct
> > > qcom_nand_host *host, u8 *data_buf,
> > > 
> > >  		if (nandc->props->is_bam) {
> > >  			if (data_buf && oob_buf) {
> > > -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> > > -				nandc_set_read_loc(nandc, 1, data_size,
> > > -						   oob_size, 1);
> > > +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
> > > +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
> > 
> > Why do you need this? Can't you use nandc_set_read_loc()? Same for below
> > cases.
> 
>   Here we are looping for all the code words and when we will do
> configuration for last
>   code word we have to use NAND_READ_LOCATION_LAST_CW_n register that's why
> i am using
>   nandc_set_read_loc_last() instead of nandc_set_read_loc().
> > 

Sorry, confused! You are calling nandc_set_read_loc_last() twice and only the
last one has "is_last" flag set. Can you please clarify?

Thanks,
Mani

> > Thanks,
> > Mani
> > 
> > > +					nandc_set_read_loc_last(nandc, 1, data_size,
> > > +								oob_size, 1);
> > > +				} else {
> > > +					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
> > > +					nandc_set_read_loc(nandc, 1, data_size,
> > > +							   oob_size, 1);
> > > +				}
> > >  			} else if (data_buf) {
> > > -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> > > +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> > > +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
> > > +				else
> > > +					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
> > >  			} else {
> > > -				nandc_set_read_loc(nandc, 0, data_size,
> > > -						   oob_size, 1);
> > > +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
> > > +					nandc_set_read_loc_last(nandc, 0, data_size,
> > > +								oob_size, 1);
> > > +				else
> > > +					nandc_set_read_loc(nandc, 0, data_size,
> > > +							   oob_size, 1);
> > >  			}
> > >  		}
> > > 
> > > --
> > > 2.7.4
> > > 
