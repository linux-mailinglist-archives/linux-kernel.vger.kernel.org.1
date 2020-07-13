Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989BC218D25
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 18:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgGHQkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 12:40:02 -0400
Received: from foss.arm.com ([217.140.110.172]:51178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgGHQkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:40:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A4311045;
        Wed,  8 Jul 2020 09:40:01 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C71563F68F;
        Wed,  8 Jul 2020 09:39:59 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v5 01/10] x86/resctrl: Nothing uses struct mbm_state chunks_bw
Date:   Wed,  8 Jul 2020 16:39:20 +0000
Message-Id: <20200708163929.2783-2-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708163929.2783-1-james.morse@arm.com>
References: <20200708163929.2783-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing reads struct mbm_states's chunks_bw value, its a copy of
chunks. Remove it.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/internal.h | 2 --
 arch/x86/kernel/cpu/resctrl/monitor.c  | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f20a47d120b1..1bb81cbdad5f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -282,7 +282,6 @@ struct rftype {
  * struct mbm_state - status for each MBM counter in each domain
  * @chunks:	Total data moved (multiply by rdt_group.mon_scale to get bytes)
  * @prev_msr	Value of IA32_QM_CTR for this RMID last time we read it
- * @chunks_bw	Total local data moved. Used for bandwidth calculation
  * @prev_bw_msr:Value of previous IA32_QM_CTR for bandwidth counting
  * @prev_bw	The most recent bandwidth in MBps
  * @delta_bw	Difference between the current and previous bandwidth
@@ -291,7 +290,6 @@ struct rftype {
 struct mbm_state {
 	u64	chunks;
 	u64	prev_msr;
-	u64	chunks_bw;
 	u64	prev_bw_msr;
 	u32	prev_bw;
 	u32	delta_bw;
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 837d7d012b7b..d6b92d7487a7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -279,8 +279,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 		return;
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
-	m->chunks_bw += chunks;
-	m->chunks = m->chunks_bw;
+	m->chunks += chunks;
 	cur_bw = (chunks * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
-- 
2.20.1

