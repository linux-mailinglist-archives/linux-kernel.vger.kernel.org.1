Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9C2A0ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgJ3QNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:22 -0400
Received: from foss.arm.com ([217.140.110.172]:39284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgJ3QNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 641BD1684;
        Fri, 30 Oct 2020 09:13:18 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 825CB3F719;
        Fri, 30 Oct 2020 09:13:16 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH 22/24] x86/resctrl: Merge the ctrlval arrays
Date:   Fri, 30 Oct 2020 16:11:18 +0000
Message-Id: <20201030161120.227225-23-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the CODE/DATA resources don't use overlapping slots in the
ctrlval arrays, they can be merged. This allows the cdp_peer configuration
to be read from any resource's domain, instead of searching for the matching
flavour.

Add a helper to allocate the ctrlval array, that returns the value on the
L2 or L3 resource if it already exists. This gets removed once the
resources are merged, and there really is only one ctrlval array.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c | 79 +++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e2f5ea129be2..01d010977367 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -509,6 +509,72 @@ void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm)
 	}
 }
 
+/*
+ * temporary.
+ * This relies on L2 or L3 being allocated before their CODE/DATA aliases
+ */
+static u32 *alloc_ctrlval_array(struct rdt_resource *r, struct rdt_domain *d,
+				bool mba_sc)
+{
+	/* these are for the underlying hardware, they may not match r/d */
+	struct rdt_domain *underlying_domain;
+	struct rdt_hw_resource *hw_res;
+	struct rdt_hw_domain *hw_dom;
+	bool remapped;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L3DATA:
+	case RDT_RESOURCE_L3CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+		remapped = true;
+		break;
+	case RDT_RESOURCE_L2DATA:
+	case RDT_RESOURCE_L2CODE:
+		hw_res = &rdt_resources_all[RDT_RESOURCE_L2];
+		remapped = true;
+		break;
+	default:
+		hw_res = resctrl_to_arch_res(r);
+		remapped = false;
+	}
+
+	/*
+	 * If we changed the resource, we need to search for the underlying
+	 * domain. Doing this for all resources would make it tricky to add the
+	 * first resource, as domains aren't added to a resource list until
+	 * after the ctrlval arrays have been allocated.
+	 */
+	if (remapped)
+		underlying_domain = rdt_find_domain(&hw_res->resctrl, d->id,
+						    NULL);
+	else
+		underlying_domain = d;
+	hw_dom = resctrl_to_arch_dom(underlying_domain);
+
+	if (mba_sc) {
+		if (hw_dom->mbps_val)
+			return hw_dom->mbps_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	} else {
+		if (hw_dom->ctrl_val)
+			return hw_dom->ctrl_val;
+		return kmalloc_array(hw_res->num_closid,
+				     sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	}
+}
+
+/* Only kfree() for L2/L3, not the CODE/DATA aliases */
+static void free_ctrlval_arrays(struct rdt_resource *r, struct rdt_domain *d)
+{
+	struct rdt_hw_domain *hw_dom = resctrl_to_arch_dom(d);
+
+	if (r->rid == RDT_RESOURCE_L2 || r->rid == RDT_RESOURCE_L3) {
+		kfree(hw_dom->ctrl_val);
+		kfree(hw_dom->mbps_val);
+	}
+}
+
 static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 {
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
@@ -516,18 +582,18 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 	struct msr_param m;
 	u32 *dc, *dm;
 
-	dc = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->ctrl_val), GFP_KERNEL);
+	dc = alloc_ctrlval_array(r, d, false);
 	if (!dc)
 		return -ENOMEM;
+	hw_dom->ctrl_val = dc;
 
-	dm = kmalloc_array(hw_res->num_closid, sizeof(*hw_dom->mbps_val), GFP_KERNEL);
+	dm = alloc_ctrlval_array(r, d, true);
 	if (!dm) {
-		kfree(dc);
+		free_ctrlval_arrays(r, d);
 		return -ENOMEM;
 	}
-
-	hw_dom->ctrl_val = dc;
 	hw_dom->mbps_val = dm;
+
 	setup_default_ctrlval(r, dc, dm);
 
 	m.low = 0;
@@ -677,8 +743,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
 		if (d->plr)
 			d->plr->d = NULL;
 
-		kfree(hw_dom->ctrl_val);
-		kfree(hw_dom->mbps_val);
+		free_ctrlval_arrays(r, d);
 		bitmap_free(d->rmid_busy_llc);
 		kfree(d->mbm_total);
 		kfree(d->mbm_local);
-- 
2.28.0

