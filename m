Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482992948FE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 09:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501928AbgJUHiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 03:38:02 -0400
Received: from mga02.intel.com ([134.134.136.20]:35030 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2501920AbgJUHiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 03:38:02 -0400
IronPort-SDR: DH0DtN9xbt3Gt1kBz8dbgqkFrpiKfL6aWHPJCNZt9iDfRmEt+wilMxUIIvHbugnfAyc2RCoy9v
 x4ClL68pcBXA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="154279337"
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="154279337"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 00:37:58 -0700
IronPort-SDR: 08o/ogkN8JaVAoo7XISqQiD8L4Uyt8Gif7lA1S3DPv610Flkkzv5obdRQg175n2LF13+cjRu8D
 EFq4dhovEyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,400,1596524400"; 
   d="scan'208";a="348206927"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga004.fm.intel.com with ESMTP; 21 Oct 2020 00:37:53 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Dharageswari R <dharageswari.r@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        linux-kernel@vger.kernel.org, Brent Lu <brent.lu@intel.com>
Subject: [PATCH] ASoC: Intel: sof_rt5682: update quirk for cml boards
Date:   Wed, 21 Oct 2020 15:26:46 +0800
Message-Id: <20201021072646.7980-1-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default quirk data of sof_rt5682 is for tgl platform. For cml
platforms to reuse this driver, the flag SOF_RT5682_MCLK_24MHZ is
necessary to setup codec asrc correctly.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index ddbb9fe7cc06..fa2c226a444a 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -768,6 +768,11 @@ static int sof_audio_probe(struct platform_device *pdev)
 		/* default number of HDMI DAI's */
 		if (!hdmi_num)
 			hdmi_num = 3;
+
+		if (soc_intel_is_cml()) {
+			/* default quirk for sof_rt5682 is for tgl platform */
+			sof_rt5682_quirk |= SOF_RT5682_MCLK_24MHZ;
+		}
 	}
 
 	/* need to get main clock from pmc */
-- 
2.17.1

