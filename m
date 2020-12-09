Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E60A2D447D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730884AbgLIOhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:37:43 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39450 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLIOhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:37:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B9EaSmQ102124;
        Wed, 9 Dec 2020 08:36:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607524588;
        bh=iaQVHNYxJpWkMNbC/2TKJjISMK1mUEKpvDp5u8woOWM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lNi9IYg7OKjtdvUwjypn/M0tsNmzLTK/4vaVQWXCwvX3qsphnZSV7pbS8+eXLujZa
         GtK5bdW9z2SoSswdk/Ey9mXNOtYC0KWagg6xuYpbbfIrEwmk/D32Vq/9ZzCpcJlKOa
         iFHFo9GkotcI+iTTFBZ8pQB0235ZZGKGvWkqZE5g=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B9EaSqx041674
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 08:36:28 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 08:36:28 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 08:36:28 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B9EaPeJ075567;
        Wed, 9 Dec 2020 08:36:26 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v8 0/7] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Wed, 9 Dec 2020 20:06:10 +0530
Message-ID: <160744362728.26394.4055203896031176694.b4-ty@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201203162959.29589-1-michael@walle.cc>
References: <20201203162959.29589-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, 3 Dec 2020 17:29:52 +0100, Michael Walle wrote:
> I bundled this as a series, because otherwise there will be conflicts
> because the "remove global protection flag" patches modify the same lines
> as the main patch.
> 
> There are now two more patches:
>   mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
>   mtd: spi-nor: ignore errors in spi_nor_unlock_all()
> Both are fixes and are first in this series. This will ensure that they
> might be cherry-picked without conflicts as the following patches touches
> the same lines.
> 
> [...]

Appreciate all the hard work!

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi-nor/next, thanks!
[1/7] mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
      https://git.kernel.org/mtd/c/989d4b72ba
[2/7] mtd: spi-nor: ignore errors in spi_nor_unlock_all()
      https://git.kernel.org/mtd/c/bdb1a75e4b
[3/7] mtd: spi-nor: atmel: remove global protection flag
      https://git.kernel.org/mtd/c/e6204d4620
[4/7] mtd: spi-nor: sst: remove global protection flag
      https://git.kernel.org/mtd/c/a833383732
[5/7] mtd: spi-nor: intel: remove global protection flag
      https://git.kernel.org/mtd/c/afcf93e9d6
[6/7] mtd: spi-nor: atmel: fix unlock_all() for AT25FS010/040
      https://git.kernel.org/mtd/c/8c174d1511
[7/7] mtd: spi-nor: keep lock bits if they are non-volatile
      https://git.kernel.org/mtd/c/31ad3eff09

--
Regards
Vignesh

