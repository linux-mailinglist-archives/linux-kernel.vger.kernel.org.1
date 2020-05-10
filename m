Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3C31CCE2A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 23:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgEJVSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 17:18:14 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:41575 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbgEJVSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 17:18:13 -0400
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D65C0200002;
        Sun, 10 May 2020 21:18:11 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Remove Xiaolei Li and mark MTK NFC as orphaned
Date:   Sun, 10 May 2020 23:18:09 +0200
Message-Id: <20200510211809.15610-2-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200510211809.15610-1-miquel.raynal@bootlin.com>
References: <20200510211809.15610-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaolei's address is bouncing, remove him from MAINTAINERS and mark
the driver he was maintaining, Mediatek's, as orphaned.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---

Changes in v2:
* None.

 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7dfaf98c69a2..d01d8019a17b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10722,9 +10722,8 @@ F:	Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 F:	drivers/i2c/busses/i2c-mt7621.c
 
 MEDIATEK NAND CONTROLLER DRIVER
-M:	Xiaolei Li <xiaolei.li@mediatek.com>
 L:	linux-mtd@lists.infradead.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/mtd/mtk-nand.txt
 F:	drivers/mtd/nand/raw/mtk_*
 
-- 
2.20.1

