Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3307A1E22DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 15:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgEZNWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 09:22:35 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:32597 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgEZNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:22:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 04QDKoZa004724;
        Tue, 26 May 2020 22:20:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04QDKoZa004724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590499252;
        bh=obb2n8kjtEQ2zCZI5gbwOsMihSFwQFDcm79n56a85H8=;
        h=From:To:Cc:Subject:Date:From;
        b=bqJSmPDJUkObDgEYZa4nT5OCk2gFkTJkHlDwNALQ1WQamQUQN9ao4xJHBwBGedKOo
         i4wvpdNVRi65OyHW88oAnV2+pKDRdcmvopsPXhYD/HyXV/0myMNX7xDgXaVZt3xGIK
         +Pseh2POVwToAgGuLSw7bX6U7jPzVLDA43l7dPAw4ZGHvbPFRztLM5uJW4efULPwKi
         gAcfqu4FQjq089c+CzNR6rZSKuih3mbYDQV1KhlCK8fP7jbpKlDt4CDPIJi3HC3y58
         shIwSbUwykOHl5cgbOa2GboKHTS+gtAjQUmzwOs3do9ufDlx8XhUZHzba3SdvGoHEp
         2cZ/Mr1IAd1Pg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Lamparter <chunkeey@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: add arch/arm/Kbuild
Date:   Tue, 26 May 2020 22:20:31 +0900
Message-Id: <20200526132032.400264-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard obj-y form to specify the sub-directories under
arch/arm/. No functional change intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.7-rc1

 arch/arm/Kbuild   | 11 +++++++++++
 arch/arm/Makefile | 12 +-----------
 2 files changed, 12 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/Kbuild

diff --git a/arch/arm/Kbuild b/arch/arm/Kbuild
new file mode 100644
index 000000000000..5208f7061524
--- /dev/null
+++ b/arch/arm/Kbuild
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_FPE_NWFPE)		+= nwfpe/
+# Put arch/arm/fastfpe/ to use this.
+obj-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/fastfpe/))
+obj-$(CONFIG_VFP)		+= vfp/
+obj-$(CONFIG_XEN)		+= xen/
+obj-$(CONFIG_VDSO)		+= vdso/
+obj-y				+= kernel/ mm/ common/
+obj-y				+= probes/
+obj-y				+= net/
+obj-y				+= crypto/
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cd28211f1418..5f617fb1782e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -272,18 +272,8 @@ endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
-core-$(CONFIG_FPE_NWFPE)	+= arch/arm/nwfpe/
-# Put arch/arm/fastfpe/ to use this.
-core-$(CONFIG_FPE_FASTFPE)	+= $(patsubst $(srctree)/%,%,$(wildcard $(srctree)/arch/arm/fastfpe/))
-core-$(CONFIG_VFP)		+= arch/arm/vfp/
-core-$(CONFIG_XEN)		+= arch/arm/xen/
-core-$(CONFIG_VDSO)		+= arch/arm/vdso/
-
+core-y				+= arch/arm/
 # If we have a machine-specific directory, then include it in the build.
-core-y				+= arch/arm/kernel/ arch/arm/mm/ arch/arm/common/
-core-y				+= arch/arm/probes/
-core-y				+= arch/arm/net/
-core-y				+= arch/arm/crypto/
 core-y				+= $(machdirs) $(platdirs)
 
 # For cleaning
-- 
2.25.1

