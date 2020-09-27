Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3240527A26D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgI0THP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:07:15 -0400
Received: from m12-13.163.com ([220.181.12.13]:41592 "EHLO m12-13.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgI0THP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:07:15 -0400
X-Greylist: delayed 4889 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 15:07:15 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=dHBuV
        XudridnxqfNWPNN2oRSCii+hG0OIcSEYu/iFZ8=; b=iD/Q03s9Nsc7CIP50bSdo
        1Rt0h/tdYxFRl+3bxG1ZLTBrU1aeYnjOasTI6my51QbjVggf+LXuSrzyJ0VAZ6X3
        Mu2ootQbbvYjIIs5fyu7nwBzHDROi6EI5JK3s2YmlJiAQs4uTp2xsgjUTzwObCLh
        rZ5n9pMljmyQQ32wz6gZ5M=
Received: from localhost (unknown [101.86.214.224])
        by smtp9 (Coremail) with SMTP id DcCowABXpyvhvnBfM8AxIg--.47504S2;
        Mon, 28 Sep 2020 00:33:37 +0800 (CST)
Date:   Mon, 28 Sep 2020 00:33:37 +0800
From:   Hui Su <sh_def@163.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc.c: check the addr first
Message-ID: <20200927163337.GA5472@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DcCowABXpyvhvnBfM8AxIg--.47504S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDWr43tF47uw4UWw47twb_yoW3trg_Ca
        sFkr1UXrWDJanrK3W29rs0vry7KFW0y3s29F13ta93Jry8GFWfGasrXr95JrW8WrW3XF9r
        W39rZFWxJrnxJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5GPfPUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgGsX1rbKaQU4AAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comments said, if @addr is NULL, no operation
is performed, check the addr first in vfree() and
vfree_atomic() maybe a better choice.

Signed-off-by: Hui Su <sh_def@163.com>
---
 mm/vmalloc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index be4724b916b3..1cf50749a209 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2305,10 +2305,11 @@ void vfree_atomic(const void *addr)
 {
 	BUG_ON(in_nmi());
 
-	kmemleak_free(addr);
-
 	if (!addr)
 		return;
+
+	kmemleak_free(addr);
+
 	__vfree_deferred(addr);
 }
 
@@ -2340,13 +2341,13 @@ void vfree(const void *addr)
 {
 	BUG_ON(in_nmi());
 
+	if (!addr)
+		return;
+
 	kmemleak_free(addr);
 
 	might_sleep_if(!in_interrupt());
 
-	if (!addr)
-		return;
-
 	__vfree(addr);
 }
 EXPORT_SYMBOL(vfree);
-- 
2.25.1


