Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574A42BC1C8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 20:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgKUTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 14:38:18 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:53638 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbgKUTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 14:38:17 -0500
Received: from grover.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 0ALJawZF029948;
        Sun, 22 Nov 2020 04:37:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 0ALJawZF029948
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1605987421;
        bh=zRjAI6MWIz8eko8nj7c1QV+VW5QvZBMpIg5afqWWL3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X+jMy/oClpaAo13iHygxx8F3dSxfFzoypa25P4VmOe4gJ3rXB8WohOPSc0BAnTaec
         o4zx7LWDjGh28u+7Bce57OLV328pXbgb8ibiv3pjUETHH/hpHUBTOK4kKSxf5hhI/4
         v9SyRdKLWPXnO0rC2p6fQjnacLrQDw3btZmEMui0MVSoh88EdwZCAsTwZ3AyoshBGN
         QOeG38sYI6/YS+MrTBmLGyiIMR1/Hjzu4w7iNNCmYHCk75XzJyOMrCMuiXinIht5Mt
         T2wRPl2IKqldLTCMFac0goaNMPSknuMLruPz/vU1E3TyAUyfkMSyIeAHeM/e8f9jVA
         3NfaTGVlEoUBg==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] ARC: build: move symlink creation to arch/arc/Makefile to avoid race
Date:   Sun, 22 Nov 2020 04:36:55 +0900
Message-Id: <20201121193657.51441-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201121193657.51441-1-masahiroy@kernel.org>
References: <20201121193657.51441-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you run 'make uImage uImage.gz' with the parallel option, uImage.gz
will be created by two threads simultaneously.

This is because arch/arc/Makefile does not specify the dependency
between uImage and uImage.gz. Hence, GNU Make assumes they can be
built in parallel. One thread descends into arch/arc/boot/ to create
uImage, and another to create uImage.gz.

Please notice the same log is displayed twice in the following steps:

  $ export CROSS_COMPILE=<your-arc-compiler-prefix>
  $ make -s ARCH=arc defconfig
  $ make -j$(nproc) ARCH=arc uImage uImage.gz
  [ snip ]
    LD      vmlinux
    SORTTAB vmlinux
    SYSMAP  System.map
    OBJCOPY arch/arc/boot/vmlinux.bin
    OBJCOPY arch/arc/boot/vmlinux.bin
    GZIP    arch/arc/boot/vmlinux.bin.gz
    GZIP    arch/arc/boot/vmlinux.bin.gz
    UIMAGE  arch/arc/boot/uImage.gz
    UIMAGE  arch/arc/boot/uImage.gz
  Image Name:   Linux-5.10.0-rc4-00003-g62f23044
  Created:      Sun Nov 22 02:52:26 2020
  Image Type:   ARC Linux Kernel Image (gzip compressed)
  Data Size:    2109376 Bytes = 2059.94 KiB = 2.01 MiB
  Load Address: 80000000
  Entry Point:  80004000
    Image arch/arc/boot/uImage is ready
  Image Name:   Linux-5.10.0-rc4-00003-g62f23044
  Created:      Sun Nov 22 02:52:26 2020
  Image Type:   ARC Linux Kernel Image (gzip compressed)
  Data Size:    2815455 Bytes = 2749.47 KiB = 2.69 MiB
  Load Address: 80000000
  Entry Point:  80004000

This is a race between the two threads trying to write to the same file
arch/arc/boot/uImage.gz. This is a potential problem that can generate
a broken file.

I fixed a similar problem for ARM by commit 3939f3345050 ("ARM: 8418/1:
add boot image dependencies to not generate invalid images").

I highly recommend to avoid such build rules that cause a race condition.

Move the uImage rule to arch/arc/Makefile.

Another strangeness is that arch/arc/boot/Makefile compares the
timestamps between $(obj)/uImage and $(obj)/uImage.*:

  $(obj)/uImage: $(obj)/uImage.$(suffix-y)
          @ln -sf $(notdir $<) $@
          @echo '  Image $@ is ready'

This does not work as expected since $(obj)/uImage is a symlink.
The symlink should be created in a phony target rule.

I used $(kecho) instead of echo to suppress the message
'Image arch/arc/boot/uImage is ready' when the -s option is given.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Makefile      | 13 ++++++++++++-
 arch/arc/boot/Makefile | 11 +----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index cf9da9aea12a..578bdbbb0fa7 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -102,11 +102,22 @@ libs-y		+= arch/arc/lib/ $(LIBGCC)
 
 boot		:= arch/arc/boot
 
-boot_targets := uImage uImage.bin uImage.gz uImage.lzma
+boot_targets := uImage.bin uImage.gz uImage.lzma
 
 PHONY += $(boot_targets)
 $(boot_targets): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
+uimage-default-y			:= uImage.bin
+uimage-default-$(CONFIG_KERNEL_GZIP)	:= uImage.gz
+uimage-default-$(CONFIG_KERNEL_LZMA)	:= uImage.lzma
+
+PHONY += uImage
+uImage: $(uimage-default-y)
+	@ln -sf $< $(boot)/uImage
+	@$(kecho) '  Image $(boot)/uImage is ready'
+
+CLEAN_FILES += $(boot)/uImage
+
 archclean:
 	$(Q)$(MAKE) $(clean)=$(boot)
diff --git a/arch/arc/boot/Makefile b/arch/arc/boot/Makefile
index 538b92f4dd25..3b1f8a69a89e 100644
--- a/arch/arc/boot/Makefile
+++ b/arch/arc/boot/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-targets := vmlinux.bin vmlinux.bin.gz uImage
+targets := vmlinux.bin vmlinux.bin.gz
 
 # uImage build relies on mkimage being availble on your host for ARC target
 # You will need to build u-boot for ARC, rename mkimage to arc-elf32-mkimage
@@ -13,11 +13,6 @@ LINUX_START_TEXT = $$(readelf -h vmlinux | \
 UIMAGE_LOADADDR    = $(CONFIG_LINUX_LINK_BASE)
 UIMAGE_ENTRYADDR   = $(LINUX_START_TEXT)
 
-suffix-y := bin
-suffix-$(CONFIG_KERNEL_GZIP)	:= gz
-suffix-$(CONFIG_KERNEL_LZMA)	:= lzma
-
-targets += uImage
 targets += uImage.bin
 targets += uImage.gz
 targets += uImage.lzma
@@ -42,7 +37,3 @@ $(obj)/uImage.gz: $(obj)/vmlinux.bin.gz FORCE
 
 $(obj)/uImage.lzma: $(obj)/vmlinux.bin.lzma FORCE
 	$(call if_changed,uimage,lzma)
-
-$(obj)/uImage: $(obj)/uImage.$(suffix-y)
-	@ln -sf $(notdir $<) $@
-	@echo '  Image $@ is ready'
-- 
2.25.1

