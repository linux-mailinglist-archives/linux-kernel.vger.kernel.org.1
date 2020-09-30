Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9527E3B4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgI3I2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:28:04 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52826 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3I2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:28:03 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U8RtCA016363;
        Wed, 30 Sep 2020 03:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601454475;
        bh=8JdpRbJ74Ne4r+saV14wPMRRgvRusJVpZ6c9SL1M234=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P9V/byVJgzMR46mj0UzMKC8f+JAg91FWPlV7stelCbbAgddFqgZwFvH+7E2Ds3EMZ
         aCJpn65cF88rUYGx1bizK0LU/9ipaf2aNt3n2ZHwTRDPSe0d2n5WLqGv9ekSp+9S+p
         MPaBVqJDwYdhDjQjegNFyunv7KcaHcBO3gUWQGQI=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U8RtqX033168
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 03:27:55 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 03:27:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 03:27:55 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U8RpZV083330;
        Wed, 30 Sep 2020 03:27:52 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
CC:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v2 0/4] mtd: hyperbus: hbmc-am654: Add DMA support
Date:   Wed, 30 Sep 2020 13:57:49 +0530
Message-ID: <160145373830.11652.18386065887476104991.b4-ty@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924081214.16934-1-vigneshr@ti.com>
References: <20200924081214.16934-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Sep 2020 13:42:10 +0530, Vignesh Raghavendra wrote:
> This series add DMA support for reading data from HyperBus memory
> devices for TI's AM654/J721e SoCs
> 
> With DMA there is ~5x improvement in read througput.
> 
> v2:
> Fix DMAengine APIs usage issues pointed out by Peter.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git cfi/next, thanks!
[1/4] mtd: hyperbus: Provide per device private pointer
      https://git.kernel.org/mtd/c/714fb2fbe7
[2/4] mtd: hyperbus: hbmc-am654: Fix direct mapping setup flash access
      https://git.kernel.org/mtd/c/aca31ce968
[3/4] mtd: hyperbus: hbmc-am654: Drop pm_runtime* calls from probe
      https://git.kernel.org/mtd/c/992df3bb35
[4/4] mtd: hyperbus: hbmc-am654: Add DMA support for reads
      https://git.kernel.org/mtd/c/00c9cf49a6

--
Regards
Vignesh

