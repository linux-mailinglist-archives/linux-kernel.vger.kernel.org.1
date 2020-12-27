Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44B32E325E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 19:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL0SOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 13:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgL0SOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 13:14:11 -0500
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D90C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 10:13:31 -0800 (PST)
Received: by mail-ua1-x94a.google.com with SMTP id b38so2726289uab.19
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=xnWBSJPhozInRwppdn26D5arQOhyJfW1ESk6fdr40LY=;
        b=Dq/IHpw1gtGkzq5FLK/NHtIAnUq2oqWzMLwgYRvTVAfZpIRHDmLWc65E2hDSOJ2FXh
         wPPxoEBceQFulXVt8Vkej4uoC8IFNalCxyyZG2Z7Qhz4gMg9MjB2j2vvyDmnCWSUv/KJ
         bvhWE+tL7sJQ5JFIxJARhcjnAvEhFXS2Xk64bHkw/yW1OYQ2B8QGUu12/bNGdjiUrSmr
         IcqmBZn6jf8NNp0HcFxJZ7bvCPQMK8Ib3OsxbmRmKujlxbO22gilrOILbjnF3HUgUkkk
         UR/SmyQjJIcLSdUqFIkHJ6pYPkCUBDjqJlYTB6h27QJEuz/rhV/E9KLlWMpI9cUSi+JC
         +Jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=xnWBSJPhozInRwppdn26D5arQOhyJfW1ESk6fdr40LY=;
        b=PC7EOx1PGz/zzD0YJJC7ILKAbH6oc4KxY8sO+ZJ2pMmT3HhdH/JJ+KW5NEbUfAitEI
         HsmkNJCZ4r3t8RHTy8+3knwBI8coZD84GN1kQvmw6Q5zbrG5ulhAgM8Iy/Sd8aI+Wbg2
         SIegi9nTUBe6wiJF+TdeVEh2MakVj0FbATHLrZdMUTnFfTEnySwMUoKXTDI1o8ssiM0u
         5/fhoExQzL5dybIUNtb+jMyX0ahdM1HoOzjZobZMZ2AtG3mapYRodmx4GExDPWWbBG6X
         A1/9LNwAxWMdVMiLZyP+u2bS18XoAJMAUGuFV1nj4nKzBB3UeaBMqqtCBHJYMkuEsT/b
         Msdg==
X-Gm-Message-State: AOAM5331O/5jz7a4xJ8bM1/ETAFd8Et/pWgTYgKiQXgy5h/Y8MH6JsWs
        zoqDDxxjhqNNp0HCKTax8nedX1SxqVGOzQ==
X-Google-Smtp-Source: ABdhPJzVt16basKGWI1Gpn+7yjVPDL14/z76m7CLZwmqFQftj6zP/jIgLYhUlGhca05J8cLYugqWEjItDownsQ==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([100.116.77.44]) (user=shakeelb
 job=sendgmr) by 2002:a67:1dc4:: with SMTP id d187mr24330187vsd.53.1609092809691;
 Sun, 27 Dec 2020 10:13:29 -0800 (PST)
Date:   Sun, 27 Dec 2020 10:13:09 -0800
Message-Id: <20201227181310.3235210-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 1/2] mm: memcg: fix memcg file_dirty numa stat
From:   Shakeel Butt <shakeelb@google.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel updates the per-node NR_FILE_DIRTY stats on page migration
but not the memcg numa stats. That was not an issue until recently the
commit 5f9a4f4a7096 ("mm: memcontrol: add the missing numa_stat interface
for cgroup v2") exposed numa stats for the memcg. So fixing the
file_dirty per-memcg numa stat.

Fixes: 5f9a4f4a7096 ("mm: memcontrol: add the missing numa_stat interface for cgroup v2")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index ee5e612b4cd8..613794f6a433 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -500,9 +500,9 @@ int migrate_page_move_mapping(struct address_space *mapping,
 			__inc_lruvec_state(new_lruvec, NR_SHMEM);
 		}
 		if (dirty && mapping_can_writeback(mapping)) {
-			__dec_node_state(oldzone->zone_pgdat, NR_FILE_DIRTY);
+			__dec_lruvec_state(old_lruvec, NR_FILE_DIRTY);
 			__dec_zone_state(oldzone, NR_ZONE_WRITE_PENDING);
-			__inc_node_state(newzone->zone_pgdat, NR_FILE_DIRTY);
+			__inc_lruvec_state(new_lruvec, NR_FILE_DIRTY);
 			__inc_zone_state(newzone, NR_ZONE_WRITE_PENDING);
 		}
 	}
-- 
2.29.2.729.g45daf8777d-goog

