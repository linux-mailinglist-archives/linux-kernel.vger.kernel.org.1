Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCD3299856
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 21:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgJZU7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 16:59:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46326 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgJZU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 16:59:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id y14so6857960pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 13:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDa/MGBFJVWKF38l+qbilXRFIDAZ0WwGP8FkHRMbDLM=;
        b=dsCNxm9ZAC2U/MfvTm4u+yvOauAENsiVo2Rmb1x7pLODRq4d6i1vwYBfrXXUOp9bFA
         NyJH5FUyUvQvuujg0d7UowhOIl6YVcbFLTO8KIXr1Ifg/5lE3nklJj0z2wVXrP9+zl6t
         PqnJJOMoB8HpuOk7anRcvVJhcfvYREUEC1CkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDa/MGBFJVWKF38l+qbilXRFIDAZ0WwGP8FkHRMbDLM=;
        b=Qb5m/Tm3gBKE3fMPq50Mm6hopDjtPU9W3vsZlFaOABdzDLNKbO35UQijQuekzpNXqP
         iGx8A5ny6Dy2LClI0m25eJPu6njantWRPolgx6SikhFlhrtaDmpIk70USIojvCoKjawJ
         FGbHRmfmo5o8s3iGvS7OpG0Unai1TWFXiI93J/Qj+a4vQEhkE5H8btReC0iCC9baBaEx
         QRo5t8aU5oG2AtfcjG3AjfWtVoLSmZi1yGf1H/iEQdOm1VjgY12KP+WkEoVOZTkMT14a
         nXPQOSxeMremQqAH0BgbKb0tjAwqgaZ1uhKbj81QWIZkEa5xTV0mnjmLwPFpiBBpGjty
         xXZQ==
X-Gm-Message-State: AOAM531K6x4TTk49FTvg+kauYEukwaSJZErxsdP6CY7SuXYs9C+Faclt
        AX4Uu0VpiydD28bnv4qGk+f2kw==
X-Google-Smtp-Source: ABdhPJy7syG26RCaKNemvkfSQbbmIEGNmH1Y5kQJ+b7ZtCTMxuxIZv6OreN7JgpZWxMYg0kWADuP6Q==
X-Received: by 2002:a63:4c42:: with SMTP id m2mr14767029pgl.122.1603745984540;
        Mon, 26 Oct 2020 13:59:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b1sm9155501pjd.11.2020.10.26.13.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 13:59:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] phy: qcom-qmp: Initialize another pointer to NULL
Date:   Mon, 26 Oct 2020 13:59:42 -0700
Message-Id: <20201026205942.2861828-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This probe function is too complicated and should be refactored. For now
let's just set this variable to NULL and keep the static analysis tools
happy.

Fixes: 52e013d0bffa ("phy: qcom-qmp: Add support for DP in USB3+DP combo phy")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index 5d33ad4d06f2..0cda16846962 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3926,7 +3926,7 @@ static int qcom_qmp_phy_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	void __iomem *serdes;
 	void __iomem *usb_serdes;
-	void __iomem *dp_serdes;
+	void __iomem *dp_serdes = NULL;
 	const struct qmp_phy_combo_cfg *combo_cfg = NULL;
 	const struct qmp_phy_cfg *cfg = NULL;
 	const struct qmp_phy_cfg *usb_cfg = NULL;
-- 
Sent by a computer, using git, on the internet

