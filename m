Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8F2296CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462158AbgJWKYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 06:24:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59757 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S462151AbgJWKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 06:24:19 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kVuEc-0006Qf-2U; Fri, 23 Oct 2020 10:23:46 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Harsha Priya <harshapriya.n@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/4] ALSA: hda: Refactor codec PM to use direct-complete optimization
Date:   Fri, 23 Oct 2020 18:23:35 +0800
Message-Id: <20201023102340.25494-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon system resume, hda_codec_pm_resume() uses hda_codec_force_resume()
to resume the codec. However, pm_runtime_force_resume() won't really
resume the codec because of pm_runtime_need_not_resume() check.

Hence, hda_codec_force_resume() schedules a jackpoll work, which is to
really power up the codec.

Instead of doing that, we can use direct-complete to make the PM flow
more straightforward, and keep codec always suspended through system PM
flow if conditions are met.

On system suspend, PM core will decide what to do based on
hda_codec_pm_prepare():
- If codec is not runtime-suspended, PM core will suspend and resume the
device as normal.
- If codec is runtime-suspended, PM core will try to keep it suspended.
If it's still suspended after system resume, we use
hda_codec_pm_complete() to resume codec if it's needed.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_codec.c | 45 +++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index a356c21edb90..c2a510cc81bb 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2934,7 +2934,7 @@ static void hda_call_codec_resume(struct hda_codec *codec)
 	snd_hdac_leave_pm(&codec->core);
 }
 
-static int hda_codec_runtime_suspend(struct device *dev)
+static int hda_codec_suspend(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 	unsigned int state;
@@ -2953,7 +2953,7 @@ static int hda_codec_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int hda_codec_runtime_resume(struct device *dev)
+static int hda_codec_resume(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
 
@@ -2967,57 +2967,70 @@ static int hda_codec_runtime_resume(struct device *dev)
 	pm_runtime_mark_last_busy(dev);
 	return 0;
 }
+
+static int hda_codec_runtime_suspend(struct device *dev)
+{
+	return hda_codec_suspend(dev);
+}
+
+static int hda_codec_runtime_resume(struct device *dev)
+{
+	return hda_codec_resume(dev);
+}
+
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
-static int hda_codec_force_resume(struct device *dev)
+static int hda_codec_pm_prepare(struct device *dev)
+{
+	return pm_runtime_suspended(dev);
+}
+
+static void hda_codec_pm_complete(struct device *dev)
 {
 	struct hda_codec *codec = dev_to_hda_codec(dev);
-	int ret;
 
-	ret = pm_runtime_force_resume(dev);
-	/* schedule jackpoll work for jack detection update */
-	if (codec->jackpoll_interval ||
-	    (pm_runtime_suspended(dev) && hda_codec_need_resume(codec)))
-		schedule_delayed_work(&codec->jackpoll_work,
-				      codec->jackpoll_interval);
-	return ret;
+	if (pm_runtime_suspended(dev) &&
+	    (hda_codec_need_resume(codec) || codec->forced_resume))
+		pm_request_resume(dev);
 }
 
 static int hda_codec_pm_suspend(struct device *dev)
 {
 	dev->power.power_state = PMSG_SUSPEND;
-	return pm_runtime_force_suspend(dev);
+	return hda_codec_suspend(dev);
 }
 
 static int hda_codec_pm_resume(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESUME;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 
 static int hda_codec_pm_freeze(struct device *dev)
 {
 	dev->power.power_state = PMSG_FREEZE;
-	return pm_runtime_force_suspend(dev);
+	return hda_codec_suspend(dev);
 }
 
 static int hda_codec_pm_thaw(struct device *dev)
 {
 	dev->power.power_state = PMSG_THAW;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 
 static int hda_codec_pm_restore(struct device *dev)
 {
 	dev->power.power_state = PMSG_RESTORE;
-	return hda_codec_force_resume(dev);
+	return hda_codec_resume(dev);
 }
 #endif /* CONFIG_PM_SLEEP */
 
 /* referred in hda_bind.c */
 const struct dev_pm_ops hda_codec_driver_pm = {
 #ifdef CONFIG_PM_SLEEP
+	.prepare = hda_codec_pm_prepare,
+	.complete = hda_codec_pm_complete,
 	.suspend = hda_codec_pm_suspend,
 	.resume = hda_codec_pm_resume,
 	.freeze = hda_codec_pm_freeze,
-- 
2.17.1

