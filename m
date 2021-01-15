Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4D2F78FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbhAOMaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732005AbhAOMaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:30:21 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADF1C06179F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:29:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y19so17769379iov.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=KlBHmLnqBTnK5J4DO27zadgPE02VDPajn5Xg/cG0Avp0kSMoBuas/f4gBKy6oYikjv
         eHMZ+mouCClKU0+QunG7Zrjbi/sGQ1MjvHhG2GHCJWNkRVYW/GTjc3FRXlCXRKAl5AlD
         MrGSX9n0S4lZFaCeasXFtcC/Vr+efZCJqGH9hSQKtv7gB2MwsF9ZsfeUF7k6tYce9ttE
         sROYyXbJf8wI7YD628/UzChvd6ivXvTPFcDM5BiPpBMg2FFg/vVqGsxfhsgYBBXicnw5
         aJnjob7RO7vZLcSrSO9IPRkzuyAP5GVEIrcPPDLQKEBr1BTzE3w/1Ei51hzx0eoGlT6s
         5F0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZgcJCeO5IRSICza2r6GEj0/QJ8rNtZfDDcOXMnAT21Y=;
        b=TJA3KwcDuEO13ljrGIZ9bl4LJgjMKTlEBS4oGDb+pZJhRPVpqJj73andzPRafoI66B
         yLmir2NWzQddGk20b21EQQxCu/sa06u3LVjByDQhuzKppCamHXbY2IsU7xmkjON4LNMn
         gFnhZI/isDysFrx0v2vstAhaiCn0/zzkSXX2SGTen/dVxnOUKN8OyhRlV90PUHQ4lqIe
         Givkw9MyzYB4IZF4lCNIaPFfMhgBbBKvHd8u5BNVtPaKdsB+jyAWEx1mBWDqpwXBKfrl
         GIIW6ts3tU2XHZD9nSdcYV9I/Pb53mg0XW5oFG8i7h9dE7pEouoYN7hcaLbJIljEcVuc
         ArOA==
X-Gm-Message-State: AOAM533+Mt5chGcq/AelL7EBcLth6N0Ii+S4twoaMpRVG/f13QW3/L8x
        D4lyrGnb6RF/lx/EKexyqNfCwQ==
X-Google-Smtp-Source: ABdhPJz1xDn2LWVaVJ8b+MHU6nw6XSrUBGZCU+K1D+osCjh8vAx4TY14eoXtbjzSaYSWT3Y4tk8i3A==
X-Received: by 2002:a5d:9418:: with SMTP id v24mr8176550ion.61.1610713743450;
        Fri, 15 Jan 2021 04:29:03 -0800 (PST)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id a9sm3828509ion.53.2021.01.15.04.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:29:02 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, bjorn.andersson@linaro.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 3/4] arm64: dts: qcom: sc7180: kill IPA modem-remoteproc property
Date:   Fri, 15 Jan 2021 06:28:54 -0600
Message-Id: <20210115122855.19928-4-elder@linaro.org>
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

