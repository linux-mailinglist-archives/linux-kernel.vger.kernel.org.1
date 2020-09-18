Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC8B26F2C1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgIRDBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 23:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730513AbgIRDBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379DAC061226
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:16 -0700 (PDT)
Received: by mail-il1-x14a.google.com with SMTP id m10so3467607ild.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 20:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xN4oCimHvtKPjnmxoot3/TeH/iRIHwliUhH4EqN3ncs=;
        b=fU4u9XAvUyFqc0FXzkoK3nY8UyYBJi56mVd5IZCcXi/06TGZR06LJCa+NOPHM3hx5H
         8Vi3W7LOmppBEorAX04u1pMD7lMDWoBkZcEincebTf9bbeQxEh8HW9PUgpnfbnIiTN68
         9o3rBJyuwDc99b0fhHU1oNUDG0h0Xw75vzSSkA7/1SEM82CPXoLce4PfkqRWQAge/aP1
         Rr3vbi5Ff/5NyfDZijt1PVK9pMQ3ZenSPV/g81k0fLtiRMiEN9M2k+0pcyo20SO7gWLn
         f1YuRnutJIYrgSOmdTnSMQMra+rHNsxOPkCkC5iCVj4JFgIYvEDVqVZbRoBajtVwrWsH
         Lc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xN4oCimHvtKPjnmxoot3/TeH/iRIHwliUhH4EqN3ncs=;
        b=UcnxGo5qY4ttHgFUatNXg0ViLAGyD5HRu7avGo2c/EXdwJsSMyS8+rS4bTJLv+njXO
         BMu6ykR4/GpgFIfpFQvNdKQi5Aqc/qnGcmgpzJ5Ne/rVH2VU1rXI6CTOfRSwAXuJ71LS
         S69iXNi0XMgU5cMYQEDXbw9GJrOgWX3fOwqjY1SXkJdzDXmpOguaWwx5gZ9gJ18ZQp0p
         gzzbmrN/DuiyuGZyq9cSJl/uwud5qArNcuPD42Al2T4wuVfDsjtwkne++QbLMyUTPzdp
         EFRQT1xVReozdzLpHeCXwUufE56L63mTI/YrI5nTRPGpM+bbmFROM0ZBndo2sjuyzmzR
         mVTg==
X-Gm-Message-State: AOAM531QIXrsFGgjnKUDBEh6ddFVnAintYu3gDFxNuGAhhqS7RI0PP1Y
        jDbbYcqUerW+E5mMv3ymM/VBflvhti8=
X-Google-Smtp-Source: ABdhPJxoASGjkRdX7gV5owKUKpPt2SzP5/4sSvfrQT5kIgM3rBNQPtBrjsZo7vBQgv022JrvE7jKBpKaBVw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a92:1fd9:: with SMTP id f86mr27888282ilf.250.1600398075411;
 Thu, 17 Sep 2020 20:01:15 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:50 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-13-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 12/13] mm: make lruvec_lru_size() static
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other references to the function were removed after
commit b910718a948a ("mm: vmscan: detect file thrashing at the reclaim root")

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mmzone.h | 2 --
 mm/vmscan.c            | 3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 8379432f4f2f..c2b1f1d363cc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -842,8 +842,6 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
 #endif
 }
 
-extern unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx);
-
 #ifdef CONFIG_HAVE_MEMORYLESS_NODES
 int local_memory_node(int node_id);
 #else
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4688e495c242..367843296c21 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -312,7 +312,8 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
  * @lru: lru to use
  * @zone_idx: zones to consider (use MAX_NR_ZONES for the whole LRU list)
  */
-unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
+static unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru,
+				     int zone_idx)
 {
 	unsigned long size = 0;
 	int zid;
-- 
2.28.0.681.g6f77f65b4e-goog

