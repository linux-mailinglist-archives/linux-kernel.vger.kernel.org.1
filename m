Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7B72879DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 18:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgJHQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 12:22:16 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34910 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgJHQWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 12:22:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 546CD29D0AA
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Collabora Kernel ML <kernel@collabora.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>, Willy Tarreau <w@1wt.eu>
Subject: [PATCH] x86/x86_64_defconfig: Enable the serial console
Date:   Thu,  8 Oct 2020 18:22:06 +0200
Message-Id: <20201008162206.862203-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of KernelCI, we added a bunch of different x86 based Chromebooks
to do test booting and runtime testing. It will be useful have serial
support for these platforms in the default defconfig, as this, is the
defconfig used by default for the different maintainer's tree.

SERIAL_8250_DW is the actual support for the console, but to have
support we need to enable X86_AMD_PLATFORM_DEVICE for specific AMD
boards and MFD_INTEL for specific Intel boards.

While here, also enable USB_RTL8152 config which enables a common
USB-Ethernet adapter used very commonly in the KernelCI labs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/x86/configs/x86_64_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 9936528e1939..c43f61a8059c 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -20,6 +20,7 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
+CONFIG_X86_AMD_PLATFORM_DEVICE=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
@@ -149,6 +150,7 @@ CONFIG_SKY2=y
 CONFIG_FORCEDETH=y
 CONFIG_8139TOO=y
 CONFIG_R8169=y
+CONFIG_USB_RTL8152=y
 CONFIG_INPUT_POLLDEV=y
 CONFIG_INPUT_EVDEV=y
 CONFIG_INPUT_JOYSTICK=y
@@ -164,6 +166,7 @@ CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
+CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HW_RANDOM_INTEL is not set
@@ -173,6 +176,7 @@ CONFIG_HPET=y
 # CONFIG_HPET_MMAP is not set
 CONFIG_I2C_I801=y
 CONFIG_WATCHDOG=y
+CONFIG_MFD_INTEL_LPSS_PCI=y
 CONFIG_AGP=y
 CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
-- 
2.28.0

