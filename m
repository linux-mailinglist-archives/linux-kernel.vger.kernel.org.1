Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBDC2B6B73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 18:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgKQRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 12:13:49 -0500
Received: from m12-12.163.com ([220.181.12.12]:33888 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727552AbgKQRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 12:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=KQwd9
        qCt8weaMSg4b6f6nBEULFHmQDCeBY2LRkzUDI4=; b=BVgsmgncqPS8bC7xfSmsj
        6F4M81F++XQTyXtcZaCfoBHQG8MBWFtfRj8/YV75ALtsUjloYwmGopOMR4c1rBJm
        Zw7gBREG4lhVPARyB9utZhl/sdsiyjQEpRIIj1U5U2tLsv1z1KWLhsLDaBMg3yiH
        eSIgFCKJhWI719yHabvc/8=
Received: from localhost (unknown [101.86.213.141])
        by smtp8 (Coremail) with SMTP id DMCowACXNh+KBLRfhdELCQ--.63434S2;
        Wed, 18 Nov 2020 01:12:42 +0800 (CST)
Date:   Wed, 18 Nov 2020 01:12:42 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117171242.GA120587@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowACXNh+KBLRfhdELCQ--.63434S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4DXw18Ww4kuFyfJrW5Wrg_yoW8Ar4rpa
        93GFW2krsYvr1UtFWDJFsF9ryrXanFvFy7AFy2gwn5JF1agFWvq3y7Kr4jqw4UWFZ5Z3WY
        9347G3y5Cay2qF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uc2-OUUUUU=
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbipAvfX1r7rfQAkAAAsH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lru_list lru bit 0 can tell whether the list is
avtive lru-list or not.
lru_list lru bit 1 can tell whether the list is
file lru-list or not.

And fix some define type in shrink_active_list()
and get_scan_count().

v1->v2:
correct the commit message, and fix the define type.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/mmzone.h | 4 ++--
 mm/vmscan.c            | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..294369c652d0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -258,12 +258,12 @@ enum lru_list {
 
 static inline bool is_file_lru(enum lru_list lru)
 {
-	return (lru == LRU_INACTIVE_FILE || lru == LRU_ACTIVE_FILE);
+	return lru & LRU_FILE;
 }
 
 static inline bool is_active_lru(enum lru_list lru)
 {
-	return (lru == LRU_ACTIVE_ANON || lru == LRU_ACTIVE_FILE);
+	return lru & LRU_ACTIVE;
 }
 
 #define ANON_AND_FILE 2
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7b4e31eac2cf..7d8ea2fc87fc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2020,7 +2020,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	struct page *page;
 	unsigned nr_deactivate, nr_activate;
 	unsigned nr_rotated = 0;
-	int file = is_file_lru(lru);
+	bool file = is_file_lru(lru);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
 	lru_add_drain();
@@ -2323,7 +2323,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 	denominator = ap + fp;
 out:
 	for_each_evictable_lru(lru) {
-		int file = is_file_lru(lru);
+		bool file = is_file_lru(lru);
 		unsigned long lruvec_size;
 		unsigned long scan;
 		unsigned long protection;
-- 
2.29.0


