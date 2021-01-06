Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A932EBE11
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 13:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbhAFM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 07:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbhAFMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 07:55:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B70C061370
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 04:54:36 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n7so2186317pgg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 04:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=72PT8I5FQuukLAeJvrHHub31x7cqLErd0FAtFysugUs=;
        b=chBrUx+BZS+xmQVt8U/+A3N12/Rc8KDXilyAdn6PmAvV0ExFAo8AeOsMkhniMAvQ+R
         BQJc83tf2iXulGONGJcNRoegpuM2JUyVpjJsAtffYoS5zKFextiZAAw9kPmpStQCpD0o
         8IIDaEO2Fmi1FGPe33B/3u4CWuF3gp3DjGAQiTUmwBu8U/+bv4uSP6IiPVC6Da6qA91X
         VjsFMlCtZYtZ0eorNGpySpcz9ZMn23P3hqEH4N44GbzB3P1Tj+PB/pDbKa7g99pmgGLZ
         P5uTI1AkAXs8KcvhxEIXx7eO6/qrk8CIerW+oDqLiyge35BAFILg3a7GREWDCpIwGGDq
         Jo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=72PT8I5FQuukLAeJvrHHub31x7cqLErd0FAtFysugUs=;
        b=HNx6Jie43UbI8EuYf0x45bDk+vlPrKnRLIIvCwNG8HVeUYQ0GAB0lItMoDt61cRRsk
         ATr06Gagjg+eOHzZBDdiJ67VMKp4Vdrhx0kPjPehqf+VBvghpfyUoFUmyL/pzmukQ8Ob
         kKMRYuTZsm/RVisRI6XC42+KajW6t32IazCcg7W8Q5gZXY+k45bv0M0Msj8E3BkRgZ6J
         V012eP0y/CWkU1o/QfyZqusDrsBUGcUrs1lC/pygsRGoChzA/qY2srUcuYyCuObs9UDa
         1XZbhrYe060Kj865TGII3dmXD2Di1Pb2rWBXMWUGRNRb7NChB3tgghQgecRoDKCylWiZ
         F/lg==
X-Gm-Message-State: AOAM532nfLiwiVUacbNgsJwL4EoxsWdlN+uNzaOeMVdd5aCGzivLFiC5
        VeHNOb1WMiVVCEsvaIXi7OWn
X-Google-Smtp-Source: ABdhPJzXDpcmBudK8H334ON4SfzKRHKHM/knBfwVRpUd/g6WZ9DYIk/7xQ1KZwDB80K7/adTF71i6Q==
X-Received: by 2002:a63:6344:: with SMTP id x65mr4376355pgb.172.1609937676394;
        Wed, 06 Jan 2021 04:54:36 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6102:e7a2:51f0:bf72:bf80:ec88])
        by smtp.gmail.com with ESMTPSA id n128sm2918182pga.55.2021.01.06.04.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 04:54:35 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 14/18] ARM: dts: qcom: sdx55-mtp: Add pm8150b pmic
Date:   Wed,  6 Jan 2021 18:23:18 +0530
Message-Id: <20210106125322.61840-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
References: <20210106125322.61840-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SDX55-mtp features PM8150B pmic, so include the dts as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 83b9d784423e..6ec0c3f1f275 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "qcom-sdx55.dtsi"
+#include <arm64/qcom/pm8150b.dtsi>
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX55 MTP";
-- 
2.25.1

