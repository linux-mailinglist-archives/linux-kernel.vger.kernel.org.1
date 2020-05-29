Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6A691E71EA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 03:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438303AbgE2BGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 21:06:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:2375 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438286AbgE2BGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:06:19 -0400
IronPort-SDR: RGDIACLiQf1BfYsNep8X33z1Uk+gr8v5KyxGnFmjSOx9UPXdpYe/ddfyshoammRtJniZzikM9e
 aBJybQSYMHRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 18:06:18 -0700
IronPort-SDR: p/zjETwGibrawIJEt9ooi+19bx4ElL9Nj2HegGeipzELO9cqLKCPwvIUNIprMkwiQDETIPG/1g
 /dY9oPKxpkrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="443187395"
Received: from shbuild999.sh.intel.com ([10.239.146.107])
  by orsmga005.jf.intel.com with ESMTP; 28 May 2020 18:06:15 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        andi.kleen@intel.com, tim.c.chen@intel.com, dave.hansen@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Feng Tang <feng.tang@intel.com>
Subject: [PATCH v4 1/4] proc/meminfo: avoid open coded reading of vm_committed_as
Date:   Fri, 29 May 2020 09:06:07 +0800
Message-Id: <1590714370-67182-2-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the existing vm_memory_committed() instead, which is also
convenient for future change.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 fs/proc/meminfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index b030d8b..e3d14ee 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -41,7 +41,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 	si_meminfo(&i);
 	si_swapinfo(&i);
-	committed = percpu_counter_read_positive(&vm_committed_as);
+	committed = vm_memory_committed();
 
 	cached = global_node_page_state(NR_FILE_PAGES) -
 			total_swapcache_pages() - i.bufferram;
-- 
2.7.4

