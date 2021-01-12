Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6132E2F3A72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 20:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406893AbhALT3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 14:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406872AbhALT3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 14:29:21 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD2DC0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:41 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id q1so6469410ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=x+zr29usZZQIbS2asOmKyiSxbO7mFhmTFZ2dthGh2JMlxCYoFiM3ePy1GTpJmWrAZB
         PBB+vrKfko/Icku/ULr4vAt5wPH83XNS6kXIFnz5pWlBBeI1DeiXqMw6idzdWTXfAApU
         dHbAhFV0RGikv9uADhBu7C2CCBaXm3ysriC3MQ/gfxjrJ42C0VWrUJEm5JJWs7YUI0Au
         AdqH8wMtIQyTqh8O2poHpSO4eiBr2184s5SzvMTs7rx4m8Z9aPPKWpPkYE5+yBwHrkEQ
         HIXe/nh6E7yjCEMOMtFfcedK7Tfqw1lW2sjh4q0yV5eFH2Y9g7NfTOwFjIWgDe744YNX
         cjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=nQ/LhtHL0HFS8GIqfPFL+gL5H2sF7GE6CtiqKEMUboDuvDngnw/eVRUBMcd7k+v2r6
         pspdEg9UDs4m41l4E7w55G2F+RUDKeyLClDnRSuns6zS+motJpc2NyD+8ngY3pq/MFud
         JO6+eJjpF+c6bt6HMin7RMiqVhAPSJfdwBrHDMgbe9Od1AI3gK5/QlxUsF3OjcHFvgyD
         vAv9IYvywE3zkuXEBHiFja8qOX7bMAhdfmBo5pCj5XRYqUu5PZRo/WvPPNBxea0B1GPm
         sY20FnqWclooMuGQil68TchzhQH7QxxJ3lQ0jBrgCaJmzyZdNNGBYmt58w4CNQ4Rkdx1
         4sng==
X-Gm-Message-State: AOAM531xcZoV32ex5hTKW3OaurV7/uEWvY0dxqhnr2VzBuopTm4wncHn
        dNQ4tfvB38mbwicuQxLc2Kl+qg==
X-Google-Smtp-Source: ABdhPJyyBSq3daVP41fcs1eGhpefB7YcnOnG8hbumFF8S2m1UNbJk49d27EQXxWb+Foa+W6C0FbctA==
X-Received: by 2002:a92:dc4a:: with SMTP id x10mr574601ilq.153.1610479720967;
        Tue, 12 Jan 2021 11:28:40 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q5sm3191892ilg.62.2021.01.12.11.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 11:28:40 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/4] arm64: dts: qcom: sc7180: kill IPA modem-remoteproc property
Date:   Tue, 12 Jan 2021 13:28:30 -0600
Message-Id: <20210112192831.686-4-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210112192831.686-1-elder@linaro.org>
References: <20210112192831.686-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "modem-remoteproc" property is no longer required for the IPA
driver, so get rid of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 22b832fc62e3d..003309f0d3e18 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -1434,8 +1434,6 @@
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
 						"ipa-clock-enabled";
 
-			modem-remoteproc = <&remoteproc_mpss>;
-
 			status = "disabled";
 		};
 
-- 
2.20.1

