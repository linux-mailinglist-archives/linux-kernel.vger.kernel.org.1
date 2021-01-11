Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A32F0F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbhAKJhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:37:51 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:44550 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728062AbhAKJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:37:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ULL1QpG_1610357816;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULL1QpG_1610357816)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Jan 2021 17:37:02 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] ata: style: Simplify bool comparison
Date:   Mon, 11 Jan 2021 17:36:55 +0800
Message-Id: <1610357815-69958-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./include/linux/ata.h:621:5-25: WARNING: Comparison of 0/1 to bool
variable

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 include/linux/ata.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ata.h b/include/linux/ata.h
index 6e67ade..89245f3 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -618,7 +618,7 @@ static inline bool ata_id_has_flush(const u16 *id)
 
 static inline bool ata_id_flush_enabled(const u16 *id)
 {
-	if (ata_id_has_flush(id) == 0)
+	if (!ata_id_has_flush(id))
 		return false;
 	if ((id[ATA_ID_CSF_DEFAULT] & 0xC000) != 0x4000)
 		return false;
-- 
1.8.3.1

