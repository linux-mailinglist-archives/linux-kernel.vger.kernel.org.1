Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB52F4516
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbhAMHTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:19:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbhAMHTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:19:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9EDD2313C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610522305;
        bh=yCKxS1DSYhVHyS1a3hs3nRJQDRpcLQ5Y+3QYsl3z4Co=;
        h=From:To:Subject:Date:From;
        b=UvuW8lB9pkVHPsC9JA/LqCICW9Z8Thu1KOCcDWKBy5mShnNHpJUAJh2wSogrtQtf/
         NHprGcbYS17Qh4EeF7I1FueIpR5mdekUXge27RvNzlF5qwfvnaEOk3Lkfmp93XE8QC
         8/I3uC41iGQ5ycDvIqP2oGMWcU1VFNfOFT4RZxhVH/EDHOSoJCh6ClfTxl2LPuYD38
         NxxqmhiXe+qOt4YrpkwEL51CmHJMpQ/ZjQJgiZ3SYyOUxsAz7EZ/p/f/Cr0MEm/scj
         8F6S+fR34Df+zTalVlGgylSMM9SuGr4hBW8Y7i514mBOMN6qXuBzb6yWzBsvkGoIzU
         feOOtiCL5sRJw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] habanalabs: update email address in sysfs/debugfs docs
Date:   Wed, 13 Jan 2021 09:18:21 +0200
Message-Id: <20210113071822.25421-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use my kernel.org address for contact point instead of my private email
address.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../ABI/testing/debugfs-driver-habanalabs     | 44 +++++++-------
 .../ABI/testing/sysfs-driver-habanalabs       | 58 +++++++++----------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/Documentation/ABI/testing/debugfs-driver-habanalabs b/Documentation/ABI/testing/debugfs-driver-habanalabs
index 3979bfdaa080..d447a611c41b 100644
--- a/Documentation/ABI/testing/debugfs-driver-habanalabs
+++ b/Documentation/ABI/testing/debugfs-driver-habanalabs
@@ -1,7 +1,7 @@
 What:           /sys/kernel/debug/habanalabs/hl<n>/addr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the device address to be used for read or write through
                 PCI bar, or the device VA of a host mapped memory to be read or
                 written directly from the host. The latter option is allowed
@@ -11,7 +11,7 @@ Description:    Sets the device address to be used for read or write through
 What:           /sys/kernel/debug/habanalabs/hl<n>/clk_gate
 Date:           May 2020
 KernelVersion:  5.8
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allow the root user to disable/enable in runtime the clock
                 gating mechanism in Gaudi. Due to how Gaudi is built, the
                 clock gating needs to be disabled in order to access the
@@ -34,28 +34,28 @@ Description:    Allow the root user to disable/enable in runtime the clock
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_buffers
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about the currently allocated
                 command buffers
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_submission
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about the currently active
                 command submissions
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/command_submission_jobs
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays a list with detailed information about each JOB (CB) of
                 each active command submission
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/data32
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the root user to read or write directly through the
                 device's PCI bar. Writing to this file generates a write
                 transaction while reading from the file generates a read
@@ -70,7 +70,7 @@ Description:    Allows the root user to read or write directly through the
 What:           /sys/kernel/debug/habanalabs/hl<n>/data64
 Date:           Jan 2020
 KernelVersion:  5.6
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the root user to read or write 64 bit data directly
                 through the device's PCI bar. Writing to this file generates a
                 write transaction while reading from the file generates a read
@@ -85,7 +85,7 @@ Description:    Allows the root user to read or write 64 bit data directly
 What:           /sys/kernel/debug/habanalabs/hl<n>/device
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Enables the root user to set the device to specific state.
                 Valid values are "disable", "enable", "suspend", "resume".
                 User can read this property to see the valid values
@@ -93,28 +93,28 @@ Description:    Enables the root user to set the device to specific state.
 What:           /sys/kernel/debug/habanalabs/hl<n>/engines
 Date:           Jul 2019
 KernelVersion:  5.3
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the status registers values of the device engines and
                 their derived idle status
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_addr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets I2C device address for I2C transaction that is generated
                 by the device's CPU
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_bus
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets I2C bus address for I2C transaction that is generated by
                 the device's CPU
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_data
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Triggers an I2C transaction that is generated by the device's
                 CPU. Writing to this file generates a write transaction while
                 reading from the file generates a read transcation
