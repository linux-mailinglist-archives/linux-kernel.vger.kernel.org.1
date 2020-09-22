Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99B2740CC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIVL2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:28:30 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:12066 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVL2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:28:30 -0400
Received: from ubuntu.localdomain (unknown [157.0.31.124])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 15BAC481928;
        Tue, 22 Sep 2020 19:28:28 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Bernard Zhao <bernard@vivo.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] mtd/map: fix typoes for struct memcard
Date:   Tue, 22 Sep 2020 04:28:02 -0700
Message-Id: <20200922112814.26761-1-bernard@vivo.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSUhCGUtNGU1OQhkdVkpNS0tMTE9KS0NJTkpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6EDo4Kz8hGg5CC08WMUsC
        Mk8wCh1VSlVKTUtLTExPSktDTUhOVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU9ZV1kIAVlBSkJLTzcG
X-HM-Tid: 0a74b592741c93bakuws15bac481928
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change struct memcard`s element "removeable" -> "removable".

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/mtd/maps/vmu-flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 177bf134e189..d48ecbdb007a 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -40,7 +40,7 @@ struct memcard {
 	u32 blocklen;
 	u32 writecnt;
 	u32 readcnt;
-	u32 removeable;
+	u32 removable;
 	int partition;
 	int read;
 	unsigned char *blockread;
@@ -619,7 +619,7 @@ static int vmu_connect(struct maple_device *mdev)
 	card->blocklen = ((basic_flash_data >> 16 & 0xFF) + 1) << 5;
 	card->writecnt = basic_flash_data >> 12 & 0xF;
 	card->readcnt = basic_flash_data >> 8 & 0xF;
-	card->removeable = basic_flash_data >> 7 & 1;
+	card->removable = basic_flash_data >> 7 & 1;
 
 	card->partition = 0;
 
-- 
2.28.0

