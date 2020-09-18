Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E826FAD0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgIRKoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:44:06 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgIRKoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:44:05 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IAhqeX062485;
        Fri, 18 Sep 2020 05:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600425832;
        bh=11/iz4CVyn0YKQ9XqTyV3nLKzBsbouQ7wrl140Vpllk=;
        h=To:CC:From:Subject:Date;
        b=A+0o6fZrC3kWN783xQn2+Yug/sVinB8tOQJkVmYrcOWEuQoUkOctky+iaIAjJ7AO3
         6lOKfJeUWWQbFoCDfzr0pBx4RxDX9YXJYZHIQS/4oJ11B0JtuZsaNApxQcLFL4kZv5
         ZGUTZdk8O8fusoONpVfRcPPIBZSn0oHUTZlO0Uso=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IAhqff111077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 05:43:52 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 05:43:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 05:43:51 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IAhmht012358;
        Fri, 18 Sep 2020 05:43:49 -0500
To:     torvalds <torvalds@linux-foundation.org>
CC:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Subject: [GIT PULL] mtd: Fixes for v5.9-rc6
Message-ID: <c6965ad6-7d32-7dd9-21f8-346cfa634147@ti.com>
Date:   Fri, 18 Sep 2020 16:13:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please pull the MTD changes for v5.9-rc6.

I am sending this on behalf of MTD maintainers group this time around.

Miquel/Richard, 

Could you please ACK the PR?

Regards
Vignesh

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.9-rc6

for you to fetch changes up to 1afc0c89f6a155c54c76d65ffcf72cd1232daf3a:

  Revert "mtd: spi-nor: Add capability to disable flash quad mode" (2020-09-14 20:58:27 +0530)

----------------------------------------------------------------
MTD/SPI NOR fixes:

Revert patches that caused non volatile Quad Enable bit to be cleared
for certain SPI NOR flashes during module remove or during shutdown, thus
breaking backward compatibility.

----------------------------------------------------------------
Yicong Yang (2):
      Revert "mtd: spi-nor: Disable the flash quad mode in spi_nor_restore()"
      Revert "mtd: spi-nor: Add capability to disable flash quad mode"

 drivers/mtd/spi-nor/core.c | 57 ++++------
 drivers/mtd/spi-nor/core.h | 10 +-
 2 files changed, 24 insertions(+), 43 deletions(-)
