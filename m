Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61242F6603
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbhANQcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbhANQck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:32:40 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4668C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:32:00 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id j13so3489272pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=u8M1Ty5OLh4UsZ7uFBCWguj8B/eIFjDQpgpp1xwZlPo=;
        b=NQo/sZL27ppZpDKlVtUpimBct9hQKJUXmYUyrXp/j+Op+WuW7lDrShIM2ZrZIbzq/s
         ccJ50DLzl6eEpyqN1WQ7cnK8cQWQRk5gDK0l/vZ7+JDd4gkZLAPKtKqRzjN3MCEcVO3q
         RQ/2M3IDe3UpvDMoCTTJFXzB9X3DhbVeEbZ3kgtpfv/VpnYKjSWCgTi68zRVJaPkFcRn
         E6I+hy/l50GejoBT/OqeepfgE8SgmuPlSIh2CsGw9jrVaJ5i2ENWH3ud50nApaYoM/z4
         tqb8hwKnNof+pXOTYbyqad5VOSj5fBK1DCtk5X0vOpufblQFzMM7HLkTxvejD2f1CeK9
         em4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=u8M1Ty5OLh4UsZ7uFBCWguj8B/eIFjDQpgpp1xwZlPo=;
        b=m/tXRE6Kp8OdSELOLoGw+0kCF5TbNwRQ6urr/uLYfeY7Bf4GmyKNtm6gF+aVrGc9hc
         f6cXuR7QAtckXTCUDS9GYVlq4niYqGKb+2VJXBfTwcsMnxoXxnehLRs1n+lXCcPum8Cn
         DZ1jDqSWzzJxSSaw7MBYwDEerFtb57tbDoEW8Zd/MfyyIxyCKj+rOQ+/EhTQFcTI+rcg
         d6wyEP2o6IbhLoIBlh86RVooJNDO5UiTpkCHMlVfJth2ShLbh6FWmXfSBJ3sIILnEAcI
         Q1w36uXqSe3BecKhZpASgE7E+RmhxswE+x68SnE/KeayPlKUBB/efTDr/qpZ3M/R0N/u
         nyJA==
X-Gm-Message-State: AOAM530EWzml4/R/P9I7cEtqmyAeufRoIqauXgDGk4J3yd1+QRQ1EHDY
        3PlUoHYXH5xCZlD/5peoqzRG
X-Google-Smtp-Source: ABdhPJw4UQdkapz8h0EaMcLjLjRWB+aITeZbyNWwPKy2PG8qgUDVTUgkOI3nRYI2t5CCGPUn7cZ9vw==
X-Received: by 2002:a17:90a:3cc6:: with SMTP id k6mr5742585pjd.204.1610641920066;
        Thu, 14 Jan 2021 08:32:00 -0800 (PST)
Received: from thinkpad ([103.77.37.186])
        by smtp.gmail.com with ESMTPSA id s1sm5402235pfb.103.2021.01.14.08.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 08:31:59 -0800 (PST)
Date:   Thu, 14 Jan 2021 22:01:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Md Sadre Alam <mdalam@codeaurora.org>, richard@nod.at,
        vigneshr@ti.com, boris.brezillon@collabora.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH V3] mtd: rawnand: qcom: update last code word register
Message-ID: <20210114163154.GA76759@thinkpad>
References: <1610251305-20792-1-git-send-email-mdalam@codeaurora.org>
 <20210114165325.3d510355@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210114165325.3d510355@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 04:53:25PM +0100, Miquel Raynal wrote:
> Hello,
> 
> Md Sadre Alam <mdalam@codeaurora.org> wrote on Sun, 10 Jan 2021
> 09:31:45 +0530:
> 
> > From QPIC version 2.0 onwards new register got added to
> 
>                                 a
> 
> > read last codeword. This change will update the same.
> 
>        the?           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>                       Please reword this sentence.
> 
> > For first three code word READ_LOCATION_n register will be
> > use.For last code word READ_LOCATION_LAST_CW_n register will be
> > use.
> 
> "For the first three codewords, READ_LOCATION_n registers will be used.
> The last codeword register will be accessed through
> READ_LOCATION_LAST_CW_n."
> 
> Also, please specify what these registers store.
> 
> > Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> 
> Could someone please test this patch?
> 

This is on my TODO list. Will get back to it once I'm back from holidays
or sooner if I find some time in the middle.

Thanks,
Mani

