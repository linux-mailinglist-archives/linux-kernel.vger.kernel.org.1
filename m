Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115972A0E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgJ3TCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:30179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgJ3TCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:44 -0400
IronPort-SDR: 67tiijuv0G82A7mnVlotQyRunYz4XRi8W+SEIYyhtiZNx8uFOob4O23CYEGXUTetNcz8x2eUyL
 Z5R/Ej2OCuBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154803"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154803"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:43 -0700
IronPort-SDR: 5YXUIAQv+McZhxTjcsBckey+vREkkHnN2xde3eKCPu6HB0BAma7fFwgOc9E23f46Aa+5yKFBMI
 tPe1edzpuM+Q==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167643"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:43 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] mm/mempolicy: Add comment for missing LOCAL
Date:   Fri, 30 Oct 2020 12:02:27 -0700
Message-Id: <20201030190238.306764-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MPOL_LOCAL is a bit weird because it is simply a different name for an
existing behavior (preferred policy with no node mask). It has been this
way since it was added here:
commit 479e2802d09f ("mm: mempolicy: Make MPOL_LOCAL a real policy")

It is so similar to MPOL_PREFERRED in fact that when the policy is
created in mpol_new, the mode is set as PREFERRED, and an internal state
representing LOCAL doesn't exist.

To prevent future explorers from scratching their head as to why
MPOL_LOCAL isn't defined in the mpol_ops table, add a small comment
explaining the situations.

v2:
Change comment to refer to mpol_new (Michal)

Link: https://lore.kernel.org/r/20200630212517.308045-2-ben.widawsky@intel.com
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3fde772ef5ef..e24f0133ff1f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -427,6 +427,7 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_bind,
 		.rebind = mpol_rebind_nodemask,
 	},
+	/* [MPOL_LOCAL] - see mpol_new() */
 };
 
 static int migrate_page_add(struct page *page, struct list_head *pagelist,
-- 
2.29.2

