Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14252A17F4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgJaNpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgJaNpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:45:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19591C0617A6;
        Sat, 31 Oct 2020 06:45:41 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id p9so12465569eji.4;
        Sat, 31 Oct 2020 06:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+vChzJQ+4flHvRyJKlk2Uh9VQxych+++R4cwBhR+cB8=;
        b=IJhi4wKMxNjdLH7IlvoZCBa+IM7Zp0fsFGqRMpbQeelHZTIYfp/fniJ4ZTIQwXQdjf
         A4xpk+aHPo0jeJRk7GkuKRhmJmDrWyePuHIyFjeToi+QBGPr+gpBCmTDnA+Upb+lZaCQ
         8fT/MyVVKq2AKl+QiZcG2rw2K6iWdfpfBCO1JSbmYX56gSlUNCfXuWKdTnN0TXJBfUl2
         fGG386B5aJF2E3R+mBGwbsYTxJ+DVHA5sXFtbkMT2rmImq2RluFV7UfdfspS7K50HKmy
         ftf8bP5uZK/Nj2FMbJUytYh/H80qZEbvHkxqynh3GmM/IBbJK0dllLrvNbGgeQVvB/21
         L8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vChzJQ+4flHvRyJKlk2Uh9VQxych+++R4cwBhR+cB8=;
        b=AHj+abICL3+uY5Ii9O6Sr+H8RqzOfrqMARw6BK/i4YY2jx0Cqvd1DgSrFtrPS4qptA
         bP4bVP8uRLc+WYzUUWStbNYlHdfANOVtQL0g9N0lbkP17cWy5vNssijCDyjHlrM0TG2k
         F0lKp0PWhG6mNf7bvPYe8xhbT0WkhIX/aQYm9kKWsyuCfAN+dqdutGCfLZmUxXbDsM2P
         +PKKcUwhwt4toXx5iYL0fbb1bS/zD95dSItnUaCN9m9UhixJQC+Lg2XcgAvWZOADmZiI
         5qfYv35U0nW/FEyFI/+xEszq/esz6qynrjkSa8o0kKvPJxRlGS+7BHybVASV1zpylthF
         G9gA==
X-Gm-Message-State: AOAM530wvJhaHiod94+CWV87SuhQ6rLrzuHrDxozp5oSTaGUJMg6IDUS
        97Io9Gm4t+kQBhH/YzrEsJI=
X-Google-Smtp-Source: ABdhPJx4n4Y6dKr69cZcbBG67TBbDYHjIGaKd1OY4/ExEQKzRvcNRnEn5aF4bqjQCyeafC05mAs5uQ==
X-Received: by 2002:a17:906:444:: with SMTP id e4mr7585761eja.218.1604151939529;
        Sat, 31 Oct 2020 06:45:39 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id h4sm5169254edj.1.2020.10.31.06.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Oct 2020 06:45:39 -0700 (PDT)
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
From:   Johan Jonker <jbx6244@gmail.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
 <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
 <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
Message-ID: <0dabd80e-b281-be65-b8e2-da00f46964fb@gmail.com>
Date:   Sat, 31 Oct 2020 14:45:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

In some functions you deselect the chips.
The MTD frame work has a functions for that and also keeps track of its
select status, so I think that you shouldn't poke with that yourself and
should therefore remove the deselections from your driver.

/**
 * nand_deselect_target() - Deselect the currently selected target
 * @chip: NAND chip object
 *
 * Deselect the currently selected NAND target. The result of operations
 * executed on @chip after the target has been deselected is undefined.
 */
void nand_deselect_target(struct nand_chip *chip)
{
	if (chip->legacy.select_chip)
		chip->legacy.select_chip(chip, -1);

	chip->cur_cs = -1;
}
EXPORT_SYMBOL_GPL(nand_deselect_target);


On 10/31/20 12:58 PM, Johan Jonker wrote:

[..]

> On 10/28/20 10:53 AM, Yifeng Zhao wrote:

[..]

