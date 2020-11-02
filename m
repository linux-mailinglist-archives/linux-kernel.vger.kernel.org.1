Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A552A2B17
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbgKBM6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 07:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgKBM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 07:58:01 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E2C0617A6;
        Mon,  2 Nov 2020 04:58:00 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id oq3so16897531ejb.7;
        Mon, 02 Nov 2020 04:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9eJ1vkYr+Qgir4hV/yr3W9dU2UtR9+tY2Iomt5NPc/Y=;
        b=GoA/3zMVPI1ZamwZkhQRGGwaM2yqWGvFmTcjvGmU2Y1N9Puh4YCO3YLon2opM+MX+v
         TsxtlPIHyBtpoYBnCJbhz1vYMovtwaaF+0rgJXCkZYtrkVB0h8PiBCVx+fLGJnN9bp5z
         NbBdtQQ2RYKYwp2u/9P+XSDYeulJBDyXi57s0pvlaN6jxy3skniiKy3sywo1uNG6AfNw
         KPRUZPyunlrrLfvwyho6j/9R46XX4gHWmTEBVTQIvKuiY/THsHzL0Vez6i4u0sE2yS6u
         aWuTs2RM2Gs0eFLlhTkywJBR87enl9wwYr7sgHkKSpxbdnrfQ2YRS2zhcwXZtx6uxBMV
         TNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eJ1vkYr+Qgir4hV/yr3W9dU2UtR9+tY2Iomt5NPc/Y=;
        b=ocJzSM44GbGvSLjtGWcJsI+hlEG3SMEtokNEHpWDNcL9wBv3ytWOo3dYIF9c5dU+R+
         4Vp1F3xkXtr3hB2QnN4aUyoTkmC92tJyj0wTr+nmCeLjrWil+5Hm3b1uB0FdQNoV6qUH
         OVBfYmyWRqeHU8IA/x4g0J43VWUdSMpi7FpKpQkUWJ31IR/bqS4QYmFOzUfaA/H+Sv0b
         sphKLR/9R+vrjV2BZ/XnkV3I5dJ4R0aN93n6nAH/LhQg1afky5jAZ93AIkSffR6FUoG5
         E7wvMSUihWUdkWE7lkKN60yv/bSDvW+8TqrnJ1U1FV/Iob2FPxuv3H5r7tLK3FCngG8Q
         tdEQ==
X-Gm-Message-State: AOAM531sxE2EG2UPmhyvYWPIzXBIqT8+/6VVsiu+Ee6WZJ9y2i/wlXZv
        2CxOxvAplDeF805p4F1xzu0=
X-Google-Smtp-Source: ABdhPJzD1dZwfyfqfiXNVYWJRtF//xT+Mh0yMdcluAVO/gAv4enhHA7ovgd3u6lHmuRw91Qv3V41VQ==
X-Received: by 2002:a17:906:cede:: with SMTP id si30mr4539265ejb.16.1604321879235;
        Mon, 02 Nov 2020 04:57:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u23sm9441006ejy.87.2020.11.02.04.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2020 04:57:58 -0800 (PST)