@@ -122,32 +122,32 @@ Description:    Triggers an I2C transaction that is generated by the device's
 What:           /sys/kernel/debug/habanalabs/hl<n>/i2c_reg
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets I2C register id for I2C transaction that is generated by
                 the device's CPU
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/led0
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the state of the first S/W led on the device
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/led1
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the state of the second S/W led on the device
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/led2
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the state of the third S/W led on the device
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/mmu
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the hop values and physical address for a given ASID
                 and virtual address. The user should write the ASID and VA into
                 the file and then read the file to get the result.
@@ -157,14 +157,14 @@ Description:    Displays the hop values and physical address for a given ASID
 What:           /sys/kernel/debug/habanalabs/hl<n>/set_power_state
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the PCI power state. Valid values are "1" for D0 and "2"
                 for D3Hot
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/userptr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about the currently user
                 pointers (user virtual addresses) that are pinned and mapped
                 to DMA addresses
@@ -172,21 +172,21 @@ Description:    Displays a list with information about the currently user
 What:           /sys/kernel/debug/habanalabs/hl<n>/vm
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays a list with information about all the active virtual
                 address mappings per ASID
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/stop_on_err
 Date:           Mar 2020
 KernelVersion:  5.6
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Sets the stop-on_error option for the device engines. Value of
                 "0" is for disable, otherwise enable.
 
 What:           /sys/kernel/debug/habanalabs/hl<n>/dump_security_violations
 Date:           Jan 2021
 KernelVersion:  5.12
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Dumps all security violations to dmesg. This will also ack
                 all security violations meanings those violations will not be
                 dumped next time user calls this API
diff --git a/Documentation/ABI/testing/sysfs-driver-habanalabs b/Documentation/ABI/testing/sysfs-driver-habanalabs
index 169ae4b2a180..1f127f71d2b4 100644
--- a/Documentation/ABI/testing/sysfs-driver-habanalabs
+++ b/Documentation/ABI/testing/sysfs-driver-habanalabs
@@ -1,7 +1,7 @@
 What:           /sys/class/habanalabs/hl<n>/armcp_kernel_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the Linux kernel running on the device's CPU.
                 Will be DEPRECATED in Linux kernel version 5.10, and be
                 replaced with cpucp_kernel_ver
@@ -9,7 +9,7 @@ Description:    Version of the Linux kernel running on the device's CPU.
 What:           /sys/class/habanalabs/hl<n>/armcp_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the application running on the device's CPU
                 Will be DEPRECATED in Linux kernel version 5.10, and be
                 replaced with cpucp_ver
@@ -17,7 +17,7 @@ Description:    Version of the application running on the device's CPU
 What:           /sys/class/habanalabs/hl<n>/clk_max_freq_mhz
 Date:           Jun 2019
 KernelVersion:  not yet upstreamed
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency, in MHz.
                 The device clock might be set to lower value than the maximum.
                 The user should read the clk_cur_freq_mhz to see the actual
@@ -27,52 +27,52 @@ Description:    Allows the user to set the maximum clock frequency, in MHz.
 What:           /sys/class/habanalabs/hl<n>/clk_cur_freq_mhz
 Date:           Jun 2019
 KernelVersion:  not yet upstreamed
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the current frequency, in MHz, of the device clock.
                 This property is valid only for the Gaudi ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/cpld_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the Device's CPLD F/W
 
 What:           /sys/class/habanalabs/hl<n>/cpucp_kernel_ver
 Date:           Oct 2020
 KernelVersion:  5.10
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the Linux kernel running on the device's CPU
 
 What:           /sys/class/habanalabs/hl<n>/cpucp_ver
 Date:           Oct 2020
 KernelVersion:  5.10
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the application running on the device's CPU
 
 What:           /sys/class/habanalabs/hl<n>/device_type
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the code name of the device according to its type.
                 The supported values are: "GOYA"
 
 What:           /sys/class/habanalabs/hl<n>/eeprom
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    A binary file attribute that contains the contents of the
                 on-board EEPROM
 
 What:           /sys/class/habanalabs/hl<n>/fuse_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the device's version from the eFuse
 
 What:           /sys/class/habanalabs/hl<n>/hard_reset
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Interface to trigger a hard-reset operation for the device.
                 Hard-reset will reset ALL internal components of the device
                 except for the PCI interface and the internal PLLs
