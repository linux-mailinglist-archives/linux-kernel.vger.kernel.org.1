Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCAF300C17
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730279AbhAVTIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbhAVSoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:44:24 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB726C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:43:44 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 19so6143476qkh.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9fNjhrnoyOFnHJ9WQ+/Ta+coPGgxGkP5OqAw7eb4FE=;
        b=jZfX+8gSvsMknjij2NXiIkewNvE/gS0U3cVGRcyPmCqSxmENCBZB94bg9qNEDpz1/6
         EraLaqdwbEc4JCtd9r5PpiJZrDTX7sq3ubzrQkZDk37siT5lhYY+2d86mkxF/54wMn6I
         FFW2rpjqkRxx58b4cmvX5LghbDFYl6D9T1qiLQIrf9H0/Bm4zCQjT3lPd29XyUUTsyWW
         JErij86cT0276L6OHd2ics2wWE8glvLdLu7uHZiKNM6MBGiI+DCKpcAUKMGjRuiCo+tE
         5IOV2/n++vOYBzOW3Dja7cVPBGgJKROdI78/O8suUL/c0aHEqbgDjxPMVcUaAYd1rEuH
         YIHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C9fNjhrnoyOFnHJ9WQ+/Ta+coPGgxGkP5OqAw7eb4FE=;
        b=LBsYIq/y+jeZWmXGXuLrxSf1nzcZR4li9VYiN4nhSDiMaPt+Hc0TJRL+Qx+O670R2x
         f07DoBzK58Dv9JKBAjv5rfuL4f2rXj15I1xBRb9ZAaBYzEOCG7UMF/XtqK/C5c4O8FRJ
         PAd4qbbApxO27/3KOBn6DDfMup4ref4Qtk3/VSRv2ajtunwEU+5okHp6FWyXAKhRprET
         yLasLaBtRNV1VCGVyJFNzClUE4aTEC4YCqq+Vyq7R3QqEHUf2J3r3fer8SIPqzHuOCPa
         BMDPJzDnGRB+8CyQEODMSONcyM56opHqxLXHzL1VcVrcG5g+ZswqA4Lb7Oj3eFiKVRzO
         wrHQ==
X-Gm-Message-State: AOAM533QQjU57OOLyU9PeI6Oe13mFHlwsrLdqmB9LOj2BWmLuo4JlJue
        ut8GDx1VqdmVSB8fLhHpqE0FEQ==
X-Google-Smtp-Source: ABdhPJxPINKbhhsKe9/jTOjmTNsgfz8lXr+DTPt12mOvOHrzFu8u8RyYYax30EeJNoeW4KXB6egXuA==
X-Received: by 2002:a05:620a:205a:: with SMTP id d26mr2334943qka.288.1611341023991;
        Fri, 22 Jan 2021 10:43:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:589b])
        by smtp.gmail.com with ESMTPSA id l204sm6940425qke.56.2021.01.22.10.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 10:43:42 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] Revert "mm: memcontrol: avoid workload stalls when lowering memory.high"
Date:   Fri, 22 Jan 2021 13:43:41 -0500
Message-Id: <20210122184341.292461-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
can cause writers to memory.high to get stuck in the kernel forever,
performing page reclaim and consuming excessive amounts of CPU cycles.

Before the patch, a write to memory.high would first put the new limit
in place for the workload, and then reclaim the requested delta. After
the patch, the kernel tries to reclaim the delta before putting the
new limit into place, in order to not overwhelm the workload with a
sudden, large excess over the limit. However, if reclaim is actively
racing with new allocations from the uncurbed workload, it can keep
the write() working inside the kernel indefinitely.

This is causing problems in Facebook production. A privileged
system-level daemon that adjusts memory.high for various workloads
running on a host can get unexpectedly stuck in the kernel and
essentially turn into a sort of involuntary kswapd for one of the
workloads. We've observed that daemon busy-spin in a write() for
minutes at a time, neglecting its other duties on the system, and
expending privileged system resources on behalf of a workload.

To remedy this, we have first considered changing the reclaim logic to
break out after a couple of loops - whether the workload has converged
to the new limit or not - and bound the write() call this way.
However, the root cause that inspired the sequence change in the first
place has been fixed through other means, and so a revert back to the
proven limit-setting sequence, also used by memory.max, is preferable.

The sequence was changed to avoid extreme latencies in the workload
when the limit was lowered: the sudden, large excess created by the
limit lowering would erroneously trigger the penalty sleeping code
that is meant to throttle excessive growth from below. Allocating
threads could end up sleeping long after the write() had already
reclaimed the delta for which they were being punished.

However, erroneous throttling also caused problems in other scenarios
at around the same time. This resulted in commit b3ff92916af3 ("mm,
memcg: reclaim more aggressively before high allocator throttling"),
included in the same release as the offending commit. When allocating
threads now encounter large excess caused by a racing write() to
memory.high, instead of entering punitive sleeps, they will simply be
tasked with helping reclaim down the excess, and will be held no
longer than it takes to accomplish that. This is in line with regular
limit enforcement - i.e. if the workload allocates up against or over
an otherwise unchanged limit from below.

With the patch breaking userspace, and the root cause addressed by
other means already, revert it again.

Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
Cc: <stable@vger.kernel.org> # 5.8+
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Andrew, this is a replacement for
mm-memcontrol-prevent-starvation-when-writing-memoryhigh.patch

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 605f671203ef..a8611a62bafd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6273,6 +6273,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 	if (err)
 		return err;
 
+	page_counter_set_high(&memcg->memory, high);
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 		unsigned long reclaimed;
@@ -6296,10 +6298,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 			break;
 	}
 
-	page_counter_set_high(&memcg->memory, high);
-
 	memcg_wb_domain_size_changed(memcg);
-
 	return nbytes;
 }
 
-- 
2.30.0

