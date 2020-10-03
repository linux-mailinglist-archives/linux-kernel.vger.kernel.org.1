Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E46A28251E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJCPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 11:32:48 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:50803 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgJCPcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 11:32:48 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0E43222F9C;
        Sat,  3 Oct 2020 17:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1601739166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MVtpaSxM1HiMcCnSmoqucfjzD+ZzkXJB0QCZni0Pybw=;
        b=Z2h/JBaKtVhLD7WoFZBHwegXRTPfzwBgrR188T1syoMnup8auSqptd2TP/371XyyK8mc2h
        NLWeB2vTxK7X8+yijGFnU2HOcSPrSLkISDOysgRf7PqYwVOIdPoFLFVWZy4sRDCo6LJfbl
        XDLF/4rYXLLoAQBsSymip90ZeeYuXvQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v5 0/3] mtd: spi-nor: keep lock bits if they are non-volatile
Date:   Sat,  3 Oct 2020 17:32:32 +0200
Message-Id: <20201003153235.29762-1-michael@walle.cc>
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

Michael Walle (3):
  mtd: spi-nor: atmel: remove global protection flag
  mtd: spi-nor: sst: remove global protection flag
  mtd: spi-nor: keep lock bits if they are non-volatile

 drivers/mtd/spi-nor/Kconfig |  42 ++++++++++++
 drivers/mtd/spi-nor/atmel.c | 125 ++++++++++++++++++++++++++++++------
 drivers/mtd/spi-nor/core.c  |  36 +++++++----
 drivers/mtd/spi-nor/core.h  |   8 +++
 drivers/mtd/spi-nor/esmt.c  |   8 ++-
 drivers/mtd/spi-nor/intel.c |   6 +-
 drivers/mtd/spi-nor/sst.c   |  31 ++++-----
 7 files changed, 203 insertions(+), 53 deletions(-)

-- 
2.20.1

