Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1648D26A725
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgIOOco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 10:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIOOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:24:55 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36129C061354
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:24:10 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so5299180ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdIlY1DMQa6xWQ6TOTopEmK8Mk3bArQLeIZPYRdF+MY=;
        b=cD2Bs7MX5CaMjdT1RGSQP9QjtU0jyd1+ezIHcOrMzjVXXu9EYL+A4L26g++gbDz+66
         V7/ikz3zTXW43pA5cStDWuOIrOULlehaNS0tp8qYe9Cx9+YKDAAswfxwo90YUtYlKwDB
         D4vKWMp0qC7KIf1xo67rwUB0p2TFinGOdfW0rMYd5fg8OTQEYRheaBeOrGekiNZimU1T
         OwOcoe3kxAygpfHMp6pwqVWnMJDr9U2OaZF/RPB7IKDkvDTk7CJVqGoJu98Sr3pjjjVS
         7uxvJBBvhLJbH3URKKet+RxrTa4LIwL7GXG/gP3uFguK8+zuMX1W+zIZupBefTXZKf5t
         pZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdIlY1DMQa6xWQ6TOTopEmK8Mk3bArQLeIZPYRdF+MY=;
        b=l7Wu60ruTEv/oM5nZSpui3XE15Q1iIlFzK0CHyx+CZAlZ0DKcJECvRuyoIPCz2xGtw
         YkQuCkYfXs6WoIHqlKq5JcZ8jm6BEnPQbJ/dE5T9CZpIsoN2edaP4bhbaX8xulhXwui1
         DGZ+wgA94oe2Fv9RNokhRxkaPY1dL9ojfyizckBRQCtphxIQGG68jEesFmbUOI9Q0xMU
         uTxPrEchvH75AgOFcp7qiGM5o8k44Y+dUn2K2y5VDWMkMnH8i45WDRK0BS10JFhMPLkk
         Bb2heen/1eQFbyzuLamK6khNFp4kLKsfIiijqrw/5Dpr92d02JEHdOmXGYHadSO0fFhN
         QOgQ==
X-Gm-Message-State: AOAM530jeG+bAlnaoWZPRcv8JvNL6Qu6oeedNIkAKPxGN4frXHDMeWLg
        gasZ+IxdhneJo16vLFYGpvxqaw==
X-Google-Smtp-Source: ABdhPJxxPQqo+SY2oLP3bGkJn5qMdGtI+WtpT8UWcDElnzK3m58LblbwEe5kthpZiMZYWa9Lpnk8Yg==
X-Received: by 2002:a17:906:9416:: with SMTP id q22mr12933333ejx.82.1600179848730;
        Tue, 15 Sep 2020 07:24:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:102f:d6a:d196:1215:6121:1cc7])
        by smtp.gmail.com with ESMTPSA id n14sm12096001edb.52.2020.09.15.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 07:24:07 -0700 (PDT)
From:   Robert Foss <robert.foss@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     Robert Foss <robert.foss@linaro.org>
Subject: [PATCH v1] arm64: dts: qcom: msm8996: Add VFE1_GDSC power domain to camss node
Date:   Tue, 15 Sep 2020 16:23:16 +0200
Message-Id: <20200915142316.147208-1-robert.foss@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the MSM8996 has two VFE IP-blocks, and each has a power domain,
both of them have to be enabled. Previously only the power domain
of VFE0 was enabled, but not the domain for VFE1.

This patch adds the VFE1_GDSC power domain to the camss device tree
node of the MSM8996 soc.

Signed-off-by: Robert Foss <robert.foss@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 9951286db775..df6e1b246a19 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1009,7 +1009,8 @@ camss: camss@a00000 {
 				"ispif",
 				"vfe0",
 				"vfe1";
-			power-domains = <&mmcc VFE0_GDSC>;
+			power-domains = <&mmcc VFE0_GDSC>,
+				<&mmcc VFE1_GDSC>;
 			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
 				<&mmcc CAMSS_ISPIF_AHB_CLK>,
 				<&mmcc CAMSS_CSI0PHYTIMER_CLK>,
-- 
2.25.1

