Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA930227E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 08:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbhAYHVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 02:21:53 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:46463 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727222AbhAYHTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 02:19:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UMkwr09_1611559048;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMkwr09_1611559048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Jan 2021 15:17:32 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, kai.vehmanen@linux.intel.com,
        pierre-louis.bossart@linux.intel.com,
        guennadi.liakhovetski@linux.intel.com, kai.heng.feng@canonical.com,
        rppt@kernel.org, hui.wang@canonical.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] ALSA: hda: Assign boolean values to a bool variable
Date:   Mon, 25 Jan 2021 15:17:27 +0800
Message-Id: <1611559047-106928-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./sound/pci/hda/hda_intel.c:2309:3-23: WARNING: Assignment of
0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 sound/pci/hda/hda_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 5a50d3a..24e9762 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2304,7 +2304,7 @@ static int azx_probe_continue(struct azx *chip)
 
 		/* HSW/BDW controllers need this power */
 		if (CONTROLLER_IN_GPU(pci))
-			hda->need_i915_power = 1;
+			hda->need_i915_power = true;
 	}
 
 	/* Request display power well for the HDA controller or codec. For
-- 
1.8.3.1

