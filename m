Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE372FA143
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392119AbhARNVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:21:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49355 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404380AbhARNLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:11:22 -0500
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1UHy-0005VN-Be; Mon, 18 Jan 2021 13:09:47 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Harsha Priya <harshapriya.n@intel.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda: Balance runtime/system PM if direct-complete is disabled
Date:   Mon, 18 Jan 2021 21:09:36 +0800
Message-Id: <20210118130937.164650-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HDA controller can't be runtime-suspended after commit 215a22ed31a1
("ALSA: hda: Refactor codjc PM to use direct-complete optimization"),
which enables direct-complete for HDA codec.

The HDA codec driver didn't expect direct-complete will be disabled
after it returns a positive value from prepare() callback. However,
there are some places that PM core can disable direct-complete. For
instance, system hibernation or when codec has subordinates like LEDs.

So if a device is prepared for direct-complete but PM core still calls
codec's suspend or freeze callback, resume the device to keep PM
operations balanced.

Reported-by: Kenneth R. Crudup <kenny@panix.com>
Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_codec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 687216e74526..0afbced979df 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2997,6 +2997,9 @@ static void hda_codec_pm_complete(struct device *dev)
 
 static int hda_codec_pm_suspend(struct device *dev)
 {
+	if (pm_runtime_status_suspended(dev))
+		pm_runtime_resume(dev);
+
 	dev->power.power_state = PMSG_SUSPEND;
 	return hda_codec_suspend(dev);
 }
@@ -3009,6 +3012,9 @@ static int hda_codec_pm_resume(struct device *dev)
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
+	if (pm_runtime_status_suspended(dev))
+		pm_runtime_resume(dev);
+
 	dev->power.power_state = PMSG_FREEZE;
 	return hda_codec_suspend(dev);
 }
-- 
2.29.2

