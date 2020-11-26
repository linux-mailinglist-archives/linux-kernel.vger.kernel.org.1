Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3422C5D08
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgKZU0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:26:37 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:42865 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbgKZU0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:26:37 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B008E22FB3;
        Thu, 26 Nov 2020 21:26:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606422395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2yzlZJGyAc8oJLWp+osP0Je8o49g4q4ZrofRXcL0G9Q=;
        b=F4OUgSErpChVU9pdHRIdX/s8TMJeuPJ5kWZPs4v5viWDwtWCbNjXXbYqcGQNOk0CT2bvyT
        a1/fzBUZSU+IojBSvDkTvkZzVCXWM2X/Z0I8qmgZ8uVcv7L9ET47DMqC0gUPK5jsMG6WdL
        uSTW5VevFxIl6wkyMBeoQeN9tXtAMQs=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 0/5] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Thu, 26 Nov 2020 21:26:09 +0100
Message-Id: <20201126202614.5710-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I bundled this as a series, because otherwise there will be conflicts
because the "remove global protection flag" patches modify the same lines
as the main patch.

See invdividual patches for the version history.

Michael Walle (5):
  mtd: spi-nor: atmel: remove global protection flag
  mtd: spi-nor: sst: remove global protection flag
  mtd: spi-nor: intel: remove global protection flag
  mtd: spi-nor: atmel: Fix unlock_all() for AT25FS010/040
  mtd: spi-nor: keep lock bits if they are non-volatile

 drivers/mtd/spi-nor/Kconfig |  42 ++++++++
 drivers/mtd/spi-nor/atmel.c | 190 ++++++++++++++++++++++++++++++++----
 drivers/mtd/spi-nor/core.c  |  38 +++++---
 drivers/mtd/spi-nor/core.h  |   9 ++
 drivers/mtd/spi-nor/esmt.c  |   2 +-
 drivers/mtd/spi-nor/intel.c |  19 ++--
 drivers/mtd/spi-nor/sst.c   |  31 +++---
 7 files changed, 268 insertions(+), 63 deletions(-)

-- 
2.20.1

