Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FE928CAF9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 11:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbgJMJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391443AbgJMJ1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 05:27:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1EAC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t9so23123250wrq.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7jRoPXGiiAoDBzp6DBsjtx/DuGJsa9AjjDde8Qs2M=;
        b=cQ54tMtqQbU/rbyhWDIkZM7lwDcs2jxlxfyBx5bPEBf8BeqFrSi7X7vCtcH8pK2YTW
         6s0Jpf2qf2E7imqT79CYWPXFfJslyeu2TrCIPVsUJJyXjZEPKD1ebcQXy8qnLnDVrts7
         tpCwGNEWtxv9mzWU/01SCi5SkXb7vGEaFwCOaKL+DLkRBA2TRysw2cUPwZX3qZxlE6Eq
         nuidr+y0mMmbs4oP+grNn/EdCN1DrdH6wbh2/WwV/j+TP5rhPpljGxjNF5WJZpw888HY
         O+OIhOw5zWDAJ5HR6V8mUfFP0kAsenEWFWUXbCr3KdQA59SD7WmB2bOIN6XixCHD/I7e
         XKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJ7jRoPXGiiAoDBzp6DBsjtx/DuGJsa9AjjDde8Qs2M=;
        b=Wwadq4aIW0lJMGce8pB24a5DriFMVBE+iWBgNSdjVnxzhaA9xCanWiey2gG/1XGbtz
         C0mMMZHAZw7UiUpi3rQDbepcIH9hOQy1nggbz8+j+Ag0iDyeJqhCwe6QzGa33l3DQ47R
         dB67gIzPMQwRe2J5dGB46X7rlgF2CFkKx49pLxitaktT4TYLzmoAV9FuxPYEOFBV6Dh+
         WOQwhxp8pX8vRFiCPKF1fkKDPWYd4RrHH7O2/Of7jsTtdFRVEh+HR1MpRHejXwOVn9/x
         Ivj8kHy52gFDdEJ6jF0bEjpvHMVlBPpKYy0pzoRSKz9VSohB9Mxf+F8zY/I08aVhVpch
         bymw==
X-Gm-Message-State: AOAM531kNXITwYI5he1hnkG/gUF219IrgYE6T016DfBiR/KmL0rYo+h7
        hqXyAQ5VAuN5KAfg+9Ry6zqLpA==
X-Google-Smtp-Source: ABdhPJy14F6d0h2r7/4p6oqrAM5LS8peDKXMcattGlrM2R297ZmvNMjauNFeh/ITF40zFAd3D86YDQ==
X-Received: by 2002:adf:8b48:: with SMTP id v8mr34705235wra.21.1602581234070;
        Tue, 13 Oct 2020 02:27:14 -0700 (PDT)
Received: from localhost.localdomain (147.169.185.81.rev.sfr.net. [81.185.169.147])
        by smtp.gmail.com with ESMTPSA id f6sm14484830wru.50.2020.10.13.02.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 02:27:13 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 1/2] cpufreq: mediatek: Add support for mt8167
Date:   Tue, 13 Oct 2020 11:27:08 +0200
Message-Id: <20201013092709.3336709-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for mediatek mt8167

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 drivers/cpufreq/mediatek-cpufreq.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 7d01df7bfa6c..b8d48ed37156 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -119,6 +119,7 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt8167", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 7d1212c9b7c8..c09bff86bb9b 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -532,6 +532,7 @@ static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2712", },
 	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt8167", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
 	{ .compatible = "mediatek,mt8176", },
-- 
2.28.0

