Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5139226CF56
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 01:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgIPXND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 19:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgIPXMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 19:12:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC29C061788
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:12:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b124so4861768pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wSus/y6lL8EmG6yL6JLfCPXtJnmL/oSSFawM27yJogM=;
        b=MSQIPGps4/l+ukgx5RkY8FEq8Invxk9IYA4yDnKdSfYXN/HO2ct9KZAQlTsnx8a3d4
         Z5M6RXpys20wGyV/f8G9ZiZIGbkIWdBUiPhTho1aEYCwqLGniGWZeqbb91MQZ4LtbC/v
         FtNkngc8UV1JbWWjAvjtUlrp+zA++MVvwDmxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wSus/y6lL8EmG6yL6JLfCPXtJnmL/oSSFawM27yJogM=;
        b=j5+2LgnBWmLt3lvpirSxKjSHVT5WdFPUgpOx6pd4KdxzoxhzhhfAk/M9+q7WA/8+U5
         SEShW9CW7nkIhwTOwY1PQ64SMO0JDpneX8DHVGmVKEGAvaRXOR+Xm0yvoaT5SX4uVNal
         8ADZFrIrVhIdENy/xOB+w0cMmaOE4Kn+UpuGEQIRy/Xf1EfkTvabBjcWXdcDiXqJTzl0
         /LHyX2jqgDkecjas/5xIJswizjdF6cJP/k8ih6/Uol7Q+gMorZH4GWh1Lb7q7uXirzVt
         5uVo8C3au6J6iPc/3oX6IuuFyOoKD+ImoKhMMFIHc5b8Liy2nVlEzSwzP21bqmMwsq8Q
         qOiw==
X-Gm-Message-State: AOAM531egTZUAKJNPka37ynBnZPRkbHiwtgE3cTBuNzBide1vlAl5bRr
        ew/HkkErru9CgjKE5jxudCGXhA==
X-Google-Smtp-Source: ABdhPJyl865ch3sXi0YjoVm5fcmUlOu68ZqejV72go/iYA4R7xwV4XRhMQjY9N7xX6R3HDVqCOXrJg==
X-Received: by 2002:a63:5952:: with SMTP id j18mr20943578pgm.317.1600297930733;
        Wed, 16 Sep 2020 16:12:10 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u6sm3643254pjy.37.2020.09.16.16.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 16:12:10 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>
Subject: [PATCH v4 05/10] phy: qcom-qmp: Get dp_com I/O resource by index
Date:   Wed, 16 Sep 2020 16:11:57 -0700
Message-Id: <20200916231202.3637932-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200916231202.3637932-1-swboyd@chromium.org>
References: <20200916231202.3637932-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dp_com resource is always at index 1 according to the dts files in
the kernel. Get this resource by index so that we don't need to make
future additions to the DT binding use 'reg-names'.

Cc: Jeykumar Sankaran <jsanka@codeaurora.org>
Cc: Chandan Uddaraju <chandanu@codeaurora.org>
Cc: Vara Reddy <varar@codeaurora.org>
Cc: Tanmay Shah <tanmay@codeaurora.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Manu Gautam <mgautam@codeaurora.org>
Cc: Sandeep Maheswaram <sanm@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Sean Paul <seanpaul@chromium.org>
Cc: Jonathan Marek <jonathan@marek.ca>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Rob Clark <robdclark@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 40c051813c34..215abd179e74 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3266,13 +3266,9 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 
 	/* per PHY dp_com; if PHY has dp_com control block */
 	if (cfg->has_phy_dp_com_ctrl) {
-		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						   "dp_com");
-		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		qmp->dp_com = base;
+		qmp->dp_com = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(qmp->dp_com))
+			return PTR_ERR(qmp->dp_com);
 	}
 
 	mutex_init(&qmp->phy_mutex);
-- 
Sent by a computer, using git, on the internet

