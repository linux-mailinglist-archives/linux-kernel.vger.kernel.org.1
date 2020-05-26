Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBCF1B432C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgDVLY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:24:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42355 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgDVLY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:24:28 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jRDUH-0006HA-IO; Wed, 22 Apr 2020 11:24:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ensure all fields in header are zero'd before copying back to userspace
Date:   Wed, 22 Apr 2020 12:24:17 +0100
Message-Id: <20200422112417.208843-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Field header.tlv is uninitialized and being copied back to userspace
and hence leaking data from the stack to userspace.  Fix this by
ensuring the header structure is zero'd.

Fixes: c3078f539704 ("ASoC: SOF: Add Sound Open Firmware KControl support")
Addresses-Coverity: ("Uninitialized scalar variable")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sof/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index dfc412e2d956..97d5c1a4c1ff 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -362,7 +362,7 @@ int snd_sof_bytes_ext_get(struct snd_kcontrol *kcontrol,
 	struct snd_sof_control *scontrol = be->dobj.private;
 	struct snd_soc_component *scomp = scontrol->scomp;
 	struct sof_ipc_ctrl_data *cdata = scontrol->control_data;
-	struct snd_ctl_tlv header;
+	struct snd_ctl_tlv header = { };
 	struct snd_ctl_tlv __user *tlvd =
 		(struct snd_ctl_tlv __user *)binary_data;
 	int data_size;
-- 
2.25.1

