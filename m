Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C596F2A5F37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgKDIRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:17:52 -0500
Received: from esa6.hc1455-7.c3s2.iphmx.com ([68.232.139.139]:20998 "EHLO
        esa6.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgKDIRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:17:52 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 03:17:51 EST
IronPort-SDR: 090X4hTywmFwt7MqSf4RmOGAV8HDipv1KtaxJIi/17Uk87xkxzxlOKaK0NpiBC0F+uy+Ogfsyz
 eRpR5sSkKFd6IhweSkuCAwkBxKX1bFUOYo1c+IHk4XEpCBhw021wKOmRbichg9BFidtxAylSc1
 Obfcz+7JZ2RSvb5jswh55G477oNcC7xORFEQPIn4XXId+PTJcRR+tMJhXWW1dJsAcsJeQNiPLL
 SaArvCCv+DauSEjen+qESY8JxCJvKgDmJhkGUJZszSInCqxXs3dxiyj6r+BeclLiUModicfr0t
 sSs=
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="2273909"
X-IronPort-AV: E=Sophos;i="5.77,450,1596466800"; 
   d="scan'208";a="2273909"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP; 04 Nov 2020 17:10:43 +0900
Received: from kw-mxoi1.gw.nic.fujitsu.com (unknown [192.168.87.34])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C0D87A86F9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:41 +0900 (JST)
Received: from pumpkin.openstacklocal (pumpkin.fct.css.fujitsu.com [10.130.70.189])
        by kw-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id AD8F0AC0090
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 17:10:40 +0900 (JST)
Received: by pumpkin.openstacklocal (Postfix, from userid 1016)
        id 3E7DDB9A9; Wed,  4 Nov 2020 17:08:02 +0900 (JST)
From:   Yuichi Ito <ito-yuichi@fujitsu.com>
To:     maz@kernel.org, sumit.garg@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yuichi Ito <ito-yuichi@fujitsu.com>
Subject: [PATCH v2 2/3] arm64: smp: Register IPI_CPU_CRASH_STOP IPI as pseudo-NMI
Date:   Wed,  4 Nov 2020 17:05:38 +0900
Message-Id: <20201104080539.3205889-3-ito-yuichi@fujitsu.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
References: <20201104080539.3205889-1-ito-yuichi@fujitsu.com>
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
 arch/arm64/kernel/smp.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 82e75fc..fd59bc7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -80,6 +80,8 @@ enum ipi_msg_type {
 static int ipi_irq_base __read_mostly;
 static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+static int ipi_crash_stop = -1;
+static int ipi_crash_stop_enable_nmi;
 
 static void ipi_setup(int cpu);
 
@@ -960,8 +962,16 @@ static void ipi_setup(int cpu)
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
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -972,24 +982,38 @@ static void ipi_teardown(int cpu)
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
 #endif
 
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
-	int i;
+	int i, ret;
 
 	WARN_ON(n < NR_IPI);
 	nr_ipi = min(n, NR_IPI);
 
+	ret = request_percpu_nmi(ipi_base + IPI_CPU_CRASH_STOP,
+				ipi_handler, "IPI", &cpu_number);
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
+						"IPI", &cpu_number);
+			WARN_ON(err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
-- 
1.8.3.1

