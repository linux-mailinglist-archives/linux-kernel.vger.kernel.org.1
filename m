Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7E2CCD22
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbgLCDOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 22:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLCDOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 22:14:37 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC95C061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 19:13:57 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p6so353353plo.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 19:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwVqmku+KuF7CBDwCXmp7GQf251F6L0Ar739gqzf9cU=;
        b=tITewJgNthn6PxKyqtA6y7Hsga8qG37N3FDSi29gWHRtvQG+yNxwFH68T9T2/XjU2d
         McUpVdjLgYPQlC7j8HhQPXZO+rMwHmoB1qk4zk1HY/jZ92ViyXbppXXZsVTD8iN8M8Av
         TPbPm1yTQzGCsDMl7nhuEzLoA0QSHzG+aqEYuvfqcJ/7hAouPj31QXTnaVm4ZVCEB1hy
         WGBtEaiDvKXSp9rE0YOCwfzz5B4NsC8gRkvzGjKJZx9QyHNyuspmL6hPsDRI1+P5oYzd
         kEC1TPjDhslQHfF862x4i6EA/EofAGpWNJlm9oyLEjfSng0F8LXkHEddvJadX359XlfS
         20Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rwVqmku+KuF7CBDwCXmp7GQf251F6L0Ar739gqzf9cU=;
        b=VTjlNLROI7j9AXA+yG5/KtkigW3bHgAbDCnxKeBYtGXp14cSe2vqw3KaHtpwPRnHWy
         KmQveibcinHo8WLLGu5XViqNBVM28OO5SURUliBwPcR5VLfRcmY8tP5jmGsNc2gMGNzy
         5vxzSLreDNySjCTvRTZi3BT7ZsdLnqEUgBRL4cfNOUuyXlV2QjCGKjCKs3a4KHPlXhq5
         I/VtIvbONGBuE9K5yMd3mX/0GkC3jLKC5Iz5z413VS1pGb3ovByrwQ8ksYdGHG2D5df/
         STd0dFoKGZLShtK5q6XtRJ0aYfkU5waM6FnvkBTY+N57tMoqnPPwKX/oK6254A8AdjL4
         C27g==
X-Gm-Message-State: AOAM5334Ns5Kt5xQO72mYQEOnrx12nsoY73IzLwq7vhXedj4+CB6/Hy7
        t7sX7V2HwPXFBy94+b8AlbEhTQ==
X-Google-Smtp-Source: ABdhPJzl03ea3XSeGXYOVgpi8aLf35MXOyZs4Z9pSvj8lIUn7ZAIrJEQm2Si9i8tcFkT/yKaS0jxEQ==
X-Received: by 2002:a17:90a:4093:: with SMTP id l19mr1073959pjg.218.1606965236823;
        Wed, 02 Dec 2020 19:13:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.95])
        by smtp.gmail.com with ESMTPSA id f17sm418336pfk.70.2020.12.02.19.13.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 19:13:56 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v2] mm/memcontrol: make the slab calculation consistent
Date:   Thu,  3 Dec 2020 11:11:11 +0800
Message-Id: <20201203031111.3187-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although the ratio of the slab is one, we also should read the ratio
from the related memory_stats instead of hard-coding. And the local
variable of size is already the value of slab_unreclaimable. So we
do not need to read again. Simplify the code here.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Roman Gushchin <guro@fb.com>
---
Changes in v2:
 - Add a comment in the memory_stat_format() suggested by Roman.

 mm/memcontrol.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9922f1510956..75df129b7a52 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1545,12 +1545,22 @@ static int __init memory_stats_init(void)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
+		switch (memory_stats[i].idx) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS ||
-		    memory_stats[i].idx == NR_FILE_THPS ||
-		    memory_stats[i].idx == NR_SHMEM_THPS)
+		case NR_ANON_THPS:
+		case NR_FILE_THPS:
+		case NR_SHMEM_THPS:
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
+			break;
 #endif
+		case NR_SLAB_UNRECLAIMABLE_B:
+			VM_BUG_ON(i < 1);
+			VM_BUG_ON(memory_stats[i - 1].idx != NR_SLAB_RECLAIMABLE_B);
+			break;
+		default:
+			break;
+		}
+
 		VM_BUG_ON(!memory_stats[i].ratio);
 		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
 	}
@@ -1586,9 +1596,15 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		size *= memory_stats[i].ratio;
 		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
+		/*
+		 * We are printing reclaimable, unreclaimable of the slab
+		 * and the sum of both.
+		 */
 		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
-			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+			int idx = i - 1;
+
+			size += memcg_page_state(memcg, memory_stats[idx].idx) *
+				memory_stats[idx].ratio;
 			seq_buf_printf(&s, "slab %llu\n", size);
 		}
 	}
-- 
2.11.0

