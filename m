Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9342B26DD35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 15:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgIQNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbgIQNxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 09:53:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA69C061356
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:50 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so2024560wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxgb9FHlpgAG/4f91+kqu5s5in2zgBwaBKiJLhO7DC0=;
        b=Yll3zR5ILnsdHgBuLpxEaq8HGdrGieIMVPNpUQjltc479vZEr00c7n8hRGa8TmEVlE
         uxT6f1jOob9GifA6NQYWfPfMo8tLrMDoXSLsJmIqAl6XVmzAEdEEd6WIiGf/vDPYjrcH
         oX0TrtfbsqdQLzZog0kpqAnjglSFITvil8v88/DkXR5+WMWiWT4hExvvclDZ1v6V+nr2
         iQH8I/uMXvEBM+cf93OdFu9DTGO3Tb7hqgq1NQkIYDBP5YjRqzeA/56MQibltigWF4SB
         q/y3AxXbrmbPucE+HtkaR2jUaO2Q+LLDOOHD16/aK/NhK/ASWUI7jqAj2S10gcr2UEPG
         K+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxgb9FHlpgAG/4f91+kqu5s5in2zgBwaBKiJLhO7DC0=;
        b=tNcLxR46nGcqVcJkpAm4a4TjH10WM+t7pheUEczTo0rvASGwm0oxx+xW8r3sJgH0lr
         aJn38FVoAt6VhCwoZGCR3UmcXkXJXgYhoROLP1aOTE34nSah8SgTCv4ly0aUqgfp6Bje
         +d/OFWu/GpiMBG9YJY7FluDiNuuvEF9rr/mw2jacz7IkevILgfkFlW1A+QwgXgY3x7OE
         IJFkiHqawbjLG4qeWsBj/rqfebNtqSVyoJzIUl9L7IoLaeMBPTo2QOPcOc94Cs8MaO9G
         leXD+F9eXwd+ix+bR0yDWEBJe4/L5mZSz3v67jqQMo/M6xW4UeHaJehE79rbB/MdAPv3
         1frg==
X-Gm-Message-State: AOAM531ikOmUTbhFBQZoucgpPJ8PKHSMMX81DPxnqpa9JODb0w/JtazP
        YJq4nw9RuP3ep5I8enEOQBA3SQ==
X-Google-Smtp-Source: ABdhPJw47VifuJX0CXxxs9zASR8IPw+DzxErc9uKwe/ZQ2xmx5eIxVarEg5UXnGy0ZpsxkhDzEzo/A==
X-Received: by 2002:a1c:40c6:: with SMTP id n189mr10020037wma.48.1600350289097;
        Thu, 17 Sep 2020 06:44:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id q15sm36892406wrr.8.2020.09.17.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 06:44:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chih-En Hsu <chih-en.hsu@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] nvmem: mtk-efuse: Remove EFUSE register write support
Date:   Thu, 17 Sep 2020 14:44:34 +0100
Message-Id: <20200917134437.16637-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
References: <20200917134437.16637-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chih-En Hsu <chih-en.hsu@mediatek.com>

This patch is to remove function "mtk_reg_write" since
Mediatek EFUSE hardware only supports read functionality
for NVMEM consumers.

Fixes: ba360fd040e3 ("nvmem: mtk-efuse: remove nvmem regmap dependency")
Signed-off-by: Chih-En Hsu <chih-en.hsu@mediatek.com>
Acked-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/mtk-efuse.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 856d9c3fc38e..6a537d959f14 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -28,19 +28,6 @@ static int mtk_reg_read(void *context,
 	return 0;
 }
 
-static int mtk_reg_write(void *context,
-			 unsigned int reg, void *_val, size_t bytes)
-{
-	struct mtk_efuse_priv *priv = context;
-	u32 *val = _val;
-	int i = 0, words = bytes / 4;
-
-	while (words--)
-		writel(*val++, priv->base + reg + (i++ * 4));
-
-	return 0;
-}
-
 static int mtk_efuse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -61,7 +48,6 @@ static int mtk_efuse_probe(struct platform_device *pdev)
 	econfig.stride = 4;
 	econfig.word_size = 4;
 	econfig.reg_read = mtk_reg_read;
-	econfig.reg_write = mtk_reg_write;
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-- 
2.21.0

