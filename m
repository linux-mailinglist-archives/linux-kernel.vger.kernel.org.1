Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890962E9D83
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 19:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhADSzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 13:55:35 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:25939 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbhADSze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:55:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609786513; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=FxqPbIlgEjfAGgnPD1xLn92qP1L1FUWNHpE3mcaaX6Y=;
 b=RWJj7ukDDAuSCOICB07456N3uLmG+OD1/tL0CeaBDIB3mciM94IMxVK4LyAYJh28ZIwvOWOq
 IhFHqCclCRyHqP3PDtfx4KOExfskeFQ+FoHDYHHxdNmzGpRylXxRahWwv5u/OtiTavQPZ95v
 agzZkppjjHgY1+oy5SpgHi8NG+A=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5ff36478b4d9fe55c1142115 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 04 Jan 2021 18:54:48
 GMT
Sender: mdalam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4555BC43464; Mon,  4 Jan 2021 18:54:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mdalam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 151A7C433CA;
        Mon,  4 Jan 2021 18:54:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Jan 2021 00:24:45 +0530
From:   mdalam@codeaurora.org
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, boris.brezillon@collabora.com,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: rawnand: qcom: update last code word register
In-Reply-To: <20201231105303.GI7345@thinkpad>
References: <1608213776-19584-1-git-send-email-mdalam@codeaurora.org>
 <20201231105303.GI7345@thinkpad>
Message-ID: <84dbe5ba193e0da45add2f74d6787bb5@codeaurora.org>
X-Sender: mdalam@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-31 16:23, Manivannan Sadhasivam wrote:
> On Thu, Dec 17, 2020 at 07:32:56PM +0530, Md Sadre Alam wrote:
>> From QPIC version 2.0 onwards new register got added to
>> read last codeword. This change will update the same.
>> 
>> For first three code word READ_LOCATION_n register will be
>> use.For last code wrod READ_LOCATION_LAST_CW_n register will be
>> use.
>> 
>> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
>> ---
>>  drivers/mtd/nand/raw/qcom_nandc.c | 79 
>> +++++++++++++++++++++++++++++++++------
>>  1 file changed, 67 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 667e4bf..eaef51d 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -48,6 +48,10 @@
>>  #define	NAND_READ_LOCATION_1		0xf24
>>  #define	NAND_READ_LOCATION_2		0xf28
>>  #define	NAND_READ_LOCATION_3		0xf2c
>> +#define NAND_READ_LOCATION_LAST_CW_0    0xf40
>> +#define NAND_READ_LOCATION_LAST_CW_1    0xf44
>> +#define NAND_READ_LOCATION_LAST_CW_2    0xf48
>> +#define NAND_READ_LOCATION_LAST_CW_3    0xf4c
> 
> Please keep the alignment as before.
> 
  Fixed alignment in V2 patch
