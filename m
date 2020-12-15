Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39912DB456
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgLOTMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:12:35 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:39875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbgLOTMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:12:35 -0500
Received: from orion.localdomain ([95.118.67.37]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MCsLo-1ky5OG0Si8-008sH3; Tue, 15 Dec 2020 20:09:40 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: [PATCH v2] arch: x86: make video init optional (expert)
Date:   Tue, 15 Dec 2020 20:09:38 +0100
Message-Id: <20201215190938.15731-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:aKY4zWW2HOkv9jw/1k+Mn2qVyLSvD2hDJW1Niz5XUqoILWdHhrr
 UJbX0IQIKP6f2KdL+P5ymIFAii4RKbFnyOm5CXKjYuPCDl0C/4Yh+LaQ22Xey3XHaIWs/tS
 AURx/FgAQWoQLmkUfx/DVvOcM3otBL6LXrJI1fjo6BvLJK7E9WS+qt+Y9C01WvrgRU5Se8N
 6E16w/apmPnAxMQ+wWexA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fwNgAtP2KIY=:8OtkQsk64sXDXEKwpWn2jV
 aiwne3e9TX77yTStkvUGCBmfcFTaitllhl0jL24+K9L2+8wRvYCGjD7EJxkngHYXl1LJPUMJ2
 ov2+RWDDxd3Nc59kXnLm2J/nC7w8l01EzIlBq9MO9zyh0tgcj/eRsweoRn3VTAjlal7/Jghzb
 UhfIcalE/g73zVgfPaGtxaiMEFfPaAhNrG+1zrGuPQXEcLHPy51toWA2GqJUUg+vM9Ok8cxO/
 XMj/Nn4qubU8i1GhnpaWWWgTi/ATum/hViJ1ya+zFB36ApYx+oWZUGC/mvPjxUmbOEktaZfWE
 dgmeB0N7IwKe2WanqVqS5VFuQpLf2ATW+uBCGVHFECJfQVxm9rGGlrdjfFsvK5Y/P+zZdNtdF
 XPnb67wyMoAFX+ajM8MG9GPewxwiDOuEDA56cOT1RNpfI+mYhiwT9MJZUdk6s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As x86 is becoming more widespread in embedded devices, that don't have
any video adapter at all, make it possible to opt out from video init on
bootup (expert option). Also useful for minimized paravirtualized kernels.

Most users want to leave this enabled and shouldn't touch it, thus defaulting
to y and hiding behind CONFIG_EXPERT.

Signed-off-by: Enrico Weigelt <info@metux.net>

---

changes v2: fixed spelling in commit message and kconfig help text
---
 arch/x86/Kconfig       |  7 +++++++
 arch/x86/boot/Makefile | 10 +++++-----
 arch/x86/boot/main.c   |  2 ++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index eeb87fce9c6f..8eba95a6bc24 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -916,6 +916,13 @@ config DMI
 	  affected by entries in the DMI blacklist. Required by PNP
 	  BIOS code.
 
+config X86_BOOT_VIDEO
+	default y
+	bool "Setup video on boot" if EXPERT
+	help
+	  Enable setting video mode on boot. Say Y here unless your machine
+	  doesn't have any video adapter. (e.g., embedded systems or VMs)
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

