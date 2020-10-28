Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D6529D915
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389497AbgJ1Wny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389477AbgJ1Wnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:43:47 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D8AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:46 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id f4so466401vsk.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DBtuKQbqQFVugOwxtfWUi7hhbBNFTZTu4rZZoWsSSOw=;
        b=Pdjp840SYs7UCdJ/A+6FMvTsWNPqC9dcSyVdlZ/v8Sw+MSDzxJCJjQLoFVBml/22V6
         8/O2ShytMQkGmtAcyUJ/KnPUm4EIKO5zO65gLADPS33qCZtbfy+SROhhrug9kRGrQyKv
         r64RW30AxdtBu10xVQ2G+PQTXAOHK66yWnPPZFwp8MidX2MXkVhSwL1ndp/Hc7XJQgGS
         adfwjXsMTB0Ue0DlNCbS2ORXkKZ8J27wcwemhCzyVIvwrb3U1UbDmjQ5tOTQvU48dmP9
         aajyg727fiHbdFfcBQoiIjv2vG49Dll4KuxiiUhYMDHb3i4tQpQCJ+OWI+5tr6Eu+8Q6
         4xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DBtuKQbqQFVugOwxtfWUi7hhbBNFTZTu4rZZoWsSSOw=;
        b=t6k4cFNd6Bzs7BJhpMLH+z6p1CvB7pTgAybubaFm0M/1tICkLL2IEJ9x+spcX7zguG
         L7zoOaDQ4+2DaWjfEH2awwC4s1XiCMbBVLI0OBGlJUSFWuZFFDuMKP+NCBPs6gUhmO51
         bZ0W1e4w2cCb20DLTBT/0Q3uYuXnFkl2XGeb8XVvvgFokKYyEJr3SfZRB8AEabz+L0ke
         iBDr/qHk1s4scdUX/o50xRpAw4zOogsmly9SA7nOD64VhG6N3lXALDGj3Lj0BF5PYYRU
         gjAWn25GYgQXG+fqFiiY9QiIa3PZxeyPbjGOU9Moto4cmOKpozzLpIEnQqT/yYfwNZ61
         ANlQ==
X-Gm-Message-State: AOAM53030ukHXugNpG4WoJk8UNDqPOKDcgmm4XWLm9kTfTeu5lLtJqfb
        et5984DtlIEHPtfjjRIV7eIR/pUW/RkyzA==
X-Google-Smtp-Source: ABdhPJyNIenHf7Vrl5iCg74QqRyLREcDKUNbEamTEBa/L8UfaHR40zNHFUDJyHuv281eFBsDS8mIzg==
X-Received: by 2002:aa7:808a:0:b029:160:167d:d332 with SMTP id v10-20020aa7808a0000b0290160167dd332mr6340101pff.1.1603867475214;
        Tue, 27 Oct 2020 23:44:35 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id t13sm4900602pfc.1.2020.10.27.23.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Oct 2020 23:44:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     robdclark@gmail.com, Sean Paul <sean@poorly.run>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 Resend 2/2] drm/msm: Unconditionally call dev_pm_opp_of_remove_table()
Date:   Wed, 28 Oct 2020 12:14:22 +0530
Message-Id: <f48fcf417bd727f685f34b6f9243fe6239b0d686.1603867405.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <c995335d16d8b4b4ff47b1273869c33e14782b32.1603867405.git.viresh.kumar@linaro.org>
References: <c995335d16d8b4b4ff47b1273869c33e14782b32.1603867405.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
find the OPP table with error -ENODEV (i.e. OPP table not present for
the device). And we can call dev_pm_opp_of_remove_table()
unconditionally here.

While at it, also create a label to put clkname.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

---
V2:
- Compare with -ENODEV only for failures.
- Create new label to put clkname.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 14 +++++---------
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 -
 drivers/gpu/drm/msm/dsi/dsi_host.c      |  8 ++------
 3 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d93c44f6996d..fe127c2f5505 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1091,12 +1091,9 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 		return PTR_ERR(dpu_kms->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(dev);
-	if (!ret) {
-		dpu_kms->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(dev, "invalid OPP table in device tree\n");
-		dev_pm_opp_put_clkname(dpu_kms->opp_table);
-		return ret;
+		goto put_clkname;
 	}
 
 	mp = &dpu_kms->mp;
@@ -1118,8 +1115,8 @@ static int dpu_bind(struct device *dev, struct device *master, void *data)
 	priv->kms = &dpu_kms->base;
 	return ret;
 err:
-	if (dpu_kms->has_opp_table)
-		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_of_remove_table(dev);
+put_clkname:
 	dev_pm_opp_put_clkname(dpu_kms->opp_table);
 	return ret;
 }
@@ -1137,8 +1134,7 @@ static void dpu_unbind(struct device *dev, struct device *master, void *data)
 	if (dpu_kms->rpm_enabled)
 		pm_runtime_disable(&pdev->dev);
 
-	if (dpu_kms->has_opp_table)
-		dev_pm_opp_of_remove_table(dev);
+	dev_pm_opp_of_remove_table(dev);
 	dev_pm_opp_put_clkname(dpu_kms->opp_table);
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 1c0e4c0c9ffb..d6717d6672f7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -131,7 +131,6 @@ struct dpu_kms {
 	bool rpm_enabled;
 
 	struct opp_table *opp_table;
-	bool has_opp_table;
 
 	struct dss_module_power mp;
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index b17ac6c27554..4335fe33250c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -113,7 +113,6 @@ struct msm_dsi_host {
 	struct clk *byte_intf_clk;
 
 	struct opp_table *opp_table;
-	bool has_opp_table;
 
 	u32 byte_clk_rate;
 	u32 pixel_clk_rate;
@@ -1891,9 +1890,7 @@ int msm_dsi_host_init(struct msm_dsi *msm_dsi)
 		return PTR_ERR(msm_host->opp_table);
 	/* OPP table is optional */
 	ret = dev_pm_opp_of_add_table(&pdev->dev);
-	if (!ret) {
-		msm_host->has_opp_table = true;
-	} else if (ret != -ENODEV) {
+	if (ret && ret != -ENODEV) {
 		dev_err(&pdev->dev, "invalid OPP table in device tree\n");
 		dev_pm_opp_put_clkname(msm_host->opp_table);
 		return ret;
@@ -1934,8 +1931,7 @@ void msm_dsi_host_destroy(struct mipi_dsi_host *host)
 	mutex_destroy(&msm_host->cmd_mutex);
 	mutex_destroy(&msm_host->dev_mutex);
 
-	if (msm_host->has_opp_table)
-		dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
+	dev_pm_opp_of_remove_table(&msm_host->pdev->dev);
 	dev_pm_opp_put_clkname(msm_host->opp_table);
 	pm_runtime_disable(&msm_host->pdev->dev);
 }
-- 
2.25.0.rc1.19.g042ed3e048af

