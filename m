Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EE01CA528
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 09:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgEHHZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 03:25:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:27650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHHZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:25:26 -0400
IronPort-SDR: votR6k4idy/DoIGAVTaU9Uc8SPzG9mJ1FJ82AOdDPBT1DWjLRdmDSTY4BgXl2LMUkx6sZDp5KI
 jKDZk9l1TYvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 00:25:26 -0700
IronPort-SDR: BaPIIrbWpE7bV+c1ngNAq+lL2CKpewOcYZUiU9wU+ozDW06TmCvkmthWhmF308Lk3l4El1JixD
 4YhgLc6czNIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="264210532"
Received: from shbuild999.sh.intel.com ([10.239.147.136])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 00:25:22 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH 1/3] proc/meminfo: avoid open coded reading of vm_committed_as
Date:   Fri,  8 May 2020 15:25:15 +0800
Message-Id: <1588922717-63697-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing vm_memory_committed() instead, which is also
convenient for future change.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 fs/proc/meminfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index 8c1f1bb..578c0b8 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -42,7 +42,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	committed = percpu_counter_read_positive(&vm_committed_as);
+	committed = vm_memory_committed();
 
 	cached = global_node_page_state(NR_FILE_PAGES) -
 			total_swapcache_pages() - i.bufferram;
-- 
2.7.4

