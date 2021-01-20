Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2EE2FDF33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbhATXz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732107AbhATVao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:30:44 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3AC0617A0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:18 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so49903077iow.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+ObhEAIT9fbovEwiN4T77G8335SbFAVW9ujGpSZ6KQ=;
        b=zOgOxPUJ16Q/PoqXkcMSKkOIxbJOIHxqmGuxI27ohstOnqAstIRb5z1TcX8C/AhEfP
         +gksQpOvmlWvPZznCZgZHLJ0rtletvG/Jkc6zjcdI2c+nQxqqRB219DRgnXS+GV24cbR
         uOgtE81FXF+XEr+bzemBWO6EAN7z2kY6q1+CPDHnMYNNuKHdnv7aekDy8vYsTbRZcOl8
         uw/Kq3ufTc1nr5WzcgNwo+3Goi3c3qAN5HomyA4l4hvw/Fq3R3NM4w0D7nIkbtcYOLBF
         FnLw+Tqfv2OWeDK23R1Lz0cNYRMVGtPDBBlnixDesILzfyVjiQdJWXr15sguxL9Yutn8
         r0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+ObhEAIT9fbovEwiN4T77G8335SbFAVW9ujGpSZ6KQ=;
        b=cTrZH6MGQS7lkIVTg82L34SYSOs4eNp3fXWeOaA+1hRKKXOfD222YyFG9UezgpljaC
         nddKo36Qq4Oc/DXB2VwpwtxS+LcwNeeMMig1ZjbOKmPclZimtHqm4gCHOvgufwBGYlH+
         Zay6PkvGeCr8+0Lx5uF6Np2nS8H6EJo99W/duhGg9LxeL+gVsZtlvoOsk3r+G5scykx9
         ssbH2pV3MP8o2YKIuPKX3q2UKgSYEXWJ9NMrstCFjrWb2TnusPWaqOt/f4qsMoHs2Mfw
         8igDuPfxT2rdPyDMzwopLrkcFvGQcBO+folkLrjwUvdt/cc2wqT41C3NfhSr8JO6iaqd
         TJ/g==
X-Gm-Message-State: AOAM531leax7cydLjWxheYY1Q8CibGvR+QADYx2jkKhbpNGX5baGcSux
        YLoGDtd9XynqmWEKI8G6MpjZBQ==
X-Google-Smtp-Source: ABdhPJw20X7I18x+BHjvjcZoUNOBxfrASy8fugAAMyqdbBBgZ0myronq4agBgRekMihQO+B5HwcAaQ==
X-Received: by 2002:a02:a997:: with SMTP id q23mr9412883jam.67.1611177976784;
        Wed, 20 Jan 2021 13:26:16 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q196sm1335687iod.27.2021.01.20.13.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:15 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     robh+dt@kernel.org, evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 4/4] arm64: dts: qcom: sdm845: kill IPA modem-remoteproc property
Date:   Wed, 20 Jan 2021 15:26:06 -0600
Message-Id: <20210120212606.12556-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120212606.12556-1-elder@linaro.org>
References: <20210120212606.12556-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "modem-remoteproc" property is no longer required for the IPA
driver, so get rid of it.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index bcf888381f144..04b2490eec9f4 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2366,8 +2366,6 @@
 			qcom,smem-state-names = "ipa-clock-enabled-valid",
 						"ipa-clock-enabled";
 
-			modem-remoteproc = <&mss_pil>;
-
 			status = "disabled";
 		};
 
-- 
2.20.1

