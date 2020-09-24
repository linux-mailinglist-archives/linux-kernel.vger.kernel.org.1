Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41A3B276805
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 06:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIXEzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 00:55:15 -0400
Received: from mgwkm01.jp.fujitsu.com ([202.219.69.168]:51380 "EHLO
        mgwkm01.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgIXEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 00:55:13 -0400
X-Greylist: delayed 682 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 00:55:11 EDT
Received: from kw-mxauth.gw.nic.fujitsu.com (unknown [192.168.231.132]) by mgwkm01.jp.fujitsu.com with smtp
         id 6f2d_0859_aeb77cb9_8c5b_4ea6_9804_e9f6eaa60eff;
        Thu, 24 Sep 2020 13:43:47 +0900
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by kw-mxauth.gw.nic.fujitsu.com (Postfix) with ESMTP id 8E2C6AC008F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:43:47 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id E4F1A1C014; Thu, 24 Sep 2020 13:42:48 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuichi Ito <ito-yuichi@fujitsu.com>
Subject: [PATCH 2/2] Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI
Date:   Thu, 24 Sep 2020 13:42:36 +0900
Message-Id: <20200924044236.1245808-3-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
References: <20200924044236.1245808-1-ito-yuichi@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI.
For systems that do not support pseudo-NMI, register as a normal IRQ.

Signed-off-by: Yuichi Ito <ito-yuichi@fujitsu.com>
---
 arch/arm64/kernel/smp.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde2675ccc..d929dd7221ff 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -79,6 +79,8 @@ enum ipi_msg_type {
 static int ipi_irq_base __read_mostly;
 static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+static int ipi_crash_stop = -1;
+static int ipi_crash_stop_enable_nmi;
 
 static void ipi_setup(int cpu);
 static void ipi_teardown(int cpu);
@@ -954,8 +956,16 @@ static void ipi_setup(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		enable_percpu_irq(ipi_irq_base + i, 0);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_irq_base + i == ipi_crash_stop) {
+			if (!prepare_percpu_nmi(ipi_irq_base + i)) {
+				enable_percpu_nmi(ipi_irq_base + i, 0);
+				ipi_crash_stop_enable_nmi = 1;
+			} else
+				pr_crit("CPU%u: IPI_CPU_CRASH_STOP cannot be enabled NMI.\n", cpu);
+		} else
+			enable_percpu_irq(ipi_irq_base + i, 0);
+	}
 }
 
 static void ipi_teardown(int cpu)
@@ -965,23 +975,37 @@ static void ipi_teardown(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		disable_percpu_irq(ipi_irq_base + i);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_irq_base + i == ipi_crash_stop) {
+			if (ipi_crash_stop_enable_nmi) {
+				disable_percpu_nmi(ipi_irq_base + i);
+				teardown_percpu_nmi(ipi_irq_base + i);
+			}
+		} else
+			disable_percpu_irq(ipi_irq_base + i);
+	}
 }
 
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
-	int i;
+	int i, ret;
 
 	WARN_ON(n < NR_IPI);
 	nr_ipi = min(n, NR_IPI);
 
+	ret = request_percpu_nmi(ipi_base + IPI_CPU_CRASH_STOP,
+				 ipi_handler, "IPI", &cpu_number);
+	if (!ret)
+		ipi_crash_stop = ipi_base + IPI_CPU_CRASH_STOP;
+
 	for (i = 0; i < nr_ipi; i++) {
 		int err;
 
-		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &cpu_number);
-		WARN_ON(err);
+		if (ipi_base + i != ipi_crash_stop) {
+			err = request_percpu_irq(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
-- 
2.25.1

