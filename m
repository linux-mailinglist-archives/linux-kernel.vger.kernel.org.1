Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6732D2169D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGGKRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgGGKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA32C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:16:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so41530991wrw.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
        b=qrsas+PZEhVKEED/gwuG+M3fvZFc9iTyVZ9kC/kfAQJtySYFhAXFVpKKKmyVPzJsef
         fCJFw/7CBzrR/D0H4Ibl8ook5vPEI7nkN6UMPeetQWBt4M+Kx0Tquh3FeHQKe+00wO+m
         GqDseXgUs910Lbr6v6S1qDkgnl8n1Y7UIIuytj30iKNt1AOZABZ9LymxXsaWj6zDFYGe
         XI8qHYoQ/wOSdxtGcESFe8ZYMktICg66e53gTSweXye36XFgFl6kw5awQcpN8EpYSN23
         8sMm+Tp30g9gUcdoX30JFTNJlS2oJp3wB6d8NA/Z4UGG+OpYufSxlq2WEns0mrZb6qvR
         vMcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HXwAK5e9O3NfsiXPR7kk8AeqU5Nw2ls4PmOWf/vu7lg=;
        b=fEFHC1QuTUzlshDqWv5B68txxxlwWXUKeVDzyhE6SxOzIwvdsI+ti6eakoqEfVuj8v
         bIrBafhNVHysjCYbqFv9/DYxEERrEWXa7HfweFDMW1HFnVsIVVt4z5XzupjdVlRuYOn4
         N3Vs6F6w99Wk3J2YouNd9w1B/iPlHRE30/m/sWU923LcLoDCPqn0vh/U8DNh4vlnd48j
         kztALsxuiSh+n658JOlVz2KGhlDQACIJNiZLyHwUB/+ibB0u11GwgJrN2o0uvXh7cTN5
         xtkmMIJErx4DTog61ZQfAb1dEsai8ZY0ct7c3ZP0UA50oMtkv/54wl2f5SO+p3LyMafa
         KvGA==
X-Gm-Message-State: AOAM533ODvUtL5uzm7ErXzOiqkrRVTNObQEfAal13368fF/be4odxn1v
        s9oxhUNX4osGbSGXgsxs2XYu4A==
X-Google-Smtp-Source: ABdhPJw+rbiTfjvaZjvfOEvXP2PwVD2bXCDT7mTpQWEQuNXSkRYtQLVPb8Dx6k7fktqcFGcvxY+9RA==
X-Received: by 2002:a5d:6802:: with SMTP id w2mr51092373wru.88.1594117018607;
        Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id z8sm469409wmg.39.2020.07.07.03.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 03:16:58 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Vladimir Barinov <vbarinov@embeddedalley.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/28] ASoC: fsl: fsl_spdif: Update 'struct fsl_spdif_priv's descriptions
Date:   Tue,  7 Jul 2020 11:16:22 +0100
Message-Id: <20200707101642.1747944-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two descriptions for 'soc' and 'regcache_srpc' were missing.  Add them.

Fixes the following W=1 kernel build warning(s):

 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'soc' not described in 'fsl_spdif_priv'
 sound/soc/fsl/fsl_spdif.c:125: warning: Function parameter or member 'regcache_srpc' not described in 'fsl_spdif_priv'

Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Barinov <vbarinov@embeddedalley.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/fsl/fsl_spdif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 7aa3bdec5b6b5..f0b2375a9246f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -83,6 +83,7 @@ struct spdif_mixer_control {
 /**
  * struct fsl_spdif_priv - Freescale SPDIF private data
  *
+ * @soc: SoC specific data
  * @fsl_spdif_control: SPDIF control data
  * @cpu_dai_drv: cpu dai driver
  * @pdev: platform device pointer
@@ -100,6 +101,7 @@ struct spdif_mixer_control {
  * @spbaclk: SPBA clock (optional, depending on SoC design)
  * @dma_params_tx: DMA parameters for transmit channel
  * @dma_params_rx: DMA parameters for receive channel
+ * @regcache_srpc: regcache for SRPC
  */
 struct fsl_spdif_priv {
 	const struct fsl_spdif_soc_data *soc;
@@ -120,7 +122,6 @@ struct fsl_spdif_priv {
 	struct clk *spbaclk;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-	/* regcache for SRPC */
 	u32 regcache_srpc;
 };
 
-- 
2.25.1

