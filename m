Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F54E2F85B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbhAOTpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:45:43 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733262AbhAOTpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:45:07 -0500
Received: from orion.localdomain ([95.117.2.80]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MJmCV-1lJxoY1Enx-00K941 for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021
 20:42:35 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: Kconfig: fix indentions
Date:   Fri, 15 Jan 2021 20:42:34 +0100
Message-Id: <20210115194234.6328-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:BUm5zuX2B30VbFPogoi/pB4sYMkUljFL3b8YJMIUzl/U5u5g9Zw
 NS0PU9H1MOATL/izXj4JExtADbbFO97o/orEUFF1wiJG/pq4dyNJ+AA3IdaBq/Q4/VP3sYW
 renpW8HC2ZWeSYOJUABx+YdduBcFOWkq6AcoHRsNcvrHE7fwxj71G2iqaQmI7wQ5L7CXKCD
 SrtRUzddIEwqeiuI62BFg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/d1/5erXTOE=:LCrqBY9vJ+b8fDbIyDRav/
 gxlEfF/3w2ZRFeOk9KkFms9OhphW90pwGGiXOvZX6pLW1vhKgqT9jKstdd5KhWWIVRgjwkOd+
 hdjPNZ4TNIhau1OUSP4odGgEAVfAcPnIOBPqTCjTlCIbvE4e3edRehgurN4ASWD/+9wG+D4E4
 fpwF20BS4NQGabD6VgaCAzsV9Aani4MLiDfN9ejtttR4vGRuzBzHtrrupIb65IYU1oM5wT1HX
 54VKLP33ZUa1luNN7IafuBEa9Z2CeNhPBUsDi2DepqNGtSpPmt0ZTG6LESfsFeqaSPyuHW6mm
 u41EQysNN00GZaaWG09rKKn/+q9A1c4BD9g0DXveSyv2bdcNZWkm3uYdbOmAZtAArcitza7RL
 Y3lQFI8Ri8et4/+RrANhbWOlmbeF/9sp1yzNAV7Zwe+7JqeWJo4fA2cd4ob3t
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the indentions consistent with everywhere else in the kernel.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/firmware/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 3f14dffb9669..490931b800ee 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -86,8 +86,8 @@ config EDD
 	  BIOS tries boot from.  This information is then exported via sysfs.
 
 	  This option is experimental and is known to fail to boot on some
-          obscure configurations. Most disk controller BIOS vendors do
-          not yet implement this feature.
+	  obscure configurations. Most disk controller BIOS vendors do
+	  not yet implement this feature.
 
 config EDD_OFF
 	bool "Sets default behavior for EDD detection to off"
@@ -99,14 +99,14 @@ config EDD_OFF
 	  using the kernel parameter 'edd={on|skipmbr|off}'.
 
 config FIRMWARE_MEMMAP
-    bool "Add firmware-provided memory map to sysfs" if EXPERT
-    default X86
-    help
-      Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
-      That memory map is used for example by kexec to set up parameter area
-      for the next kernel, but can also be used for debugging purposes.
+	bool "Add firmware-provided memory map to sysfs" if EXPERT
+	default X86
+	help
+	  Add the firmware-provided (unmodified) memory map to /sys/firmware/memmap.
+	  That memory map is used for example by kexec to set up parameter area
+	  for the next kernel, but can also be used for debugging purposes.
 
-      See also Documentation/ABI/testing/sysfs-firmware-memmap.
+	  See also Documentation/ABI/testing/sysfs-firmware-memmap.
 
 config EFI_PCDP
 	bool "Console device selection via EFI PCDP or HCDP table"
@@ -133,9 +133,9 @@ config EFI_PCDP
 	  <http://www.dig64.org/specifications/> 
 
 config DMIID
-    bool "Export DMI identification via sysfs to userspace"
-    depends on DMI
-    default y
+	bool "Export DMI identification via sysfs to userspace"
+	depends on DMI
+	default y
 	help
 	  Say Y here if you want to query SMBIOS/DMI system identification
 	  information from userspace through /sys/class/dmi/id/ or if you want
@@ -170,7 +170,7 @@ config ISCSI_IBFT
 	select ISCSI_BOOT_SYSFS
 	select ISCSI_IBFT_FIND if X86
 	depends on ACPI && SCSI && SCSI_LOWLEVEL
-	default	n
+	default n
 	help
 	  This option enables support for detection and exposing of iSCSI
 	  Boot Firmware Table (iBFT) via sysfs to userspace. If you wish to
-- 
2.11.0

