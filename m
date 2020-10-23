Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B1D2974A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752324AbgJWQiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbgJWQdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:49 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AA81223EA;
        Fri, 23 Oct 2020 16:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470827;
        bh=BKM7L17mY/AVYbaBekF/DbVRgqrXGbkET0zZgx6V5Lc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACHRRoOojGyvIszgvI+ucpIl9hmgrFdRnffyViygY61ouLCIkklOJ08lfUqrZ2tOT
         y5s2W0xLg1TfwofyHpkDMud4m8qoY30JIXaftKaYcb9CRabNgler2YqVz5XmoXg6Cy
         CpBxMVEW56BXk5h3ESAzWtBF18hSNmLcSBhzbUCA=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00f-002Aw5-D2; Fri, 23 Oct 2020 18:33:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 17/56] mtd: rawnand: fix a kernel-doc markup
Date:   Fri, 23 Oct 2020 18:33:04 +0200
Message-Id: <9ed47a57d12c40e73a9b01612ee119d39baa6236.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/mtd/nand/raw/nand_bbt.c | 2 +-
 include/linux/mtd/rawnand.h     | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 344a24fd2ca8..dced32a126d9 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1087,7 +1087,7 @@ static int nand_update_bbt(struct nand_chip *this, loff_t offs)
 }
 
 /**
- * mark_bbt_regions - [GENERIC] mark the bad block table regions
+ * mark_bbt_region - [GENERIC] mark the bad block table regions
  * @this: the NAND device
  * @td: bad block table descriptor
  *
diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
index aac07940de09..ace1ce70f5e4 100644
--- a/include/linux/mtd/rawnand.h
+++ b/include/linux/mtd/rawnand.h
@@ -1286,7 +1286,8 @@ static inline bool nand_is_slc(struct nand_chip *chip)
 }
 
 /**
- * Check if the opcode's address should be sent only on the lower 8 bits
+ * nand_opcode_8bits - Check if the opcode's address should be sent only on the
+ *	lower 8 bits
  * @command: opcode to check
  */
 static inline int nand_opcode_8bits(unsigned int command)
-- 
2.26.2

