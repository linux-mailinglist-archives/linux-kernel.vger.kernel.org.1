Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB332FC9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbhATEVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:21:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:44841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbhATERi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:17:38 -0500
IronPort-SDR: VsBgo9L+9VXslz1N6ZGpRk8qdMw1FC7Nc25gOBX+wDcbovc5FrL3rU1Yt6AEmUJ8cApggoaMqm
 GOy7jVRsJTzg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158222171"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="158222171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 20:16:56 -0800
IronPort-SDR: T5kBBZeAKOzBG5bGQ8LN5hG+ho85Icc5hIerVXBdMbIHkAUnfAZaUedfT9sCxvlrWxPfcJqX6g
 Ab9hCEk2CDYA==
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="384275314"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 20:16:56 -0800
Subject: [PATCH] mm: Fix ZONE_DEVICE usage in move_pfn_range_to_zone()
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Jan 2021 20:16:56 -0800
Message-ID: <161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy reports the build breaks with recent additions of
section_taint_zone_device() in move_pfn_range_to_zone(). Fix that by
including a conditionally stubbed out zone_is_zone_device() helper.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Andrew, apologies for the thrash. Please fold this into:

mm-teach-pfn_to_online_page-about-zone_device-section-collisions.patch

 include/linux/mmzone.h |   12 ++++++++++++
 mm/memory_hotplug.c    |    2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 0b5c44f730b4..66ba38dae9ba 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -885,6 +885,18 @@ static inline int local_memory_node(int node_id) { return node_id; };
  */
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
+#ifdef CONFIG_ZONE_DEVICE
+static inline bool zone_is_zone_device(struct zone *zone)
+{
+	return zone_idx(zone) == ZONE_DEVICE;
+}
+#else
+static inline bool zone_is_zone_device(struct zone *zone)
+{
+	return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c78a1bef561b..710e469fb3a1 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -769,7 +769,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
 	 * section.
 	 */
-	if (zone_idx(zone) == ZONE_DEVICE) {
+	if (zone_is_zone_device(zone)) {
 		if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
 			section_taint_zone_device(start_pfn);
 		if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))

