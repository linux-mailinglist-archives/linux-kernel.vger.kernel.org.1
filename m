Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE292F7900
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbhAOMab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbhAOMaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:30:22 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481E2C0617A2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:29:05 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id b19so15217994ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+ObhEAIT9fbovEwiN4T77G8335SbFAVW9ujGpSZ6KQ=;
        b=j6zz31UDqKS8+mz/uvFOZxGx09lqzxksGJlSucJEC306pIAr/tS++aEARxTyTaH+Hd
         XUuUs0eJMu9h+6nbhO3R3g7q8WXN6e9/LR/5RoOQc+IdiFEtT1tTAUlpnxrwo4z6kQ42
         M/j0WVGT//n0hPipDvnW9ADeABfPakasVTbrTtTroRkxku/HjEnk8cIBJ8BHicMgAYHF
         lW4soIHt3COX5JOAO+cKhe3KwPtpCdSbMF+06RITNiOGbHuseTyRc89ZYVaPTIfaCDjZ
         QzyhByhQrQB1NphzUS2MIUfJsy67NAAqja7dEBKS0NQRhiHWFgV8UOKKffnA5Fm0jZbD
         Nv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+ObhEAIT9fbovEwiN4T77G8335SbFAVW9ujGpSZ6KQ=;
        b=kvTKLN3rtNbpt+cTVbMrgudToqKAZdmCstDOVSqrq6wtUxWYQ2mmlF6qaUxwvOguKb
         op3d1nDFXK9gFjTh7uZeAXPXFnjr9GexuHq28COMs2QUlnalxmkzMIpVN2bOZ8smzTzZ
         Q3M0I/rbdmucP2TxXIbpw4OWbIc1Yg99hx/14uc6swJtadUZlmTqwJCF1yqLidTJF1o9
         vEyQ/dpT9iYtH4dZU9wV0coyqHOMZpS1n5fbnutY7MOq/fb8IZyoV82IR2+uLM4dmcNr
         uSVv2yYcQ6nAHWUaXc6/aNjt54Slp64yt1j3eGUB2+sd0Q1JNG9jkzDTPelz/qakg1Sx
         LAqA==
X-Gm-Message-State: AOAM530TFksLONt3JpbqqWeaqOwwXK83mO3Rupa81z0guWA3q7qx5cVk
        /xif6FHk8tUScrtOSbq+1d5KCQ==
X-Google-Smtp-Source: ABdhPJz4k+H5EbE4BC6jKWyuKS4/qK9DyW17Y1VbtDQjIjztsxWWY3DD8dcCwWM8nxwAyr+batzR3w==
X-Received: by 2002:a6b:6f17:: with SMTP id k23mr8495949ioc.147.1610713744655;
        Fri, 15 Jan 2021 04:29:04 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a9sm3828509ion.53.2021.01.15.04.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:29:04 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 4/4] arm64: dts: qcom: sdm845: kill IPA modem-remoteproc property
Date:   Fri, 15 Jan 2021 06:28:55 -0600
Message-Id: <20210115122855.19928-5-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210115122855.19928-1-elder@linaro.org>
References: <20210115122855.19928-1-elder@linaro.org>
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

