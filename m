Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1692B2F72CE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAOGSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:18:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:21420 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbhAOGSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:18:39 -0500
IronPort-SDR: SgEYMqQaBv/zqsXkrsVStuDnWRuKo3bXgL83KxzSQBfCyu2JmqC4v8FcLS1PrFc4U9GnxjTbcd
 lo+1KkQoQ+Yw==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="263296414"
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="263296414"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:52 -0800
IronPort-SDR: 0YFkTGPHWc0u2EqSh/t/3eWphL2MJQYu4ZjLTZ5HY1OuZ03DuNIetorT2HKaWM5rUqvHDij89A
 halSoNGljpmQ==
X-IronPort-AV: E=Sophos;i="5.79,348,1602572400"; 
   d="scan'208";a="382551872"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:16:48 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH 1/2] ASoC: codecs: soundwire: increase resume timeout
Date:   Fri, 15 Jan 2021 14:16:50 +0800
Message-Id: <20210115061651.9740-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
References: <20210115061651.9740-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

The resume operation relies on multiple transactions to synchronize
the regmap state, make sure the timeout is one order of magnitude
larger than an individual transaction, so that timeouts of failed
transactions are detected first.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/codecs/max98373-sdw.c | 4 +++-
 sound/soc/codecs/rt1308-sdw.c   | 2 +-
 sound/soc/codecs/rt5682.h       | 2 +-
 sound/soc/codecs/rt700-sdw.c    | 2 +-
 sound/soc/codecs/rt711-sdw.c    | 2 +-
 sound/soc/codecs/rt715-sdw.c    | 2 +-
 6 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index ec2e79c57357..ad2d5d6a2fe4 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -251,6 +251,8 @@ static __maybe_unused int max98373_suspend(struct device *dev)
 	return 0;
 }
 
+#define MAX98373_PROBE_TIMEOUT 5000
+
 static __maybe_unused int max98373_resume(struct device *dev)
 {
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
@@ -264,7 +266,7 @@ static __maybe_unused int max98373_resume(struct device *dev)
 		goto regmap_sync;
 
 	time = wait_for_completion_timeout(&slave->initialization_complete,
-					   msecs_to_jiffies(2000));
+					   msecs_to_jiffies(MAX98373_PROBE_TIMEOUT));
 	if (!time) {
 		dev_err(dev, "Initialization not complete, timed out\n");
 		return -ETIMEDOUT;
diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index ec5564f780e8..afd2c3b687cc 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -701,7 +701,7 @@ static int __maybe_unused rt1308_dev_suspend(struct device *dev)
 	return 0;
 }
 
-#define RT1308_PROBE_TIMEOUT 2000
+#define RT1308_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt1308_dev_resume(struct device *dev)
 {
diff --git a/sound/soc/codecs/rt5682.h b/sound/soc/codecs/rt5682.h
index 99b85cfe6248..1f9c51a5b9bf 100644
--- a/sound/soc/codecs/rt5682.h
+++ b/sound/soc/codecs/rt5682.h
@@ -1356,7 +1356,7 @@
 #define RT5682_SAR_SOUR_TYPE			(0x0)
 
 /* soundwire timeout */
-#define RT5682_PROBE_TIMEOUT			2000
+#define RT5682_PROBE_TIMEOUT			5000
 
 
 #define RT5682_STEREO_RATES SNDRV_PCM_RATE_8000_192000
diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index fb77e77a4ebd..ce9255b881d4 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -490,7 +490,7 @@ static int __maybe_unused rt700_dev_suspend(struct device *dev)
 	return 0;
 }
 
-#define RT700_PROBE_TIMEOUT 2000
+#define RT700_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt700_dev_resume(struct device *dev)
 {
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index fc7df79c3b91..756c0ada3b31 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -493,7 +493,7 @@ static int __maybe_unused rt711_dev_suspend(struct device *dev)
 	return 0;
 }
 
-#define RT711_PROBE_TIMEOUT 2000
+#define RT711_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt711_dev_resume(struct device *dev)
 {
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 8f0aa1e8a273..71dd3b97a459 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -533,7 +533,7 @@ static int __maybe_unused rt715_dev_suspend(struct device *dev)
 	return 0;
 }
 
-#define RT715_PROBE_TIMEOUT 2000
+#define RT715_PROBE_TIMEOUT 5000
 
 static int __maybe_unused rt715_dev_resume(struct device *dev)
 {
-- 
2.17.1

