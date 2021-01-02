Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77692E7FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 13:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLaMZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Dec 2020 07:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgLaMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Dec 2020 07:25:25 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86754C0617A4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:24:07 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id h205so43736402lfd.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Dec 2020 04:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=byqJcKdKFpWTm4VSr9Eiv/kYmNHdQVPFpzs7G6s8ZJI=;
        b=G8eObkzGtydhVt044+/rP2/EisfNdgckFEkq+1wG84Rt74FOIeosTCIi9pT5qH4N/w
         WkZnFfranXG1JmlIY4nzJAjixXZVDGdrrTjcaK7TUzH0xGWitLX+yjSXfR1L4IVNzkCP
         DTBhRsP3IN8Ft4kH81loTytLHk1rESTOS+U96OSxdmqzkuG0WMnj++t81/mQTNswyCrz
         YSeFdlJU+89T187j3VQo6jWclOIuRTaBaNT48B9awa25JZz1TjT0E+wp/vWyk63nfzaw
         PXOf5ZVdPA3hb6z+aIJLJuuZv3fA/z0s7l9Ipmf5VMBm5cnBd/V9U4oa5E8dkU30wApI
         3lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=byqJcKdKFpWTm4VSr9Eiv/kYmNHdQVPFpzs7G6s8ZJI=;
        b=YawgOvA+/qjeixVX7FScASrNb8cTGNRxy/EfQ9frExYiQU6b1+X9+nXY8G1TftbKo3
         rn/BMxToW/IjZBPgn5ENbOwbUP/GgaXc8Fzcq/e3x6mSN0emfFUZ+fC7U9Cy4K19oSpf
         E5m9Eaz/5+WHMckBtdcgwgCZ3HlNFTE1jehV+O1j89PjVN7Min4Hf6uiaBNIG355SBuk
         XbTOjdodHDqBsJfbTfeFCr6V0aZ35bbQRUmnVsFbkkh6UgcslXsVYpzFN5SSdsdNRFgE
         j8oD1tTM7GvMqLam35nSz9g9Hnz6Do0kP0zcn+TwzeDsVuGa7Cjgf7VY5x892vLo2Xuu
         XxlQ==
X-Gm-Message-State: AOAM532Ugok3KghgdO7c5yaZ0s9zYkUFqHTtAyHcawp5c12pxRTsquNi
        iGp9DH6ikytVTPAy/tYQ7OODYNOEoCf7HQ==
X-Google-Smtp-Source: ABdhPJzq6abg1TwVhr803d1PPYncSi4k6ZuV6MIzHQB2v5QqMipPfsrxYtGCfUqlkLzdy6smRL16mQ==
X-Received: by 2002:a2e:a366:: with SMTP id i6mr29588290ljn.427.1609417446061;
        Thu, 31 Dec 2020 04:24:06 -0800 (PST)
Received: from eriador.lumag.spb.ru ([94.25.228.115])
        by smtp.gmail.com with ESMTPSA id n10sm428569lji.99.2020.12.31.04.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 04:24:05 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] regulator: qcom-rpmh-regulator: add pm8009-1 chip revision
Date:   Thu, 31 Dec 2020 15:23:47 +0300
Message-Id: <20201231122348.637917-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201231122348.637917-1-dmitry.baryshkov@linaro.org>
References: <20201231122348.637917-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PM8009 has special revision (P=1), which is to be used for sm8250
platform. The major difference is the S2 regulator which supplies 0.95 V
instead of 2.848V. Declare regulators data to be used for this chip
revision. The datasheet calls the chip just pm8009-1, so use the same
name.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Fixes: 06369bcc15a1 ("regulator: qcom-rpmh: Add support for SM8150")
---
 drivers/regulator/qcom-rpmh-regulator.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index c395a8dda6f7..98320e1d8bf6 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -732,6 +732,15 @@ static const struct rpmh_vreg_hw_data pmic5_hfsmps515 = {
 	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
 };
 
+static const struct rpmh_vreg_hw_data pmic5_hfsmps515_1 = {
+	.regulator_type = VRM,
+	.ops = &rpmh_regulator_vrm_ops,
+	.voltage_range = REGULATOR_LINEAR_RANGE(900000, 0, 4, 16000),
+	.n_voltages = 5,
+	.pmic_mode_map = pmic_mode_map_pmic5_smps,
+	.of_map_mode = rpmh_regulator_pmic4_smps_of_map_mode,
+};
+
 static const struct rpmh_vreg_hw_data pmic5_bob = {
 	.regulator_type = VRM,
 	.ops = &rpmh_regulator_vrm_bypass_ops,
@@ -932,6 +941,19 @@ static const struct rpmh_vreg_init_data pm8009_vreg_data[] = {
 	{},
 };
 
+static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
+	RPMH_VREG("smps1",  "smp%s1",  &pmic5_hfsmps510, "vdd-s1"),
+	RPMH_VREG("smps2",  "smp%s2",  &pmic5_hfsmps515_1, "vdd-s2"),
+	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1"),
+	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_nldo,      "vdd-l2"),
+	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3"),
+	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
+	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
+	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
+	RPMH_VREG("ldo7",   "ldo%s6",  &pmic5_pldo_lv,   "vdd-l7"),
+	{},
+};
+
 static const struct rpmh_vreg_init_data pm6150_vreg_data[] = {
 	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
 	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
@@ -1057,6 +1079,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
 		.compatible = "qcom,pm8009-rpmh-regulators",
 		.data = pm8009_vreg_data,
 	},
+	{
+		.compatible = "qcom,pm8009-1-rpmh-regulators",
+		.data = pm8009_1_vreg_data,
+	},
 	{
 		.compatible = "qcom,pm8150-rpmh-regulators",
 		.data = pm8150_vreg_data,
-- 
2.29.2

