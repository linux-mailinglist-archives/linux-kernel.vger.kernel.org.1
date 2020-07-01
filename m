Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED0A21128D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbgGASZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 14:25:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:61638 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732935AbgGASYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:24:51 -0400
IronPort-SDR: 0KKdH5Yz8aIOeteiZryWR2MlINFL2adZ8Pilej339AnEUUtVPBLYERlJ0lMe54s8pZ7pq87Ypr
 0tgKPelPa2nA==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="148218898"
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="148218898"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:51 -0700
IronPort-SDR: OstUsJRNU7wiBztQkVXB738t8mNNBDud0dRxSNU2mSlDo9sM+NlESkdgVxXDIT7QCmMOvMRs28
 fh9EyObt01qA==
X-IronPort-AV: E=Sophos;i="5.75,301,1589266800"; 
   d="scan'208";a="425679625"
Received: from srnatla-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.254.76.199])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 11:24:50 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/11] ASoC: codecs: tlv320aic26: fix kernel-doc warning
Date:   Wed,  1 Jul 2020 13:24:21 -0500
Message-Id: <20200701182422.81496-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
References: <20200701182422.81496-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 warning. Remove spurious /** since there isn't any kernel-doc
comment in this file.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/tlv320aic26.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 032b39735643..4569bbc08acb 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -131,7 +131,7 @@ static int aic26_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-/**
+/*
  * aic26_mute - Mute control to reduce noise when changing audio format
  */
 static int aic26_mute(struct snd_soc_dai *dai, int mute)
-- 
2.25.1

