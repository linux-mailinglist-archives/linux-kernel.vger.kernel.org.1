Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACF32AD73E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgKJNOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:14:32 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52726 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgKJNOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:14:31 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AADELJI054024;
        Tue, 10 Nov 2020 07:14:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605014061;
        bh=+g/DEVhJYtkc2T/gQ5S006B5Obb8oIoEMqC2xcIJOzw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pC+b3MKZ7pqRjZxK2n0DR/J+/CrzjdpZq+rjjHw3Oi+FQ/48ZkvhTJe6cEx6/G+P/
         3BTyP4SFK/E452hNZCCrSfUj2pwJuvK5pZZs+OQZkr8S/9l+bKQ4GIOCBqq1QhdR+S
         IoLnS/CVe8CvICcVqxsp8DdNd3hNckufLCEofvRI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AADELeO057954
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 07:14:21 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 10
 Nov 2020 07:14:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 10 Nov 2020 07:14:21 -0600
Received: from [10.250.233.179] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AADEIFb019665;
        Tue, 10 Nov 2020 07:14:19 -0600
Subject: Re: [PATCH] mtd: spi-nor: Fix multiple typos
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        <linux-mtd@lists.infradead.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>
References: <20201107134151.1071327-1-j.neuschaefer@gmx.net>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <7463ff20-6791-35f4-8824-fa1423c50099@ti.com>
Date:   Tue, 10 Nov 2020 18:44:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201107134151.1071327-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/7/20 7:11 PM, Jonathan Neuschäfer wrote:
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks for the patch, but a commit msg is expected however trivial the
patch maybe. scripts/checkpatch.pl --strict complains about the same:

WARNING: Missing commit description - Add an appropriate one

Regards
Vignesh

> ---
>  drivers/mtd/spi-nor/core.c  | 4 ++--
>  drivers/mtd/spi-nor/sfdp.c  | 2 +-
>  include/linux/mtd/spi-nor.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 0369d98b2d12e..85c0704945259 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1447,7 +1447,7 @@ static int spi_nor_erase_multi_sectors(struct spi_nor *nor, u64 addr, u32 len)
> 
>  /*
>   * Erase an address range on the nor chip.  The address range may extend
> - * one or more erase sectors.  Return an error is there is a problem erasing.
> + * one or more erase sectors.  Return an error if there is a problem erasing.
>   */
>  static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
>  {
> @@ -2537,7 +2537,7 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
>  		}
> 
>  		/*
> -		 * Otherwise, the current erase size is still a valid canditate.
> +		 * Otherwise, the current erase size is still a valid candidate.
>  		 * Select the biggest valid candidate.
>  		 */
>  		if (!erase && tested_erase->size)
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index e2a43d39eb5f4..05b22c6576832 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -59,7 +59,7 @@ struct sfdp_bfpt_read {
> 
>  struct sfdp_bfpt_erase {
>  	/*
> -	 * The half-word at offset <shift> in DWORD <dwoard> encodes the
> +	 * The half-word at offset <shift> in DWORD <dword> encodes the
>  	 * op code and erase sector size to be used by Sector Erase commands.
>  	 */
>  	u32			dword;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 60bac2c0ec456..582ee04eeea20 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -406,7 +406,7 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
>   * @name:	the chip type name
>   * @hwcaps:	the hardware capabilities supported by the controller driver
>   *
> - * The drivers can use this fuction to scan the SPI NOR.
> + * The drivers can use this function to scan the SPI NOR.
>   * In the scanning, it will try to get all the necessary information to
>   * fill the mtd_info{} and the spi_nor{}.
>   *
> --
> 2.28.0
> 
