Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD17F211292
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732986AbgGASZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 14:25:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:61638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732926AbgGASYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:49 -0400
IronPort-SDR: 9RuWfVzwd77vni6JxsVuJZOlGF/klLXCiTiQc4VFoAayBbCwLZjOv3LGIcKW5ueF5quOinZnC0
 sIYk+W+0xuEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148218891"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="148218891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:48 -0700
IronPort-SDR: w93MlZB3WzzjwSR0zJWhH0yf1a5S5FeqlaJI0DXEyVXkJ44VHug9r+lQTIURX1uVtCDObXKSzd
 yLD54xgtnAJg==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679614"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:48 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/11] ASoC: codecs: rt5659: add _maybe_unused as needed
Date:   Wed,  1 Jul 2020 13:24:19 -0500
Message-Id: <20200701182422.81496-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning by adding __maybe_unused. Maintainers for this file
may want to double-check if those definitions are necessary.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5659.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 541fc6f1089b..40a954e480a5 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1204,31 +1204,31 @@ static unsigned int rt5659_asrc_clk_map_values[] = {
 	0, 1, 2, 3, 5, 6,
 };
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-static SOC_VALUE_ENUM_SINGLE_DECL(
+static __maybe_unused SOC_VALUE_ENUM_SINGLE_DECL(
 	rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
 	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
 
-- 
2.25.1

