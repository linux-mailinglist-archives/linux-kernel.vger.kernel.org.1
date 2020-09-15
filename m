Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF6D8269EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgIOGqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:46:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37814 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgIOGqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:46:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08F6kQbk044766;
        Tue, 15 Sep 2020 01:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600152386;
        bh=c0qC89K+xtv78g9xW2nSARu/6vLSkAR2jagY7DanMCg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=BFs8VHb6IVFfWP9OGM+9f1eBIV9ePXmt8PrbnZ+nxxsvdkYceGOGF8sekM6HLHQiQ
         iYev7adKEJpYqLhjI+C9f0sS3g+8nZmltXPwE6t3xv+uWFZkQhwAx1tbT7RUWNaHJR
         PNBer+aa24QlDA2SUwcyVZlnDtymIUUE9TK6E2Gg=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08F6kQxY128608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 01:46:26 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 01:46:26 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 01:46:26 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08F6kMp4074503;
        Tue, 15 Sep 2020 01:46:23 -0500
Subject: Re: [PATCH v12 00/14] mtd: spi-nor: add xSPI Octal DTR support
To:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
References: <20200903171313.18741-1-p.yadav@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <973eac67-fa01-309f-c4d1-7983f404d507@ti.com>
Date:   Tue, 15 Sep 2020 12:16:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903171313.18741-1-p.yadav@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/20 10:42 PM, Pratyush Yadav wrote:
> Hi,
> 
> This series adds support for Octal DTR flashes in the SPI NOR framework,
> and then adds hooks for the Cypress Semper and Micron Xcella flashes to
> allow running them in Octal DTR mode. This series assumes that the flash
> is handed to the kernel in Legacy SPI mode.
> 
> Tested on TI J721E EVM with 1-bit ECC on the Cypress flash.
> 
[...]

Please fix checkpatch issues on patch 1, 3, 4 and 5

Otherwise patches look good to me...

> 
> Pratyush Yadav (14):
>   mtd: spi-nor: core: add spi_nor_{read,write}_reg() helpers
>   mtd: spi-nor: core: add spi_nor_controller_ops_erase helper
>   mtd: spi-nor: add support for DTR protocol
>   mtd: spi-nor: sfdp: get command opcode extension type from BFPT
>   mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
>   mtd: spi-nor: core: use dummy cycle and address width info from SFDP
>   mtd: spi-nor: core: do 2 byte reads for SR and FSR in DTR mode
>   mtd: spi-nor: core: enable octal DTR mode when possible
>   mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
>   mtd: spi-nor: core: perform a Soft Reset on shutdown
>   mtd: spi-nor: core: disable Octal DTR mode on suspend.
>   mtd: spi-nor: core: expose spi_nor_default_setup() in core.h
>   mtd: spi-nor: spansion: add support for Cypress Semper flash
>   mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode
> 
>  drivers/mtd/spi-nor/core.c      | 462 ++++++++++++++++++++++++--------
>  drivers/mtd/spi-nor/core.h      |  23 ++
>  drivers/mtd/spi-nor/micron-st.c | 102 ++++++-
>  drivers/mtd/spi-nor/sfdp.c      | 122 ++++++++-
>  drivers/mtd/spi-nor/sfdp.h      |   8 +
>  drivers/mtd/spi-nor/spansion.c  | 166 ++++++++++++
>  include/linux/mtd/spi-nor.h     |  53 +++-
>  7 files changed, 813 insertions(+), 123 deletions(-)



