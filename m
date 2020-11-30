Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1142C84E9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgK3NR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgK3NR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:17:28 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D38CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:16:42 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e23so5206633pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=226PRqqx4Z2LZBrOf7jo3xFAshxZxY1K5Av0IyZmLV8=;
        b=w5OaFM++CbyizHmFtWxrqNE2GwBOC3K+1Qs+6z5tw4698a+6zKHG9CLWmyRpu+gclB
         SvRVASmaAfdvhUhf24PPU/z7L6MKxePJ2lfb9b26TzzMmUymucWDyEIj+V8mFVWdqhL4
         f8WBeedivcYkuo/5oWBIId4CPG/YrpNwqOQwARStdktbDAZ9HHY1c5lJsi+hEH9wzJNK
         AmPoL1JyBMdzNrA3mpA2o2ioM6tybucVmd6R7XdwvBPD+J7uTCWmCBx/v63ASnQecu7r
         hsa9pkb0/dFdC9KXO7/FvZz0CRsVy9rHEsZ7r/Qi/F+TprzlhG+1ukYSoupzsqu7s55h
         tqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=226PRqqx4Z2LZBrOf7jo3xFAshxZxY1K5Av0IyZmLV8=;
        b=TeKFOXkJTewWHfEmfOnYCh1aDRfIys/A3PK9YB1ZBGbWGPc0NDa3K+yRJhyMUZcxf4
         z+UVlj+7kwbebTS3UHOvac4CB9fBnVn5zK6LADeOnpA2l1K73p/QrfHZuAKyNyxpnBPN
         4L9QvDC8e7zxygpHYq7IhsvaNIEW+GfcHmTKx7bJbN4fPLj6u02rEiwcGb07rEMWJ9vW
         eIiCxtpv5f5XE/TFofR3IrajTeS8Z3dQtPKZgRIs0wnRqXPpdGOPshnzkAJSCE8UyWIG
         entV+UNoCnHTbnw8qM1oOGbIA6oGwIVehjn2TGWHaqNfFZYWZ9ClAMmQE4uY+oKJOeSy
         VoQA==
X-Gm-Message-State: AOAM530AcOvDyXvDp+jXuIhun+s7wyscK70Xo0Ftjgqo84iOXPS+r2/t
        5e3Lme0jOkZUVhP2xBer9PcVxQ==
X-Google-Smtp-Source: ABdhPJwhbJ9stRuaGwCkRVStLBXXGgX9xkRJz4yAVBzafCl5rScsuBdxryMiEvgAb8af5habdGPybQ==
X-Received: by 2002:a65:4548:: with SMTP id x8mr9094151pgr.163.1606742201853;
        Mon, 30 Nov 2020 05:16:41 -0800 (PST)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id j16sm16943134pgl.50.2020.11.30.05.16.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 05:16:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        guro@fb.com, sfr@canb.auug.org.au, alex.shi@linux.alibaba.com,
        alexander.h.duyck@linux.intel.com, laoar.shao@gmail.com,
        richard.weiyang@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm/memcg: fix NULL pointer dereference at workingset_eviction
Date:   Mon, 30 Nov 2020 21:15:12 +0800
Message-Id: <20201130131512.6043-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found a case of kernel panic. The stack trace is as follows
(omit some irrelevant information):

    BUG: kernel NULL pointer dereference, address: 00000000000000c8
    RIP: 0010:workingset_eviction+0x26b/0x450
    Call Trace:
     __remove_mapping+0x224/0x2b0
     shrink_page_list+0x8c2/0x14e0
     shrink_inactive_list+0x1bf/0x3f0
     ? do_raw_spin_unlock+0x49/0xc0
     ? _raw_spin_unlock+0xa/0x20
     shrink_lruvec+0x401/0x640

This was caused by commit 76761ffa9ea1 ("mm/memcg: bail out early when
!memcg in mem_cgroup_lruvec"). When the parameter of memcg is NULL, we
should not use the &pgdat->__lruvec. So this just reverts commit
76761ffa9ea1 to fix it.

Fixes: 76761ffa9ea1 ("mm/memcg: bail out early when !memcg in mem_cgroup_lruvec")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f9a496c4eac7..a1416205507c 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -610,17 +610,20 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
 static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
 					       struct pglist_data *pgdat)
 {
+	struct mem_cgroup_per_node *mz;
 	struct lruvec *lruvec;
 
-	if (mem_cgroup_disabled() || !memcg) {
+	if (mem_cgroup_disabled()) {
 		lruvec = &pgdat->__lruvec;
-	} else {
-		struct mem_cgroup_per_node *mz;
-
-		mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
-		lruvec = &mz->lruvec;
+		goto out;
 	}
 
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
+	lruvec = &mz->lruvec;
+out:
 	/*
 	 * Since a node can be onlined after the mem_cgroup was created,
 	 * we have to be prepared to initialize lruvec->pgdat here;
-- 
2.11.0

