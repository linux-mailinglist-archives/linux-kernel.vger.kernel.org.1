Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF362796F8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgIZEg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:36:27 -0400
Received: from m12-11.163.com ([220.181.12.11]:52733 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbgIZEg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Nv8xi
        E7qsf+vORc2bIdtiQeE1xHTyVYHiZvju+0MMe8=; b=MA/gZZOZp3JsMLF9SlEoG
        mV46L2/GaweXEao1JCRlRJ8hJhEQ+uzVVSV02OJCzjcaZ9vsb9mjWiCzuMzJfiuZ
        NCHIZ4CE8ODIQ1K/FeIjeVBHx4qM/Fyg3QVcgTx6lO9fSab1DnZakv4ZeiCaaMg5
        awKFiMUxR0e5jpFL29YEXc=
Received: from localhost (unknown [101.86.214.224])
        by smtp7 (Coremail) with SMTP id C8CowACnFEXhxG5fS4VPIg--.62503S2;
        Sat, 26 Sep 2020 12:34:41 +0800 (CST)
Date:   Sat, 26 Sep 2020 12:34:40 +0800
From:   Hui Su <sh_def@163.com>
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm,slab_common: use list_for_each_entry in
 dump_unreclaimable_slab()
Message-ID: <20200926043440.GA180545@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowACnFEXhxG5fS4VPIg--.62503S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFWfZFy3Jw47tF1xXr17Awb_yoWDWwb_Z3
        4ktF1UKr4UXF1fGF40kFn5GrW3W34vvF18X3Z3tFy3Jr1UKw43tw40gFsxWF95C3y0g3sx
        u34ktrnxZr17JjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0-Vy3UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiWRSrX1WBswcHrwABsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dump_unreclaimable_slab() acquires the slab_mutex first,
and it won't remove any slab_caches list entry when
itering the slab_caches lists.

Thus, we do not need list_for_each_entry_safe here,
which is against removal of list entry.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index f9ccd5dc13f3..0cd2821b7066 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -978,7 +978,7 @@ static int slab_show(struct seq_file *m, void *p)
 
 void dump_unreclaimable_slab(void)
 {
-	struct kmem_cache *s, *s2;
+	struct kmem_cache *s;
 	struct slabinfo sinfo;
 
 	/*
@@ -996,7 +996,7 @@ void dump_unreclaimable_slab(void)
 	pr_info("Unreclaimable slab info:\n");
 	pr_info("Name                      Used          Total\n");
 
-	list_for_each_entry_safe(s, s2, &slab_caches, list) {
+	list_for_each_entry(s, &slab_caches, list) {
 		if (s->flags & SLAB_RECLAIM_ACCOUNT)
 			continue;
 
-- 
2.25.1


