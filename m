Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3AD285A1D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgJGIIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbgJGIIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:08:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E65C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:08:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e22so1672050ejr.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCF8SynXrWVRYxNQ22uW6uSFDL0I44L0Irm6uzCuBCc=;
        b=ox4PxNK9iCxu2B18rdmRCaoEGcbD4CgFLBa5LFXCSNsT2y/kBWF/XUpeD8yZyzwaRS
         LC4z+VOvuwPT6de7nY0uKs9PYwbpdH+Ec1qyaAeIpTLPi5s9dJ6iKJI/goNuO00wF6z6
         ISDrcgjCSz6JlM7b4Hg2Tqpoxg0G5d7tDWBckRvdA1vsYDQFtPuJM85BVxJtocTScbLU
         Tp579wt2OvniUuqGoPCDps3DiKK8u6lR7oNZrM4vJWpY5JD5h5SomMZZgtap+99G/2Oz
         vA7al3NHRSZRLTtfd+c5v7F9SnxbLYlGhrmLOJjuqr/DHXEGOveOvtVY5+FNMeb4YAwK
         s/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCF8SynXrWVRYxNQ22uW6uSFDL0I44L0Irm6uzCuBCc=;
        b=kcJ0sJ1+8qCvOjGAeHTkezKNgzEhfbTqyDvJgjJswRhYGbkbYMQJyfaLoixL/9El+3
         Dmn1O3cD4GAt58WPGbYiINW5JnIxDQ9U82wysFGpa+/eKPhFrg/Jgd68IeAiuFqVYGPO
         Ootl5cXFNw2Hr/vcQsVulbhaTU/WJLnXiQcVaAGW8mg8z4siy1CdlLjhH5xkpZosmHB6
         AYr8A0i2raAAcEAq+G3Gll2e3PT6Q+tBgJ63CukJ43Get7AV1Yq3eiQMsfear3IeaVZG
         xKBVBrfLVdlEr9P6v9WtibimFZm6DYYEMGvOj9oIBYKy53PCIDwbYtUmkVYSnoOccgzA
         zlMw==
X-Gm-Message-State: AOAM531fGM85zO8uAA1g0HDVLBlPAlKqthbBmrn2XZWXQ/pcwDMCtmdx
        XAKcbKPJF2BMWwJt7ToR3X7nSg==
X-Google-Smtp-Source: ABdhPJybptPbF4/1Q7e1paiatpmUVApwJAseaJOEaCM+dgpba+3RlGvV8tZ4QucnKe3c0/wuHvfsdw==
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr2231056ejr.217.1602058090835;
        Wed, 07 Oct 2020 01:08:10 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id p11sm888645edu.93.2020.10.07.01.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:08:10 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Wolfram Sang <wsa@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>, linux-i2c@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] i2c: meson: keep peripheral clock enabled
Date:   Wed,  7 Oct 2020 10:07:50 +0200
Message-Id: <20201007080751.1259442-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007080751.1259442-1-jbrunet@baylibre.com>
References: <20201007080751.1259442-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SCL rate appears to be different than what is expected. For example,
We get 164kHz on i2c3 of the vim3 when 400kHz is expected. This is
partially due to the peripheral clock being disabled when the clock is
set.

Let's keep the peripheral clock on after probe to fix the problem. This
does not affect the SCL output which is still gated when i2c is idle.

Fixes: 09af1c2fa490 ("i2c: meson: set clock divider in probe instead of setting it for each transfer")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/i2c/busses/i2c-meson.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index dac0d2a00cec..e7ec2ab2a220 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -370,16 +370,12 @@ static int meson_i2c_xfer_messages(struct i2c_adapter *adap,
 	struct meson_i2c *i2c = adap->algo_data;
 	int i, ret = 0;
 
-	clk_enable(i2c->clk);
-
 	for (i = 0; i < num; i++) {
 		ret = meson_i2c_xfer_msg(i2c, msgs + i, i == num - 1, atomic);
 		if (ret)
 			break;
 	}
 
-	clk_disable(i2c->clk);
-
 	return ret ?: i;
 }
 
@@ -448,7 +444,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare(i2c->clk);
+	ret = clk_prepare_enable(i2c->clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can't prepare clock\n");
 		return ret;
@@ -470,7 +466,7 @@ static int meson_i2c_probe(struct platform_device *pdev)
 
 	ret = i2c_add_adapter(&i2c->adap);
 	if (ret < 0) {
-		clk_unprepare(i2c->clk);
+		clk_disable_unprepare(i2c->clk);
 		return ret;
 	}
 
@@ -488,7 +484,7 @@ static int meson_i2c_remove(struct platform_device *pdev)
 	struct meson_i2c *i2c = platform_get_drvdata(pdev);
 
 	i2c_del_adapter(&i2c->adap);
-	clk_unprepare(i2c->clk);
+	clk_disable_unprepare(i2c->clk);
 
 	return 0;
 }
-- 
2.25.4

