Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5A1E445E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 15:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgE0Nt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 09:49:58 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51029 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388607AbgE0Nt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:49:57 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MeToK-1j3mD13omq-00aStF; Wed, 27 May 2020 15:49:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pass -msoft-float to gcc earlier
Date:   Wed, 27 May 2020 15:49:34 +0200
Message-Id: <20200527134946.1034391-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G5fO0GvXqQ7URCOK275565svfOfjD5zjWbghoAyYqsXD61NGPPV
 K3P+UcFTh2o/d8MI/VsrOcbfFksMEw7u1v2KFJI6nP+xf/v/qOU6RVa+Pu5ZZg2ZtebjVaW
 tsb2V6RQplKSQTiTvuvi5WkDqZy6qzEGPwloEkwqKHfbICW6mNJObm/mwqBT1AGpuNNM43i
 vEz1YQwWcfzoziXlzOepQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:F/gBf8yOHW8=:5cuOcmDhdtzCJCm0zoNZgt
 ZtF8+oGlZwNWTXQJqiHCMjNXmEsfdwmft9cA4rbnXJs9aM7km6WYRsyc6oz9js5S1d3sh/aye
 xnogOzfSLlw+BYYo/c4AzbyxQgxv4OKSMa+RisnP8LfBCwUO980XTUQV5zRKqWw8IZn+FMPmB
 WtZhDlM9utEQyHFrPLej3hA/59gBS9ly0J0hXKZJRAvsykz8CzxVdtB639NywEP24FtN7cth6
 bWHBzJeTfzu/4dB6UWULId8FwI0XShfSfurO6JXs7gLBUJMruxzK9t8Y7WnCWnJY5e6q+GtOv
 +Mv0p6hs0+HsDU1jJRyQXtAbdAWJ92FMIaBptBuDogpASSMz2MwT2XeL6XXFAwJ+ndY/WBfbz
 SP3HS5MpUbA06oumhVdpuZR2WY8I3DxrmL5XYz9SXyJrr9PnEvcyrUwVjyK9dYSVvQhiLKfi1
 szwpcnObSPKcbdjQkxZSQ6WNJ73zQxmBtiqUjSZoy3FAxEvaGu23bH6+gRn2oFkkd0/M5R7UC
 Gs8rPkNeFdnDTpOeJOUXlD4t/AbqNafO0auZuWwnmvA9dRBiJfVj/Y63/XIkstvjBbTWx9GjG
 aUoPZpu+wffPiTB/0WCY3K4EQn5S0XwRXYYKHfypFtctx52XbI9G2utzxW4henz2dE4/gvxFa
 +3ZNgLhUBk1iDMWpzcERcAgRiGTX+Uxwk9yimIb1V6k4SUnoH6rKXG91EPLsNHPr54fMeJvF5
 3lu5tOCJzhS33qiU2PAupR2XFh93FPWVYvs55jwY0OiFTlqbH9DoBINICzuivzM3NVBPRryvJ
 KywP/UlNgPerwZHcHme3CXB1FxX6+wGwHYyoiXy3Lac0wX7lfM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Szabolcs Nagy ran into a kernel build failure with a custom gcc
toochain that sets -mfpu=auto -mfloat-abi-hard:

 /tmp/ccmNdcdf.s:1898: Error: selected processor does not support `cpsid i' in ARM mode

The problem is that $(call cc-option, -march=armv7-a) fails before the
kernel overrides the gcc options to also pass -msoft-float.

Move the option to the beginning the Makefile, before we call
cc-option for the first time.

Reported-by: Szabolcs Nagy <szabolcs.nagy@arm.com>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87302
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index fcd40c5bfd94..9804f8f61e67 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -16,6 +16,8 @@ LDFLAGS_vmlinux	+= --be8
 KBUILD_LDFLAGS_MODULE	+= --be8
 endif
 
+KBUILD_CFLAGS	+= -msoft-float
+
 ifeq ($(CONFIG_CPU_32v4),y)
 LDFLAGS_vmlinux	+= $(call ld-option,--fix-v4bx)
 LDFLAGS_MODULE	+= $(call ld-option,--fix-v4bx)
@@ -138,7 +140,7 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
-KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
+KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
-- 
2.26.2

