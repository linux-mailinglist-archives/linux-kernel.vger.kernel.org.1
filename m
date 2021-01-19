Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B232FBB3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390624AbhASPcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:32:10 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391398AbhASPW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:22:58 -0500
Received: from 1-171-232-235.dynamic-ip.hinet.net ([1.171.232.235] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1l1spS-0000wH-K5; Tue, 19 Jan 2021 15:21:59 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Harsha Priya <harshapriya.n@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ALSA: hda: Balance runtime/system PM if direct-complete is disabled
Date:   Tue, 19 Jan 2021 23:21:43 +0800
Message-Id: <20210119152145.346558-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After hibernation, HDA controller can't be runtime-suspended after
commit 215a22ed31a1 ("ALSA: hda: Refactor codjc PM to use
direct-complete optimization"), which enables direct-complete for HDA
codec.

The HDA codec driver didn't expect direct-complete will be disabled
after it returns a positive value from prepare() callback. However,
there are some places that PM core can disable direct-complete. For
instance, system hibernation or when codec has subordinates like LEDs.

So if the codec is prepared for direct-complete but PM core still calls
codec's suspend or freeze callback, partially revert the commit and take
the original approach, which uses pm_runtime_force_*() helpers to
ensure PM refcount are balanced. Meanwhile, still keep prepare() and
complete() callbacks to enable direct-complete and request a resume for
jack detection, respectively.

Reported-by: Kenneth R. Crudup <kenny@panix.com>
Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Use pm_runtime_force_*() helpers to avoid suspend/resume ping pong.

 sound/pci/hda/hda_codec.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)


diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 687216e74526..eec1775dfffe 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2934,7 +2934,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	snd_hdac_leave_pm(&codec->core);
 }
 
-static int hda_codec_suspend(struct device *dev)
+static int hda_codec_runtime_suspend(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int state;
@@ -2953,7 +2953,7 @@ static int hda_codec_suspend(struct device *dev)
 	return 0;
 }
 
-static int hda_codec_resume(struct device *dev)
+static int hda_codec_runtime_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
@@ -2968,16 +2968,6 @@ static int hda_codec_resume(struct device *dev)
 	return 0;
 }
 
-static int hda_codec_runtime_suspend(struct device *dev)
-{
-	return hda_codec_suspend(dev);
-}
-
-static int hda_codec_runtime_resume(struct device *dev)
-{
-	return hda_codec_resume(dev);
-}
-
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
@@ -2998,31 +2988,31 @@ static void hda_codec_pm_complete(struct device *dev)
 static int hda_codec_pm_suspend(struct device *dev)
 {
 	dev->power.power_state = PMSG_SUSPEND;
-	return hda_codec_suspend(dev);
+	return pm_runtime_force_suspend(dev);
 }
 
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return hda_codec_resume(dev);
+	return pm_runtime_force_resume(dev);
 }
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
 	dev->power.power_state = PMSG_FREEZE;
-	return hda_codec_suspend(dev);
+	return pm_runtime_force_suspend(dev);
 }
 
 static int hda_codec_pm_thaw(struct device *dev)
 {
 	dev->power.power_state = PMSG_THAW;
-	return hda_codec_resume(dev);
+	return pm_runtime_force_resume(dev);
 }
 
 static int hda_codec_pm_restore(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESTORE;
-	return hda_codec_resume(dev);
+	return pm_runtime_force_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 
-- 
2.29.2

