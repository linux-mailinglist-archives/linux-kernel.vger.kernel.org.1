Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65159221BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 07:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGPFLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 01:11:01 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42134 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgGPFK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:10:59 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4886A1A0522;
        Thu, 16 Jul 2020 07:10:58 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DE3FA1A04F1;
        Thu, 16 Jul 2020 07:10:53 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3E86E402BF;
        Thu, 16 Jul 2020 13:10:48 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: soc-component: Add missed return for calling soc_component_ret
Date:   Thu, 16 Jul 2020 13:07:08 +0800
Message-Id: <1594876028-1845-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed return for calling soc_component_ret, otherwise the return
value is wrong.

Fixes: e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
- add missed return in snd_soc_pcm_component_sync_stop and
- snd_soc_pcm_component_new

 sound/soc/soc-component.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index af9909c5492f..9565a0dd7cb6 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -647,7 +647,7 @@ int snd_soc_pcm_component_sync_stop(struct snd_pcm_substream *substream)
 			ret = component->driver->sync_stop(component,
 							   substream);
 			if (ret < 0)
-				soc_component_ret(component, ret);
+				return soc_component_ret(component, ret);
 		}
 	}
 
@@ -705,7 +705,7 @@ int snd_soc_pcm_component_mmap(struct snd_pcm_substream *substream,
 	/* FIXME. it returns 1st mmap now */
 	for_each_rtd_components(rtd, i, component)
 		if (component->driver->mmap)
-			soc_component_ret(
+			return soc_component_ret(
 				component,
 				component->driver->mmap(component,
 							substream, vma));
@@ -723,7 +723,7 @@ int snd_soc_pcm_component_new(struct snd_soc_pcm_runtime *rtd)
 		if (component->driver->pcm_construct) {
 			ret = component->driver->pcm_construct(component, rtd);
 			if (ret < 0)
-				soc_component_ret(component, ret);
+				return soc_component_ret(component, ret);
 		}
 	}
 
-- 
2.27.0

