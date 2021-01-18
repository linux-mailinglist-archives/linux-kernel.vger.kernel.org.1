Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D46D2F9B41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 09:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbhARI2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 03:28:45 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54061 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733226AbhARI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 03:28:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UM3Lpls_1610958471;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UM3Lpls_1610958471)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 18 Jan 2021 16:27:58 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     perex@perex.cz
Cc:     tiwai@suse.com, bo.liu@senarytech.com, pegro@friiks.de,
        gustavoars@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] sound/pci/hda: boolean values to a bool variable
Date:   Mon, 18 Jan 2021 16:27:49 +0800
Message-Id: <1610958469-65856-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./sound/pci/hda/patch_conexant.c:570:2-20: WARNING:
Assignment of 0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 sound/pci/hda/patch_conexant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index d49cc44..f2aa226 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -567,7 +567,7 @@ static void cxt_fixup_mute_led_eapd(struct hda_codec *codec,
 
 	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
 		spec->mute_led_eapd = 0x1b;
-		spec->dynamic_eapd = 1;
+		spec->dynamic_eapd = true;
 		snd_hda_gen_add_mute_led_cdev(codec, cx_auto_vmaster_mute_led);
 	}
 }
-- 
1.8.3.1

