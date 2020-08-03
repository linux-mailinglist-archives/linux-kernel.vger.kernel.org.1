Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BEE23A967
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 17:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgHCPcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 11:32:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39501 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:32:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id q76so14630003wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aAEEBYH/RNE6F6eih4Xf8kJGXqfcNHHmi9tjJ8DCSlI=;
        b=ZHEu9jrEGD5jfkB7KwMAUjYGFHe6d0avoeArT8Q1YCmb7TBmz/19HUwWNCgjY/HNFE
         OIx1TArP5pGgr4hIj+O1waKxpcuzI1/+0RYXU/TM7MOIgmvff5PhS0sVC5/pGFW/HhjF
         qrupkkiunMVjcB7m9T7rYcs9a0lbH98G7LuBNdMhOAE+iYWQiIbID0qzz1RS4Q0VGvyM
         2CF8moP78kRTnDvjUKSvz7/1kY8K1USjOZQHHIPOLK1SnMR3n9wsbQCcaMioM7B7w15j
         Mt5NIrA49jIMPDdkCPuDEO9zt7k3zYBBDJggms0pC70E2ZZU1qIAl7HQhfMs4ISSv/kh
         wNCA==
X-Gm-Message-State: AOAM532MMB0VSPGx7eLyX7rzwxQywA0H4lKJ0MphW0RRd7u3btWNQC1Z
        DoJtrjo48NfXMX9yUDBmolY=
X-Google-Smtp-Source: ABdhPJyjogI7x4EjysRPYcFwG3urMjXbnPLRiwE52sPayUyavtnb6nVIzYghbVaf/rmvG/kmOb0Rfg==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr515975wmf.160.1596468764859;
        Mon, 03 Aug 2020 08:32:44 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id w1sm25562444wmc.18.2020.08.03.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:32:44 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Koutny <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: Fix protection usage propagation
Date:   Mon,  3 Aug 2020 17:32:31 +0200
Message-Id: <20200803153231.15477-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Koutný <mkoutny@suse.com>

When workload runs in cgroups that aren't directly below root cgroup and
their parent specifies reclaim protection, it may end up ineffective.

The reason is that propagate_protected_usage() is not called in all
hierarchy up. All the protected usage is incorrectly accumulated in the
workload's parent. This means that siblings_low_usage is overestimated
and effective protection underestimated. Even though it is transitional
phenomenon (uncharge path does correct propagation and fixes the wrong
children_low_usage), it can undermine the indended protection
unexpectedly.

The fix is simply updating children_low_usage in respective ancestors
also in the charging path.

Fixes: 230671533d64 ("mm: memory.low hierarchical behavior")
Cc: stable # 4.18+
Signed-off-by: Michal Koutný <mkoutny@suse.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---

Hi,
I am sending this patch on behalf of Michal Koutny who is currently
on vacation and didn't get to post it before he left.

We have noticed this problem while seeing a swap out in a descendant of
a protected memcg (intermediate node) while the parent was conveniently
under its protection limit and the memory pressure was external
to that hierarchy. Michal has pinpointed this down to the wrong
siblings_low_usage which led to the unwanted reclaim.

I am adding my ack directly in this submission.

 mm/page_counter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_counter.c b/mm/page_counter.c
index c56db2d5e159..b4663844c9b3 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -72,7 +72,7 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
 		long new;
 
 		new = atomic_long_add_return(nr_pages, &c->usage);
-		propagate_protected_usage(counter, new);
+		propagate_protected_usage(c, new);
 		/*
 		 * This is indeed racy, but we can live with some
 		 * inaccuracy in the watermark.
@@ -116,7 +116,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 		new = atomic_long_add_return(nr_pages, &c->usage);
 		if (new > c->max) {
 			atomic_long_sub(nr_pages, &c->usage);
-			propagate_protected_usage(counter, new);
+			propagate_protected_usage(c, new);
 			/*
 			 * This is racy, but we can live with some
 			 * inaccuracy in the failcnt.
@@ -125,7 +125,7 @@ bool page_counter_try_charge(struct page_counter *counter,
 			*fail = c;
 			goto failed;
 		}
-		propagate_protected_usage(counter, new);
+		propagate_protected_usage(c, new);
 		/*
 		 * Just like with failcnt, we can live with some
 		 * inaccuracy in the watermark.
-- 
2.27.0

