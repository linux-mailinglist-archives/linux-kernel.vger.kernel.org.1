Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0515C2FDDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392146AbhAUAYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404043AbhATXXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:23:44 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60552C0617BA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:45:25 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id n186so84272oia.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UMTJ0JHuVDvRdMql14H7mW/63Qwi+kchpGfybyMLqlE=;
        b=L9pnkOb1g0h9Evn94z6yhdXe3BvX/dUxq9knD0iUOvRAt1duITpneYRtHD+gXRcK6S
         Wjrf/CHEut8lVcecB5qDwtxsMJ7b8Vyn3RAA3BIkVo6iajtZ2Z8yWukVOPaEPAwG7439
         XYmbT+iozQ7IU7YXxxU84GmbxKMgK2dT0IFMR0QTxX373UWdKGZE2zoRojbdcmoLJkbP
         Vkz9FNtjrMVubvGmoH7N0ZjtH2Uscp9/1HFqolXy1BedRri1yOJ9uGdAB9kMdAvpGO/o
         pGMe5gO7Pkl2DmypS+eXHI7Ec6mwjQJMUXzDNoun+11rRuF3ncq5sVUpJRr4x+j8trVx
         j86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UMTJ0JHuVDvRdMql14H7mW/63Qwi+kchpGfybyMLqlE=;
        b=s08d7CPhz8fFZsb3wHiD//ScpuCg4HyJN7G/tb81RlZt6NI1btMDU4riHnRJgy9GZm
         SNDHtz0V7PHsG8HUjIrirPPk/5mwhPElckmDPaKpzdv0P1wYMAHkdbZWIrMNvBEuUGIN
         iq8RnviqkIcaQV8dIoE26EXz8p7V6WEBBoXvek7qGA6R/JtB/O1SBgBaeiix6+1i/fpO
         RtD5uWgheUhLnvAqM+jFQs8rbrJGVTmQk4+BPCmaQUQ0R0d/N9cpsDezL1O/UVsbTZQc
         6tAm91mqCOQ2NcxeJBgI58/pB/p06xRQhP0BF0I0ahMT75EQcnNOYTWAduALtwlzxiux
         p/gg==
X-Gm-Message-State: AOAM533NDCVQqMdgRo3Q8/Dn/68c6ZOOAUgUJ4eTrKJis97tW2EaneAO
        oyDZiBFsh5hJzJpgckGndLtrIg==
X-Google-Smtp-Source: ABdhPJyzj88dLLbYYlRKVCaP9cu++hO6ZvH1DKP9EnzLKSXpe9DE4vXK0nUQiowjRr/XNElYNdeXDQ==
X-Received: by 2002:aca:d98a:: with SMTP id q132mr4302008oig.33.1611182724813;
        Wed, 20 Jan 2021 14:45:24 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id m18sm692791otj.50.2021.01.20.14.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:45:24 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] phy: qcom-qmp: Add SC8180X UFS phy
Date:   Wed, 20 Jan 2021 14:45:31 -0800
Message-Id: <20210120224531.1610709-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120224531.1610709-1-bjorn.andersson@linaro.org>
References: <20210120224531.1610709-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UFS phy found in the Qualcomm SC8180X is either the same or very
similar to the phy present in SM8150, so add a compatible and reuse the
SM8150 configuration.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index bdcb8bf6225d..a1ea911856fb 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -4208,6 +4208,9 @@ static const struct of_device_id qcom_qmp_phy_of_match_table[] = {
 	}, {
 		.compatible = "qcom,sc7180-qmp-usb3-dp-phy",
 		/* It's a combo phy */
+	}, {
+		.compatible = "qcom,sc8180x-qmp-ufs-phy",
+		.data = &sm8150_ufsphy_cfg,
 	}, {
 		.compatible = "qcom,sdm845-qhp-pcie-phy",
 		.data = &sdm845_qhp_pciephy_cfg,
-- 
2.29.2

