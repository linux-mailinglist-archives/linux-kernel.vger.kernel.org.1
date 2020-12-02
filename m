Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40B2CCA32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbgLBXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgLBXBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:01:39 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CFC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:00:59 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ADFDD23E43;
        Thu,  3 Dec 2020 00:00:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606950055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VbAeyqT69wmC7k3gUjKgzJ7BJQNzs3FcYwUcXu4/g+Q=;
        b=MtYEYxjbAQnQW4lxNQIqODTjShc19nOUglNpUlPhHBtbopfliXasR8y0Hq5fmXMNCJSRCe
        B1SaUAQrKdswL6HoXB1hC+LFJzbo6TxQbgg5Fb0T8oEbOmgv+P2tftsauh1PAoK0J4jkLH
        RopfBRstjNj99nthqlzEqN/kaXuIXvg=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v7 0/7] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Thu,  3 Dec 2020 00:00:33 +0100
Message-Id: <20201202230040.14009-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I bundled this as a series, because otherwise there will be conflicts
because the "remove global protection flag" patches modify the same lines
as the main patch.

There are now two more patches:
  mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
  mtd: spi-nor: ignore errors in spi_nor_unlock_all()
Both are fixes and are first in this series. This will ensure that they
even have a chance to apply cleanly to the stable trees as the following
patches touches the same lines.

See invdividual patches for the version history.

Michael Walle (7):
  mtd: spi-nor: sst: fix BPn bits for the SST25VF064C
  mtd: spi-nor: ignore errors in spi_nor_unlock_all()
  mtd: spi-nor: atmel: remove global protection flag
  mtd: spi-nor: sst: remove global protection flag
  mtd: spi-nor: intel: remove global protection flag
  mtd: spi-nor: atmel: fix unlock_all() for AT25FS010/040
  mtd: spi-nor: keep lock bits if they are non-volatile

 drivers/mtd/spi-nor/Kconfig |  44 +++++++++
 drivers/mtd/spi-nor/atmel.c | 191 ++++++++++++++++++++++++++++++++----
 drivers/mtd/spi-nor/core.c  |  46 ++++++---
 drivers/mtd/spi-nor/core.h  |   9 ++
 drivers/mtd/spi-nor/esmt.c  |   2 +-
 drivers/mtd/spi-nor/intel.c |  19 ++--
 drivers/mtd/spi-nor/sst.c   |  32 +++---
 7 files changed, 279 insertions(+), 64 deletions(-)

-- 
2.20.1

