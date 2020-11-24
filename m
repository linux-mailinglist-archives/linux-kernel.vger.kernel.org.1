Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182352C289E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388656AbgKXNq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:46:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55198 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388638AbgKXNqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:46:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AODkLXg055894;
        Tue, 24 Nov 2020 07:46:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606225581;
        bh=XcV4HWBN2J0sF2FulGtrQUKZH8qYfI7pApSvMca8Jbg=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=diKZmGIzvxgXT99+wtQ5Po9H59CWCjYajGTlo0W4MzBj5yIQIjlFValPmwinL8pnv
         bTDU4wW1DYBUD8h7m4jlq2DD9n3SVmvOO9sHdQ92aE5rrrKTdvHIecRaW29rblL0Hv
         acmEYOvctwIMpkGh9VXYfdjfw+4CIC3rLSnuL6VQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AODkL3n005940
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Nov 2020 07:46:21 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 24
 Nov 2020 07:46:21 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 24 Nov 2020 07:46:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AODkKLw106370;
        Tue, 24 Nov 2020 07:46:20 -0600
Date:   Tue, 24 Nov 2020 19:16:19 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] mtd: Make sure UBIFS does not do multi-pass page
 programming on flashes that don't support it
Message-ID: <20201124134619.2pbg7zejbvwc3e2w@ti.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201118182459.18197-1-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 18/11/20 11:54PM, Pratyush Yadav wrote:
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
> This series fixes that by setting mtd->writesize to the ECC block size
> (16) and making sure UBIFS does not try to do a multi-pass write on
> flashes with writesize > 1.
> 
> It is based on the xSPI/8D series that adds support for Cypress S28
> flash [0] (it is in next now). The patches themselves are independent of
> that series in the sense that they don't rely on 8D support. But since
> S28 flash is not supported without that series, these patches don't make
> much sense without it.
> 
> Tested on Cypress S28HS512T and MT35XU512ABA on J7200 and J721E
> respectively.
> 
> [0] https://lore.kernel.org/linux-mtd/20201005153138.6437-1-p.yadav@ti.com/

Any comments on the series? If not, can it be picked up?
 
> Pratyush Yadav (3):
>   UBI: Do not zero out EC and VID on ECC-ed NOR flashes
>   mtd: spi-nor: core: Allow flashes to specify MTD writesize
>   mtd: spi-nor: spansion: Set ECC block size
> 
>  drivers/mtd/spi-nor/core.c     | 4 +++-
>  drivers/mtd/spi-nor/core.h     | 3 +++
>  drivers/mtd/spi-nor/spansion.c | 1 +
>  drivers/mtd/ubi/build.c        | 4 +---
>  drivers/mtd/ubi/io.c           | 9 ++++++++-
>  5 files changed, 16 insertions(+), 5 deletions(-)
> 
> --
> 2.28.0
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments India
