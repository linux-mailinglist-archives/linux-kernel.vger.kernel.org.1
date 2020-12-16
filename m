Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBAE72DC081
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 13:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgLPMsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 07:48:23 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45041 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLPMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 07:48:23 -0500
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kpWDN-0008Rc-4O; Wed, 16 Dec 2020 12:47:34 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mike Rapoport <rppt@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] ALSA: hda: Continue to probe when codec probe fails
Date:   Wed, 16 Dec 2020 20:47:24 +0800
Message-Id: <20201216124726.2842197-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
References: <20201214060621.1102931-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 9479e75fca37 ("ALSA: hda: Keep the controller
initialization even if no codecs found"), when codec probe fails, it
doesn't enable runtime suspend, and can prevent graphics card from
getting powered down:
[    4.280991] snd_hda_intel 0000:01:00.1: no codecs initialized

$ cat /sys/bus/pci/devices/0000:01:00.1/power/runtime_status
active

So mark there's no codec and continue probing to let runtime PM to work.

BugLink: https://bugs.launchpad.net/bugs/1907212
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 6852668f1bcb..872a703dee43 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2328,7 +2328,7 @@ static int azx_probe_continue(struct azx *chip)
 	if (bus->codec_mask) {
 		err = azx_probe_codecs(chip, azx_max_codecs[chip->driver_type]);
 		if (err < 0)
-			goto out_free;
+			bus->codec_mask = 0;
 	}
 
 #ifdef CONFIG_SND_HDA_PATCH_LOADER
-- 
2.29.2

