Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B36E2FDF48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404382AbhATXyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 18:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbhATVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 16:30:19 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8D3C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:16 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q1so49814352ion.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=laOq+sY8LdhQ82MV1OE2k34/xvmxGGN8PYlZcP/QlnQd36aPaJL0QwY6yrkwtxZsCG
         AxO8a7SKnSFX6L3IDCUyZSeU29af28mcRdXZeBaDanpsvywcLg6uhJuFs1SCEmm7pDq/
         PmlZuq+fvsBCSSMfV0Lqzk+P6TDZrGHWm6/rHAVtxwicLhPHz1ts5+Ln3upe9F/eTJoR
         l8xNILxBwBTJYQH7gLYUCNlu4ENvip5fBJGVt34ijeCSf7IhrSynpli/uhfWVZ3FrqVE
         7wMylBzj2Yg3sliX8JK0g3RSsBklNNot5FgTptKsiKbcZWWmp09TgTYsohXaHQgUJj6V
         LvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=Mhhb+B4NMhRbGmy2WfUihGJ2V9CRvn1dy+Ba5mVGmitCWocTCMp0c9qvh/UkJ9tynW
         q+PJzAEyHb5H0w9313ya5LJ0m5VWzrEMUoCioZUirGqjlTwFtJgaoc6pNwgbza9jWyP2
         aPTsqqdyc4gUg6t9jvXvpbU2DluKAtH8XUszjVNwJt5VSRwe8KsJJUaVl5BUZJ4A1TUW
         FEGFLvIha6XwJObFPRNXKEbDZFA4R325hAfwkxhGMBT0RKC+oCiYaQvwzxCkYefakwU1
         Fq08nnp9dMisSdPJo3tkpEgWyEncEVbrzWb7HX7krUljiIGq7CzVOIWCAUrAqKgdsT3i
         piRg==
X-Gm-Message-State: AOAM530/AXoPv0XIfpgHI6p5azvbhmVA73bnN+FS+Pe/ovSikeO1G/b4
        Waa9yw9+24qdlsCR183n6HS1Cg==
X-Google-Smtp-Source: ABdhPJxJj4nC6zIao/ax3tDl6ctcokGZcYWqetq/RRwKiBH/F8BiV38BeQQYHbVK6AY3DnZtx2DY3w==
X-Received: by 2002:a92:5e11:: with SMTP id s17mr9482916ilb.23.1611177975159;
        Wed, 20 Jan 2021 13:26:15 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id q196sm1335687iod.27.2021.01.20.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:26:14 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Cc:     robh+dt@kernel.org, evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, rdunlap@infradead.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 net-next 3/4] arm64: dts: qcom: sc7180: kill IPA modem-remoteproc property
Date:   Wed, 20 Jan 2021 15:26:05 -0600
Message-Id: <20210120212606.12556-4-elder@linaro.org>
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

