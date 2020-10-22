Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41437295C38
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 11:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896158AbgJVJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 05:49:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896142AbgJVJtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 05:49:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603360150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I8ggVRtWIXEDLgeQFmioHekHeyrBQ6I5PgwEHN8hSsU=;
        b=Ju+czaxvRC6i22B87p6i1lSEv88o6z4+BLHbqlqBexcmz64qzWCTf4VZdzQgbq07WzQ3Am
        iuBhHY6Tskp2xObJCN0baZ6MoRfZ6UGmGpKaIAMDuGBlX7MjjxzQQM47vZpzCmxQGG/D8Y
        PuQVBSvvao19fFAPagIdg5YcBQ4XNK0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CC373AE42;
        Thu, 22 Oct 2020 09:49:10 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <jbeulich@suse.com>
Subject: [PATCH v2 3/5] xen/events: only register debug interrupt for 2-level events
Date:   Thu, 22 Oct 2020 11:49:05 +0200
Message-Id: <20201022094907.28560-4-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201022094907.28560-1-jgross@suse.com>
References: <20201022094907.28560-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_debug_interrupt() is specific to 2-level event handling. So don't
register it with fifo event handling being active.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
---
V2:
- rename fifo_events variable to xen_fifo_events (Jan Beulich)
---
 arch/x86/xen/smp.c               | 19 +++++++++++--------
 arch/x86/xen/xen-ops.h           |  2 ++
 drivers/xen/events/events_base.c | 10 ++++++----
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 2097fa0ebdb5..c1b2f764b29a 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -88,14 +88,17 @@ int xen_smp_intr_init(unsigned int cpu)
 	per_cpu(xen_callfunc_irq, cpu).irq = rc;
 	per_cpu(xen_callfunc_irq, cpu).name = callfunc_name;
 
-	debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
-	rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu, xen_debug_interrupt,
-				     IRQF_PERCPU | IRQF_NOBALANCING,
-				     debug_name, NULL);
-	if (rc < 0)
-		goto fail;
-	per_cpu(xen_debug_irq, cpu).irq = rc;
-	per_cpu(xen_debug_irq, cpu).name = debug_name;
+	if (!xen_fifo_events) {
+		debug_name = kasprintf(GFP_KERNEL, "debug%d", cpu);
+		rc = bind_virq_to_irqhandler(VIRQ_DEBUG, cpu,
+					     xen_debug_interrupt,
+					     IRQF_PERCPU | IRQF_NOBALANCING,
+					     debug_name, NULL);
+		if (rc < 0)
+			goto fail;
+		per_cpu(xen_debug_irq, cpu).irq = rc;
+		per_cpu(xen_debug_irq, cpu).name = debug_name;
+	}
 
 	callfunc_name = kasprintf(GFP_KERNEL, "callfuncsingle%d", cpu);
 	rc = bind_ipi_to_irqhandler(XEN_CALL_FUNCTION_SINGLE_VECTOR,
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 45d556f71858..9546c3384c75 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -29,6 +29,8 @@ extern struct start_info *xen_start_info;
 extern struct shared_info xen_dummy_shared_info;
 extern struct shared_info *HYPERVISOR_shared_info;
 
+extern bool xen_fifo_events;
+
 void xen_setup_mfn_list_list(void);
 void xen_build_mfn_list_list(void);
 void xen_setup_machphys_mapping(void);
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 1c25580c7691..6038c4c35db5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2050,8 +2050,8 @@ void xen_setup_callback_vector(void) {}
 static inline void xen_alloc_callback_vector(void) {}
 #endif
 
-static bool fifo_events = true;
-module_param(fifo_events, bool, 0);
+bool xen_fifo_events = true;
+module_param_named(fifo_events, xen_fifo_events, bool, 0);
 
 static int xen_evtchn_cpu_prepare(unsigned int cpu)
 {
@@ -2080,10 +2080,12 @@ void __init xen_init_IRQ(void)
 	int ret = -EINVAL;
 	evtchn_port_t evtchn;
 
-	if (fifo_events)
+	if (xen_fifo_events)
 		ret = xen_evtchn_fifo_init();
-	if (ret < 0)
+	if (ret < 0) {
 		xen_evtchn_2l_init();
+		xen_fifo_events = false;
+	}
 
 	xen_cpu_init_eoi(smp_processor_id());
 
-- 
2.26.2

