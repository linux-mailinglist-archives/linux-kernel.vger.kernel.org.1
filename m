Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA42AA31E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgKGH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 02:59:24 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49894 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgKGH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 02:59:23 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A77x3R2094841;
        Sat, 7 Nov 2020 01:59:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604735943;
        bh=m1ljeRvRQu70/RVn7t4RTCGUhrp33lrcApjaJLu5Ai4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=USgwjntvc/+INV9C8mO0snj3P2//moEB3JE2jxz3fJkO2gLonQVjQVm/PUjOliHFW
         m0MyPqHV2fHBVktNevXvD5QeoBX59Va6zFTlcvT7hfrHv91MJIRWy5xr3CXibgzF9I
         UDDsQYkxFqt4txBtIQip0Brhv3GjCk2lbqWMv5L0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A77x2MW078432
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 7 Nov 2020 01:59:03 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 7 Nov
 2020 01:59:02 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 7 Nov 2020 01:59:02 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A77wxYD044540;
        Sat, 7 Nov 2020 01:59:00 -0600
Subject: Re: [PATCH v16 14/15] mtd: spi-nor: spansion: add support for Cypress
 Semper flash
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
 <20201005153138.6437-15-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7d058da8-90ef-8f71-fe86-cc0b27a2895a@ti.com>
Date:   Sat, 7 Nov 2020 13:28:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201005153138.6437-15-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[...]

On 10/5/20 9:01 PM, Pratyush Yadav wrote:
> +static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
> +{
> +	struct spi_mem_op op;
> +	u8 *buf = nor->bouncebuf;
> +	int ret;
> +
> +	if (enable) {
> +		/* Use 24 dummy cycles for memory array reads. */
> +		ret = spi_nor_write_enable(nor);
> +		if (ret)
> +			return ret;
> +
> +		*buf = SPINOR_REG_CYPRESS_CFR2V_MEMLAT_11_24;
> +		op = (struct spi_mem_op)
> +			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> +				   SPI_MEM_OP_ADDR(3, SPINOR_REG_CYPRESS_CFR2V,
> +						   1),
> +				   SPI_MEM_OP_NO_DUMMY,
> +				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +
> +		ret = spi_mem_exec_op(nor->spimem, &op);
> +		if (ret)
> +			return ret;
> +
> +		ret = spi_nor_wait_till_ready(nor);
> +		if (ret)
> +			return ret;
> +
> +		nor->read_dummy = 24;
> +	}
> +
> +	/* Set/unset the octal and DTR enable bits. */
> +	ret = spi_nor_write_enable(nor);
> +	if (ret)
> +		return ret;
> +
> +	if (enable)
> +		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_EN;
> +	else
> +		*buf = SPINOR_REG_CYPRESS_CFR5V_OCT_DTR_DS;
> +
> +	op = (struct spi_mem_op)
> +		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WR_ANY_REG, 1),
> +			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
> +					   SPINOR_REG_CYPRESS_CFR5V,
> +					   1),
> +			   SPI_MEM_OP_NO_DUMMY,
> +			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
> +
> +	if (!enable)
> +		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
> +
> +	ret = spi_mem_exec_op(nor->spimem, &op);
> +	if (ret)
> +		return ret;
> +
> +	/* Give some time for the mode change to take place. */
> +	usleep_range(1000, 1500);
> +

This delay is no longer needed right? I can drop it while applying, if
you confirm.

Tudor: Could you provide your R-by?

Regards
Vignesh
