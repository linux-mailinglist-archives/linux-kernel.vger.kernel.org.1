Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A642D1BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 22:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgLGVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 16:23:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:49167 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLGVXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 16:23:34 -0500
Received: from orion.localdomain ([95.114.88.149]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MybX9-1jwriY0rjZ-00ywdJ; Mon, 07 Dec 2020 22:20:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: [PATCH] arch: x86: make video init optional (expert)
Date:   Mon,  7 Dec 2020 22:20:33 +0100
Message-Id: <20201207212033.2736-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:empXPJ9sRUIswU1hXbgajJBpKXKAV49kijNPEitaurNmp2D1dxN
 fow3lCyEu8XjxHxANPaE5Wn6WzbtPfWHLS5HLrOKq6JjAVZoqZkV5ETbi5VfhcchvrCndbo
 /HypW/nf8EG5mkTq4n1fEBvUHf6CTz6l8GbNAC8IqAZ55vSZBurueTAlpabJu3UcY1C95AI
 VUunFfxxDxRGT4FXVARWQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GuzlYWLLAfQ=:d8FVKcGd/6H/LXYjNoO0U3
 lGj0E3zyDirbWV0bn4zuHyqFH3iCCbKjr8ZSJYwn6ehLd0g2itCt6LjHFFwKGqrkNuXRnmRpM
 qQdiIXgQx9C871mC+aG1WGWuhc6AkayGu+nziuBJglwOusX0DUYOtfMhl+d8usZ3S+IhYCLmL
 HnutRSKhwOXwXx7R8/sGpO6l0blkGUaAc9MKH5WsyuoKJfYCzZ1OwR4SEmeOeZ154f+oJ951V
 aAYJNgR54GC+KmRTes0WxNoYqWghxOVdGKlN8LbJqNyMQH6yghEu4mKnL9OtlRf7aFdyiXcCm
 uKnbsUcPtAvlFkMUKrGs100eL2t8QNL+s/NJYEfLRc2KFe1CW8fjTx2tJPhmPb7Z4bqYa7H+u
 rUvZCU5zemjNbBDJD+CXdFagntCaVzOE2A4OF/I5oUT6zY6IdsHya36yOhXkW
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As x86 is becoming more widespread in embedded devices, that don't have
any video adapter at all, make it possible to opt out from video init on
bootup (expert option). Also useful for minimized paravirtualized kernels.

Most users wanna leave this enabled and shouldn't touch it, thus defaulting
to y and hiding behind CONFIG_EXPERT.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 arch/x86/Kconfig       |  7 +++++++
 arch/x86/boot/Makefile | 10 +++++-----
 arch/x86/boot/main.c   |  2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fbf26e0f7a6a..43b4b2cca2b0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -913,6 +913,13 @@ config DMI
 	  affected by entries in the DMI blacklist. Required by PNP
 	  BIOS code.
 
+config X86_BOOT_VIDEO
+	default y
+	bool "Setup video on boot" if EXPERT
+	help
+	  Enable setting video mode on boot. Say Y here unless your machine
+	  doesn't have any video adapter. (eg. embedded systems or VMs)
+
 config GART_IOMMU
 	bool "Old AMD GART IOMMU support"
 	select DMA_OPS
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index fe605205b4ce..7f67e1118a99 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -34,17 +34,17 @@ subdir-		:= compressed
 
 setup-y		+= a20.o bioscall.o cmdline.o copy.o cpu.o cpuflags.o cpucheck.o
 setup-y		+= early_serial_console.o edd.o header.o main.o memory.o
-setup-y		+= pm.o pmjump.o printf.o regs.o string.o tty.o video.o
-setup-y		+= video-mode.o version.o
+setup-y		+= pm.o pmjump.o printf.o regs.o string.o tty.o version.o
 setup-$(CONFIG_X86_APM_BOOT) += apm.o
+setup-$(CONFIG_X86_BOOT_VIDEO) += video.o video-mode.o
 
 # The link order of the video-*.o modules can matter.  In particular,
 # video-vga.o *must* be listed first, followed by video-vesa.o.
 # Hardware-specific drivers should follow in the order they should be
 # probed, and video-bios.o should typically be last.
-setup-y		+= video-vga.o
-setup-y		+= video-vesa.o
-setup-y		+= video-bios.o
+setup-$(CONFIG_X86_BOOT_VIDEO)	+= video-vga.o
+setup-$(CONFIG_X86_BOOT_VIDEO)	+= video-vesa.o
+setup-$(CONFIG_X86_BOOT_VIDEO)	+= video-bios.o
 
 targets		+= $(setup-y)
 hostprogs	:= tools/build
diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index e3add857c2c9..61cab92f9a8e 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -174,7 +174,9 @@ void main(void)
 #endif
 
 	/* Set the video mode */
+#if defined(CONFIG_X86_BOOT_VIDEO)
 	set_video();
+#endif
 
 	/* Do the last things and invoke protected mode */
 	go_to_protected_mode();
-- 
2.11.0

