Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF51A2E716E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgL2Of7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:35:59 -0500
Received: from mga09.intel.com ([134.134.136.24]:20288 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbgL2Of7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:35:59 -0500
IronPort-SDR: Oho49HabzHVJrDjf4MX7r6cR95gevHjSB0P06nhtAjpDlnZVWnNUp3cV5hoW3NafIL7nkdST3t
 d/E3Lx65+qvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176652517"
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="176652517"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 06:35:18 -0800
IronPort-SDR: 90Tie2bCZPBy/9Ux/SljHFQW6M/rurKEfGWOYmOFx7dMBOJtv+/ehiW22sam+UhhnQ1/zeywBI
 IjAXYLa4RmPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,458,1599548400"; 
   d="scan'208";a="419194790"
Received: from shbuild999.sh.intel.com ([10.239.147.98])
  by orsmga001.jf.intel.com with ESMTP; 29 Dec 2020 06:35:15 -0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Feng Tang <feng.tang@intel.com>, Roman Gushchin <guro@fb.com>
Subject: [PATCH 1/2] mm: page_counter: relayout structure to reduce false sharing
Date:   Tue, 29 Dec 2020 22:35:13 +0800
Message-Id: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a memory cgroup related performance regression [1],
from the perf c2c profiling data, we found high false sharing for
accessing 'usage' and 'parent'.

On 64 bit system, the 'usage' and 'parent' are close to each other,
and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
is usally written, while 'parent' is usually read as the cgroup's
hierarchical counting nature.

So move the 'parent' to the end of the structure to make sure they
are in different cache lines.

Following are some performance data with the patch, against
v5.11-rc1, on several generations of Xeon platforms. Most of the
results are improvements, with only one malloc case on one platform
shows a -4.0% regression. Each category below has several subcases
run on different platform, and only the worst and best scores are
listed:

fio:				 +1.8% ~  +8.3%
will-it-scale/malloc1:		 -4.0% ~  +8.9%
will-it-scale/page_fault1:	 no change
will-it-scale/page_fault2:	 +2.4% ~  +20.2%

[1].https://lore.kernel.org/lkml/20201102091543.GM31092@shao2-debian/
Signed-off-by: Feng Tang <feng.tang@intel.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page_counter.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/page_counter.h b/include/linux/page_counter.h
index 85bd413..6795913 100644
--- a/include/linux/page_counter.h
+++ b/include/linux/page_counter.h
@@ -12,7 +12,6 @@ struct page_counter {
 	unsigned long low;
 	unsigned long high;
 	unsigned long max;
-	struct page_counter *parent;
 
 	/* effective memory.min and memory.min usage tracking */
 	unsigned long emin;
@@ -27,6 +26,14 @@ struct page_counter {
 	/* legacy */
 	unsigned long watermark;
 	unsigned long failcnt;
+
+	/*
+	 * 'parent' is placed here to be far from 'usage' to reduce
+	 * cache false sharing, as 'usage' is written mostly while
+	 * parent is frequently read for cgroup's hierarchical
+	 * counting nature.
+	 */
+	struct page_counter *parent;
 };
 
 #if BITS_PER_LONG == 32
-- 
2.7.4

