Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747BF26A214
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgIOJXY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 05:23:24 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:51595 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIOJXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:23:21 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 0895B2000C;
        Tue, 15 Sep 2020 09:23:16 +0000 (UTC)
Date:   Tue, 15 Sep 2020 11:23:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     richard@nod.at, vigneshr@ti.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/8] mtd: rawnand: rockchip: NFC drivers for RK3308,
 RK2928 and others
Message-ID: <20200915112315.310d89c8@xps13>
In-Reply-To: <20200915100728.5c866f89@xps13>
References: <20200717092420.19798-1-yifeng.zhao@rock-chips.com>
        <20200717092420.19798-3-yifeng.zhao@rock-chips.com>
        <20200915100728.5c866f89@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miquel Raynal <miquel.raynal@bootlin.com> wrote on Tue, 15 Sep 2020
10:07:28 +0200:

> Hi Yifeng,
> 
> I am very sorry for the delay it took me to review this driver, but
> there are still some small incoherences IMHO, see below.

One last important comment below

> > +static int rk_nfc_attach_chip(struct nand_chip *chip)
> > +{
> > +	struct mtd_info *mtd = nand_to_mtd(chip);
> > +	struct device *dev = mtd->dev.parent;
> > +	struct rk_nfc *nfc = nand_get_controller_data(chip);
> > +	struct rk_nfc_nand_chip *rknand = to_rknand(chip);
> > +	struct nand_ecc_ctrl *ecc = &chip->ecc;
> > +	int len;
> > +	int ret;
> > +
> > +	if (chip->options & NAND_BUSWIDTH_16) {
> > +		dev_err(dev, "16 bits bus width not supported");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (ecc->mode != NAND_ECC_HW)
> > +		return 0;
> > +
> > +	ret = rk_nfc_ecc_init(dev, mtd);
> > +	if (ret)
> > +		return ret;
> > +	rknand->spare_per_sector = ecc->bytes + NFC_SYS_DATA_SIZE;
> > +	rknand->metadata_size = NFC_SYS_DATA_SIZE * ecc->steps;
> > +
> > +	if (rknand->metadata_size < NFC_SYS_DATA_SIZE + 2) {
> > +		dev_err(dev,
> > +			"Driver needs at least %d bytes of meta data\n",
> > +			NFC_SYS_DATA_SIZE + 2);
> > +		return -EIO;
> > +	}
> > +	/* Check buffer first, avoid duplicate alloc buffer. */
> > +	if (nfc->buffer)
> > +		return 0;  
> 
> You can't do that this way: what if the first mtd to be registered uses
> a smaller page size than the second?
> 
> > +
> > +	len = mtd->writesize + mtd->oobsize;
> > +	nfc->buffer = devm_kzalloc(dev, len, GFP_KERNEL | GFP_DMA);

I don't think this fits your purpose. You should probably allocate with
kzalloc or perhaps dma_alloc*.

Then, you'll also have to free this memory.

> > +	if (!nfc->buffer)
> > +		return -ENOMEM;
> > +
> > +	nfc->page_buf = nfc->buffer;
> > +	len = ecc->steps * NFC_MAX_OOB_PER_STEP;
> > +	nfc->oob_buf = devm_kzalloc(dev, len, GFP_KERNEL | GFP_DMA);
> > +	if (!nfc->oob_buf) {
> > +		nfc->buffer = NULL;
> > +		nfc->oob_buf = NULL;  
> 
> I don't think this is needed
> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	chip->ecc.write_page_raw = rk_nfc_write_page_raw;
> > +	chip->ecc.write_page = rk_nfc_write_page_hwecc;
> > +	chip->ecc.write_oob_raw = rk_nfc_write_oob_std;
> > +	chip->ecc.write_oob = rk_nfc_write_oob_std;
> > +
> > +	chip->ecc.read_page_raw = rk_nfc_read_page_raw;
> > +	chip->ecc.read_page = rk_nfc_read_page_hwecc;
> > +	chip->ecc.read_oob_raw = rk_nfc_read_oob_std;
> > +	chip->ecc.read_oob = rk_nfc_read_oob_std;  
> 
> I don't like the _std prefix, but it should be gone when splitting the
> functions as advised.
> 
> > +
> > +	return 0;
> > +}

Thanks,
Miquèl