>> +
>> +static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
>> +				 int oob_on, int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	int ret = 0;
>> +	u32 i;
>> +
> 
> 	/*
> 	* Normal timing and ECC layout size setup is already done in
> 	* the rk_nfc_select_chip() function.
> 	*/
> 
> How about the ECC layout size setup for a boot block?
> 
>> +	if (!buf)
>> +		memset(nfc->buffer, 0xff, mtd->writesize + mtd->oobsize);
>> +> +	for (i = 0; i < ecc->steps; i++) {
>> +		/* Copy data to nfc buffer. */
>> +		if (buf)
>> +			memcpy(rk_nfc_data_ptr(chip, i),
>> +			       rk_nfc_buf_to_data_ptr(chip, buf, i),
>> +			       ecc->size);
> 
>> +		/*
>> +		 * The first four bytes of OOB are reserved for the
>> +		 * boot ROM. In some debugging cases, such as with a
>> +		 * read, erase and write back test these 4 bytes stored
>> +		 * in OOB also need to be written back.
>> +		 */
> 
> 
> 	/*
> 	* The first four bytes of OOB are reserved for the
> 	* boot ROM. In some debugging cases, such as with a
> 	* read, erase and write back test these 4 bytes stored
> 	* in OOB also need to be written back.
> 	*
> 	* The function nand_block_bad detects bad blocks like:
> 	*
> 	* bad = chip->oob_poi[chip->badblockpos];
> 	*
> 	* chip->badblockpos == 0 for a large page NAND Flash,
> 	* so chip->oob_poi[0] is the bad block mask (BBM).
> 	*
> 	* The OOB data layout on the NFC is:
> 	*
> 	*   PA0  PA1  PA2  PA3 | BBM OOB1 OOB2 OOB3 | ...
> 	*
> 	* or
> 	*
> 	*  0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
> 	*
> 	* The code here just swaps the first 4 bytes with the last
> 	* 4 bytes without losing any data.
> 	*
> 	* The chip->oob_poi data layout:
> 	*
> 	*   BBM OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
> 	*
> 	* The rk_nfc_ooblayout_free() function already has reserved
> 	* these 4 bytes with:
> 	*
> 	* oob_region->offset = NFC_SYS_DATA_SIZE + 2;
> 	*/
> 
> 
>> +		if (!i)
>> +			memcpy(rk_nfc_oob_ptr(chip, i),
>> +			       rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
>> +			       NFC_SYS_DATA_SIZE);
>> +		else
>> +			memcpy(rk_nfc_oob_ptr(chip, i),
>> +			       rk_nfc_buf_to_oob_ptr(chip, i - 1),
>> +			       NFC_SYS_DATA_SIZE);
>> +		/* Copy ECC data to the NFC buffer. */
>> +		memcpy(rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
>> +		       rk_nfc_buf_to_oob_ecc_ptr(chip, i),
>> +		       ecc->bytes);
>> +	}
>> +
>> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> +	rk_nfc_write_buf(nfc, buf, mtd->writesize + mtd->oobsize);
>> +	ret = nand_prog_page_end_op(chip);
>> +

>> +	/*
>> +	 * Deselect the currently selected target after the ops is done
>> +	 * to reduce the power consumption.
>> +	 */
>> +	rk_nfc_select_chip(chip, -1);
> 
> Does the MTD framework always select again?

