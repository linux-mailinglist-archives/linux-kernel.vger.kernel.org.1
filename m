Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8219E2A0E3B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgJ3TCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:02:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:30179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbgJ3TCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:46 -0400
IronPort-SDR: e1vcUwJwinHoqZbmNvXDUhnk90Q8pR79FhRnlxGtangqFo9eilBL2f1lwYdeugYjGtzVpZAZ7a
 0cCSDrbfDB5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154813"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154813"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:45 -0700
IronPort-SDR: moOtnPBPvXI5kXDkK8QMb74wV3yzANcuPk57m+g7D5MI2QX/T5J0tVhwiKX+QXZQ2hr4MINbk1
 cjBzXf6htP2w==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167660"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:45 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/12] mm/mempolicy: allow preferred code to take a nodemask
Date:   Fri, 30 Oct 2020 12:02:30 -0700
Message-Id: <20201030190238.306764-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Create a helper function (mpol_new_preferred_many()) which is usable
both by the old, single-node MPOL_PREFERRED and the new
MPOL_PREFERRED_MANY.

Enforce the old single-node MPOL_PREFERRED behavior in the "new"
version of mpol_new_preferred() which calls mpol_new_preferred_many().

Link: https://lore.kernel.org/r/20200630212517.308045-5-ben.widawsky@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 21a6f80f91a9..b1b43e511d6f 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -203,17 +203,30 @@ static int mpol_new_interleave(struct mempolicy *pol, const nodemask_t *nodes)
 	return 0;
 }
 
-static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+static int mpol_new_preferred_many(struct mempolicy *pol,
+				   const nodemask_t *nodes)
 {
 	if (!nodes)
 		pol->flags |= MPOL_F_LOCAL;	/* local allocation */
 	else if (nodes_empty(*nodes))
 		return -EINVAL;			/*  no allowed nodes */
 	else
-		pol->v.preferred_nodes = nodemask_of_node(first_node(*nodes));
+		pol->v.preferred_nodes = *nodes;
 	return 0;
 }
 
+static int mpol_new_preferred(struct mempolicy *pol, const nodemask_t *nodes)
+{
+	if (nodes) {
+		/* MPOL_PREFERRED can only take a single node: */
+		nodemask_t tmp = nodemask_of_node(first_node(*nodes));
+
+		return mpol_new_preferred_many(pol, &tmp);
+	}
+
+	return mpol_new_preferred_many(pol, NULL);
+}
+
 static int mpol_new_bind(struct mempolicy *pol, const nodemask_t *nodes)
 {
 	if (nodes_empty(*nodes))
-- 
2.29.2

