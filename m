Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0A02A003A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 09:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgJ3In1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 04:43:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:36686 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbgJ3In1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 04:43:27 -0400
IronPort-SDR: qihjapCdtA4tALK9b/AaFESO1Pk11xVFJL67SDCeggYTN8QwbLwMyMnmJzUA6xxB787VgzrT8I
 af5yZd1YS3tQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="186381985"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="186381985"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 01:43:26 -0700
IronPort-SDR: XjSnM+vJX1VrgkPr2onDnCG6DkgeY4rc7kXe01SYfsNPR9Qc79h8hEtXmgdG90cB0/3Y1T8bMn
 9Wd7cMCb5OLA==
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="536993206"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 01:43:23 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v3] soundwire: SDCA: add helper macro to access controls
Date:   Fri, 30 Oct 2020 04:49:55 +0800
Message-Id: <20201029204955.8568-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The upcoming SDCA (SoundWire Device Class Audio) specification defines
a hierarchical encoding to interface with Class-defined capabilities.

The specification is not yet accessible to the general public but this
information is released with explicit permission from the MIPI Board
to avoid delays with SDCA support on Linux platforms.

A block of 64 MBytes of register addresses are allocated to SDCA
controls, starting at address 0x40000000. The 26 LSBs which identify
individual controls are set based on the following variables:

- Function Number. An SCDA device can be split in up to 8 independent
  Functions. Each of these Functions is described in the SDCA
  specification, e.g. Smart Amplifier, Smart Microphone, Simple
  Microphone, Jack codec, HID, etc.

- Entity Number.  Within each Function,  an Entity is  an identifiable
  block.  Up   to  127  Entities   are  connected  in   a  pre-defined
  graph  (similar to  USB), with  Entity0 reserved  for Function-level
  configurations.  In  contrast  to  USB, the  SDCA  spec  pre-defines
  Function Types, topologies, and allowed  options, i.e. the degree of
  freedom  is not  unlimited to  limit  the possibility  of errors  in
  descriptors leading to software quirks.

- Control Selector. Within each Entity, the SDCA specification defines
  48 controls such as Mute, Gain, AGC, etc, and 16 implementation
  defined ones. Some Control Selectors might be used for low-level
  platform setup, and other exposed to applications and users. Note
  that the same Control Selector capability, e.g. Latency control,
  might be located at different offsets in different entities, the
  Control Selector mapping is Entity-specific.

- Control Number. Some Control Selectors allow channel-specific values
  to be set, with up to 64 channels allowed. This is mostly used for
  volume control.

- Current/Next values. Some Control Selectors are
  'Dual-Ranked'. Software may either update the Current value directly
  for immediate effect. Alternatively, software may write into the
  'Next' values and update the SoundWire 1.2 'Commit Groups' register
  to copy 'Next' values into 'Current' ones in a synchronized
  manner. This is different from bank switching which is typically
  used to change the bus configuration only.

- MBQ. the Multi-Byte Quantity bit is used to provide atomic updates
  when accessing more that one byte, for example a 16-bit volume
  control would be updated consistently, the intermediate values
  mixing old MSB with new LSB are not applied.

These 6 parameters are used to build a 32-bit address to access the
desired Controls. Because of address range, paging is required, but
the most often used parameter values are placed in the lower 16 bits
of the address. This helps to keep the paging registers constant while
updating Controls for a specific Device/Function.

Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
Changelog:

v2:
 - add SDW_SDCA_MBQ_CTL

v3:
 - add SDW_SDCA_NEXT_CTL

---
 include/linux/soundwire/sdw_registers.h | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/soundwire/sdw_registers.h b/include/linux/soundwire/sdw_registers.h
index f420e8059779..e14dff9a9c7f 100644
--- a/include/linux/soundwire/sdw_registers.h
+++ b/include/linux/soundwire/sdw_registers.h
@@ -298,4 +298,36 @@
 #define SDW_CASC_PORT_MASK_INTSTAT3		1
 #define SDW_CASC_PORT_REG_OFFSET_INTSTAT3	2
 
+/*
+ * v1.2 device - SDCA address mapping
+ *
+ * Spec definition
+ *	Bits		Contents
+ *	31		0 (required by addressing range)
+ *	30:26		0b10000 (Control Prefix)
+ *	25		0 (Reserved)
+ *	24:22		Function Number [2:0]
+ *	21		Entity[6]
+ *	20:19		Control Selector[5:4]
+ *	18		0 (Reserved)
+ *	17:15		Control Number[5:3]
+ *	14		Next
+ *	13		MBQ
+ *	12:7		Entity[5:0]
+ *	6:3		Control Selector[3:0]
+ *	2:0		Control Number[2:0]
+ */
+
+#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
+						 (((fun) & 0x7) << 22) |	\
+						 (((ent) & 0x40) << 15) |	\
+						 (((ent) & 0x3f) << 7) |	\
+						 (((ctl) & 0x30) << 15) |	\
+						 (((ctl) & 0x0f) << 3) |	\
+						 (((ch) & 0x38) << 12) |	\
+						 ((ch) & 0x07))
+
+#define SDW_SDCA_MBQ_CTL(reg)			((reg) | BIT(13))
+#define SDW_SDCA_NEXT_CTL(reg)			((reg) | BIT(14))
+
 #endif /* __SDW_REGISTERS_H */
-- 
2.17.1

