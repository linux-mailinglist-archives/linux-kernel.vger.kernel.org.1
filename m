Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ED81A865C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391430AbgDNQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407498AbgDNQtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:07 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9D2E215A4;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882942;
        bh=TDBaW2fv5MluchG9f30Ep3GiWk6bRYTPMXmOqn5u5bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tExRyItUnncx8LuWTOl4o0YMcL20au2ug1LFxzmZIWwVa++CAIcxzVxHFVRl2eaH5
         FL0/xjRhw8Q358JBfLTBEObUiHFsf6M2UAI2SPYiICm0GmNqkaE+oyNChsgfB0KH1V
         2NdCsqlOCMy6NFbnVz+k7K0KBY+nGBmYdGeWETfY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk8-0068lt-Uu; Tue, 14 Apr 2020 18:49:00 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 13/33] docs: arm64: booting.rst: get rid of some warnings
Date:   Tue, 14 Apr 2020 18:48:39 +0200
Message-Id: <121b267be0a102fde73498c31792e5a9309013cc.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of those warnings:

    Documentation/arm64/booting.rst:253: WARNING: Unexpected indentation.
    Documentation/arm64/booting.rst:259: WARNING: Block quote ends without a blank line; unexpected unindent.

By adding an extra blank lines where needed.

While here, use list markups on some places, as otherwise Sphinx
will consider the next lines as continuation of the privious ones.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/booting.rst | 36 ++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index a3f1a47b6f1c..e50186092948 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -173,7 +173,9 @@ Before jumping into the kernel, the following conditions must be met:
 - Caches, MMUs
 
   The MMU must be off.
+
   Instruction cache may be on or off.
+
   The address range corresponding to the loaded kernel image must be
   cleaned to the PoC. In the presence of a system cache or other
   coherent masters with caches enabled, this will typically require
@@ -238,6 +240,7 @@ Before jumping into the kernel, the following conditions must be met:
   - The DT or ACPI tables must describe a GICv2 interrupt controller.
 
   For CPUs with pointer authentication functionality:
+
   - If EL3 is present:
 
     - SCR_EL3.APK (bit 16) must be initialised to 0b1
@@ -249,18 +252,22 @@ Before jumping into the kernel, the following conditions must be met:
     - HCR_EL2.API (bit 41) must be initialised to 0b1
 
   For CPUs with Activity Monitors Unit v1 (AMUv1) extension present:
+
   - If EL3 is present:
-    CPTR_EL3.TAM (bit 30) must be initialised to 0b0
-    CPTR_EL2.TAM (bit 30) must be initialised to 0b0
-    AMCNTENSET0_EL0 must be initialised to 0b1111
-    AMCNTENSET1_EL0 must be initialised to a platform specific value
-    having 0b1 set for the corresponding bit for each of the auxiliary
-    counters present.
+
+    - CPTR_EL3.TAM (bit 30) must be initialised to 0b0
+    - CPTR_EL2.TAM (bit 30) must be initialised to 0b0
+    - AMCNTENSET0_EL0 must be initialised to 0b1111
+    - AMCNTENSET1_EL0 must be initialised to a platform specific value
+      having 0b1 set for the corresponding bit for each of the auxiliary
+      counters present.
+
   - If the kernel is entered at EL1:
-    AMCNTENSET0_EL0 must be initialised to 0b1111
-    AMCNTENSET1_EL0 must be initialised to a platform specific value
-    having 0b1 set for the corresponding bit for each of the auxiliary
-    counters present.
+
+    - AMCNTENSET0_EL0 must be initialised to 0b1111
+    - AMCNTENSET1_EL0 must be initialised to a platform specific value
+      having 0b1 set for the corresponding bit for each of the auxiliary
+      counters present.
 
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
@@ -304,7 +311,8 @@ following manner:
   Documentation/devicetree/bindings/arm/psci.yaml.
 
 - Secondary CPU general-purpose register settings
-  x0 = 0 (reserved for future use)
-  x1 = 0 (reserved for future use)
-  x2 = 0 (reserved for future use)
-  x3 = 0 (reserved for future use)
+
+  - x0 = 0 (reserved for future use)
+  - x1 = 0 (reserved for future use)
+  - x2 = 0 (reserved for future use)
+  - x3 = 0 (reserved for future use)
-- 
2.25.2

