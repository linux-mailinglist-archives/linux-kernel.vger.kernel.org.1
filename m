Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C009A19EEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 02:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgDFAhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 20:37:13 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37708 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgDFAhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 20:37:12 -0400
Received: by mail-pj1-f67.google.com with SMTP id k3so5715814pjj.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 17:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvYWLTBBEPzNhiod3cjeYc3OHqWvfXvPsRBTDrGfXnA=;
        b=PzqH2n6vYOaIRonvp9bghIFwf8QZOks+MnMgNadoVasEX189l4pmeNOm01fUvitnmX
         UnGU3frsDXMj/vr36zOlliSHbp1aPQ3UqSVlmvHd1mHsQw5Ps6zw4z3MDoj0sn2VGvuL
         N+hl42N4XnjOhmXpip+/j4o+JMpUdKDa+/0IXLXmj25gCCf1fwwcd39e0Qhu4psZrHFm
         3fppTGeOMtRIqHag9zGCHfbnyBB6Qg5FtibK4aACphe8cUOsFeq3E868uw/fEQ04ZzFL
         TbumhNaGSHLVcS1eziz0x4D7ilidZQHVBVaIQAA4/uglzZPWPHt5SZCltQGYHOnNxVoO
         EP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvYWLTBBEPzNhiod3cjeYc3OHqWvfXvPsRBTDrGfXnA=;
        b=BSa03xBrF3LvM4jwvYzKiyLk5PF8PtSKUr68Q+v1aUe10yzYpXpsPZu0ONnsaCzmkd
         e0gsXA5eYiMDwyOHgJVyleGJLDfzWCcRcr6DsejH9rOaUVpgRLIB1NBSpiDvrI+D+pGQ
         m+eKgAL8d2jjCUixSlB+yk1jdstyMZA0MzD6QC/bb3uSJJUsjusHAE3jxSIOcJtdzg6B
         451xpI0pqx+qnlnunr4RBKHOOnre32z9S6ZXMCMtJPTDbNLc7ukZnEpnR3wzL1ZiN/Pj
         17Ri5yw91dGPl/xuxqfPUMuu+9i2aNkqBLN7KcPJyDQCNYybuZIR85+xkbHk4eC9RCfD
         jelw==
X-Gm-Message-State: AGi0Pua1e8L2jGquLxpKmuoMkqGdMxAM4Mw17T0Gi9R1FmNSyXl+YPwQ
        XVetbsE/BImm6HK/zURy15yT/g==
X-Google-Smtp-Source: APiQypKZjQq4Rihame6g7Iyop+OqSZx5pqYbbK3jnpuQoiVNHhgj/jMLG2KrDy1T/fcXbrcqV7pKag==
X-Received: by 2002:a17:90a:ad87:: with SMTP id s7mr23267930pjq.52.1586133431315;
        Sun, 05 Apr 2020 17:37:11 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r59sm11048920pjb.45.2020.04.05.17.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2020 17:37:10 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: [PATCH] ASoC: qcom: common: Silence EPROBE_DEFER messages
Date:   Sun,  5 Apr 2020 17:36:56 -0700
Message-Id: <20200406003656.2383978-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm sound card typically depends on several other drivers,
resulting in plenty of noise in the kernel log due to probe deferral.
Silence these errors.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 6c20bdd850f3..cb266d7ec03e 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -80,7 +80,8 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 		ret = snd_soc_of_get_dai_name(cpu, &link->cpus->dai_name);
 		if (ret) {
-			dev_err(card->dev, "%s: error getting cpu dai name\n", link->name);
+			if (ret != -EPROBE_DEFER)
+				dev_err(card->dev, "%s: error getting cpu dai name", link->name);
 			goto err;
 		}
 
@@ -96,7 +97,8 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 			ret = snd_soc_of_get_dai_link_codecs(dev, codec, link);
 			if (ret < 0) {
-				dev_err(card->dev, "%s: codec dai not found\n", link->name);
+				if (ret != -EPROBE_DEFER)
+					dev_err(card->dev, "%s: codec dai not found\n", link->name);
 				goto err;
 			}
 			link->no_pcm = 1;
-- 
2.24.0

