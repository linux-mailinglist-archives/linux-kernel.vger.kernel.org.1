Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7519D2FCB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbhATH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:28:43 -0500
Received: from mga01.intel.com ([192.55.52.88]:35972 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbhATH2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:28:15 -0500
IronPort-SDR: dIrCFGQdSFZt5AlLS6Tz5CsLwIF/bZ1G8pEpfxewL0TNJDtDdJVYE2h03KFHTMCDC+VDystf5/
 ivm4qMK8vZlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="197783196"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="197783196"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 23:27:32 -0800
IronPort-SDR: jehrqGgljQOaCPdMz3iBg9FeTtt/OjUDpnGO95N50pRIPyArG6CYEe0MUdfNpxV6smC/2dsfdM
 9kY9OfW0exXw==
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="355947381"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 23:27:22 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] swap: Check nrexceptional of swap cache before being freed
Date:   Wed, 20 Jan 2021 15:27:11 +0800
Message-Id: <20210120072711.209099-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To catch the error in updating the swap cache shadow entries or their count.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
Cc: Johannes Weiner <hannes@cmpxchg.org>,
Cc: Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
Cc: Mel Gorman <mgorman@techsingularity.net>,
Cc: Michal Hocko <mhocko@kernel.org>,
Cc: Dan Williams <dan.j.williams@intel.com>,
Cc: Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
---
 mm/swap_state.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index d0d417efeecc..240a4f97594a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -703,7 +703,12 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 
 void exit_swap_address_space(unsigned int type)
 {
-	kvfree(swapper_spaces[type]);
+	int i;
+	struct address_space *spaces = swapper_spaces[type];
+
+	for (i = 0; i < nr_swapper_spaces[type]; i++)
+		VM_BUG_ON(spaces[i].nrexceptional);
+	kvfree(spaces);
 	nr_swapper_spaces[type] = 0;
 	swapper_spaces[type] = NULL;
 }
-- 
2.29.2

