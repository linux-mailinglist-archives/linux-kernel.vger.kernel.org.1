Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63764282878
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 06:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgJDEBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 00:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgJDEBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 00:01:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2AFC0613CE
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 21:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=t54hCYUQtp+1v6QUAKNpRtfkaPn4Zxp8C8yhxxeRyrA=; b=fuM+kYkpv8WSAtT9hB85kxl9iY
        1JutuV0jIlwWstREQ6eyXkf6OSBvKYjGN7b8Jqg8GXTPvoLraZJjzbKupLj2j6VFRivsXsbG2TTeC
        kf7+xowT4WDQIkTLz17ffQKKRysp8pZ8D7j98mnPlcvw75Ft2//fDRQP2qgeTYlweVzPzhUW06alX
        PJcRCwqzeMIMwBrd+ujld27/aSGXZcBhmyzyh65qyBav+PsIEzEiWRNQdYFtgVVz4pcx1iXgQWPaJ
        6kRlWfxXCC3nsLVGmY/5bW22E1fhJSymi76RNlF+6MF6BecLhHWYTD6fJJDN2y/z2z+DQasOplPbm
        uP1NVJgQ==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOvDJ-0004vu-1m; Sun, 04 Oct 2020 04:01:33 +0000
Subject: Re: [PATCH 2/2] Platform integrity information in sysfs (version 9)
To:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        linux-mtd@lists.infradead.org
References: <20200930163714.12879-1-daniel.gutson@eclypsium.com>
 <20200930163714.12879-3-daniel.gutson@eclypsium.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <82bb95bd-988f-3cc2-40f7-8ebfd20b09d9@infradead.org>
Date:   Sat, 3 Oct 2020 21:01:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200930163714.12879-3-daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/20 9:37 AM, Daniel Gutson wrote:
> diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
> index 5c0e0ec2e6d1..e7eaef506fc2 100644
> --- a/drivers/mtd/spi-nor/controllers/Kconfig
> +++ b/drivers/mtd/spi-nor/controllers/Kconfig
> @@ -29,6 +29,7 @@ config SPI_NXP_SPIFI
>  
>  config SPI_INTEL_SPI
>  	tristate
> +	depends on PLATFORM_INTEGRITY_DATA

So SPI_INTEL_SPI_PCI selects SPI_INTEL_SPI:

config SPI_INTEL_SPI_PCI
	tristate "Intel PCH/PCU SPI flash PCI driver (DANGEROUS)"
	depends on X86 && PCI
	select SPI_INTEL_SPI

without checking that PLATFORM_INTEGRITY_DATA is set/enabled.

"select" does not follow any kconfig dependency chains, so when
PLATFORM_INTEGRITY_DATA is not enabled, this should be causing
a kconfig warning, which is not OK.


-- 
~Randy

