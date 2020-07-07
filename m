Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E1E217422
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 18:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgGGQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 12:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgGGQhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:37:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F54C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 09:37:01 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g75so43975534wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jDd/jOO1T/ruFMoY49CNrft5M2iX6NipaAY3YRHpai8=;
        b=xDVqMh7wZ28YQhZaKhWcGtAfi7MZZjMJbvcuxy1AOlzlxNBkmVAaCsGhsXyUXFRY7t
         G77qZSTKZuxbJQXI6ZyvfJIXpuBrFMfmQON4XpDAx3mzouzKGr54Y6D6F+wf8VR0Tz/j
         e+IkaxFhfYRBeeFcVafRGE6ORD2XJX5mMDz36Jxi7iPS03UCcCP/JgPHlzTQz9r63PAp
         K2eHhcTQcNZsD3r0WqRP7ZM+zOfadYIzvak16nXZnuLz7QV/LPYmtLmJDitirH9lvlrz
         XVuRAgNvArdtM4HqKPoj19mPpKGIM/NgC8bzdgMggQWQCwz4cPsQlZDNRdr0cS6tQT0N
         KaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jDd/jOO1T/ruFMoY49CNrft5M2iX6NipaAY3YRHpai8=;
        b=glD9W34PRxeUWPQPcpx4+NIgOicG5pgmdibPBScn/eQA9/bgv9DtuF7+gBR+ATXpp/
         ZAN+n9LY5AoDdKXj5COMH77Idw/cRBQzjeh0H2TFfLjSk49jvP3kyoOwvc4qpSZEa0xr
         A5L5qga+ula8ECNZzP2B86v8Pa+7iROda4czYTtU9e3RLMUF+QnT2HVykSu1y/CbCknF
         39kMTrF5x8HOu3XOJIQKbxCyEQmw9dzN/fexHwGptYG8SAW0uRpuzD8A3gk6PnFSVOS7
         vR7SX+uOoJcC6tQfah2KEoDRQ0AD6Owj9sHCHqv2ovzsOo+ZRdAfR9JeGENGkPfNPY8G
         AP2Q==
X-Gm-Message-State: AOAM530B3byBpMVAaIR6Mm2msNjnFC72ynqq9EKjExjefUycEqaFk6Tt
        xqP73pYKrJCVR0gLMvgy2gW0+g==
X-Google-Smtp-Source: ABdhPJzfGMlbsCGk2jwZpmap5pDTN2+aTLt72kCfLypuTpmGaAsqgBzWzSeuhyB4XzW1LmwZTXZtVg==
X-Received: by 2002:a7b:cd90:: with SMTP id y16mr4971353wmj.20.1594139820088;
        Tue, 07 Jul 2020 09:37:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id p14sm1925874wrj.14.2020.07.07.09.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 09:36:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/11] ASoC: q6asm-dai: add next track metadata support
Date:   Tue,  7 Jul 2020 17:36:38 +0100
Message-Id: <20200707163641.17113-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to metadata required to do a gapless playback.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 8c214436a2c2..c0e1e84267bf 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -71,6 +71,8 @@ struct q6asm_dai_rtd {
 	uint32_t stream_id;
 	uint16_t session_id;
 	enum stream_state state;
+	uint32_t initial_samples_drop;
+	uint32_t trailing_samples_drop;
 };
 
 struct q6asm_dai_data {
@@ -868,6 +870,28 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static int q6asm_dai_compr_set_metadata(struct snd_compr_stream *stream,
+					struct snd_compr_metadata *metadata)
+{
+	struct snd_compr_runtime *runtime = stream->runtime;
+	struct q6asm_dai_rtd *prtd = runtime->private_data;
+	int ret = 0;
+
+	switch (metadata->key) {
+	case SNDRV_COMPRESS_ENCODER_PADDING:
+		prtd->trailing_samples_drop = metadata->value[0];
+		break;
+	case SNDRV_COMPRESS_ENCODER_DELAY:
+		prtd->initial_samples_drop = metadata->value[0];
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
 static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 				   struct snd_compr_stream *stream, int cmd)
 {
@@ -984,6 +1008,7 @@ static struct snd_compress_ops q6asm_dai_compress_ops = {
 	.open		= q6asm_dai_compr_open,
 	.free		= q6asm_dai_compr_free,
 	.set_params	= q6asm_dai_compr_set_params,
+	.set_metadata	= q6asm_dai_compr_set_metadata,
 	.pointer	= q6asm_dai_compr_pointer,
 	.trigger	= q6asm_dai_compr_trigger,
 	.get_caps	= q6asm_dai_compr_get_caps,
-- 
2.21.0

