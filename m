Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ACD1CA529
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 09:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgEHHZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 03:25:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:27650 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgEHHZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:25:30 -0400
IronPort-SDR: lCM4wIeHs/QpHKqMdjRWqaMYhrkc1x6yyEnJ3MqkWx/8qYhJ2SfV9EsS7qkRor6uJAwJCHw3ja
 ab8bmSJklF6g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2020 00:25:30 -0700
IronPort-SDR: XTxoPgiIpK+yKm21wvSPK3ZDNzwkPuJQf+V+gxo+7RrjNFtdNo8zJdE2Rt+Y3Xk+SDBDr0k++H
 2sAn7N1ZXtdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="264210556"
Received: from shbuild999.sh.intel.com ([10.239.147.136])
  by orsmga006.jf.intel.com with ESMTP; 08 May 2020 00:25:26 -0700
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
Subject: [PATCH 2/3] mm/util.c: make vm_memory_committed() more accurate
Date:   Fri,  8 May 2020 15:25:16 +0800
Message-Id: <1588922717-63697-3-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

percpu_counter_sum_positive() will provide more accurate info.

Its time cost is about 800 nanoseconds on a 2C/4T platform and
2~3 microseconds on a 2S/36C/72T server in normal case, and in
worst case where vm_committed_as's spinlock is under severe
contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
which should be fine for its two users: /proc/meminfo and HV ballon
driver's status trace per second.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e..3de78e9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -774,7 +774,7 @@ struct percpu_counter vm_committed_as ____cacheline_aligned_in_smp;
  */
 unsigned long vm_memory_committed(void)
 {
-	return percpu_counter_read_positive(&vm_committed_as);
+	return percpu_counter_sum_positive(&vm_committed_as);
 }
 EXPORT_SYMBOL_GPL(vm_memory_committed);
 
-- 
2.7.4

