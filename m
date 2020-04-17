Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B591AD947
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 10:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgDQI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 04:57:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2347 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730040AbgDQI52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 04:57:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EF823D445A7E116B46C7;
        Fri, 17 Apr 2020 16:57:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Apr 2020
 16:57:18 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <cezary.rojewski@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <liam.r.girdwood@linux.intel.com>, <yang.jie@linux.intel.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <hdegoede@redhat.com>, <tglx@linutronix.de>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] ASoC: Intel: atom: remove unused 'sst_mix_voip_controls'
Date:   Fri, 17 Apr 2020 17:23:44 +0800
Message-ID: <20200417092344.14301-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

sound/soc/intel/atom/sst-atom-controls.c:710:30: warning:
‘sst_mix_voip_controls’ defined but not used [-Wunused-const-variable=]
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
                              ^

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 69f3af4524ab..541f0059ba7a 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -707,7 +707,6 @@ SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_pcm2_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_sprot_l0_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l1_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_media_l2_controls);
-SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_voip_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec0_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_codec1_controls);
 SST_SBA_DECLARE_MIX_CONTROLS(sst_mix_modem_controls);
-- 
2.21.1