> > ---
> > [V3]
> >  * Added else condition for last code word in update_rw_regs().
> >  drivers/mtd/nand/raw/qcom_nandc.c | 84 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 70 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 667e4bf..50ff6e3 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -48,6 +48,10 @@
> >  #define	NAND_READ_LOCATION_1		0xf24
> >  #define	NAND_READ_LOCATION_2		0xf28
> >  #define	NAND_READ_LOCATION_3		0xf2c
> > +#define	NAND_READ_LOCATION_LAST_CW_0	0xf40
> > +#define	NAND_READ_LOCATION_LAST_CW_1	0xf44
> > +#define	NAND_READ_LOCATION_LAST_CW_2	0xf48
> > +#define	NAND_READ_LOCATION_LAST_CW_3	0xf4c
> >  
> >  /* dummy register offsets, used by write_reg_dma */
> >  #define	NAND_DEV_CMD1_RESTORE		0xdead
> > @@ -187,6 +191,12 @@ nandc_set_reg(nandc, NAND_READ_LOCATION_##reg,			\
> >  	      ((size) << READ_LOCATION_SIZE) |			\
> >  	      ((is_last) << READ_LOCATION_LAST))
> >  
> > +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
> > +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
> > +	      ((offset) << READ_LOCATION_OFFSET) |		\
> > +	      ((size) << READ_LOCATION_SIZE) |			\
> > +	      ((is_last) << READ_LOCATION_LAST))
> > +
> >  /*
> >   * Returns the actual register address for all NAND_DEV_ registers
> >   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and NAND_DEV_CMD_VLD)
> > @@ -316,6 +326,10 @@ struct nandc_regs {
> >  	__le32 read_location1;
> >  	__le32 read_location2;
> >  	__le32 read_location3;
> > +	__le32 read_location_last0;
> > +	__le32 read_location_last1;
> > +	__le32 read_location_last2;
> > +	__le32 read_location_last3;
> >  
> >  	__le32 erased_cw_detect_cfg_clr;
> >  	__le32 erased_cw_detect_cfg_set;
> > @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct nandc_regs *regs, int offset)
> >  		return &regs->read_location2;
> >  	case NAND_READ_LOCATION_3:
> >  		return &regs->read_location3;
> > +	case NAND_READ_LOCATION_LAST_CW_0:
> > +		return &regs->read_location_last0;
> > +	case NAND_READ_LOCATION_LAST_CW_1:
> > +		return &regs->read_location_last1;
> > +	case NAND_READ_LOCATION_LAST_CW_2:
> > +		return &regs->read_location_last2;
> > +	case NAND_READ_LOCATION_LAST_CW_3:
> > +		return &regs->read_location_last3;
> >  	default:
> >  		return NULL;
> >  	}
> > @@ -719,9 +741,14 @@ static void update_rw_regs(struct qcom_nand_host *host, int num_cw, bool read)
> >  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
> >  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
> >  
> > -	if (read)
> > -		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> > -				   host->cw_data : host->cw_size, 1);
> > +	if (read) {
> > +		if (nandc->props->qpic_v2)
> > +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
> > +					host->cw_data : host->cw_size, 1);
> > +		else
> > +			nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
> > +					host->cw_data : host->cw_size, 1);
> > +	}
> >  }
> >  
> >  /*
> > @@ -1096,9 +1123,13 @@ static void config_nand_page_read(struct qcom_nand_controller *nandc)
> >  static void
> >  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
> >  {
> > -	if (nandc->props->is_bam)
> > +	if (nandc->props->is_bam) {
> > +		if (nandc->props->qpic_v2)
> > +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
> > +				      1, NAND_BAM_NEXT_SGL);
> >  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
> >  			      NAND_BAM_NEXT_SGL);
> > +	}
> >  
> >  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> >  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> > @@ -1633,16 +1664,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
> >  	}
> >  
> >  	if (nandc->props->is_bam) {
> > -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
> > +		else
> > +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> 
> You repeat many times this logic, a helper to avoid this extra
> indentation level with the if/else block is needed.
> 
> >  		read_loc += data_size1;
> >  
> > -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
> > +		else
> > +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
> >  		read_loc += oob_size1;
> >  
> > -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
> > +		else
> > +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
> >  		read_loc += data_size2;
> >  
> > -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> > +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
> > +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
> > +		else
> > +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> >  	}
> 
> Thanks,
> Miquèl
