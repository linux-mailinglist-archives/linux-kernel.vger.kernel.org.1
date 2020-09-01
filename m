Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA7925A350
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 04:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgIBC4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 22:56:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:49594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgIBC4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:56:35 -0400
IronPort-SDR: xvN2nAGEwO1/edg4nmed/KbM8GHievcZtux09SwtcDBRMgYAG+IFEd4cKAKYJxoZLsyUwQCP+3
 WcDPp5Ecg3CA==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221528371"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="221528371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:35 -0700
IronPort-SDR: CHgh3Ia8+8KlG5hhGZ2zo+ve5b+pEwoy+5UJh1ZMl6iL+pcW11BqAWMmqLlXe+ArA8gc2GITAa
 gZfFRplep06w==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477457273"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:31 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 3/7] soundwire: intel: fix NULL/ERR_PTR confusion
Date:   Tue,  1 Sep 2020 23:02:36 +0800
Message-Id: <20200901150240.19288-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

snd_soc_dai_get_sdw_stream() can only return the pointer to stream or
an ERR_PTR value, NULL is not a possible value.

Fixes: 09553140c8d7b ('soundwire: intel: implement get_sdw_stream() operations')
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index ebca8ced59ec..bbfb86ffa653 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1106,7 +1106,7 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 		dma = dai->capture_dma_data;
 
 	if (!dma)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	return dma->stream;
 }
-- 
2.17.1

