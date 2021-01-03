Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9AF2E8C5D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 14:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhACNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 08:53:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbhACNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 08:53:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A2A52080D;
        Sun,  3 Jan 2021 13:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609681983;
        bh=V7rDKYCFcuZSgAl1YWdvMaci7rDCqi0C/xM+NOOsOs8=;
        h=From:To:Cc:Subject:Date:From;
        b=VVuw7uHhdIvgtoItbkQWTUChPwiOgzAgG4fHHoRtyAE+15/dCHKFuHWLe0roznUJn
         s5d0sSWRxv043pWfzTBDCH2VZU02AM1zSLkvuWNPRv+TiuNNay3FsN7IqPlwKY0cqW
         /ADlrVqTh/zmPTogXVEP8D85CmfUVMd6Yc7bMceOdaIU9OK7x1c0eMIDlGBWJdbRA3
         /uH/gC+mvPjhzFLoLxKIkdDLD545adVdgTH1EPbM8ug5YslUejWpJ8ycahCjMeDvrY
         Bvq+2s2DWJBprRJi43FyiObZBqd1J2n04cTu5FXmB4+7mZCZIw557GQTvcETS2eEJO
         LceL3fEdBEszA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        sound-open-firmware@alsa-project.org
Subject: [PATCH] ALSA: hda: fix SND_INTEL_DSP_CONFIG dependency
Date:   Sun,  3 Jan 2021 14:52:32 +0100
Message-Id: <20210103135257.3611821-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The sof-pci-dev driver fails to link when built into the kernel
and CONFIG_SND_INTEL_DSP_CONFIG is set to =m:

arm-linux-gnueabi-ld: sound/soc/sof/sof-pci-dev.o: in function `sof_pci_probe':
sof-pci-dev.c:(.text+0x1c): undefined reference to `snd_intel_dsp_driver_probe'

All other drivers using this interface already use a 'select
SND_INTEL_DSP_CONFIG' statement to force the it to be present, so it
seems reasonable to do the same here.

The stub implementation in the header makes the problem harder to find,
as it avoids the link error when SND_INTEL_DSP_CONFIG is completely
disabled, without any obvious upsides. Remove these stubs to make it
clearer that the driver is in fact needed here.

Fixes: 82d9d54a6c0e ("ALSA: hda: add Intel DSP configuration / probe code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/sound/intel-dsp-config.h | 17 -----------------
 sound/soc/sof/Kconfig            |  2 ++
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/include/sound/intel-dsp-config.h b/include/sound/intel-dsp-config.h
index d4609077c258..94667e870029 100644
--- a/include/sound/intel-dsp-config.h
+++ b/include/sound/intel-dsp-config.h
@@ -18,24 +18,7 @@ enum {
 	SND_INTEL_DSP_DRIVER_LAST = SND_INTEL_DSP_DRIVER_SOF
 };
 
-#if IS_ENABLED(CONFIG_SND_INTEL_DSP_CONFIG)
-
 int snd_intel_dsp_driver_probe(struct pci_dev *pci);
 int snd_intel_acpi_dsp_driver_probe(struct device *dev, const u8 acpi_hid[ACPI_ID_LEN]);
 
-#else
-
-static inline int snd_intel_dsp_driver_probe(struct pci_dev *pci)
-{
-	return SND_INTEL_DSP_DRIVER_ANY;
-}
-
-static inline
-int snd_intel_acpi_dsp_driver_probe(struct device *dev, const u8 acpi_hid[ACPI_ID_LEN])
-{
-	return SND_INTEL_DSP_DRIVER_ANY;
-}
-
-#endif
-
 #endif
diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 031dad5fc4c7..051fd3d27047 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -12,6 +12,7 @@ if SND_SOC_SOF_TOPLEVEL
 config SND_SOC_SOF_PCI
 	tristate "SOF PCI enumeration support"
 	depends on PCI
+	select SND_INTEL_DSP_CONFIG
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
 	help
@@ -23,6 +24,7 @@ config SND_SOC_SOF_PCI
 config SND_SOC_SOF_ACPI
 	tristate "SOF ACPI enumeration support"
 	depends on ACPI || COMPILE_TEST
+	select SND_INTEL_DSP_CONFIG
 	select SND_SOC_SOF
 	select SND_SOC_ACPI if ACPI
 	select IOSF_MBI if X86 && PCI
-- 
2.29.2

