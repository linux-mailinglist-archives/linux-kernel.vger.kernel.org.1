Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F4F2D9336
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 07:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438636AbgLNGHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 01:07:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40633 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407140AbgLNGHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 01:07:24 -0500
Received: from 1-171-239-132.dynamic-ip.hinet.net ([1.171.239.132] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1koh07-0004hH-Ao; Mon, 14 Dec 2020 06:06:28 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda: Enable runtime PM when codec probe fails
Date:   Mon, 14 Dec 2020 14:06:20 +0800
Message-Id: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When codec probe fails, it doesn't enable runtime suspend, and can
prevent graphics card from getting powered down:
[    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized

$ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
active

So enable runtime PM when codec probe fails, to let graphics card be
able to runtime suspend again.

Merge azx_probe_continue() into azx_probe() and just let probe fail for
this case could be a better approach. However that's a much bigger task
so let's settle with a quirk workaround.

BugLink: https://bugs.launchpad.net/bugs/1907212
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6852668f1bcb..3fd920069268 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2328,7 +2328,7 @@ static int azx_probe_continue(struct azx *chip)
 	if (bus->codec_mask) {
 		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
 		if (err < 0)
-			goto out_free;
+			goto out_enable_rpm;
 	}
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
@@ -2360,6 +2360,7 @@ static int azx_probe_continue(struct azx *chip)
 
 	set_default_power_save(chip);
 
+out_enable_rpm:
 	if (azx_has_pm_runtime(chip)) {
 		pm_runtime_use_autosuspend(&pci->dev);
 		pm_runtime_allow(&pci->dev);
-- 
2.29.2

