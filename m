Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63281D7994
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgERNTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 09:19:53 -0400
Received: from foss.arm.com ([217.140.110.172]:40450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgERNTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:19:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCC813FD;
        Mon, 18 May 2020 06:19:45 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D3A6F3F305;
        Mon, 18 May 2020 06:19:43 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v3 07/10] x86/resctrl: Add arch_needs_linear to explain AMD/Intel MBA difference
Date:   Mon, 18 May 2020 14:19:20 +0100
Message-Id: <20200518131924.7741-8-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200518131924.7741-1-james.morse@arm.com>
References: <20200518131924.7741-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The configuration values user-space provides to the resctrl filesystem
are ABI. To make this work on another architecture we want to move all
the ABI bits out of /arch/x86 and under /fs.

To do this, the differences between AMD and Intel CPUs needs to be
explained to resctrl via resource properties, instead of function
pointers that let the arch code accept subtly different values on
different platforms/architectures.

For MBA, Intel CPUs reject configuration attempts for non-linear
resources, whereas AMD ignore this field as its MBA resource is never
linear. To merge the parse/validate functions we need to explain
this difference.

Add arch_needs_linear to indicate the arch code needs the linear
property to be true to configure this resource. AMD can set this
and delay_linear to false. Intel can set arch_needs_linear
to true to keep the existing "No support for non-linear MB domains"
error message for affected platforms.

CC: Babu Moger <Babu.Moger@amd.com>
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

---
An alternative to this is for Intel non-linear MBA resources to
clear alloc_capable as they can't be configured anyway.
---
 arch/x86/kernel/cpu/resctrl/core.c        | 3 +++
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/internal.h    | 2 ++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e1fed3928b59..c6b73b0ee070 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -260,6 +260,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	r->num_closid = edx.split.cos_max + 1;
 	max_delay = eax.split.max_delay + 1;
 	r->default_ctrl = MAX_MBA_BW;
+	r->membw.arch_needs_linear = true;
 	if (ecx & MBA_IS_LINEAR) {
 		r->membw.delay_linear = true;
 		r->membw.min_bw = MAX_MBA_BW - max_delay;
@@ -267,6 +268,7 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 	} else {
 		if (!rdt_get_mb_table(r))
 			return false;
+		r->membw.arch_needs_linear = false;
 	}
 	r->data_width = 3;
 
@@ -288,6 +290,7 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 
 	/* AMD does not use delay */
 	r->membw.delay_linear = false;
+	r->membw.arch_needs_linear = false;
 
 	r->membw.min_bw = 0;
 	r->membw.bw_gran = 1;
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 934c8fb8a64a..e3bcd77add2b 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -33,6 +33,12 @@ static bool bw_validate_amd(char *buf, unsigned long *data,
 	unsigned long bw;
 	int ret;
 
+	/* temporary: always false on AMD */
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
+		rdt_last_cmd_puts("No support for non-linear MB domains\n");
+		return false;
+	}
+
 	ret = kstrtoul(buf, 10, &bw);
 	if (ret) {
 		rdt_last_cmd_printf("Non-decimal digit in MB value %s\n", buf);
@@ -82,7 +88,7 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 	/*
 	 * Only linear delay values is supported for current Intel SKUs.
 	 */
-	if (!r->membw.delay_linear) {
+	if (!r->membw.delay_linear && r->membw.arch_needs_linear) {
 		rdt_last_cmd_puts("No support for non-linear MB domains\n");
 		return false;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index dd51e23e346b..0b288b6fefd9 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -370,6 +370,7 @@ struct rdt_cache {
  * struct rdt_membw - Memory bandwidth allocation related data
  * @min_bw:		Minimum memory bandwidth percentage user can request
  * @bw_gran:		Granularity at which the memory bandwidth is allocated
+ * @arch_needs_linear:	True if we can't configure non-linear resources
  * @delay_linear:	True if memory B/W delay is in linear scale
  * @mba_sc:		True if MBA software controller(mba_sc) is enabled
  * @mb_map:		Mapping of memory B/W percentage to memory B/W delay
@@ -378,6 +379,7 @@ struct rdt_membw {
 	u32		min_bw;
 	u32		bw_gran;
 	u32		delay_linear;
+	bool		arch_needs_linear;
 	bool		mba_sc;
 	u32		*mb_map;
 };
-- 
2.19.1

