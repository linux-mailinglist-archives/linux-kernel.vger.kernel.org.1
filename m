Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CA275D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIWQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:49336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWQ3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:29:24 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7E5120708;
        Wed, 23 Sep 2020 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600878564;
        bh=wEdP9FXhax0ON6y8WUr3LDvYc1+6aZORh0IBDJ7jXV8=;
        h=From:To:Cc:Subject:Date:From;
        b=czt6RXCiHuJAavrW0jJRvhgIYC1+qZFt2p3A0UKg/zpTbyyTAvNbG4kNR+Gfvc653
         DxzGm5XjoVgw+fn2dnDdcyHfGYrlMbTuSMzUHuFh6AvCXV8JHtyqU6+jfzCtjn3j1S
         QwVtFJKBzJoTI4joOQCQHULY7WRboBWKiCPymA+w=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm: remove unused early_pfn_valid()
Date:   Wed, 23 Sep 2020 19:29:15 +0300
Message-Id: <20200923162915.26935-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The early_pfn_valid() macro is defined by it is never used.
Remove it.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 include/linux/mmzone.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..38264363b0d4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1376,7 +1376,6 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #define pfn_to_nid(pfn)		(0)
 #endif
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1396,10 +1395,6 @@ struct mminit_pfnnid_cache {
 	int last_nid;
 };
 
-#ifndef early_pfn_valid
-#define early_pfn_valid(pfn)	(1)
-#endif
-
 /*
  * If it is possible to have holes within a MAX_ORDER_NR_PAGES, then we
  * need to check pfn validity within that MAX_ORDER_NR_PAGES block.
-- 
2.28.0