Remove.
Do not assume that the MTD framework or user space knows that you have
deselected the chip.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int rk_nfc_write_oob(struct nand_chip *chip, int page)
>> +{
>> +	return rk_nfc_write_page_raw(chip, NULL, 1, page);
>> +}
>> +
>> +static int rk_nfc_write_page_hwecc(struct nand_chip *chip, const u8 *buf,
>> +				   int oob_on, int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
>> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
>> +			NFC_MIN_OOB_PER_STEP;
>> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
>> +	int ret = 0, i, boot_rom_mode = 0;
>> +	dma_addr_t dma_data, dma_oob;
>> +	u32 reg;
>> +	u8 *oob;
>> +
>> +	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> +
>> +	memcpy(nfc->page_buf, buf, mtd->writesize);
>> +
>> +	/*
>> +	 * The first blocks (4, 8 or 16 depending on the device) are used
>> +	 * by the boot ROM and the first 32 bits of OOB need to link to
>> +	 * the next page address in the same block. We can't directly copy
>> +	 * OOB data from the MTD framework, because this page address
>> +	 * conflicts for example with the bad block marker (BBM),
>> +	 * so we shift all OOB data including the BBM with 4 byte positions.
>> +	 * As a consequence the OOB size available to the MTD framework is
>> +	 * also reduced with 4 bytes.
>> +	 *
> 
>> +	 *    PA0 PA1 PA2 PA3 | BBM OOB1 OOB2 OOB3 | ...
> 
> 
> 	 *    PA0  PA1  PA2  PA3 | BBM OOB1 OOB2 OOB3 | ...
> 
> keep layouts aligned
> 
>> +	 *
>> +	 * If a NAND is not a boot medium or the page is not a boot block,
>> +	 * the first 4 bytes are left untouched by writing 0xFF to them.
>> +	 *
>> +	 *   0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
>> +	 *
>> +	 * Configure the ECC algorithm supported by the boot ROM.
>> +	 */
>> +	if ((page < pages_per_blk * rknand->boot_blks) &&
> 
> 	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> 
>> +	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
>> +		boot_rom_mode = 1;
>> +		if (rknand->boot_ecc != ecc->strength)
>> +			rk_nfc_hw_ecc_setup(chip, ecc,
>> +					    rknand->boot_ecc);
>> +	}
>> +
>> +	for (i = 0; i < ecc->steps; i++) {
>> +		if (!i) {
>> +			reg = 0xFFFFFFFF;
>> +		} else {
>> +			oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
>> +			reg = oob[0] | oob[1] << 8 | oob[2] << 16 |
>> +			      oob[3] << 24;
>> +		}
>> +		if (!i && boot_rom_mode)
>> +			reg = (page & (pages_per_blk - 1)) * 4;
>> +
>> +		if (nfc->cfg->type == NFC_V9)
>> +			nfc->oob_buf[i] = reg;
>> +		else
>> +			nfc->oob_buf[i * (oob_step / 4)] = reg;
>> +	}
>> +
>> +	dma_data = dma_map_single(nfc->dev, (void *)nfc->page_buf,
>> +				  mtd->writesize, DMA_TO_DEVICE);
>> +	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
>> +				 ecc->steps * oob_step,
>> +				 DMA_TO_DEVICE);
>> +
>> +	reinit_completion(&nfc->done);
>> +	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
>> +
>> +	rk_nfc_xfer_start(nfc, NFC_WRITE, ecc->steps, dma_data,
>> +			  dma_oob);
>> +	ret = wait_for_completion_timeout(&nfc->done,
>> +					  msecs_to_jiffies(100));
>> +	if (!ret)
>> +		dev_warn(nfc->dev, "write: wait dma done timeout.\n");
>> +	/*
>> +	 * Whether the DMA transfer is completed or not. The driver
>> +	 * needs to check the NFC`s status register to see if the data
>> +	 * transfer was completed.
>> +	 */
>> +	ret = rk_nfc_wait_for_xfer_done(nfc);
>> +
>> +	dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
>> +			 DMA_TO_DEVICE);
>> +	dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
>> +			 DMA_TO_DEVICE);
>> +
> 
>> +	if (boot_rom_mode && rknand->boot_ecc != ecc->strength)
>> +		rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
>> +
> 
>> +	if (ret) {
>> +		ret = -EIO;
>> +		dev_err(nfc->dev,
>> +			"write: wait transfer done timeout.\n");
>> +	}
>> +
> 
>> +	if (ret)
>> +		return ret;
> 
> remove, always deselect
> 
> if (!ret) {
> 
>> +
>> +	ret = nand_prog_page_end_op(chip);
> 
> }
> 

>> +
>> +	/*
>> +	 * Deselect the currently selected target after the ops is done
>> +	 * to reduce the power consumption.
>> +	 */
>> +	rk_nfc_select_chip(chip, -1);
> 
> Does the MTD framework always select again?

Remove.
Do not assume that the MTD framework or user space knows that you have
deselected the chip.

