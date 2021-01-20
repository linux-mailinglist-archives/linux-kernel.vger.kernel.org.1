Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C82FD221
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbhATN5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:57:46 -0500
Received: from mout.gmx.net ([212.227.15.19]:57827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389894AbhATN3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149253;
        bh=Qa9Di41LcN0RuLnAp68u5mMaALrY7xnIGO1WB315kuo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=akLBpE10xmN+SQNDTySZETF5P6JMvSSXEEqfrLQ8sbKMcz0aSw6iNRmK/TPMs7+Cr
         BMD1KfWBWlOcf/0uhYIDqnme+60U+SjD2fTa7zS71kXdWCtzueZ1L23LYAypvFp1YO
         QqdGA9NwL2upvnFeaZQDj08MTtcCjeVr7uuUexmc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MIwzA-1lIDwF2YO2-00KTG9; Wed, 20 Jan 2021 14:27:33 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>
Subject: [RFC PATCH 2/7] arm64: kernel: Add a WFI hook.
Date:   Wed, 20 Jan 2021 14:27:12 +0100
Message-Id: <20210120132717.395873-3-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VFpxDb1Pw2xeOZRr7mOJYZKYKFdz9uqWWjqerljkCcZ9LCRlKdN
 Q5uAw7cv2cLU3r24bGFbFQNqNzTMXIg6nBOdfRDMUyr5RIq0GQVT/xFBaYTO65TMYcvHSBb
 i839SCKlA6H2az5y/0KNi3nRucCFPMzEe544c0albOKkKGS7nWwImD/LPbJCHj0poBrDyb7
 c9bubmzDe876bkTyY9v8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lptcHETjPWI=:H8zJtTpVUX88hOd4CmTUwM
 eXCTnZIzj8MEsPy1fz1MiLFlq1mocVd4sID0CDXoIOzaMK+xDCXO8rBzm5+7tipzqd9TKfXTA
 ZzDXAuX5AS7v64qWbVMzM2nQM2p2jM0wmLX60hWqNPakY0joMKwRf7hgGjnogY6xcI3293CtU
 ZrVsQzJv7RoIKRDO2ZIDz+oe7SCj9BDumcmQN+q4mhday4hDjh2MLuU9kTw8uP3oba6vzAYIa
 vvvmPcA0QzM+9DyPxPSi2QIfHY3xuoCYywME/Xu8Hatubcc+c30T9tYEIYk72HaUIFOHXodPl
 Bt7qK7FSyg+SedxovJ0bs+wqpQA0s2ecXQFkBTsAptEg0qAgR4UfAniyp7+8oqbjGJr/fxd/0
 Q89A7v0CRIAazZqW9KD449VmnGYc8OOwU7TWu4lJOaP+fhXVRPKjXkufjRAeMw8mRx2nirp6c
 05X0VcYEmHmP27sfLtgWVWcBprFOxocENJeVgVwazranfdzyu1Vk2O1uMVHIV8ajOK0MD0VtC
 IMUT+4xinygpxTCV2ACoOQhAm1JWbB600HlZx7CYq76MQnkMwdizmWGmDyiBvJv2MSZkRj4tq
 6gFJmURf7sbcsyJiA3SpFg2/9S2nyE1qJFSR6/XbhuD9WfCTlcOpPP1W0pbbKLAgJ8EP1Y4rZ
 17s20BB1IO4/Vw0fWx2dYwzGoG3F8GgBBBSfwRyP45AunuDWw1MpcI/T3Pu8s0nfb3Pv7G+Ob
 d4XFRv5u01iNK/2wXtRPpfQAKBtpp2twxgYR7LCwzA8XAZDlxTGqrhsaPqlXVmbwcu0l6KtQZ
 tR0MoJG+haX4ui5HGVRnjnPPbAiitF5/TKzDPu/L9QGCL8i0aapSC/knWSI5xA0OAA5HBAGUL
 2TbISFds5qsTmJ5rTsok6nxcJ4A3UkL9dXNJcvlng=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stan Skowronek <stan@corellium.com>

WFI drops register state on Apple Silicon for SMP systems.

This hook will be used for a hardware workaround in the
Apple CPU start driver.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 arch/arm64/include/asm/cpu_ops.h |  2 ++
 arch/arm64/kernel/cpu_ops.c      |  6 ++++++
 arch/arm64/kernel/process.c      | 11 +++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu=
_ops.h
index e95c4df83911..4be0fc5bcaf9 100644
=2D-- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -23,6 +23,7 @@
  * @cpu_boot:	Boots a cpu into the kernel.
  * @cpu_postboot: Optionally, perform any post-boot cleanup or necessary
  *		synchronisation. Called from the cpu being booted.
+ * @cpu_wfi:    Optionally, replace calls to WFI in default idle with thi=
s.
  * @cpu_can_disable: Determines whether a CPU can be disabled based on
  *		mechanism-specific information.
  * @cpu_disable: Prepares a cpu to die. May fail for some mechanism-speci=
fic
@@ -43,6 +44,7 @@ struct cpu_operations {
 	int		(*cpu_prepare)(unsigned int);
 	int		(*cpu_boot)(unsigned int);
 	void		(*cpu_postboot)(void);
+	void		(*cpu_wfi)(void);
 #ifdef CONFIG_HOTPLUG_CPU
 	bool		(*cpu_can_disable)(unsigned int cpu);
 	int		(*cpu_disable)(unsigned int cpu);
diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
index e133011f64b5..6979fc4490b2 100644
=2D-- a/arch/arm64/kernel/cpu_ops.c
+++ b/arch/arm64/kernel/cpu_ops.c
@@ -19,12 +19,18 @@ extern const struct cpu_operations smp_spin_table_ops;
 extern const struct cpu_operations acpi_parking_protocol_ops;
 #endif
 extern const struct cpu_operations cpu_psci_ops;
+#ifdef CONFIG_ARCH_APPLE
+extern const struct cpu_operations cpu_apple_start_ops;
+#endif

 static const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;

 static const struct cpu_operations *const dt_supported_cpu_ops[] __initco=
nst =3D {
 	&smp_spin_table_ops,
 	&cpu_psci_ops,
+#ifdef CONFIG_ARCH_APPLE
+	&cpu_apple_start_ops,
+#endif
 	NULL,
 };

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 34ec400288d0..611c639e20be 100644
=2D-- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -57,6 +57,7 @@
 #include <asm/processor.h>
 #include <asm/pointer_auth.h>
 #include <asm/stacktrace.h>
+#include <asm/cpu_ops.h>

 #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_STACKPROTECTOR_PER_=
TASK)
 #include <linux/stackprotector.h>
@@ -74,8 +75,14 @@ void (*arm_pm_restart)(enum reboot_mode reboot_mode, co=
nst char *cmd);

 static void noinstr __cpu_do_idle(void)
 {
-	dsb(sy);
-	wfi();
+	const struct cpu_operations *ops =3D get_cpu_ops(task_cpu(current));
+
+	if (ops->cpu_wfi) {
+		ops->cpu_wfi();
+	} else {
+		dsb(sy);
+		wfi();
+	}
 }

 static void noinstr __cpu_do_idle_irqprio(void)
=2D-
2.29.2

