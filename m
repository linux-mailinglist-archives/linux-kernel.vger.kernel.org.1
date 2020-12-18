Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FD2DDD09
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 03:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbgLRCra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 21:47:30 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:52347 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727134AbgLRCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 21:47:30 -0500
Received: from oscar.flets-west.jp (softbank126090214151.bbtec.net [126.90.214.151]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 0BI2jiPf019455;
        Fri, 18 Dec 2020 11:45:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 0BI2jiPf019455
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608259545;
        bh=qPO/CeFS916iiTlmoorEws7SZCbGYT3y30FxASNWlXY=;
        h=From:To:Cc:Subject:Date:From;
        b=ASh8EJOKtMoLmEkmBgZrSl/3bpm2TTRDE51v7Cvn4Qm1u5vopOVBmYaTgc0kfBGnX
         MwNa1SytSQZHFG9kE+fKdZ5TTZJWzNFbPo4gjJR3KKFTX9mXjJPb2GHN6oV//8tPn0
         H4fP5ucdPYRx2w459we6f3OUqWyGzYanqy6mx3YnFpnnI0ODY5eZqo+SLF9ndT+5Nh
         22NJIgXte2tBEn/iqEs/SpbRaBNVJY3kzRb+bDAu51S90UuU7eHLd3UouXjph0wLvj
         GACdLjGcgiJSkZEVjhACRT/YvrJ9+fNykSY0DJTRdamIJy+S4drpeLzA8ZEanmPsiX
         ENDwZ4iLBuuCA==
X-Nifty-SrcIP: [126.90.214.151]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: do not descend to vdso directories twice
Date:   Fri, 18 Dec 2020 11:45:40 +0900
Message-Id: <20201218024540.1102650-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

arm64 descends into each vdso directory twice; first in vdso_prepare,
second during the ordinary build process.

PPC mimicked it and uncovered a problem [1]. In the first descend,
Kbuild directly visits the vdso directories, therefore it does not
inherit subdir-ccflags-y from upper directories.

This means the command line parameters may differ between the two.
If it happens, the offset values in the generated headers might be
different from real offsets of vdso.so in the kernel.

This potential danger should be avoided. The vdso directories are
built in the vdso_prepare stage, so the second descend is unneeded.

[1]: https://lore.kernel.org/linux-kbuild/CAK7LNARAkJ3_-4gX0VA2UkapbOftuzfSTVMBbgbw=HD8n7N+7w@mail.gmail.com/T/#ma10dcb961fda13f36d42d58fa6cb2da988b7e73a

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arm64/Makefile                                | 10 ++++++----
 arch/arm64/kernel/Makefile                         |  5 +++--
 arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S}     |  0
 arch/arm64/kernel/vdso/Makefile                    |  1 -
 arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} |  0
 arch/arm64/kernel/vdso32/Makefile                  |  1 -
 6 files changed, 9 insertions(+), 8 deletions(-)
 rename arch/arm64/kernel/{vdso/vdso.S => vdso-wrap.S} (100%)
 rename arch/arm64/kernel/{vdso32/vdso.S => vdso32-wrap.S} (100%)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 6a87d592bd00..f18d20a68170 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -179,10 +179,12 @@ ifeq ($(KBUILD_EXTMOD),)
 # this hack.
 prepare: vdso_prepare
 vdso_prepare: prepare0
-	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso include/generated/vdso-offsets.h
-	$(if $(CONFIG_COMPAT_VDSO),$(Q)$(MAKE) \
-		$(build)=arch/arm64/kernel/vdso32  \
-		include/generated/vdso32-offsets.h)
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso \
+	include/generated/vdso-offsets.h arch/arm64/kernel/vdso/vdso.so
+ifdef CONFIG_COMPAT_VDSO
+	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso32 \
+	include/generated/vdso32-offsets.h arch/arm64/kernel/vdso32/vdso.so
+endif
 endif
 
 define archhelp
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 86364ab6f13f..42f6ad2c7eac 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -59,9 +59,10 @@ obj-$(CONFIG_CRASH_CORE)		+= crash_core.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)		+= sdei.o
 obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
+obj-y					+= vdso-wrap.o
+obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
 
-obj-y					+= vdso/ probes/
-obj-$(CONFIG_COMPAT_VDSO)		+= vdso32/
+obj-y					+= probes/
 head-y					:= head.o
 extra-y					+= $(head-y) vmlinux.lds
 
diff --git a/arch/arm64/kernel/vdso/vdso.S b/arch/arm64/kernel/vdso-wrap.S
similarity index 100%
rename from arch/arm64/kernel/vdso/vdso.S
rename to arch/arm64/kernel/vdso-wrap.S
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index a8f8e409e2bf..85222f64f394 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -45,7 +45,6 @@ endif
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-obj-y += vdso.o
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
diff --git a/arch/arm64/kernel/vdso32/vdso.S b/arch/arm64/kernel/vdso32-wrap.S
similarity index 100%
rename from arch/arm64/kernel/vdso32/vdso.S
rename to arch/arm64/kernel/vdso32-wrap.S
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index a1e0f91e6cea..789ad420f16b 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -155,7 +155,6 @@ c-obj-vdso-gettimeofday := $(addprefix $(obj)/, $(c-obj-vdso-gettimeofday))
 asm-obj-vdso := $(addprefix $(obj)/, $(asm-obj-vdso))
 obj-vdso := $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
 
-obj-y += vdso.o
 targets += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 
-- 
2.27.0

