Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 216C02A0AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgJ3QNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 12:13:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727199AbgJ3QND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 12:13:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CAFC1684;
        Fri, 30 Oct 2020 09:13:02 -0700 (PDT)
Received: from eglon.eretz (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7873F3F719;
        Fri, 30 Oct 2020 09:13:00 -0700 (PDT)
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
Subject: [PATCH 17/24] x86/resctrl: Use cdp_enabled in rdt_domain_reconfigure_cdp()
Date:   Fri, 30 Oct 2020 16:11:13 +0000
Message-Id: <20201030161120.227225-18-james.morse@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201030161120.227225-1-james.morse@arm.com>
References: <20201030161120.227225-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rdt_domain_reconfigure_cdp() infers whether CDP is enabled by
checking the alloc_capable and alloc_enabled flags of the data
resources.

Now that there is an explicit cdp_enabled, use that.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6e150560c3c1..eeedafa7d5e7 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1944,14 +1944,16 @@ static int set_cache_qos_cfg(int level, bool enable)
 /* Restore the qos cfg state when a domain comes online */
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r)
 {
-	if (!r->alloc_capable)
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+
+	if (!hw_res->cdp_capable)
 		return;
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L2DATA].resctrl)
-		l2_qos_cfg_update(&r->alloc_enabled);
+		l2_qos_cfg_update(&hw_res->cdp_enabled);
 
 	if (r == &rdt_resources_all[RDT_RESOURCE_L3DATA].resctrl)
-		l3_qos_cfg_update(&r->alloc_enabled);
+		l3_qos_cfg_update(&hw_res->cdp_enabled);
 }
 
 /*
-- 
2.28.0

