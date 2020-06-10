Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECC41F520F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 12:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgFJKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 06:16:49 -0400
Received: from inva020.nxp.com ([92.121.34.13]:46754 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728158AbgFJKQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:16:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id F196C1A02CE;
        Wed, 10 Jun 2020 12:16:41 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 18DBF1A0447;
        Wed, 10 Jun 2020 12:16:37 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2409A40307;
        Wed, 10 Jun 2020 18:16:31 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 1/3] ASoC: soc-card: export snd_soc_lookup_component_nolocked
Date:   Wed, 10 Jun 2020 18:05:47 +0800
Message-Id: <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591783089.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591783089.git.shengjiu.wang@nxp.com>
References: <cover.1591783089.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591783089.git.shengjiu.wang@nxp.com>
References: <cover.1591783089.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_lookup_component_nolocked can be used for the DPCM case
that Front-End needs to get the unused platform component but
added by Back-End cpu dai driver.

If the component is gotten, then we can get the dma chan created
by Back-End component and reused it in Front-End.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/soc.h  | 2 ++
 sound/soc/soc-core.c | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 74868436ac79..565612a8d690 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -444,6 +444,8 @@ int devm_snd_soc_register_component(struct device *dev,
 			 const struct snd_soc_component_driver *component_driver,
 			 struct snd_soc_dai_driver *dai_drv, int num_dai);
 void snd_soc_unregister_component(struct device *dev);
+struct snd_soc_component *snd_soc_lookup_component_nolocked(struct device *dev,
+							    const char *driver_name);
 struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name);
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index b07eca2c6ccc..d4c73e86d058 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -310,7 +310,7 @@ struct snd_soc_component *snd_soc_rtdcom_lookup(struct snd_soc_pcm_runtime *rtd,
 }
 EXPORT_SYMBOL_GPL(snd_soc_rtdcom_lookup);
 
-static struct snd_soc_component
+struct snd_soc_component
 *snd_soc_lookup_component_nolocked(struct device *dev, const char *driver_name)
 {
 	struct snd_soc_component *component;
@@ -329,6 +329,7 @@ static struct snd_soc_component
 
 	return found_component;
 }
+EXPORT_SYMBOL_GPL(snd_soc_lookup_component_nolocked);
 
 struct snd_soc_component *snd_soc_lookup_component(struct device *dev,
 						   const char *driver_name)
-- 
2.21.0

