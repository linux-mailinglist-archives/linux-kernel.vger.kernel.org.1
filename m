Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A022A0E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgJ3S6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:58:11 -0400
Received: from m12-14.163.com ([220.181.12.14]:35101 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3S6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=FTOYd
        4xfiIeQjxtwB6Cv+3cAXXCIcv2qvGvBd4ClkuI=; b=XUYL0Rt5gE4mFraONWcOn
        Vy7rfuZfKcF0InNH+LVF9XO+IzhklNV7TMzZYUQ5Y5Pp3oFG+y9qGjwiryIYR8ZL
        l6/f8RPlD5ELgUE8PEKaojmZut0hNzWmnWpGqGVa+B1cPmjhWnkJDcZvUl1Qz2r+
        ZvZBXvmpQzXMnLFV4LFYjI=
Received: from localhost (unknown [101.86.209.82])
        by smtp10 (Coremail) with SMTP id DsCowADHDvsOYpxfc9EpTA--.36234S2;
        Sat, 31 Oct 2020 02:57:18 +0800 (CST)
Date:   Sat, 31 Oct 2020 02:57:18 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: define flags using bit numbers
Message-ID: <20201030185718.GA150073@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowADHDvsOYpxfc9EpTA--.36234S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFy5WF4ktFW5Ww43KF1rWFg_yoW8Wr48pF
        Z0gF98Gr1FvF42k3Z2yF1DWFy8AFWDKay7Kr1j934xu3W3Xr18XF95AF45Za4rXFZ3Gay3
        uwn09347Zr1qyFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyiihUUUUU=
X-Originating-IP: [101.86.209.82]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbipA7NX1r7rHdVdwAAsg
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These flag is meant the bit numbers, they are
used like '(type & SLOTS_CACHE)' and so on.

Define these flags using bit numbers instead of
hardcoding powers of 2, which maybe better.

No change in the actual values.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/swap_slots.c | 4 ++--
 mm/swapfile.c   | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index 0357fbe70645..18e7a01fd35c 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -47,8 +47,8 @@ static void deactivate_swap_slots_cache(void);
 static void reactivate_swap_slots_cache(void);
 
 #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_enabled)
-#define SLOTS_CACHE 0x1
-#define SLOTS_CACHE_RET 0x2
+#define SLOTS_CACHE		(1 << 0)
+#define SLOTS_CACHE_RET	(1 << 1)
 
 static void deactivate_swap_slots_cache(void)
 {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c4a613688a17..a0476c121c0e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -113,14 +113,14 @@ static inline unsigned char swap_count(unsigned char ent)
 }
 
 /* Reclaim the swap entry anyway if possible */
-#define TTRS_ANYWAY		0x1
+#define TTRS_ANYWAY		(1 << 0)
 /*
  * Reclaim the swap entry if there are no more mappings of the
  * corresponding page
  */
-#define TTRS_UNMAPPED		0x2
+#define TTRS_UNMAPPED		(1 << 1)
 /* Reclaim the swap entry if swap is getting full*/
-#define TTRS_FULL		0x4
+#define TTRS_FULL		(1 << 2)
 
 /* returns 1 if swap entry is freed */
 static int __try_to_reclaim_swap(struct swap_info_struct *si,
-- 
2.29.0


