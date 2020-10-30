Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D16E2A0C4C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJ3RRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:17:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:26899 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgJ3RRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:17:12 -0400
IronPort-SDR: QqZJas1bqZvooxbLn8gzHJcSN+40wNRhPbrvy5Lor/r9ZyqtQ5+TMXH9WEvq1YoGQTNslQ6a6D
 fxt96xhOME8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="147923449"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="147923449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 10:17:11 -0700
IronPort-SDR: 1kklI0b9O1wKMbbpvK/ZW2KDzAGwZBabH/P6SCpUgvKOB81gxahNsi0TinDJ1ft+YdwxAcZKWJ
 c3fhczMXsJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="469584718"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 10:17:08 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>,
        Fred Oh <fred.oh@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ASoC: intel: sof_rt5682: Add quirk for Dooly
Date:   Sat, 31 Oct 2020 01:05:59 +0800
Message-Id: <20201030170559.20370-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030170559.20370-1-brent.lu@intel.com>
References: <20201030170559.20370-1-brent.lu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This DMI product family string of this board is "Google_Hatch" so the
DMI quirk will take place. However, this board is using rt1015 speaker
amp instead of max98357a specified in the quirk. Therefore, we need an
new DMI quirk for this board.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 7701957e0eb7..e7d9a82ca70d 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -100,6 +100,24 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(1)),
 	},
+	{
+		/*
+		 * Dooly is hatch family but using rt1015 amp so it
+		 * requires a quirk before "Google_Hatch".
+		 */
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dooly"),
+		},
+		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT1015_SPEAKER_AMP_PRESENT |
+					SOF_RT1015_SPEAKER_AMP_100FS |
+					SOF_RT5682_SSP_AMP(1)),
+	},
 	{
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
-- 
2.17.1

