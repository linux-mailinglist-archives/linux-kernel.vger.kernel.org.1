Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5382A0AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgJ3QNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:13 -0400
Received: from foss.arm.com ([217.140.110.172]:39224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbgJ3QNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2D516F2;
        Fri, 30 Oct 2020 09:13:08 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E14E3F719;
        Fri, 30 Oct 2020 09:13:06 -0700 (PDT)
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
Subject: [PATCH 19/24] x86/resctrl: Make ctrlval arrays the same size
Date:   Fri, 30 Oct 2020 16:11:15 +0000
Message-Id: <20201030161120.227225-20-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CODE and DATA resources have their own ctrlval arrays which are half
the size because num_closid was already adjusted.

Prior to having one ctrlval array for the resource, move the num_closid
correction into resctrl, so that the ctrlval arrays are all the same
size.

A shortlived quirk of this is that the caches are reset twice, once
for CODE once for DATA.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/core.c     | 10 +++++++++-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 10 ++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 7e98869ba006..b2fda4cd88ba 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -363,7 +363,7 @@ static void rdt_get_cdp_config(int level, int type)
 	struct rdt_resource *r = &rdt_resources_all[type].resctrl;
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 
-	hw_res->num_closid = hw_res_l->num_closid / 2;
+	hw_res->num_closid = hw_res_l->num_closid;
 	r->cache.cbm_len = r_l->cache.cbm_len;
 	r->default_ctrl = r_l->default_ctrl;
 	r->cache.shareable_bits = r_l->cache.shareable_bits;
@@ -549,6 +549,14 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
 
 	m.low = 0;
 	m.high = hw_res->num_closid;
+
+	/*
+	 * temporary: the array is full-size, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->conf_type != CDP_BOTH)
+		m.high /= 2;
+
 	hw_res->msr_update(d, &m, r);
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index cb9ca56ce2e6..4fa6c386d751 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2165,6 +2165,9 @@ static int create_schemata_list(void)
 
 		s->res = r;
 		s->num_closid = resctrl_arch_get_num_closid(r);
+		if (resctrl_arch_get_cdp_enabled(r->rid))
+			s->num_closid /= 2;
+
 		s->conf_type = resctrl_to_arch_res(r)->conf_type;
 
 		ret = snprintf(s->name, sizeof(s->name), r->name);
@@ -2376,6 +2379,13 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	msr_param.low = 0;
 	msr_param.high = hw_res->num_closid;
 
+	/*
+	 * temporary: the array is full-sized, but cat_wrmsr() still re-maps
+	 * the index.
+	 */
+	if (hw_res->cdp_enabled)
+		msr_param.high /= 2;
+
 	/*
 	 * Disable resource control for this resource by setting all
 	 * CBMs in all domains to the maximum mask value. Pick one CPU
-- 
2.28.0

