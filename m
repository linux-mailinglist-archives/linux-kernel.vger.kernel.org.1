Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB3C2EA7F4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbhAEJsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 04:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbhAEJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 04:48:21 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B293C0617B0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 01:47:11 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 15so20945891pgx.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 01:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BLbdaRxk6oqUg6S4+Ngw1P3UvW0aGkSqUfFk1ISiyXA=;
        b=jWuPEgBYtwaTNm09wCvSMc1IDXGxDAU6TMFvSsKD+tVnGy8Q2DTT+iVIjk/gbO8vqs
         8PsKaNAwwkNyxM3ZhbW7E5uJRcDp2LhEcCGJ5Frd67G/pdF6qGSK6wR4ufsqqxxe/7ME
         1517Sotu0O1ShQuAcphwPm/uAuRHpqCdkO+eo3ja7RUPkKRf41YUchwsZzbaa/f/XFGH
         R8FkM8np5rpoBwF1k7EuHnP0p31YrK3Qyi2d4qofce39IR4FY7C5WEr1pespEzLeRZHe
         IqASpBNPk3zRUDjT5CkZNVwMWny+5iaUdgN/XdzhOEj9ZzzcmVkLFmXn8ZlV61IfUXaw
         ZTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BLbdaRxk6oqUg6S4+Ngw1P3UvW0aGkSqUfFk1ISiyXA=;
        b=EMtx5k3H0U6ShxG7dVWLWV1WCUQ9bB57KrbhFkE1yHghyks2weI58r0Y2h2xv/xI32
         CLI1tzFhgfQd3fW6ZmxZmJkSa/c71wNRzJPgWhR9rt6i/SSeSUHxzG0BjssHvLJygvNg
         k6YAohGpwy1rny3oX7iAP5mI+pP+PJy0ktTrzcuOXW0yZfsFRPUckSPhm+WhYk2l7Cb8
         U9ggP0KZkePMQE0+PYAKeSySPKcU8F6xqE0hmjw4C6LFsvzmv5dB1+fRna+aVijLBcvZ
         5IqB6yxHTqcwokilqxqCs0r1fGUPRu5KAYxsTEL3HteADhK1/lWfKdigiqlKC2SCk5tN
         1b2A==
X-Gm-Message-State: AOAM531wbF64r4BXal+/Il/f+121GDEL3U8hKkDYyRw95ED4hAtcVV/C
        Rs3eXdv3tSPUVorMblP9iqUN
X-Google-Smtp-Source: ABdhPJy9Gz0DyGAIXiaylEtFy9cw5JPSacjeg7XwBVqeAnYrfuyD7Kc3+tEHXL9Z8/z0ds3aFumspg==
X-Received: by 2002:a63:545f:: with SMTP id e31mr75297023pgm.327.1609840030553;
        Tue, 05 Jan 2021 01:47:10 -0800 (PST)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id f64sm60073921pfb.146.2021.01.05.01.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 01:47:10 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/18] ARM: dts: qcom: sdx55: Add Shared memory manager support
Date:   Tue,  5 Jan 2021 15:16:26 +0530
Message-Id: <20210105094636.10301-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
References: <20210105094636.10301-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add smem node to support shared memory manager on SDX55 SoC.

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

