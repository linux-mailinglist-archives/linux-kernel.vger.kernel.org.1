Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531D92C3045
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 19:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbgKXS5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 13:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390975AbgKXS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:57:47 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B8EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 10:57:47 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id wJxg2300q4C55Sk01Jxglf; Tue, 24 Nov 2020 19:57:44 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khdVU-005WMp-Cs; Tue, 24 Nov 2020 19:57:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1khdVT-00ErGj-Rb; Tue, 24 Nov 2020 19:57:39 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] riscv: defconfig: k210: Disable CONFIG_VT
Date:   Tue, 24 Nov 2020 19:57:38 +0100
Message-Id: <20201124185738.3541314-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to enable Virtual Terminal support in the Canaan
Kendryte K210 defconfigs, as no terminal devices are supported and
enabled.  Hence disable CONFIG_VT, and remove the no longer needed
override for CONFIG_VGA_CONSOLE.

This reduces kernel size by ca. 65 KiB.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Against k210-sysctl-v15
---
 arch/riscv/configs/nommu_k210_defconfig        | 2 +-
 arch/riscv/configs/nommu_k210_sdcard_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index df89d53bd125679b..9262223037e43479 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -48,6 +48,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_LDISC_AUTOLOAD is not set
 # CONFIG_HW_RANDOM is not set
@@ -67,7 +68,6 @@ CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_NEW_LEDS=y
diff --git a/arch/riscv/configs/nommu_k210_sdcard_defconfig b/arch/riscv/configs/nommu_k210_sdcard_defconfig
index 3d2cb4747e7f85b7..4cd1715dd0cf3747 100644
--- a/arch/riscv/configs/nommu_k210_sdcard_defconfig
+++ b/arch/riscv/configs/nommu_k210_sdcard_defconfig
@@ -41,6 +41,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
+# CONFIG_VT is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_LDISC_AUTOLOAD is not set
 # CONFIG_HW_RANDOM is not set
@@ -60,7 +61,6 @@ CONFIG_GPIO_SIFIVE=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-- 
2.25.1

