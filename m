Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BCB2F35D9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392765AbhALQdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:33:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388991AbhALQdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:33:19 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7CEC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:32:38 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id p14so2340088qke.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSfbgJHMgHLM9rzB5N8TPqwylQdBK6aN3u6pmU/8Jk4=;
        b=XRtRi+npxUhv1aIaFonEpF9d9xK4DvoowayUJ3B3qkBd1aLaEH2E7JKQzu/AV9pDOT
         fIETBbFsDj6lgUWnkEQOnMgb7rUD27wGjJ5x5wHlEWIAsCLQgmMLTbbFJKgO6jhO5aFm
         4xwavol2Mz98x5eMv0tqfMrRy+KoNbmEtxmNcHHm2cFTepKbx9AmChWp/aH65taw8I7q
         MYxPRcAhTffnCW9cbjoc4FdWKHgpDC4bT+m0LLWJAmr4sKbd8tpTA4wO5kOY8VehxlL7
         tABlka6b/ikymYrABypNGD7TfR74nzqfsrYHaT9I0xbrxyLhmu4wIAZH3UjsqchkNTx6
         2fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aSfbgJHMgHLM9rzB5N8TPqwylQdBK6aN3u6pmU/8Jk4=;
        b=o7SrsWAayzeW+o6ux3X3CRnb8I7pGhy/V3nxzIFOjGINVWIl2vfhfNl/OGRt2MtlM9
         hFCbpG/8xCwuDQx1/00YbKJ9h8UhjVpAwiJCnZDMC53ezI82onWJgXphjJ2XkM7PrYAN
         FSRE94wSavW1Y0xFx26l7c0uRtXA2QHbY+V/G76/E2FbJrnekkAi4SonY6+NBV14IBtA
         3BReD+rv0ylKC3hYONNWeJw244Wq/p5ShLaQY6HgIOA5/Jwm2hC+fzSQ/UvCjJb2+tGe
         Rvt8P+WZWa5EcmXgJTOit+OSBEk/uHpXVfz3raDwlVZ5lWXpxjj7ThjE93hyYiQhsFtq
         c6LA==
X-Gm-Message-State: AOAM531lsQNkjWA0OwVEMqmfwkuS772pUPhlPpewA75cY/h7HdisEjws
        MVVxM3uykvX0v6gXUBvA03P57Q==
X-Google-Smtp-Source: ABdhPJxHrShkZ/TEBY6Kc+dwor37fO2ZPO8LEL1PAw3K5sR2T3rxsJacgtbo9WyiKHFNnedWpoGcog==
X-Received: by 2002:a37:aace:: with SMTP id t197mr89781qke.175.1610469157955;
        Tue, 12 Jan 2021 08:32:37 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:1fb4])
        by smtp.gmail.com with ESMTPSA id m190sm1530954qkb.42.2021.01.12.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:32:37 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: memcontrol: prevent starvation when writing memory.high
Date:   Tue, 12 Jan 2021 11:30:11 -0500
Message-Id: <20210112163011.127833-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a value is written to a cgroup's memory.high control file, the
write() context first tries to reclaim the cgroup to size before
putting the limit in place for the workload. Concurrent charges from
the workload can keep such a write() looping in reclaim indefinitely.

In the past, a write to memory.high would first put the limit in place
for the workload, then do targeted reclaim until the new limit has
been met - similar to how we do it for memory.max. This wasn't prone
to the described starvation issue. However, this sequence could cause
excessive latencies in the workload, when allocating threads could be
put into long penalty sleeps on the sudden memory.high overage created
by the write(), before that had a chance to work it off.

Now that memory_high_write() performs reclaim before enforcing the new
limit, reflect that the cgroup may well fail to converge due to
concurrent workload activity. Bail out of the loop after a few tries.

Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
Cc: <stable@vger.kernel.org> # 5.8+
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671203ef..63a8d47c1cd3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6275,7 +6275,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
-		unsigned long reclaimed;
 
 		if (nr_pages <= high)
 			break;
@@ -6289,10 +6288,10 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			continue;
 		}
 
-		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
-							 GFP_KERNEL, true);
+		try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
+					     GFP_KERNEL, true);
 
-		if (!reclaimed && !nr_retries--)
+		if (!nr_retries--)
 			break;
 	}
 
-- 
2.30.0

