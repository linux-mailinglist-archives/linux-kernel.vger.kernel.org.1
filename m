Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0904D2FDAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388792AbhATN6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:58:47 -0500
Received: from mout.gmx.net ([212.227.15.15]:37119 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389844AbhATN3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:29:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611149254;
        bh=s+ysOp4OcvfRllPUaGW+Vz2xQAyomqy7xIT6QOV4oaQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OW+6blaI6lZsvDiIrRkXFfuhKpbCF1mPXlZZnWfPVeKtDA8PgS6JoUgi3XNRp25Xo
         KaB+oo1ozexSmGo8SRpjlv+tmoNDf3CUmbkB4MlSuwUDL4Vrwubj2jwUDztd0WHAwv
         fciCabDX/718a98oXRZ48K6t3sZRpRr+7KjnE3BM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.204.192.78]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MZTmO-1lYi5A0kBK-00WWzx; Wed, 20 Jan 2021 14:27:34 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>
Subject: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple processors
Date:   Wed, 20 Jan 2021 14:27:13 +0100
Message-Id: <20210120132717.395873-4-mohamed.mediouni@caramail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tgRN9ZZSe4I0G1AnOStUrLzlx9ePZFoTVM7kvlMbPu/L2SyFwd2
 wVJoN+bOlH6NLGXNiegaSDh5m7jd1xuzbp3eGpZ2y9bfJVLBs/1kd6gq64kAGriYnH1zxgg
 3n0lRknK/OWJeYjRcO2YOtv55SssMWh7o26n74OqFUiYwMSD4hjhSwZsx64N8PkVaMnJDge
 UpFJEdaabuc5buav1mjuA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cvzZywDWErY=:y87grJtHm0+LLMwsB+ZsLA
 FQaQM0GBgeYTo2zySC2+7rX+N7JR8Z2G4x2vnkC2DGABO5aN44monBSOY5Tz3f0CYbv+KSAHC
 wgpKeKWhUUlhwce/w3dkuyQ+h2DMTugsn5tg9O8t/wwaoZDQt4S1YL19LON3R8FaGaEebcFA1
 T8kD4LQjBvYh45z7HxMh3/N6BQLigNimFrhF/61U6swlP163sHAowwsN+fTOZOLr2zkefb8RZ
 ZX7ljnLxnniP3RfV9jQLVj2vl4GCcDs89CvWzXAj3iNxCkpinIyio0IZbhh5G3H3VqQ3I5juJ
 L77usap/mtCJS+Wlss2aBsOEoki9BCxIVpHm5p+0iUfrDAGcnlZyq2UsjgOHFQ+nkCozhBhnG
 mZztXr1na/R7I/mWIe6tNLbwe5KLb9Cn5cdS103mn+qZsvpTnfURS9YoOAUclJhJ2LvrpBU/+
 HK+JgWusLCdqTZorPVgITAjtNSdAL7MsbNLtFYMDnY9DYUsqbN8ug44AuYxqPGRpmJPjowYJ9
 lhiwm5Xihcg+xqil4Jk2nmZ8deBhGGzkP6OL2VVvilGS9txan80AVlHjroi0h/4EJ/r6htm29
 kWHL/Nhc875N+O59EFm1+lUOhWGaV5iDUfLJzL7iobEH7FCKhNLWZH6qUp2t7IgtfpP3fOauz
 aZ3XmxivUFASM8urLjVfbgIBOyUihnkFbvlkPLlu9jSYcnp1Bm7/DQe0YLJnhLY1S14SN0wdS
 1lFRMqLq3il1sBq4z0aHvoPx0EAHnXspuZqBJe393uCPggl5zKCjOkyQFsW0VmV7x10hAXYm9
 esdzlvE7O5P/ZJwV6EM0THsYz5q0qix4VFUfDuTXwVZmT4cFAR+yS2GXYdi0dLWip3gpjd9QX
 yYIsUxiArBl26aqG5p42QDt/DImVR9J5Amb1E+HOA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious hardware=
 quirk.

On Apple processors, writes using the nGnRE device memory type get dropped=
 in flight,
getting to nowhere.

Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
=2D--
 arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 1f7ee8c8b7b8..06436916f137 100644
=2D-- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -51,6 +51,25 @@
 #define TCR_KASAN_HW_FLAGS 0
 #endif

+#ifdef CONFIG_ARCH_APPLE
+
+/*
+ * Apple cores appear to black-hole writes done with nGnRE.
+ * We settled on a work-around that uses MAIR vs changing every single us=
er of
+ * nGnRE across the arm64 code.
+ */
+
+#define MAIR_EL1_SET_APPLE						\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
+#endif
+
 /*
  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal memor=
y and
  * changed during __cpu_setup to Normal Tagged if the system supports MTE=
.
@@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
 	 * Memory region attributes
 	 */
 	mov_q	x5, MAIR_EL1_SET
+#ifdef CONFIG_ARCH_APPLE
+	mrs	x0, MIDR_EL1
+	lsr	w0, w0, #24
+	mov_q	x1, MAIR_EL1_SET_APPLE
+	cmp	x0, #0x61			// 0x61 =3D Implementer: Apple
+	csel	x5, x1, x5, eq
+#endif
 #ifdef CONFIG_ARM64_MTE
 	mte_tcr	.req	x20

=2D-
2.29.2

