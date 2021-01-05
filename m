Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8622EAACF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 13:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730262AbhAEM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 07:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbhAEM2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 07:28:49 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA9C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 04:27:46 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id lj6so1590595pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 04:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99rzKTlTSe9qUr5y9f4oV2o3y4JbKLKmKgTDd+AN/bw=;
        b=WVmf9JSz7yJ198Fn3wKNX7a19UhtUQCONzxBdN7hqzYlbcde2FWwPVL3RspvD5voCj
         6WNr0DV1vN61sTcyTUkgL+nxi/m4W5/074YWySI/PCLbNgs/KcL1HZFs0qBILiwT4vS3
         sTd/XgKTGAHkQIHb8Tn0HnEMJATuYaZMsT/szqs/GW0UAMpFD5BO8dh6zmeZ6qtHZ2ia
         JTQaa0hx8Qo2FabiK56lSQZZYwtj3g9r62HcqbIxUjERIwK6T/btWlNCo8tleI3EFark
         WTDxRJvln+hQ6DrodF2L3GY/uV98qZWhk0y7/q3I2Rd7KnRg7xHii79YL+X4EjMxzol3
         hdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99rzKTlTSe9qUr5y9f4oV2o3y4JbKLKmKgTDd+AN/bw=;
        b=jpqJvF1JQbwoBW5DjYK1vD17+zUFBgpOd7cGm5Wlh11CjSQqC446hnt+9ikNbhfHCl
         nkwDGWf8iF33t5yOp3Tdj3lo5AiR0pjZFsrueOlUxLiIy0WavVupZzJ7ctGmDXpVm8L/
         aqEOIPxMQaeFtcyF2gQzneZgB3/N6Vj1CqgTYnXNqKXOsNnLD5mE6fJuqrPcdq6aBFU8
         lnqxyb6TnIW5AJivBFtej+gGlAzuvtMJuS/LYheB/hpNTa4K5kmfemovO0WKHDmTqeG8
         RV8EcKMXXXjH0V9j7vqY34RLlb3ENYrfBxblt8Cx2FzHd8OX0TN7WT4qbvaTMIMaD58T
         3h1A==
X-Gm-Message-State: AOAM533rZ+X5fItxY49g6f3QuETPXBVzt02C0yA+ps7KOvoY7JdXjI6I
        2MhnIMiZ87ovtlqz598OdhVK
X-Google-Smtp-Source: ABdhPJwURrB/isL7UwKJt24kr1Jv5j8BUpTvyXwRvO9qt1UZZCWAUfePI7bNZx5UiB4ABgq0/1ehkw==
X-Received: by 2002:a17:90a:ff03:: with SMTP id ce3mr3826646pjb.44.1609849665677;
        Tue, 05 Jan 2021 04:27:45 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id t22sm64745402pgm.18.2021.01.05.04.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 04:27:45 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 15/18] ARM: dts: qcom: sdx55-mtp: Add pmx55 pmic
Date:   Tue,  5 Jan 2021 17:56:46 +0530
Message-Id: <20210105122649.13581-16-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
References: <20210105122649.13581-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

SDX55-mtp features PMX55 pmic, so include the dts as well

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-mtp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-mtp.dts b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
index 09aeeb14be37..825cc7d0ba18 100644
--- a/arch/arm/boot/dts/qcom-sdx55-mtp.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-mtp.dts
@@ -8,6 +8,7 @@
 
 #include "qcom-sdx55.dtsi"
 #include <arm64/qcom/pm8150b.dtsi>
+#include "qcom-pmx55.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDX55 MTP";
-- 
2.25.1

