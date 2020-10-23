Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538BB296CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462098AbgJWKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:24:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59738 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462060AbgJWKYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:24:01 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVuEh-0006R7-5W; Fri, 23 Oct 2020 10:23:51 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] ALSA: hda: Stop mangling PCI MSI
Date:   Fri, 23 Oct 2020 18:23:36 +0800
Message-Id: <20201023102340.25494-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201023102340.25494-1-kai.heng.feng@canonical.com>
References: <20201023102340.25494-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code predates 2005, it should be unnecessary now as PCI core handles
MSI much better nowadays.

So stop PCI MSI mangling in suspend/resume callbacks.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 749b88090970..b4aa1dcf1aae 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1022,13 +1022,11 @@ static int azx_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
-	struct hdac_bus *bus;
 
 	if (!azx_is_pm_ready(card))
 		return 0;
 
 	chip = card->private_data;
-	bus = azx_bus(chip);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
 	/* An ugly workaround: direct call of __azx_runtime_suspend() and
 	 * __azx_runtime_resume() for old Intel platforms that suffer from
@@ -1038,14 +1036,6 @@ static int azx_suspend(struct device *dev)
 		__azx_runtime_suspend(chip);
 	else
 		pm_runtime_force_suspend(dev);
-	if (bus->irq >= 0) {
-		free_irq(bus->irq, chip);
-		bus->irq = -1;
-		chip->card->sync_irq = -1;
-	}
-
-	if (chip->msi)
-		pci_disable_msi(chip->pci);
 
 	trace_azx_suspend(chip);
 	return 0;
@@ -1060,11 +1050,6 @@ static int azx_resume(struct device *dev)
 		return 0;
 
 	chip = card->private_data;
-	if (chip->msi)
-		if (pci_enable_msi(chip->pci) < 0)
-			chip->msi = 0;
-	if (azx_acquire_irq(chip, 1) < 0)
-		return -EIO;
 
 	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
 		__azx_runtime_resume(chip, false);
-- 
2.17.1

