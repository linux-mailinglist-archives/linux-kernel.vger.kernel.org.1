Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A6A2EAAD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbhAEM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbhAEM27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:59 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E84C0617AB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:24 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v3so16262090plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RyijtvfzOEwv7y75RleS9x+X/d9lA9ueEmTbZLEwMZ8=;
        b=zNYhZQy5bbQBnjuJlFostO4T2P9s56aLDKRbMbZNaovVwfdc9ITyrZC5/g3undrD9A
         Dimlh2J8B/C/Y2quAtc9kV9W1iu4iHJpGEMlAhSs92pLrazeUe0F6socr2Fun4v27+OG
         Z2FLt040yMh/xMOO2kvLpeuh2/0bKiJODqXDA/ef5xsqKzn/DtDO4C+txfRfoJAneAyY
         QKvUBZ2f12TevOyhK2zEwUhQmI+szr5F6pFw00iZnQi0R7IDgSZp8LTTZJv9BLLyRxEq
         lxmYvVl+78Hsss3ldv9xX9UwnUZGKGOydTSGdjsnNTd7Y8NYMz6Z59o++LXOqtUlH6Tp
         unqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RyijtvfzOEwv7y75RleS9x+X/d9lA9ueEmTbZLEwMZ8=;
        b=QEL60rIDp4+EyQ/BWC/dtu9Xuegt1z+PhgaPapZ/1pXxSl7DUTGblbomnt8Ohoh/Di
         6D+fOnVXLYYViyhF/uMhsgma/8J/Qwupab8D9WLuVXXDlJIe8z1Rb0EXCGmeTFBmIr4o
         jdn4SnbVhHjreXqyz9sqMDtQvpOWDAQddDEuwBW65J4s3QGXtY03Bbhexa4VomZhflte
         2EshQzFhLQ5IrIgruPnX5rLYIR8T/4thtnxuX5tBTf5tSTWyEsg+JNTBl/+kE3VNPmEa
         JLniGyISmuiLBdtuv9dJQcp1+SJ0nDlDWzXD6vUpPC6QjmyRGyM4GU6uH7ro76pIocbl
         EaNA==
X-Gm-Message-State: AOAM5315RdV2LqgVNOZuYPFU54H7VatNxkrh1q4rVDDWZJ4aP+BxLpEV
        tkaUrjJrVU47F5ldSbG/fjD/f3dEgFLP
X-Google-Smtp-Source: ABdhPJyF7OrMv1xYEcG/jorGg/SWqGIZQxDWyj14o1Adh9xqvhv1QpVb1YhTQvSVuVTMjFZK8Lgr4Q==
X-Received: by 2002:a17:902:6a83:b029:dc:2a2c:6b91 with SMTP id n3-20020a1709026a83b02900dc2a2c6b91mr53667252plk.8.1609849643510;
        Tue, 05 Jan 2021 04:27:23 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:22 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 08/18] ARM: dts: qcom: sdx55: Add Shared memory manager support
Date:   Tue,  5 Jan 2021 17:56:39 +0530
Message-Id: <20210105122649.13581-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smem node to support shared memory manager on SDX55 platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index e48ec7a1971b..622a63b0058f 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -177,6 +177,12 @@ tcsr_mutex: hwlock {
 			#hwlock-cells = <1>;
 		};
 
+		smem {
+			compatible = "qcom,smem";
+			memory-region = <&smem_mem>;
+			hwlocks = <&tcsr_mutex 3>;
+		};
+
 		pdc: interrupt-controller@b210000 {
 			compatible = "qcom,sdx55-pdc", "qcom,pdc";
 			reg = <0x0b210000 0x30000>;
-- 
2.25.1

