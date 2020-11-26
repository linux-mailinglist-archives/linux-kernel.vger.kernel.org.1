Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE02C4F85
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgKZH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729701AbgKZH3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:29:50 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20717C061A04
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:50 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id t8so858305pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrIF8npwlrqxLr6Igah5Ek/omJmCk/eZLSe1ULAbqaY=;
        b=vwjnecL7+HRvNcp2/QtOXgiS5f1StvfUiYod01dCOQllzXdtF9MY2EUZdSOnOd0zjg
         rcyRDx080Fua0RfOcotAkNLHVETyneFv5Z4d2HiA48uJ46O09h5uJjkFPb4NvY5rsjoG
         r15qsySIVo6wFxU/ZGZQ60SRKayEup6ZBr5J91mBimojS6VMXJmJWvor8lViSrW//ukZ
         jKWtC1LLR+XrssnKeYTbKao98VHkmCCmVS0Mocb6jVtlnUqQkRG+CYnrsTcmfBoJ3ics
         m37I0olDtj15mp9oW6G9/nROfyL9YA/G1a2cSZP46W6K4+iMMxTugZa66smHM+y1U33K
         frzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrIF8npwlrqxLr6Igah5Ek/omJmCk/eZLSe1ULAbqaY=;
        b=Mozve4pw+FM1EAtnwM8kQUW9Sjmcubdu4c4iGH6UvvjQiSQvIQWstBlot87aLmlRCm
         nW1dB8IQGtD9ym2GOQ1g8Na6+hiVYwvPThOZOyhrhRmDMjK9tJjgznR5pVhdIds3WGXp
         QXgSAXf/KM4K6CCSuUYKN6f1JnaD76dJIrrFLmZPHsWCtk2oLKwUr/zo3L3r+JWdSlMK
         fDQkSt8kTMEWDaUDSLYKEE118GgBELLPLH5bnGTrn1XMFyOFBkzEKKru6GafTmKQRIV2
         wAujGRNRSGU+kakT2fnk4J5L7qTYOOxnUKBTr9wdQsXMyFAOBabUtgXO4/3Nh6zQky4e
         pWgA==
X-Gm-Message-State: AOAM530gODMg5eWzTsTZ4T5NRsaaa7KSj+t9t2g9KvHl8g2e+japb8Hs
        39LvSyYZwEDoZx+aKQDKSjqM
X-Google-Smtp-Source: ABdhPJxnW6Di3Yy8aHSj3rGQbdFEbp6WxXhA9CofeXAnnQgscmsA6ITioMijAb8veJ08ST2oH7Ghjw==
X-Received: by 2002:a17:90a:4a0f:: with SMTP id e15mr2162901pjh.182.1606375789668;
        Wed, 25 Nov 2020 23:29:49 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6e95:f2a:3996:9d7f:e389:7f7d])
        by smtp.gmail.com with ESMTPSA id t9sm5508097pjq.46.2020.11.25.23.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:29:49 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v4 5/6] dt-bindings: clock: Add GDSC in SDX55 GCC
Date:   Thu, 26 Nov 2020 12:58:43 +0530
Message-Id: <20201126072844.35370-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
References: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GDSC instances in SDX55 GCC block.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sdx55.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-sdx55.h b/include/dt-bindings/clock/qcom,gcc-sdx55.h
index c372451b3461..fb9a5942f793 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdx55.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdx55.h
@@ -109,4 +109,9 @@
 #define GCC_USB3PHY_PHY_BCR					13
 #define GCC_USB_PHY_CFG_AHB2PHY_BCR				14
 
+/* GCC power domains */
+#define USB30_GDSC						0
+#define PCIE_GDSC						1
+#define EMAC_GDSC						2
+
 #endif
-- 
2.25.1

