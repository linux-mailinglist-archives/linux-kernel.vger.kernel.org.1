Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A761D7993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgERNTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:19:43 -0400
Received: from foss.arm.com ([217.140.110.172]:40392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727036AbgERNTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:19:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36C0E1435;
        Mon, 18 May 2020 06:19:39 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3293F305;
        Mon, 18 May 2020 06:19:37 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 04/10] x86/resctrl: use container_of() in delayed_work handlers
Date:   Mon, 18 May 2020 14:19:17 +0100
Message-Id: <20200518131924.7741-5-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200518131924.7741-1-james.morse@arm.com>
References: <20200518131924.7741-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mbm_handle_overflow() and cqm_handle_limbo() are both provided with
the domain's work_struct when called, but use get_domain_from_cpu()
to find the domain, along with the appropriate error handling.

container_of() saves some list walking and bitmap testing, use that
instead.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index d6b92d7487a7..54dffe574e67 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -477,19 +477,13 @@ void cqm_handle_limbo(struct work_struct *work)
 	mutex_lock(&rdtgroup_mutex);
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-	d = get_domain_from_cpu(cpu, r);
-
-	if (!d) {
-		pr_warn_once("Failure to get domain for limbo worker\n");
-		goto out_unlock;
-	}
+	d = container_of(work, struct rdt_domain, cqm_limbo.work);
 
 	__check_limbo(d, false);
 
 	if (has_busy_rmid(r, d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
 
-out_unlock:
 	mutex_unlock(&rdtgroup_mutex);
 }
 
@@ -519,10 +513,7 @@ void mbm_handle_overflow(struct work_struct *work)
 		goto out_unlock;
 
 	r = &rdt_resources_all[RDT_RESOURCE_L3];
-
-	d = get_domain_from_cpu(cpu, r);
-	if (!d)
-		goto out_unlock;
+	d = container_of(work, struct rdt_domain, mbm_over.work);
 
 	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
 		mbm_update(r, d, prgrp->mon.rmid);
-- 
2.19.1

