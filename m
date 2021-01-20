Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFE62FD21F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbhATN5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:57:31 -0500
Received: from mout.gmx.net ([212.227.15.18]:53571 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389887AbhATN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149256;
        bh=sS4ZFSv3zmqbPz2KXwVaLWTiVk0irVa/4iHby0s9NZM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=P0Lc4p7x2k8OBs1gihxpv3hGuxDqXekOzn5JSH8v9ojrSS1Hz6UFvCl3GRwtjE9Pj
         vzbNmW3ISlJDrIV84TWgm/O+GHcshsr48iEsTrEECuEKa3caG4gbamyWw1Dvwh8W31
         pr5TdWB4KsyqJo2dd2Y9d6w3cTVuoId90E/n+xd0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MeCtZ-1ldT9L10y7-00bKLo; Wed, 20 Jan 2021 14:27:36 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 6/7] arm64: kernel: Apple CPU start driver
Date:   Wed, 20 Jan 2021 14:27:16 +0100
Message-Id: <20210120132717.395873-7-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xUPi8b7530TH/g+V/7aWoHbeFH+rk/x2LFHGA/9Sl1KJwIJfV5C
 jfGehtCY8csqFOO1zmmup+141aV1J1ZfmujSe95UakvCUnWpUyk9X7zL3CSMlu8v3+5kWus
 +lso3mXkauwD1DipAU2Bn+b8m2Rs9/8Q3KzsaVKF/ngHPPgiZSWOaacZeWJL5xTDQFDxtvD
 LWOuwRkHh4EF1R7tTwKCA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:StyHDgkrnfA=:UrrLMK6n+pXPxaPuNl+gwY
 rmwePNL3zKSXviM+fZkqFJquecXruB4brz/eYGVbJQQr63NtrOyk9dxX5XIaNG91uBebyMAbq
 NjkTcIiar38VywkmL8+M+by4n4uHZDMACB6/DMWB6pdYgQJdr/Iw9jhpLGaoCyl1/QCeUCWKa
 3bd65iZtImlSIrrOcH/BoAGzczJgtcpa1eKNlNRpPZay53THTSnl4okIofZFRehOCw1fOga96
 zVX8eJSVGzKgAy3gv2jXO81Y125998bLHIV+2hH/ppcncTMeYg6BFGch0v9/2tQOolCd+/0vn
 p7XkCeCY4sOZrP+bMpHEOGsUrrbgv9PPbUfk/pPMlzdcVoo/Nku9B6A1zWL7q6aupWnVujDQb
 /KDidwemmFCyjVit1FVhVa0k9Rhd/+0W2zJyaN0XJW9CxQc38EQmqrBGLPtCWFKWPGb+bcywO
 5X9pqPVJzZxmEZn6+D5rRBGsXS47qgIe4mmDpwDELj8wg2R9WZnhlQQ3W97rt/R5OD2P71hdP
 zMYws81fLXAscOLz5U7fP2vj2ds8vUufZbtKIGJ0BPRqSCrDOqjnC4vreXHJAnH4GWlF177WU
 va6gYIWUTUB5bfgkd2qpOJHVf1D5Rqj9RqcSMhv4OgQdpgYm3eQUHnsodvW/XxunPwNAtxyRQ
 JF8tEXS6W2MalJRCEyhJzeOFEheZfeJz7fzLVOrWRITua6RwdgxNeblbFdvxKcY9nVmPXVceT
 C74Lk5dfHA0fMPqI7Wcbl9yGtmzAKIGSaQI334VHeHvKhHANNYibHwzRnok4TgsfLda/ew8Rx
 Q4OAzahAM57RfyGfXuHTvZzW9YuoozokbkovOowyC3NVw4MRF/5NiwBh7lv/Eu/IN2DntCBeI
 ioJ5NyoFMASa9W0SDmnH3Ao47Avbnjx7Ai1JLQOUM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

This driver is needed to spawn CPUs for SMP
on Apple Silicon platforms.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 .../devicetree/bindings/arm/cpus.yaml         |   1 +
 arch/arm64/kernel/Makefile                    |   1 +
 arch/arm64/kernel/apple_cpustart.c            | 153 ++++++++++++++++++
 3 files changed, 155 insertions(+)
 create mode 100644 arch/arm64/kernel/apple_cpustart.c

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentati=
on/devicetree/bindings/arm/cpus.yaml
index 14cd727d3c4b..a6ff8cb3db1e 100644
=2D-- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -176,6 +176,7 @@ properties:
     oneOf:
       # On ARM v8 64-bit this property is required
       - enum:
+          - apple
           - psci
           - spin-table
       # On ARM 32-bit systems this property is optional
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 86364ab6f13f..497f43ca7f0f 100644
=2D-- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_ARM64_RELOC_TEST)		+=3D arm64-reloc-test.o
 arm64-reloc-test-y :=3D reloc_test_core.o reloc_test_syms.o
 obj-$(CONFIG_CRASH_DUMP)		+=3D crash_dump.o
 obj-$(CONFIG_CRASH_CORE)		+=3D crash_core.o