Subject: Re: [PATCH v13 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
To:     Yifeng <yifeng.zhao@rock-chips.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org
References: <20201028095326.15562-1-yifeng.zhao@rock-chips.com>
 <20201028095326.15562-3-yifeng.zhao@rock-chips.com>
 <a8a7875b-f08b-62c6-a630-245687e0df3b@gmail.com>
 <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <0b417fc2-3503-9bf6-914d-0f8b38df1914@gmail.com>
Date:   Mon, 2 Nov 2020 13:57:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e02e13a0-769d-6b73-c87e-5b7d75fd4254@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Don't poke with "ecc->bytes" ones it is set in rk_nfc_ecc_init(). It
will not be noted by the MTD frame work or userspace. I think there's
currently no way to let the user know that a different ECC must be used.
Neither can the user set ECC on the fly.

Example R/W flow:

        nand_select_target()
	chip->ecc.write_page_raw()
	chip->ecc.write_page()

[..]

	chip->ecc.read_page_raw()
	chip->ecc.read_page()
        nand_deselect_target()

A write/read with:

rk_nfc_read_page_hwecc()
rk_nfc_write_page_hwecc()

or

rk_nfc_read_page_raw()
rk_nfc_write_page_raw()

must end up with the same result. If we can't archive that, then we
shouldn't offer RAW mode to the user for now. If Miquel agrees you
should just get the driver ready now without these 2 functions and round
things up.

On 11/2/20 11:21 AM, Yifeng wrote:
> Hi Johan，
> 
> 
>>> +static int rk_nfc_write_page_raw(struct nand_chip *chip, const u8 *buf,
>>> +                 int oob_on, int page)
>>> +{
>>> +    struct mtd_info *mtd = nand_to_mtd(chip);
>>> +    struct rk_nfc *nfc = nand_get_controller_data(chip);
>>> +    struct nand_ecc_ctrl *ecc = &chip->ecc;
> 
>      int ecc_bytes_backup = ecc->bytes;
> 
>>> +    int ret = 0;
>>> +    u32 i;
>>> +
>>     /*
>>     * Normal timing and ECC layout size setup is already done in
>>     * the rk_nfc_select_chip() function.
>>     */
>>
>> How about the ECC layout size setup for a boot block?
> |The ecc->bytes will different while |||rknand->|boot_ecc is different
> from ecc->strength.|
> 
> |How about？
> 1. backup ecc->bytes
> 2. config ecc->bytes with boot_ecc_bytes
> 3. restore ecc->bytes|
> 
> |    pages_per_blk = mtd->erasesize / mtd->writesize;|
> 
> |    if ((chip->options & NAND_IS_BOOT_MEDIUM) &&||
> ||        (page < (pages_per_blk * rknand->boot_blks))) {||
> ||        boot_rom_blk = 1;||
> ||        if (rknand->boot_ecc != ecc->strength)||
> ||            ecc->bytes = rknand->boot_ecc_bytes;||
> ||    }|
> 
>>> +    if (!buf)
>>> +        memset(nfc->buffer, 0xff, mtd->writesize + mtd->oobsize);
>>> +> +    for (i = 0; i < ecc->steps; i++) {
>>> +        /* Copy data to nfc buffer. */
>>> +        if (buf)
>>> +            memcpy(rk_nfc_data_ptr(chip, i),
>>> +                   rk_nfc_buf_to_data_ptr(chip, buf, i),
>>> +                   ecc->size);
>>> +        /*
>>> +         * The first four bytes of OOB are reserved for the
>>> +         * boot ROM. In some debugging cases, such as with a
>>> +         * read, erase and write back test these 4 bytes stored
>>> +         * in OOB also need to be written back.
>>> +         */
>>     /*
>>     * The first four bytes of OOB are reserved for the
>>     * boot ROM. In some debugging cases, such as with a
>>     * read, erase and write back test these 4 bytes stored
>>     * in OOB also need to be written back.
>>     *
>>     * The function nand_block_bad detects bad blocks like:
>>     *
>>     * bad = chip->oob_poi[chip->badblockpos];
>>     *
>>     * chip->badblockpos == 0 for a large page NAND Flash,
>>     * so chip->oob_poi[0] is the bad block mask (BBM).
>>     *
>>     * The OOB data layout on the NFC is:
>>     *
>>     *   PA0  PA1  PA2  PA3 | BBM OOB1 OOB2 OOB3 | ...
>>     *
>>     * or
>>     *
>>     *  0xFF 0xFF 0xFF 0xFF | BBM OOB1 OOB2 OOB3 | ...
>>     *
>>     * The code here just swaps the first 4 bytes with the last
>>     * 4 bytes without losing any data.
>>     *
>>     * The chip->oob_poi data layout:
>>     *
>>     *   BBM OOB1 OOB2 OOB3 |......|  PA0  PA1  PA2  PA3
>>     *
>>     * The rk_nfc_ooblayout_free() function already has reserved
>>     * these 4 bytes with:
>>     *
>>     * oob_region->offset = NFC_SYS_DATA_SIZE + 2;
>>     */
>>
>>
>>> +        if (!i)
>>> +            memcpy(rk_nfc_oob_ptr(chip, i),
>>> +                   rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
>>> +                   NFC_SYS_DATA_SIZE);
>>> +        else
>>> +            memcpy(rk_nfc_oob_ptr(chip, i),
>>> +                   rk_nfc_buf_to_oob_ptr(chip, i - 1),
>>> +                   NFC_SYS_DATA_SIZE);
>>> +        /* Copy ECC data to the NFC buffer. */
>>> +        memcpy(rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
>>> +               rk_nfc_buf_to_oob_ecc_ptr(chip, i),
>>> +               ecc->bytes);
>>> +    }
> 
>     if (boot_rom_blk && (rknand->boot_ecc != ecc->strength))
>         ecc->bytes = ecc_bytes_backup;
> 
>>> +    nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>>> +    rk_nfc_write_buf(nfc, buf, mtd->writesize + mtd->oobsize);
>>> +    ret = nand_prog_page_end_op(chip);
>>> +
>>> +    /*
>>> +     * Deselect the currently selected target after the ops is done
>>> +     * to reduce the power consumption.
>>> +     */
>>> +    rk_nfc_select_chip(chip, -1);
>> Does the MTD framework always select again?
>>
>>> +
>>> +    return ret;
>>> +}
> ...
>>> +
>>> +static int rk_nfc_read_page_raw(struct nand_chip *chip, u8 *buf, int
>>> oob_on,
>>> +                int page)
>>> +{
>>> +    struct mtd_info *mtd = nand_to_mtd(chip);
>>> +    struct rk_nfc *nfc = nand_get_controller_data(chip);
>>> +    struct nand_ecc_ctrl *ecc = &chip->ecc;
> 
>     int ecc_bytes_backup = ecc->bytes;
> 
>>> +    int i;
>>> +
>>     /*
>>     * Normal timing and ECC layout size setup is already done in
>>     * the rk_nfc_select_chip() function.
>>     */
>>
>> How about the ECC layout size setup for a boot block?
>>
>>> +    nand_read_page_op(chip, page, 0, NULL, 0);
>>> +    rk_nfc_read_buf(nfc, nfc->buffer, mtd->writesize + mtd->oobsize);
> 
> |    pages_per_blk = mtd->erasesize / mtd->writesize;|
> 
> |    if ((chip->options & NAND_IS_BOOT_MEDIUM) &&||
> ||        (page < (pages_per_blk * rknand->boot_blks))) {||
> ||        boot_rom_blk = 1;||
> ||        if (rknand->boot_ecc != ecc->strength)||
> ||            ecc->bytes = rknand->boot_ecc_bytes;||
> ||    }|
> 
>>> +    /*
>>> +     * Deselect the currently selected target after the ops is done
>>> +     * to reduce the power consumption.
>>> +     */
>>> +    rk_nfc_select_chip(chip, -1);
>>> +
>>> +    for (i = 0; i < ecc->steps; i++) {
>>> +        /*
>>> +         * The first four bytes of OOB are reserved for the
>>> +         * boot ROM. In some debugging cases, such as with a read,
>>> +         * erase and write back test, these 4 bytes also must be
>>> +         * saved somewhere, otherwise this information will be
>>> +         * lost during a write back.
>>> +         */
>>> +        if (!i)
>>> +            memcpy(rk_nfc_buf_to_oob_ptr(chip, ecc->steps - 1),
>>> +                   rk_nfc_oob_ptr(chip, i),
>>> +                   NFC_SYS_DATA_SIZE);
>>> +        else
>>> +            memcpy(rk_nfc_buf_to_oob_ptr(chip, i - 1),
>>> +                   rk_nfc_oob_ptr(chip, i),
>>> +                   NFC_SYS_DATA_SIZE);
>>> +        /* Copy ECC data from the NFC buffer. */
>>> +        memcpy(rk_nfc_buf_to_oob_ecc_ptr(chip, i),
>>> +               rk_nfc_oob_ptr(chip, i) + NFC_SYS_DATA_SIZE,
>>> +               ecc->bytes);
>>> +        /* Copy data from the NFC buffer. */
>>> +        if (buf)
>>> +            memcpy(rk_nfc_buf_to_data_ptr(chip, buf, i),
>>> +                   rk_nfc_data_ptr(chip, i),
>>> +                   ecc->size);
>>> +    }
> |    if (boot_rom_blk && (rknand->boot_ecc != ecc->strength))||
> ||        ecc->bytes = ecc_bytes_backup;|
>>> +    return 0;
>>> +}
>>> +
> ...
>>> +static int rk_nfc_attach_chip(struct nand_chip *chip)
>>> +{
>>> +    struct mtd_info *mtd = nand_to_mtd(chip);
>>> +    struct device *dev = mtd->dev.parent;
>>> +    struct rk_nfc *nfc = nand_get_controller_data(chip);
>>> +    struct rk_nfc_nand_chip *rknand = rk_nfc_to_rknand(chip);
>>> +    struct nand_ecc_ctrl *ecc = &chip->ecc;
>>> +    int new_len, new_oob_len;
>>> +    void *buf;
>>> +    int ret;
>>> +
>>> +    if (chip->options & NAND_BUSWIDTH_16) {
>>> +        dev_err(dev, "16 bits bus width not supported");
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if (ecc->engine_type != NAND_ECC_ENGINE_TYPE_ON_HOST)
>>> +        return 0;
>>> +
>>> +    ret = rk_nfc_ecc_init(dev, mtd);
>>> +    if (ret)
>>> +        return ret;
>>> +    rknand->spare_per_sector = ecc->bytes + NFC_SYS_DATA_SIZE;
>>> +    rknand->metadata_size = NFC_SYS_DATA_SIZE * ecc->steps;
>>> +
> |    if (chip->options & NAND_IS_BOOT_MEDIUM)||
> ||        rknand->boot_ecc_bytes = DIV_ROUND_UP(rknand->boot_ecc * fls(8
> * ecc->size), 8);|
>>> +    if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
>>> +        dev_err(dev,
>>> +            "Driver needs at least %d bytes of meta data\n",
>>> +            NFC_SYS_DATA_SIZE + 2);
>>> +        return -EIO;
>>> +    }
>>> +
>>> +    /* Check buffer first, avoid duplicate alloc buffer. */
>>> +    new_len = mtd->writesize + mtd->oobsize;
>>> +    if (nfc->buffer && new_len > nfc->buffer_size) {
>>> +        buf = krealloc(nfc->buffer, new_len, GFP_KERNEL | GFP_DMA);
>>> +        if (!buf)
>>> +            return -ENOMEM;
>>> +        nfc->buffer = buf;
>>> +        nfc->buffer_size = new_len;
>>> +    }
>>> +
>>> +    new_oob_len = ecc->steps * NFC_MAX_OOB_PER_STEP;
>>> +    if (nfc->oob_buf && new_oob_len > nfc->oob_buf_size) {
>>> +        buf = krealloc(nfc->oob_buf, new_oob_len,
>>> +                   GFP_KERNEL | GFP_DMA);
>>> +        if (!buf) {
>>> +            kfree(nfc->buffer);
>>> +            nfc->buffer = NULL;
>>> +            return -ENOMEM;
>>> +        }
>>> +        nfc->oob_buf = buf;
>>> +        nfc->oob_buf_size = new_oob_len;
>>> +    }
>>> +
>>> +    if (!nfc->buffer) {
>>> +        nfc->buffer = kzalloc(new_len, GFP_KERNEL | GFP_DMA);
>>> +        if (!nfc->buffer)
>>> +            return -ENOMEM;
>>> +        nfc->buffer_size = new_len;
>>> +    }
>>> +
>>> +    if (!nfc->oob_buf) {
>>> +        nfc->oob_buf = kzalloc(new_oob_len, GFP_KERNEL | GFP_DMA);
>>> +        if (!nfc->oob_buf) {
>>> +            kfree(nfc->buffer);
>>> +            nfc->buffer = NULL;
>>> +            return -ENOMEM;
>>> +        }
>>> +        nfc->oob_buf_size = new_oob_len;
>>> +    }
>>> +
>>> +    nfc->page_buf = nfc->buffer;
>>> +
>>> +    chip->ecc.write_page_raw = rk_nfc_write_page_raw;
>>> +    chip->ecc.write_page = rk_nfc_write_page_hwecc;
>>> +    chip->ecc.write_oob_raw = rk_nfc_write_oob;
>>> +    chip->ecc.write_oob = rk_nfc_write_oob;
>>> +
>>> +    chip->ecc.read_page_raw = rk_nfc_read_page_raw;
>>> +    chip->ecc.read_page = rk_nfc_read_page_hwecc;
>>> +    chip->ecc.read_oob_raw = rk_nfc_read_oob;
>>> +    chip->ecc.read_oob = rk_nfc_read_oob;
>>> +
>>> +    return 0;
>>> +}
> 
> Thanks，
> 
> Yifeng
> 
> 

