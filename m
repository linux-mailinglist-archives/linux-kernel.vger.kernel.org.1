Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC14A2B6AA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 17:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgKQQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 11:49:44 -0500
Received: from m12-13.163.com ([220.181.12.13]:40163 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbgKQQto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 11:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=0kJRm
        r4J72jwh/DQ8J2Hn1LSz9YEVVyO0Q8Q29QpUT0=; b=C9rNxyGL3AtlGGxtIBYm1
        qPBLzJBCe1vJ/ULlazMLGHol+V4y8CdNS71kp63+fMhPasNAKZwVq1Mk9tvQQ05j
        FHxOQweDyKIvB2mtqOxQtFfklG8Wc0Wotvhs4qHI+JpMYoktyrawdIG3g+QBUoKZ
        am6oZC+OPKdldhfUJnSBbw=
Received: from localhost (unknown [101.86.213.141])
        by smtp9 (Coremail) with SMTP id DcCowACnvXoP_7Nfk7jURA--.60410S2;
        Wed, 18 Nov 2020 00:49:20 +0800 (CST)
Date:   Wed, 18 Nov 2020 00:49:19 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] mm/lru: simplify is_file_lru() and is_active_lru()
Message-ID: <20201117164919.GA82821@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowACnvXoP_7Nfk7jURA--.60410S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKFWxXw4DGr48JFWfAr18Zrb_yoW3Cwc_ua
        y8A3WkJwsxXrnrWw40k3ZrJ3yYk3W7XF4kZF95tw4IyrnxKws8K34kCr4qqr4kWay29ryU
        W3W09ryfur13GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRiwID3UUUUU==
X-Originating-IP: [101.86.213.141]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDhDfX1rbLE6IsgAAsH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page->lru bit 0 can tell whether the page is
avtive page or not.
page->lru bit 1 can tell whether the page is
file page or not.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/mmzone.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
-- 
2.29.0


