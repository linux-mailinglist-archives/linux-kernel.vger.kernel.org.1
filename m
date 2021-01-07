Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0098E2EE838
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:17:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbhAGWQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbhAGWQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:16:08 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0085CC0612F5;
        Thu,  7 Jan 2021 14:15:27 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id b5so4994375pjl.0;
        Thu, 07 Jan 2021 14:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WZ0XBPw5rLkEDXHtBQzLvxXTmDU6S/SHITAFiBYK730=;
        b=jIHeiI1kVrjG+DCsMVsO1xFF9i3dWyRGCrWqXgK8nOdaIlVJdMOhl0Ks9tOp6CS73N
         zA07EaKb9XdM72SaymmJxFhJQzd/b0Lo3U5nO/RxjrJkELr4v7BX9LAQDjDb72EQuVOM
         tKMynD66ISR97gNCU9fC1ibpizz50EsjKLhPZR0HTn6YPYpFbUgVKmEV1C8W7f5V2Y2u
         8/NLW1CnG+MS8i9fZzzRyp8I2b7glhILN8de0jl9ORkErQfDAOhTzy0X4gZgyEkY+LX0
         eMpvrIjt/DQuNytAsDiJpIRfa00yDZQCI9pa6ub+5LsyHDiiI+w1Fe5w+K0bBBWmoC/5
         wQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WZ0XBPw5rLkEDXHtBQzLvxXTmDU6S/SHITAFiBYK730=;
        b=GccVGb+zx4cfKOLBAwREzLTVVK+pIz67qoSi0qWT3g2s0rzjogfDXcDXTBmT14Fc+l
         dek6jdvM2c1HMDJXMHSiXh0nBX5i0Wx+SMkPUJnJuo3/M5oaxp5knsqIS6STGtYnlfaS
         Jg3H+CBHZYF2SoccwhgzjAVal7/L71FV3yk2B48XDuKENrCd8dqKxfu+afM2ctwap6kA
         PeIHpc8D6kKtsE7d55voWwzeu6atGQgF0AQcOZBcNZSxQgi3whVx+9z7jwBiDCYxqjBZ
         1vQGviQ9bqCYnO4clK8LQnJozAU6Whoe42f8OF/MXgSHUzpj38V7y7IpThiCjddEsq1a
         S5ow==
X-Gm-Message-State: AOAM5336V5T8zHUll7xKEuG6GAyBRL7b+6+rVpdL1taKo1KQvBUSRnch
        uA7nDa7LgL9HlJ+FhtHjnYg1LQC/HYk=
X-Google-Smtp-Source: ABdhPJw8j8kSHJ4xSxiB6bT1YL4sk7XN/GCNYzKFBjTUx2mSteKc+Y1JZb6r2nLm7KIFw3Bd8FoWyA==
X-Received: by 2002:a17:90a:de03:: with SMTP id m3mr606664pjv.20.1610057727336;
        Thu, 07 Jan 2021 14:15:27 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id nm6sm5958542pjb.25.2021.01.07.14.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 14:15:26 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
Date:   Thu,  7 Jan 2021 17:15:09 -0500
Message-Id: <20210107221509.6597-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
that added a shutdown callback to the diver, is causing "mmc timeout"
errors on S5 suspend. The problem was that the "remove" was queuing
additional MMC commands after the "shutdown" and these caused
timeouts as the MMC queues were cleaned up for "remove". The
shutdown callback will be changed to calling sdhci-pltfm_suspend
which should get better power savings because the clocks will be
shutdown.

Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index bbf3496f4495..f9780c65ebe9 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 
 static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 {
-	int ret;
-
-	ret = sdhci_pltfm_unregister(pdev);
-	if (ret)
-		dev_err(&pdev->dev, "failed to shutdown\n");
+	sdhci_pltfm_suspend(&pdev->dev);
 }
 
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
-- 
2.17.1

