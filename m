Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47DB2FCFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbhATLzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 06:55:40 -0500
Received: from mout.gmx.net ([212.227.17.20]:42671 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbhATLi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611142623;
        bh=yP+0ZpEyODQg4IQgrFLqLHkUEaxLQnyVarhdKMvY+Ew=;
        h=X-UI-Sender-Class:From:Subject:Date:Cc:To;
        b=NidgcRekJDfzb+7vs8u2A5qpqDVYwChkU6hZx25xb87lgh9e1MOepMBqBd76mZmI4
         IipsRmJChZ5/nJwb5YNaBT+JwnATdKESpc9dH66Hx7sMgA2QUr7ArVn70U93HdgVQA
         Vx0HJGrtEAVvXqL4VBfPcc58GjHFYdLCnLXzATa0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.42.0.78] ([83.204.192.78]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2mBQ-1m0vh43aA8-0132VU; Wed, 20
 Jan 2021 12:37:03 +0100
From:   Mohamed Mediouni <mohamed.mediouni@caramail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.5\))
Subject: [PATCH 3/3] arm64: mm: use nGnRnE instead of nGnRE on Apple 
 processors
Message-Id: <EA9911F3-9BB5-4B07-8FA7-8148B00B0F77@caramail.com>
Date:   Wed, 20 Jan 2021 12:37:02 +0100
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stan Skowronek <stan@corellium.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: Apple Mail (2.3654.60.0.2.5)
X-Provags-ID: V03:K1:LqipaoXg1JiKrBNorCn8+FwCfrzoRZrJ9EZuGtcEElXHOzz6vPB
 5h9Axeed+jmKMBiQzSOm4DnrO6Qxsy38Pn5BCZ7DjgmpKvALx6JxHjTUXXdO853F1wobyon
 LFjV1yo+vkNQn8AF2mwPL2pPH31q0Mdx8HTWx055vLJggoB2Chsi90CZlOoiWIUwo6otIMn
 7lI08uR3Nb9w1hDK3qz0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YWTH2k09Pjc=:ekdBfAdYjnPaVM/vkUpGmN
 5QogswEZLhOsx3vsb30ktDLV5aVF7PDTVctRPm3XyWQrKH8kTkf6hJC1YUJTQ07F4NpvsTHRV
 nNxDLm2bw0Xn2znW/Cx6FQc/yiyd7veYwJxH2hiEpIpwlDlHlPSxhPlmllqLJFnHV8XrDD6PY
 l5d7QTU35Azliwid1IbClWUSgdXNU6+zZuG7jK+a9oYhLdO6On0OhR4KKthKx+Qdn3RjOcjgS
 A6SaC5LZtMfXADc1ali2y5+r+IJY+oqOQrNu1Qdd54NYBd7KtKjfQbSf9okjo3DtDRSauQdJM
 gc/Z52KYc4idMORGG/TZdyC0iNXVUpz+cdBfzFyY8MlUAevEsTY7Saq4nBl9l/jNasc4IFRgf
 R5cUAn8xRxdPCp65caEG9ZIeRXEUW3GZT+uLYACVX+1d4IddkE73I+xWuQCLLLchbceXfQ8Hw
 3yqkpCATYdMekyhuHcQNR/W3jILPGq6pCNZtDw0inufklUV2vAa9Ez44avQarqDATQKjtBzM7
 vqrQZWDryCWrw3P8irtPn7CGCa5X0U1zI3L3simRNdh3hkO+o1ppkEMAKBI+//MZ4s91dnzp6
 zCfJMpGRgeeB9tCEbVXtQRqA7wk5j+0O6LYaTXR7oTDHHnyvxw94Nl9znT2N9yVdQ6CakgIq2
 a/m6UaTmIlQ7M0aDHdnjQCQZGBE9FA/wh5C8ddRK1Whb5cO73cI2lbAh+Z2amhHkrKl+svDay
 VrTiHJvx8aKyiRxOC6F3tl16KzT9JQC9+dMxE/rWFsXx2UVMUvnTLnBCP/kWbweysmsOTonZi
 BfLEKWPW5BXVcf7gqFnmt/hMDeUXEqi7XB81aRVQzDxR79PZZdTlj0BC1bVhsyLEN41TfuDHj
 k7hcpYXW1leFbkL+lbNBW6QIYl6l8p4+dHW8wQ+no=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mohamed Mediouni <mohamed.mediouni@caramail.com>

Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious =
hardware quirk.

On Apple processors, writes using the nGnRE device memory type get =
dropped in flight,
getting to nowhere.

Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
Signed-off-by: Stan Skowronek <stan@corellium.com>
---
 arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 1f7ee8c8b7b8..06436916f137 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -51,6 +51,25 @@
 #define TCR_KASAN_HW_FLAGS 0
 #endif
=20
+#ifdef CONFIG_ARCH_APPLE
+
+/*
+ * Apple cores appear to black-hole writes done with nGnRE.
+ * We settled on a work-around that uses MAIR vs changing every single =
user of
+ * nGnRE across the arm64 code.
+ */
+
+#define MAIR_EL1_SET_APPLE						=
\
+	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		=
\
+	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
+
+#endif
+
 /*
  * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal =
memory and
  * changed during __cpu_setup to Normal Tagged if the system supports =
MTE.
@@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
 	 * Memory region attributes
 	 */
 	mov_q	x5, MAIR_EL1_SET
+#ifdef CONFIG_ARCH_APPLE
+	mrs	x0, MIDR_EL1
+	lsr	w0, w0, #24
+	mov_q	x1, MAIR_EL1_SET_APPLE
+	cmp	x0, #0x61			// 0x61 =3D Implementer: =
Apple
+	csel	x5, x1, x5, eq
+#endif
 #ifdef CONFIG_ARM64_MTE
 	mte_tcr	.req	x20
=20
--=20
2.29.2


