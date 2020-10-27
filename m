Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A34129AA6B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899087AbgJ0LS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:18:26 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37886 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437238AbgJ0LS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:18:26 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09RBI84V022554;
        Tue, 27 Oct 2020 06:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603797488;
        bh=n2ru3Mr0iMYemHjwDfq5SA03dYGNMsfunxIAIX/C4X8=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=OBohc5nkMosV1XoUEV2HaULUopaZmqCJnwMKQMlfNbrK9MLppABUZ58d9bjFYAuLa
         9RhhaanS1g1te6K1MQWu+qbuwwiSKYrdQZGo1rnmCEi+FAAhu0FAvg/fI486RA3tvn
         U8h/UDquKGOup5A21Nb2jq/FUdIZqbhRF7WDJu/I=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09RBI89S047065
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 06:18:08 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 27
 Oct 2020 06:18:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 27 Oct 2020 06:18:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09RBI7U1106738;
        Tue, 27 Oct 2020 06:18:07 -0500
Date:   Tue, 27 Oct 2020 16:48:06 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Message-ID: <20201027111804.e27pyvf62eksngmp@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201012180404.6476-1-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/20 11:34PM, Pratyush Yadav wrote:
> Hi,
> 
> The Cypress Semper S28 flash family uses 2-bit ECC by default. Under
> this ECC scheme, multi-pass page programs result in a program error.
> This means that unlike many other SPI NOR flashes, bit-walking cannot be
> done. In other words, once a page is programmed, its bits cannot then be
> flipped to 0 without an erase in between.
> 
> This causes problems with UBIFS because it uses bit-walking to clear EC
> and VID magic numbers from a PEB before issuing an erase to preserve the
> file system correctness in case of power cuts.
> 
> This series fixes that problem by introducing a flag
> MTD_NO_MULTI_PASS_WRITE that tells the file system layer that it can't
> do multi-pass writes. It also sets the writesize to the page size for
> such flashes to make sure file systems know that they should write the
> entire page in one go.
> 
> It is based on the xSPI/8D series that adds support for Cypress S28
> flash [0]. The patches themselves are independent of that series in the
> sense that they don't rely on 8D support. But since S28 flash is not
> supported without that series, these patches don't make much sense
> without it.
> 
> Tested on Cypress S28HS512T and MT35XU512ABA on J7200 and J721E
> respectively.
> 
> [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/

Ping. Any comments on the series?
 
> Pratyush Yadav (3):
>   mtd: abi: Introduce MTD_NO_MULTI_PASS_WRITE
>   UBI: Do not zero out EC and VID when multi-pass writes are not
>     supported
>   mtd: spi-nor: core: Introduce SPI_NOR_NO_MULTI_PASS_PP
> 
>  drivers/mtd/spi-nor/core.c     | 5 +++++
>  drivers/mtd/spi-nor/core.h     | 6 ++++++
>  drivers/mtd/spi-nor/spansion.c | 2 +-
>  drivers/mtd/ubi/io.c           | 2 +-
>  include/uapi/mtd/mtd-abi.h     | 1 +
>  5 files changed, 14 insertions(+), 2 deletions(-)
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