@@ -80,14 +80,14 @@ Description:    Interface to trigger a hard-reset operation for the device.
 What:           /sys/class/habanalabs/hl<n>/hard_reset_cnt
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays how many times the device have undergone a hard-reset
                 operation since the driver was loaded
 
 What:           /sys/class/habanalabs/hl<n>/high_pll
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency for MME, TPC
                 and IC when the power management profile is set to "automatic".
                 This property is valid only for the Goya ASIC family
@@ -95,7 +95,7 @@ Description:    Allows the user to set the maximum clock frequency for MME, TPC
 What:           /sys/class/habanalabs/hl<n>/ic_clk
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency, in Hz, of
                 the Interconnect fabric. Writes to this parameter affect the
                 device only when the power management profile is set to "manual"
@@ -107,27 +107,27 @@ Description:    Allows the user to set the maximum clock frequency, in Hz, of
 What:           /sys/class/habanalabs/hl<n>/ic_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the current clock frequency, in Hz, of the Interconnect
                 fabric. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/infineon_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the Device's power supply F/W code
 
 What:           /sys/class/habanalabs/hl<n>/max_power
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum power consumption of the
                 device in milliwatts.
 
 What:           /sys/class/habanalabs/hl<n>/mme_clk
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency, in Hz, of
                 the MME compute engine. Writes to this parameter affect the
                 device only when the power management profile is set to "manual"
@@ -139,21 +139,21 @@ Description:    Allows the user to set the maximum clock frequency, in Hz, of
 What:           /sys/class/habanalabs/hl<n>/mme_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the current clock frequency, in Hz, of the MME compute
                 engine. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/pci_addr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the PCI address of the device. This is needed so the
                 user would be able to open a device based on its PCI address
 
 What:           /sys/class/habanalabs/hl<n>/pm_mng_profile
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Power management profile. Values are "auto", "manual". In "auto"
                 mode, the driver will set the maximum clock frequency to a high
                 value when a user-space process opens the device's file (unless
@@ -167,13 +167,13 @@ Description:    Power management profile. Values are "auto", "manual". In "auto"
 What:           /sys/class/habanalabs/hl<n>/preboot_btl_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the device's preboot F/W code
 
 What:           /sys/class/habanalabs/hl<n>/soft_reset
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Interface to trigger a soft-reset operation for the device.
                 Soft-reset will reset only the compute and DMA engines of the
                 device
@@ -181,26 +181,26 @@ Description:    Interface to trigger a soft-reset operation for the device.
 What:           /sys/class/habanalabs/hl<n>/soft_reset_cnt
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays how many times the device have undergone a soft-reset
                 operation since the driver was loaded
 
 What:           /sys/class/habanalabs/hl<n>/status
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Status of the card: "Operational", "Malfunction", "In reset".
 
 What:           /sys/class/habanalabs/hl<n>/thermal_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the Device's thermal daemon
 
 What:           /sys/class/habanalabs/hl<n>/tpc_clk
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Allows the user to set the maximum clock frequency, in Hz, of
                 the TPC compute engines. Writes to this parameter affect the
                 device only when the power management profile is set to "manual"
@@ -212,12 +212,12 @@ Description:    Allows the user to set the maximum clock frequency, in Hz, of
 What:           /sys/class/habanalabs/hl<n>/tpc_clk_curr
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Displays the current clock frequency, in Hz, of the TPC compute
                 engines. This property is valid only for the Goya ASIC family
 
 What:           /sys/class/habanalabs/hl<n>/uboot_ver
 Date:           Jan 2019
 KernelVersion:  5.1
-Contact:        oded.gabbay@gmail.com
+Contact:        ogabbay@kernel.org
 Description:    Version of the u-boot running on the device's CPU
\ No newline at end of file
-- 
2.25.1