>> 
>>  /* dummy register offsets, used by write_reg_dma */
>>  #define	NAND_DEV_CMD1_RESTORE		0xdead
>> @@ -187,6 +191,12 @@ nandc_set_reg(nandc, 
>> NAND_READ_LOCATION_##reg,			\
>>  	      ((size) << READ_LOCATION_SIZE) |			\
>>  	      ((is_last) << READ_LOCATION_LAST))
>> 
>> +#define nandc_set_read_loc_last(nandc, reg, offset, size, is_last)	\
>> +nandc_set_reg(nandc, NAND_READ_LOCATION_LAST_CW_##reg,			\
>> +	      ((offset) << READ_LOCATION_OFFSET) |		\
>> +	      ((size) << READ_LOCATION_SIZE) |			\
>> +	      ((is_last) << READ_LOCATION_LAST))
>> +
>>  /*
>>   * Returns the actual register address for all NAND_DEV_ registers
>>   * (i.e. NAND_DEV_CMD0, NAND_DEV_CMD1, NAND_DEV_CMD2 and 
>> NAND_DEV_CMD_VLD)
>> @@ -316,6 +326,10 @@ struct nandc_regs {
>>  	__le32 read_location1;
>>  	__le32 read_location2;
>>  	__le32 read_location3;
>> +	__le32 read_location_last0;
>> +	__le32 read_location_last1;
>> +	__le32 read_location_last2;
>> +	__le32 read_location_last3;
>> 
>>  	__le32 erased_cw_detect_cfg_clr;
>>  	__le32 erased_cw_detect_cfg_set;
>> @@ -644,6 +658,14 @@ static __le32 *offset_to_nandc_reg(struct 
>> nandc_regs *regs, int offset)
>>  		return &regs->read_location2;
>>  	case NAND_READ_LOCATION_3:
>>  		return &regs->read_location3;
>> +	case NAND_READ_LOCATION_LAST_CW_0:
>> +		return &regs->read_location_last0;
>> +	case NAND_READ_LOCATION_LAST_CW_1:
>> +		return &regs->read_location_last1;
>> +	case NAND_READ_LOCATION_LAST_CW_2:
>> +		return &regs->read_location_last2;
>> +	case NAND_READ_LOCATION_LAST_CW_3:
>> +		return &regs->read_location_last3;
>>  	default:
>>  		return NULL;
>>  	}
>> @@ -719,9 +741,13 @@ static void update_rw_regs(struct qcom_nand_host 
>> *host, int num_cw, bool read)
>>  	nandc_set_reg(nandc, NAND_READ_STATUS, host->clrreadstatus);
>>  	nandc_set_reg(nandc, NAND_EXEC_CMD, 1);
>> 
>> -	if (read)
>> +	if (read) {
>> +		if (nandc->props->qpic_v2)
>> +			nandc_set_read_loc_last(nandc, 0, 0, host->use_ecc ?
>> +					host->cw_data : host->cw_size, 1);
> 
> Forgot to add else? Otherwise both NAND_READ_LOCATION_n and
> NAND_READ_LOCATION_LAST_CW_n
> will be used.

   Here else is not needed , because to read last code word we need to 
configure
   NAND_READ_LOCATION_LAST_CW_n register. Any way here we are doing only 
register configuration.
   for all the code words. Earlier version of QPIC we were using  
nandc_set_read_loc()
   for all the code words, but in qpic V2 onwards for last code word we 
have to use
   NAND_READ_LOCATION_LAST_CW_n register. So configuring here the same.


> 
>>  		nandc_set_read_loc(nandc, 0, 0, host->use_ecc ?
>>  				   host->cw_data : host->cw_size, 1);
>> +	}
>>  }
>> 
>>  /*
>> @@ -1096,9 +1122,13 @@ static void config_nand_page_read(struct 
>> qcom_nand_controller *nandc)
>>  static void
>>  config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>>  {
>> -	if (nandc->props->is_bam)
>> +	if (nandc->props->is_bam) {
>> +		if (nandc->props->qpic_v2)
>> +			write_reg_dma(nandc, NAND_READ_LOCATION_LAST_CW_0,
>> +				      4, NAND_BAM_NEXT_SGL);
>>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>>  			      NAND_BAM_NEXT_SGL);
> 
> Don't you need to modify the number of registers to write? It can't be 
> 4 all the
> time if NAND_READ_LOCATION_LAST_CW_0 is used.

   Changed number of registers to write from 4 to 1 in V2 patch for 
register NAND_READ_LOCATION_LAST_CW_0 .
> 
>> +	}
>> 
>>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> @@ -1633,16 +1663,28 @@ qcom_nandc_read_cw_raw(struct mtd_info *mtd, 
>> struct nand_chip *chip,
>>  	}
>> 
>>  	if (nandc->props->is_bam) {
>> -		nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 0, read_loc, data_size1, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 0, read_loc, data_size1, 0);
> 
> IIUC nandc_set_read_loc_last() is only needed to read the last codeword 
> which is
> handled by the last command in this function:

   Function qcom_nandc_read_cw_raw() is getting called for each code word 
for raw read and its reading
   one code word at a time. So to read last code word when condition cw 
== (ecc->steps - 1) will match, we have
   to configure NAND_READ_LOCATION_LAST_CW_n register. Because below 
piece of code is doing one code word
   read for first three code word so same logic will also apply for last 
code word as well.

> 
> nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
> 
>>  		read_loc += data_size1;
>> 
>> -		nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 1, read_loc, oob_size1, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 1, read_loc, oob_size1, 0);
>>  		read_loc += oob_size1;
>> 
>> -		nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 2, read_loc, data_size2, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 2, read_loc, data_size2, 0);
>>  		read_loc += data_size2;
>> 
>> -		nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>> +		if (nandc->props->qpic_v2 && cw == (ecc->steps - 1))
>> +			nandc_set_read_loc_last(nandc, 3, read_loc, oob_size2, 0);
>> +		else
>> +			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>>  	}
>> 
>>  	config_nand_cw_read(nandc, false);
>> @@ -1873,14 +1915,27 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>> 
>>  		if (nandc->props->is_bam) {
>>  			if (data_buf && oob_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> -				nandc_set_read_loc(nandc, 1, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1)) {
>> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 0);
> 
> Why do you need this? Can't you use nandc_set_read_loc()? Same for 
> below cases.

   Here we are looping for all the code words and when we will do 
configuration for last
   code word we have to use NAND_READ_LOCATION_LAST_CW_n register that's 
why i am using
   nandc_set_read_loc_last() instead of nandc_set_read_loc().
> 
> Thanks,
> Mani
> 
>> +					nandc_set_read_loc_last(nandc, 1, data_size,
>> +								oob_size, 1);
>> +				} else {
>> +					nandc_set_read_loc(nandc, 0, 0, data_size, 0);
>> +					nandc_set_read_loc(nandc, 1, data_size,
>> +							   oob_size, 1);
>> +				}
>>  			} else if (data_buf) {
>> -				nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc_last(nandc, 0, 0, data_size, 1);
>> +				else
>> +					nandc_set_read_loc(nandc, 0, 0, data_size, 1);
>>  			} else {
>> -				nandc_set_read_loc(nandc, 0, data_size,
>> -						   oob_size, 1);
>> +				if (nandc->props->qpic_v2 && i == (ecc->steps - 1))
>> +					nandc_set_read_loc_last(nandc, 0, data_size,
>> +								oob_size, 1);
>> +				else
>> +					nandc_set_read_loc(nandc, 0, data_size,
>> +							   oob_size, 1);
>>  			}
>>  		}
>> 
>> --
>> 2.7.4
>> 
