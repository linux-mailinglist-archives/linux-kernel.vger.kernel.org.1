Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6129C10D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1811613AbgJ0RVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:21:40 -0400
Received: from m12-15.163.com ([220.181.12.15]:54574 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1795239AbgJ0RVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:21:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=7iC1B
        g63LnwLLyjyKl+KfHw1n3wjgF5SyvewtftGbW8=; b=pTvlvA8lpXFsnDPlnTUpq
        VqIxb5kQGIVq+goQmwZSgck2RaXBAEeQpcA3XhbsXy09d3CLA9/2BVPdFJ41XquE
        fsEK9QqrAXci31PYUp4Lv8YBOokmEhkXHDI3cVQc5+LPskLXrRkI8i0aoVhVKb4d
        5MC40oNMxV10/sYr4KK4Os=
Received: from localhost (unknown [101.86.209.121])
        by smtp11 (Coremail) with SMTP id D8CowADHlfIUU5hfgOmYFA--.51943S2;
        Wed, 28 Oct 2020 01:04:20 +0800 (CST)
Date:   Wed, 28 Oct 2020 01:04:20 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, gustavo@embeddedor.com, sh_def@163.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm/list_lru: optimize condition of exiting the loop
Message-ID: <20201027170420.GA61326@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: D8CowADHlfIUU5hfgOmYFA--.51943S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtryDtr47uF1fur4UJrW8WFg_yoW8Jr4Upa
        n09rW7KFyxXF48u3y8J39ruF10grWUCrW7KrZruw1jyw13JFZxX39FkrW2qF98XFWxXFyf
        GryDCF45uF4UGwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UJwIkUUUUU=
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiIBTKX10TB9dVFAAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In list_lru_walk(), nr_to_walk type is 'unsigned long',
so nr_to_walk won't be '< 0'.

In list_lru_walk_node(), nr_to_walk type is 'unsigned long',
so *nr_to_walk won't be '< 0' too.

We can use '!nr_to_walk' instead of 'nr_to_walk <= 0', which
is more precise.

Signed-off-by: Hui Su <sh_def@163.com>
---
 include/linux/list_lru.h | 2 +-
 mm/list_lru.c            | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index 9dcaa3e582c9..b7bc4a2636b9 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -214,7 +214,7 @@ list_lru_walk(struct list_lru *lru, list_lru_walk_cb isolate,
 	for_each_node_state(nid, N_NORMAL_MEMORY) {
 		isolated += list_lru_walk_node(lru, nid, isolate,
 					       cb_arg, &nr_to_walk);
-		if (nr_to_walk <= 0)
+		if (!nr_to_walk)
 			break;
 	}
 	return isolated;
diff --git a/mm/list_lru.c b/mm/list_lru.c
index 5aa6e44bc2ae..39b8d467159d 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -304,7 +304,7 @@ unsigned long list_lru_walk_node(struct list_lru *lru, int nid,
 							nr_to_walk);
 			spin_unlock(&nlru->lock);
 
-			if (*nr_to_walk <= 0)
+			if (!*nr_to_walk)
 				break;
 		}
 	}
-- 
2.25.1


