Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4512796EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 06:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgIZEbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 00:31:17 -0400
Received: from m12-16.163.com ([220.181.12.16]:40863 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729926AbgIZEbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 00:31:17 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Sep 2020 00:31:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=wgZYw
        PIZh8sIPpZ6ltIViSprmgLuN1DsPWbAqEjddWQ=; b=WEyeUiyJ6sjABIIP4SqbM
        +pnkSqHACv1S0mbxcS44hqlg7q+4iOxsuwApyBDJhcoMPg2v6/RQ9vAetzzPfsn4
        RzGKHS1FVBfzZ/gY1PKMTGmDG0sFf6CXkX44HmWxZLB+Z7cVNJChRKkfMmED2Vvd
        eaiBSbSIq/jsy7MjA1oKOE=
Received: from localhost (unknown [101.86.214.224])
        by smtp12 (Coremail) with SMTP id EMCowADXLI5ewG5fx0_NCw--.32388S2;
        Sat, 26 Sep 2020 12:15:27 +0800 (CST)
Date:   Sat, 26 Sep 2020 12:15:26 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm,oom_kill: fix the comment of is_dump_unreclaim_slabs()
Message-ID: <20200926041526.GA179745@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EMCowADXLI5ewG5fx0_NCw--.32388S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr18tFy8GFWkuFy8trWxCrg_yoW3WrgEya
        yjgwnrKrWDua9xCFn2kwn3Jry2grs5ZFW5XF1xtry7try5Zw1fWFWIkr1UCFy5Za1xCas8
        XF1xG3y3A34avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0xwIDUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitx+rX1aEFv0RngAAsq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the comment of is_dump_unreclaim_slabs(), it just check
whether nr_unreclaimable slabs amount is greater than user
memory.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/oom_kill.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index e90f25d6385d..a4a47559abcd 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -168,9 +168,9 @@ static bool oom_unkillable_task(struct task_struct *p)
 	return false;
 }
 
-/*
- * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
- * than all user memory (LRU pages)
+/**
+ * Check whether unreclaimable slabs amount is greater than
+ * all user memory(LRU pages).
  */
 static bool is_dump_unreclaim_slabs(void)
 {
-- 
2.25.1