> 
>> +
>> +	return ret;
>> +}
>> +
>> +static int rk_nfc_read_page_raw(struct nand_chip *chip, u8 *buf, int oob_on,
>> +				int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	int i;
>> +
> 
> 	/*
> 	* Normal timing and ECC layout size setup is already done in
> 	* the rk_nfc_select_chip() function.
> 	*/
> 
> How about the ECC layout size setup for a boot block?
> 
>> +	nand_read_page_op(chip, page, 0, NULL, 0);
>> +	rk_nfc_read_buf(nfc, nfc->buffer, mtd->writesize + mtd->oobsize);
>> +

>> +	/*
>> +	 * Deselect the currently selected target after the ops is done
>> +	 * to reduce the power consumption.
>> +	 */
>> +	rk_nfc_select_chip(chip, -1);

Remove.
Do not assume that the MTD framework or user space knows that you have
deselected the chip.

>> +
>> +	for (i = 0; i < ecc->steps; i++) {
>> +		/*
>> +		 * The first four bytes of OOB are reserved for the
>> +		 * boot ROM. In some debugging cases, such as with a read,
>> +		 * erase and write back test, these 4 bytes also must be
>> +		 * saved somewhere, otherwise this information will be
>> +		 * lost during a write back.
>> +		 */
>> +		if (!i)
>> +			memcpy(rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
>> +			       rk_nfc_oob_ptr(chip, i),
>> +			       NFC_SYS_DATA_SIZE);
>> +		else
>> +			memcpy(rk_nfc_buf_to_oob_ptr(chip, i - 1),
>> +			       rk_nfc_oob_ptr(chip, i),
>> +			       NFC_SYS_DATA_SIZE);
>> +		/* Copy ECC data from the NFC buffer. */
>> +		memcpy(rk_nfc_buf_to_oob_ecc_ptr(chip, i),
>> +		       rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
>> +		       ecc->bytes);
>> +		/* Copy data from the NFC buffer. */
>> +		if (buf)
>> +			memcpy(rk_nfc_buf_to_data_ptr(chip, buf, i),
>> +			       rk_nfc_data_ptr(chip, i),
>> +			       ecc->size);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int rk_nfc_read_oob(struct nand_chip *chip, int page)
>> +{
>> +	return rk_nfc_read_page_raw(chip, NULL, 1, page);
>> +}
>> +
>> +static int rk_nfc_read_page_hwecc(struct nand_chip *chip, u8 *buf, int oob_on,
>> +				  int page)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct rk_nfc *nfc = nand_get_controller_data(chip);
>> +	struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
>> +	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> +	int oob_step = (ecc->bytes > 60) ? NFC_MAX_OOB_PER_STEP :
>> +			NFC_MIN_OOB_PER_STEP;
>> +	int pages_per_blk = mtd->erasesize / mtd->writesize;
>> +	dma_addr_t dma_data, dma_oob;
> 
>> +	int ret = 0, i, boot_rom_mode = 0;
> 
> 	int ret = 0, i, cnt, boot_rom_mode = 0;
> 
>> +	int bitflips = 0, bch_st;
>> +	u8 *oob;
>> +	u32 tmp;
>> +
>> +	nand_read_page_op(chip, page, 0, NULL, 0);
>> +
>> +	dma_data = dma_map_single(nfc->dev, nfc->page_buf,
>> +				  mtd->writesize,
>> +				  DMA_FROM_DEVICE);
>> +	dma_oob = dma_map_single(nfc->dev, nfc->oob_buf,
>> +				 ecc->steps * oob_step,
>> +				 DMA_FROM_DEVICE);
>> +
>> +	/*
>> +	 * The first blocks (4, 8 or 16 depending on the device)
>> +	 * are used by the boot ROM.
>> +	 * Configure the ECC algorithm supported by the boot ROM.
>> +	 */
> 
>> +	if ((page < pages_per_blk * rknand->boot_blks) &&
> 
>> +	if ((page < (pages_per_blk * rknand->boot_blks)) &&
> 
>> +	    (chip->options & NAND_IS_BOOT_MEDIUM)) {
>> +		boot_rom_mode = 1;
>> +		if (rknand->boot_ecc != ecc->strength)
>> +			rk_nfc_hw_ecc_setup(chip, ecc,
>> +					    rknand->boot_ecc);
>> +	}
>> +
>> +	reinit_completion(&nfc->done);
>> +	writel(INT_DMA, nfc->regs + nfc->cfg->int_en_off);
>> +	rk_nfc_xfer_start(nfc, NFC_READ, ecc->steps, dma_data,
>> +			  dma_oob);
>> +	ret = wait_for_completion_timeout(&nfc->done,
>> +					  msecs_to_jiffies(100));
>> +	if (!ret)
>> +		dev_warn(nfc->dev, "read: wait dma done timeout.\n");
>> +	/*
>> +	 * Whether the DMA transfer is completed or not. The driver
>> +	 * needs to check the NFC`s status register to see if the data
>> +	 * transfer was completed.
>> +	 */
>> +	ret = rk_nfc_wait_for_xfer_done(nfc);
> 
> add empty line
> 
>> +	dma_unmap_single(nfc->dev, dma_data, mtd->writesize,
>> +			 DMA_FROM_DEVICE);
>> +	dma_unmap_single(nfc->dev, dma_oob, ecc->steps * oob_step,
>> +			 DMA_FROM_DEVICE);
>> +
>> +	if (ret) {
> 
>> +		bitflips = -EIO;
> 
> 		ret = -EIO;
> 
> return only "0" or official error codes
> 
>> +		dev_err(nfc->dev,
>> +			"read: wait transfer done timeout.\n");
>> +		goto out;
>> +	}
>> +
>> +	for (i = 1; i < ecc->steps; i++) {
>> +		oob = chip->oob_poi + (i - 1) * NFC_SYS_DATA_SIZE;
>> +		if (nfc->cfg->type == NFC_V9)
>> +			tmp = nfc->oob_buf[i];
>> +		else
>> +			tmp = nfc->oob_buf[i * (oob_step / 4)];
>> +		*oob++ = (u8)tmp;
>> +		*oob++ = (u8)(tmp >> 8);
>> +		*oob++ = (u8)(tmp >> 16);
>> +		*oob++ = (u8)(tmp >> 24);
>> +	}
>> +
>> +	for (i = 0; i < (ecc->steps / 2); i++) {
>> +		bch_st = readl_relaxed(nfc->regs +
>> +				       nfc->cfg->bch_st_off + i * 4);
>> +		if (bch_st & BIT(nfc->cfg->ecc0.err_flag_bit) ||
>> +		    bch_st & BIT(nfc->cfg->ecc1.err_flag_bit)) {
>> +			mtd->ecc_stats.failed++;
> 
>> +			bitflips = 0;
> 
> max_bitflips = -1;
> 
> use max_bitflips only for the error warning, not as return value
> 
>> +		} else {
> 
>> +			ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc0);
> 
> use ret only with "0" or official error codes, use cnt instead
> 
> 			cnt = ECC_ERR_CNT(bch_st, nfc->cfg->ecc0);
> 
>> +			mtd->ecc_stats.corrected += ret;
> 			mtd->ecc_stats.corrected += cnt;
> 
>> +			bitflips = max_t(u32, bitflips, ret);
> 
> 			bitflips = max_t(u32, bitflips, cnt);
> 
>> +
>> +			ret = ECC_ERR_CNT(bch_st, nfc->cfg->ecc1);
> 
> 			cnt = ECC_ERR_CNT(bch_st, nfc->cfg->ecc1);
> 
>> +			mtd->ecc_stats.corrected += ret;
> 
> 			mtd->ecc_stats.corrected += cnt;
> 
>> +			bitflips = max_t(u32, bitflips, ret);
> 
> 			bitflips = max_t(u32, bitflips, cnt);
>> +		}
>> +	}
>> +out:
>> +	memcpy(buf, nfc->page_buf, mtd->writesize);
>> +
> 
>> +	if (boot_rom_mode && rknand->boot_ecc != ecc->strength)
>> +		rk_nfc_hw_ecc_setup(chip, ecc, ecc->strength);
>> +
> 
>> +	if (bitflips > ecc->strength)
> 
> 	if (bitflips  == -1) {
> 		ret = -EIO;
> 
>> +		dev_err(nfc->dev, "read page: %x ecc error!\n", page);
> 
> }
> 

>> +
>> +	/*
>> +	 * Deselect the currently selected target after the ops is done
>> +	 * to reduce the power consumption.
>> +	 */
>> +	rk_nfc_select_chip(chip, -1);


Remove.
Do not assume that the MTD framework or user space knows that you have
deselected the chip.

>> +
> 
>> +	return bitflips;
> 
> 	return ret;
> 
> Return only "0" or official error codes
> If you want to do a "bad block scan" function in user space analyse/use
> "mtd->ecc_stats" instead.
> 
>> +}
>> +
