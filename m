Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D0B2A0E46
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 20:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgJ3TDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 15:03:20 -0400
Received: from mga11.intel.com ([192.55.52.93]:30185 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727396AbgJ3TCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 15:02:46 -0400
IronPort-SDR: QCnSzkgEjzVeol3vq34mSoniA0jyoae2BNaIW47/IAt8VpWRfkGVv3VLqgYKXgz92Vn7AMjGZe
 Q0YbZHYYr+nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165154818"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165154818"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:46 -0700
IronPort-SDR: zY1RkexspqZ2jaT18JTEukY09sP8wM6SQZf5xmso6brYs57D0yspOYtauXox2ibu/NZUbEVPQk
 ma8aZhUijPmg==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="537167672"
Received: from kingelix-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.139.120])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 12:02:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] mm/mempolicy: refactor rebind code for PREFERRED_MANY
Date:   Fri, 30 Oct 2020 12:02:31 -0700
Message-Id: <20201030190238.306764-6-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201030190238.306764-1-ben.widawsky@intel.com>
References: <20201030190238.306764-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Hansen <dave.hansen@linux.intel.com>

Again, this extracts the "only one node must be set" behavior of
MPOL_PREFERRED.  It retains virtually all of the existing code so it can
be used by MPOL_PREFERRED_MANY as well.

v2:
Fixed typos in commit message. (Ben)
Merged bits from other patches. (Ben)
annotate mpol_rebind_preferred_many as unused (Ben)

Link: https://lore.kernel.org/r/20200630212517.308045-6-ben.widawsky@intel.com
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 mm/mempolicy.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b1b43e511d6f..1b88c133f5c5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -359,14 +359,11 @@ static void mpol_rebind_nodemask(struct mempolicy *pol, const nodemask_t *nodes)
 	pol->v.nodes = tmp;
 }
 
-static void mpol_rebind_preferred(struct mempolicy *pol,
-						const nodemask_t *nodes)
+static void mpol_rebind_preferred_common(struct mempolicy *pol,
+					 const nodemask_t *preferred_nodes,
+					 const nodemask_t *nodes)
 {
 	nodemask_t tmp;
-	nodemask_t preferred_node;
-
-	/* MPOL_PREFERRED uses only the first node in the mask */
-	preferred_node = nodemask_of_node(first_node(*nodes));
 
 	if (pol->flags & MPOL_F_STATIC_NODES) {
 		int node = first_node(pol->w.user_nodemask);
@@ -381,12 +378,30 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
 		pol->v.preferred_nodes = tmp;
 	} else if (!(pol->flags & MPOL_F_LOCAL)) {
 		nodes_remap(tmp, pol->v.preferred_nodes,
-			    pol->w.cpuset_mems_allowed, preferred_node);
+			    pol->w.cpuset_mems_allowed, *preferred_nodes);
 		pol->v.preferred_nodes = tmp;
 		pol->w.cpuset_mems_allowed = *nodes;
 	}
 }
 
+/* MPOL_PREFERRED_MANY allows multiple nodes to be set in 'nodes' */
+static void __maybe_unused mpol_rebind_preferred_many(struct mempolicy *pol,
+						      const nodemask_t *nodes)
+{
+	mpol_rebind_preferred_common(pol, nodes, nodes);
+}
+
+static void mpol_rebind_preferred(struct mempolicy *pol,
+				  const nodemask_t *nodes)
+{
+	nodemask_t preferred_node;
+
+	/* MPOL_PREFERRED uses only the first node in 'nodes' */
+	preferred_node = nodemask_of_node(first_node(*nodes));
+
+	mpol_rebind_preferred_common(pol, &preferred_node, nodes);
+}
+
 /*
  * mpol_rebind_policy - Migrate a policy to a different set of nodes
  *
-- 
2.29.2

