Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6FB2F7D89
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbhAOOCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732186AbhAOOCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:02:49 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE47C061794;
        Fri, 15 Jan 2021 06:02:08 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id p13so10522476ljg.2;
        Fri, 15 Jan 2021 06:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sAP+3CkhcyAzGSOOjeDge3bGII17aWYwDL7K0dtBg44=;
        b=esP6s1upDtlp2uQOrdq1lxKgaCueiDMX/Cduzlzb5LWZedBD0FYmJ7XmN/hYK+jOz5
         55GRMimGODVhKTncYqiCRi5rHvZ189Idn9KaCvVpKNeP6JdPaaA1RC5dOUGjiEfxQ57Y
         16AzaMSCuXU5lde4DqZ383S+jdeuLcJF2mJY3jYj4d0ZX3YAlbsooPwSSk5MV/my7pIX
         Ci0L8OfFpsEZDfC/tCkTUuAcXx43CghtQZ6JfZ49CLxfjDqnNurQSeVCv0ag1Z5nG0wx
         PP+Yn6jfPo+8jlCAZ4DDqtNFKjGRN5T4KSR5XjXFVyGJPelkwAC2TM9HX/xUwd+/1KTr
         JwFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sAP+3CkhcyAzGSOOjeDge3bGII17aWYwDL7K0dtBg44=;
        b=S5eqeXA6xJmoGo9F3UkelWVTRFxn3W0Oz0rqt2PzJfIG73CPRVBoU9w+v+wdvA4TQZ
         BLBo9wWx0Dv6f070yMaTTp7QxV+g2gocO77uY+oQj6Bd1h41dwjfJNs6SPELU+BSRKAc
         tenjxEhDcDG76XN2+YyoMAiDfVsrrDSE6q4InZ/RsnJIUgVJXG3SFcpHZw4hW+lo5Y8p
         IK6zSS10p1zr7A26nzcckwITWEUtTTzzeITUm9ToN+Tvr8eyiYRsvaSD6XmD3K758FcS
         Xr8EwMWPZ8yNn2r/acsTgph8mWEjYrqosoGFRzD+ruR7KPINDpMeQKTfhfbEJ9XCFzkP
         VJQQ==
X-Gm-Message-State: AOAM5306YC1m9SJj2Ea0Cl7xbJWMe46ynukynVvcqTzZPQr/WdgAy3Di
        orpHWZKVYdWxXbgepvMeo53R2JEU5pg=
X-Google-Smtp-Source: ABdhPJwDsWHwKzdFGUfir57SjL+eIx0jVbGppz6E0440MAgbkTD8QUEuIhW4v5pg8TEZ1W0DSXi/yQ==
X-Received: by 2002:a2e:8745:: with SMTP id q5mr5177200ljj.77.1610719327257;
        Fri, 15 Jan 2021 06:02:07 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f132sm906852lfd.252.2021.01.15.06.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 06:02:06 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc:     alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ASoC: tegra: ahub: Use clk_bulk helpers
Date:   Fri, 15 Jan 2021 17:01:44 +0300
Message-Id: <20210115140145.10668-5-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115140145.10668-1-digetx@gmail.com>
References: <20210115140145.10668-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clk_bulk helpers to make code cleaner.

Tested-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Nicolas Chauvet <kwizart@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra30_ahub.c | 30 +++++++-----------------------
 sound/soc/tegra/tegra30_ahub.h |  4 ++--
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
index 8bd3e83b2c3b..37a847569a40 100644
--- a/sound/soc/tegra/tegra30_ahub.c
+++ b/sound/soc/tegra/tegra30_ahub.c
@@ -45,8 +45,7 @@ static int tegra30_ahub_runtime_suspend(struct device *dev)
 	regcache_cache_only(ahub->regmap_apbif, true);
 	regcache_cache_only(ahub->regmap_ahub, true);
 
-	clk_disable_unprepare(ahub->clk_apbif);
-	clk_disable_unprepare(ahub->clk_d_audio);
+	clk_bulk_disable_unprepare(ahub->nclocks, ahub->clocks);
 
 	return 0;
 }
@@ -66,17 +65,9 @@ static int tegra30_ahub_runtime_resume(struct device *dev)
 {
 	int ret;
 
-	ret = clk_prepare_enable(ahub->clk_d_audio);
-	if (ret) {
-		dev_err(dev, "clk_enable d_audio failed: %d\n", ret);
-		return ret;
-	}
-	ret = clk_prepare_enable(ahub->clk_apbif);
-	if (ret) {
-		dev_err(dev, "clk_enable apbif failed: %d\n", ret);
-		clk_disable(ahub->clk_d_audio);
+	ret = clk_bulk_prepare_enable(ahub->nclocks, ahub->clocks);
+	if (ret)
 		return ret;
-	}
 
 	regcache_cache_only(ahub->regmap_apbif, false);
 	regcache_cache_only(ahub->regmap_ahub, false);
@@ -509,19 +500,12 @@ static int tegra30_ahub_probe(struct platform_device *pdev)
 	ahub->soc_data = soc_data;
 	ahub->dev = &pdev->dev;
 
-	ahub->clk_d_audio = devm_clk_get(&pdev->dev, "d_audio");
-	if (IS_ERR(ahub->clk_d_audio)) {
-		dev_err(&pdev->dev, "Can't retrieve ahub d_audio clock\n");
-		ret = PTR_ERR(ahub->clk_d_audio);
-		return ret;
-	}
+	ahub->clocks[ahub->nclocks++].id = "apbif";
+	ahub->clocks[ahub->nclocks++].id = "d_audio";
 
-	ahub->clk_apbif = devm_clk_get(&pdev->dev, "apbif");
-	if (IS_ERR(ahub->clk_apbif)) {
-		dev_err(&pdev->dev, "Can't retrieve ahub apbif clock\n");
-		ret = PTR_ERR(ahub->clk_apbif);
+	ret = devm_clk_bulk_get(&pdev->dev, ahub->nclocks, ahub->clocks);
+	if (ret)
 		return ret;
-	}
 
 	res0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs_apbif = devm_ioremap_resource(&pdev->dev, res0);
diff --git a/sound/soc/tegra/tegra30_ahub.h b/sound/soc/tegra/tegra30_ahub.h
index 5a2500b4ea06..063aed5037d7 100644
--- a/sound/soc/tegra/tegra30_ahub.h
+++ b/sound/soc/tegra/tegra30_ahub.h
@@ -510,8 +510,8 @@ struct tegra30_ahub_soc_data {
 struct tegra30_ahub {
 	const struct tegra30_ahub_soc_data *soc_data;
 	struct device *dev;
-	struct clk *clk_d_audio;
-	struct clk *clk_apbif;
+	struct clk_bulk_data clocks[2];
+	unsigned int nclocks;
 	resource_size_t apbif_addr;
 	struct regmap *regmap_apbif;
 	struct regmap *regmap_ahub;
-- 
2.29.2

