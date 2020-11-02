Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEDD2A2DB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgKBPLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:11:30 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7784 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKBPLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:11:25 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa021a80000>; Mon, 02 Nov 2020 07:11:36 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 2 Nov
 2020 15:11:24 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 2 Nov 2020 15:11:20 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <kuninori.morimoto.gx@renesas.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v5 2/7] ASoC: soc-pcm: Get all BEs along DAPM path
Date:   Mon, 2 Nov 2020 20:40:09 +0530
Message-ID: <1604329814-24779-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604329814-24779-1-git-send-email-spujar@nvidia.com>
References: <1604329814-24779-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604329896; bh=WDJ0zXsCLUxYP51jq6c1bq2lG2EK0zhHddSgQBLIuq4=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Type;
        b=Kg+eXaMEZcaEJRhozsDQ15XRSdU5gJObWyMWRo9HKpAbrsooHPvJiGOTRWtGY+vWL
         +gr62Bi51U6LbTjzdLQ1L5Z1udqD+Ps/rHGPoLfBMvXCwPvAg34CxP6nNHMftbtcTR
         jsqbtKGRUWJz+MmKrqdXOky0fLnIAOU8b0cdn2D44Ckwl6H6s14SV4nO5X/Da/ahVI
         bmhFChPes1elZKryo2Wl86LBmJ17/Uz7pZ4PnZhnetzGsJGzhiHZca+jYuZSUhx1UT
         iFQgGUHnx/mNK5/4nBZ3lecagZK6S74ogSsxIL6tBLQ9JAb0s/Zw5p63i65155Z7wd
         vUMe5U/rExvgA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dpcm_end_walk_at_be() stops the graph walk when first BE is found for
the given FE component. In a component model we may want to connect
multiple DAIs from different components. A new flag is introduced in
'snd_soc_card', which when set allows DAI/component chaining. Later
PCM operations can be called for all these listed components for a
valid DAPM path.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 include/sound/soc.h | 1 +
 sound/soc/soc-pcm.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5ac578c..4a9958b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1084,6 +1084,7 @@ struct snd_soc_card {
 	unsigned int fully_routed:1;
 	unsigned int disable_route_checks:1;
 	unsigned int probed:1;
+	unsigned int component_chaining:1;
 
 	void *drvdata;
 };
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 17ff3a3..51d98ff5 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1259,7 +1259,8 @@ int dpcm_path_get(struct snd_soc_pcm_runtime *fe,
 
 	/* get number of valid DAI paths and their widgets */
 	paths = snd_soc_dapm_dai_get_connected_widgets(cpu_dai, stream, list,
-			dpcm_end_walk_at_be);
+			fe->card->component_chaining ?
+				NULL : dpcm_end_walk_at_be);
 
 	dev_dbg(fe->dev, "ASoC: found %d audio %s paths\n", paths,
 			stream ? "capture" : "playback");
-- 
2.7.4

