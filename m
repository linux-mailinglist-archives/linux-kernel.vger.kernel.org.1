Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12478221B13
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 05:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGPD40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 23:56:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50650 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgGPD4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:56:25 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 21C3B200393;
        Thu, 16 Jul 2020 05:56:24 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B7936200385;
        Thu, 16 Jul 2020 05:56:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0FD55402BF;
        Thu, 16 Jul 2020 11:56:13 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        ranjani.sridharan@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: soc-component: Add missed return for snd_soc_pcm_component_mmap
Date:   Thu, 16 Jul 2020 11:52:43 +0800
Message-Id: <1594871563-30088-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed return for snd_soc_pcm_component_mmap, otherwise it always
return -EINVAL.

Fixes: e2329eeba45f ("ASoC: soc-component: add soc_component_err()")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/soc-component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index af9909c5492f..cde7b9c609bb 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -705,7 +705,7 @@ int snd_soc_pcm_component_mmap(struct snd_pcm_substream *substream,
 	/* FIXME. it returns 1st mmap now */
 	for_each_rtd_components(rtd, i, component)
 		if (component->driver->mmap)
-			soc_component_ret(
+			return soc_component_ret(
 				component,
 				component->driver->mmap(component,
 							substream, vma));
-- 
2.27.0

