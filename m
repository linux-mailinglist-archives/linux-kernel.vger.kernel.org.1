Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275D225CE42
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 01:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgICXZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 19:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgICXZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 19:25:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BF6C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 16:25:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 5so3345512pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9D90+pAFL80PupYKppeDjSMb53d09AW9uWDmD+PNvZ8=;
        b=Ceo30NPe/3i/3NSMwH3W/JmqHwlMveG9Dbgn22rEsVDTvkKhjXSsLRfkwsSMLijOLe
         rhLbGd6zdxIchiLENz6Q6dG/9pQceKqjgdjQDtegsa+aq3vlF44HSYgSzzq7b6VWPmHY
         CVs5vzHFfIXNRjnsZrms8xwCwnp7nqiTY9q/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9D90+pAFL80PupYKppeDjSMb53d09AW9uWDmD+PNvZ8=;
        b=VMyIB8jbmVM5Ui/ZgTuBQKEvE0abFbCuXnn/UfGJNM4jEBhT2kaikmOGcNNHP/TiWc
         m3CNjSsOOG/w3U1DksZxjSRF6YXc0EkgHMJFG6ukKRIMPcdtFvQbBx0REgNpvvFuXB5u
         SSbBMpkrT3XZMzupQ6tgOOwIjemCPK88fUojL1c55sSfAEPtChOm3m/4Dy22yHk/XM12
         4ekuilmSHZDskTvtnsxsSqbm6RBIdOBQbKFvBR4zaCt05pGIRM/Vr9KwZw248Z4GUuj4
         QrZSiRA1v3c5dDzqnwvazSLsZfMshBRLat/ZyS4Gfr8GyMSHUF6CXa4mnZOjxSa1KjJ1
         ndCA==
X-Gm-Message-State: AOAM532OiLvPa66P1OlFRo0XnQaDij5Hlk0HRnYJu5/TYq+fKQ12IgNT
        scPyJrxuakgk58uicnAe0zocAg==
X-Google-Smtp-Source: ABdhPJyotTnzJcV701e1rWtMf0V7HnsqMU8RXbPl7+Pw/P9r/85I6PHiwIVMdF+JrKzrzh3qyGgC5A==
X-Received: by 2002:a17:902:be08:: with SMTP id r8mr3905651pls.103.1599175505475;
        Thu, 03 Sep 2020 16:25:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id q7sm3614459pgg.10.2020.09.03.16.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:25:05 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     swboyd@chromium.org, Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 2/6] mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.9
Date:   Thu,  3 Sep 2020 16:24:37 -0700
Message-Id: <20200903162412.2.I226782b43191ce367fa3bc1c907c29f571890412@changeid>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200903232441.2694866-1-dianders@chromium.org>
References: <20200903232441.2694866-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is like commit 3d3451124f3d ("mmc: sdhci-msm: Prefer asynchronous
probe") but applied to a whole pile of drivers.  This batch converts
the drivers that appeared to be around in the v4.9 timeframe.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-brcmstb.c | 1 +
 drivers/mmc/host/sdhci-pic32.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 876668827580..bbf3496f4495 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -326,6 +326,7 @@ MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.pm	= &sdhci_pltfm_pmops,
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index a11e6397d4ff..6ce1519ae177 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -241,6 +241,7 @@ MODULE_DEVICE_TABLE(of, pic32_sdhci_id_table);
 static struct platform_driver pic32_sdhci_driver = {
 	.driver = {
 		.name	= "pic32-sdhci",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(pic32_sdhci_id_table),
 	},
 	.probe		= pic32_sdhci_probe,
-- 
2.28.0.526.ge36021eeef-goog