+obj-$(CONFIG_ARCH_APPLE)                +=3D apple_cpustart.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+=3D sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+=3D pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+=3D mte.o
diff --git a/arch/arm64/kernel/apple_cpustart.c b/arch/arm64/kernel/apple_=
cpustart.c
new file mode 100644
index 000000000000..41d049eaaec7
=2D-- /dev/null
+++ b/arch/arm64/kernel/apple_cpustart.c
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: (GPL-2.0 or BSD-3-Clause) */
+/*
+ * Copyright (C) 2020 Corellium LLC
+ */
+
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/smp.h>
+#include <linux/delay.h>
+#include <linux/mm.h>
+
+#include <asm/cpu_ops.h>
+#include <asm/errno.h>
+#include <asm/smp_plat.h>
+#include <asm/io.h>
+
+#define MAGIC_UNLOCK 0xc5acce55
+
+struct cpu_apple_start_info {
+	void __iomem *pmgr_start;
+	u64 pmgr_start_size;
+	void __iomem *cputrc_rvbar;
+	void __iomem *dbg_unlock;
+};
+
+extern void apple_aic_cpu_prepare(unsigned int cpu);
+
+static int cpu_apple_start0_unlocked =3D 0;
+static DEFINE_PER_CPU(struct cpu_apple_start_info, cpu_apple_start_info);
+
+static int __init cpu_apple_start_init(unsigned int cpu)
+{
+	return 0;
+}
+
+static int cpu_apple_start_prepare(unsigned int cpu)
+{
+	struct device_node *node;
+	struct cpu_apple_start_info *info;
+
+	info =3D per_cpu_ptr(&cpu_apple_start_info, cpu);
+
+	if (info->pmgr_start && info->cputrc_rvbar && info->dbg_unlock)
+		return 0;
+
+	node =3D of_find_compatible_node(NULL, NULL, "apple,startcpu");
+	if (!node) {
+		pr_err("%s: missing startcpu node in device tree.\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!info->pmgr_start) {
+		info->pmgr_start =3D of_iomap(node, cpu * 3);
+		if (!info->pmgr_start) {
+			pr_err("%s: failed to map start register for CPU %d.\n",
+			       __func__, cpu);
+			return -EINVAL;
+		}
+		if (!of_get_address(node, cpu * 3, &info->pmgr_start_size,
+				    NULL))
+			info->pmgr_start_size =3D 8;
+	}
+
+	if (!info->cputrc_rvbar) {
+		info->cputrc_rvbar =3D of_iomap(node, cpu * 3 + 1);
+		if (!info->cputrc_rvbar) {
+			pr_err("%s: failed to map reset address register for CPU %d.\n",
+			       __func__, cpu);
+			return -EINVAL;
+		}
+	}
+
+	if (!info->dbg_unlock) {
+		info->dbg_unlock =3D of_iomap(node, cpu * 3 + 2);
+		if (!info->dbg_unlock) {
+			pr_err("%s: failed to map unlock register for CPU %d.\n",
+			       __func__, cpu);
+			return -EINVAL;
+		}
+	}
+
+	if (cpu)
+		apple_aic_cpu_prepare(cpu);
+
+	return 0;
+}
+
+static int cpu_apple_start_boot(unsigned int cpu)
+{
+	struct cpu_apple_start_info *info;
+	unsigned long addr;
+
+	if (!cpu_apple_start0_unlocked) {
+		if (!cpu_apple_start_prepare(0)) {
+			info =3D per_cpu_ptr(&cpu_apple_start_info, 0);
+			writel(MAGIC_UNLOCK, info->dbg_unlock);
+			cpu_apple_start0_unlocked =3D 1;
+		} else
+			pr_err("%s: failed to unlock boot CPU\n", __func__);
+	}
+
+	info =3D per_cpu_ptr(&cpu_apple_start_info, cpu);
+
+	if (!info->pmgr_start || !info->cputrc_rvbar || !info->dbg_unlock)
+		return -EINVAL;
+
+	writeq(__pa_symbol(secondary_entry) | 1, info->cputrc_rvbar);
+	readq(info->cputrc_rvbar);
+	writeq(__pa_symbol(secondary_entry) | 1, info->cputrc_rvbar);
+	addr =3D readq(info->cputrc_rvbar) & 0xFFFFFFFFFul;
+	dsb(sy);
+
+	if (addr !=3D (__pa_symbol(secondary_entry) | 1))
+		pr_err("%s: CPU%d reset address: 0x%lx, failed to set to 0x%lx.\n",
+		       __func__, cpu, addr,
+		       (unsigned long)(__pa_symbol(secondary_entry) | 1));
+
+	writel(MAGIC_UNLOCK, info->dbg_unlock);
+
+	writel(1 << cpu, info->pmgr_start);
+	if (info->pmgr_start_size >=3D 12) {
+		if (cpu < 4) {
+			writel(1 << cpu, info->pmgr_start + 4);
+			writel(0, info->pmgr_start + 8);
+		} else {
+			writel(0, info->pmgr_start + 4);
+			writel(1 << (cpu - 4), info->pmgr_start + 8);
+		}
+	} else
+		writel(1 << cpu, info->pmgr_start + 4);
+
+	dsb(sy);
+	sev();
+
+	return 0;
+}
+
+static void cpu_apple_wfi(void)
+{
+	/* can't do a proper WFI, because the CPU tends to lose state; will need
+       a proper wrapper sequence */
+	dsb(sy);
+	wfe();
+}
+
+const struct cpu_operations cpu_apple_start_ops =3D {
+	.name =3D "apple",
+	.cpu_init =3D cpu_apple_start_init,
+	.cpu_prepare =3D cpu_apple_start_prepare,
+	.cpu_boot =3D cpu_apple_start_boot,
+	.cpu_wfi =3D cpu_apple_wfi,
+};
=2D-
2.29.2

