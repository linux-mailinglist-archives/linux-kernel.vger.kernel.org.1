Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510792AB773
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgKILqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:46:18 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59008 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbgKILqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:46:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A9BjiSG009421;
        Mon, 9 Nov 2020 05:45:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604922344;
        bh=NNwBY8g5f0FY29nACv1fAakM+XMumhmixbP2pLqwiw4=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qUq2RvTShgzqsdopPtWkYwQMLTz4mNM8c5/u2FLqd4FxlRtwGA4hNT1hto2XBgFkw
         GnPVa1/FtIWxw6VU8FAQVdjFLrYpaNKmx5ir9411GpGM96FrD7kvdQFDITjyfNxGcI
         +AmOyWpAQjEHeYjCAqSnTdHcXrznPfcUS8iMDngg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A9Bjibb127564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 9 Nov 2020 05:45:44 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 9 Nov
 2020 05:45:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 9 Nov 2020 05:45:44 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A9Bjh93079202;
        Mon, 9 Nov 2020 05:45:44 -0600
Date:   Mon, 9 Nov 2020 17:15:43 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [PATCH v16 14/15] mtd: spi-nor: spansion: add support for
 Cypress Semper flash
Message-ID: <20201109114541.g6phaz36glhkpajz@ti.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <20201005153138.6437-15-p.yadav@ti.com>
 <7d058da8-90ef-8f71-fe86-cc0b27a2895a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7d058da8-90ef-8f71-fe86-cc0b27a2895a@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/20 01:28PM, Vignesh Raghavendra wrote:
> Hi,
> 
> [...]
> 
> On 10/5/20 9:01 PM, Pratyush Yadav wrote:
> > +static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
> > +{
> > +	struct spi_mem_op op;
> > +	u8 *buf = nor->bouncebuf;
> > +	int ret;
> > +
> > +	if (enable) {
> > +		/* Use 24 dummy cycles for memory array reads. */
> > +		ret = spi_nor_write_enable(nor);
> > +		if (ret)
> > +			return ret;
> > +
> > +		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> > +		op = (struct spi_mem_op)
> > +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> > +				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
> > +						   1),
> > +				   SPI_MEM_OP_NO_DUMMY,
> > +				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > +
> > +		ret = spi_mem_exec_op(nor->spimem, &op);
> > +		if (ret)
> > +			return ret;
> > +
> > +		ret = spi_nor_wait_till_ready(nor);
> > +		if (ret)
> > +			return ret;
> > +
> > +		nor->read_dummy = 24;
> > +	}
> > +
> > +	/* Set/unset the octal and DTR enable bits. */
> > +	ret = spi_nor_write_enable(nor);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (enable)
> > +		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> > +	else
> > +		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> > +
> > +	op = (struct spi_mem_op)
> > +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> > +			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
> > +					   SPINOR_REG_CYPRESS_CFR5V,
> > +					   1),
> > +			   SPI_MEM_OP_NO_DUMMY,
> > +			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> > +
> > +	if (!enable)
> > +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> > +
> > +	ret = spi_mem_exec_op(nor->spimem, &op);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Give some time for the mode change to take place. */
> > +	usleep_range(1000, 1500);
> > +
> 
> This delay is no longer needed right? I can drop it while applying, if
> you confirm.

Yes, this delay is not needed. Please drop it while applying.
 
> Tudor: Could you provide your R-by?
> 
> Regards
> Vignesh

-- 
Regards,
Pratyush Yadav
Texas Instruments India
