Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C949D2AF4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgKKPhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgKKPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:37:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4259C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:37:18 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k7so1157078plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 07:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAPmV9edE4/crH+mmhu7/1610fImDAiNEzW6DR8R1SM=;
        b=lFzNV2BkovmVncb3mvVZHFlLQmmFJaozQ6V9PbjhDzHzu75wP6AxV1jKRNXaH20uNA
         I+QRLibZQXgbSwcayS6tjc5ScPIc/cKc+2fw5MjwzjveXoxnzBBjwysz4gxw7EIygDiu
         X4KsBl61UZVZnbmgDGDUwGZRXCdR7rEBW9Hvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dAPmV9edE4/crH+mmhu7/1610fImDAiNEzW6DR8R1SM=;
        b=DbKuYU/RK82/Zkxqoou2ff5nusMHphPE1NJmAGkzNJEAvDYb3qoVkVnTatIqE9+G0U
         cHOtcpUBhfyLl8jYdghZzpKx2Zop+FNZPejer1migRuI1l2Q1lKxhAA3Dt6CNtonTYjf
         1HrhibmWK//9kjdqZH7zFfPSf1y19AMpJvajkq9gzgV5wYFILTGOHJ0uwRsd9LFuhzcL
         dCRoQHiQnoiXwMHplfIlKmfMYVGs/JqIwOafwCShss1+ueOiaCAKcebLO8vLeeQNk/hW
         hFw3hRV68YjSLHbaT3NLdpZwgZWDhOKzx20rNFYiWbuWf8+Sl4mJOSOqNYW9jU5f/sss
         S27A==
X-Gm-Message-State: AOAM532tHNBaaO0BehoBQUXeXwETjWNAjDnEtllsh4KIoaincfzoIoe7
        mIdDWulCQzoQVPG5JJX/8K6tqQ==
X-Google-Smtp-Source: ABdhPJy8mgsDncieuqZo/EMZLxuVK3XT0SQT2xkfSjn2mJVzlim+pZwZKAD0SXWDCH1v2Ri1jTSKbQ==
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr4677388pjb.172.1605109038207;
        Wed, 11 Nov 2020 07:37:18 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:42b0:34ff:fe3d:58e6])
        by smtp.gmail.com with ESMTPSA id c19sm3005904pfp.1.2020.11.11.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:37:17 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     swboyd@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180: Assign numbers to eMMC and SD
Date:   Wed, 11 Nov 2020 07:37:01 -0800
Message-Id: <20201111073652.1.Ia5bccd9eab7d74ea1ea9a7780e3cdbf662f5a464@changeid>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After many years of struggle, commit fa2d0aa96941 ("mmc: core: Allow
setting slot index via device tree alias") finally allows the use of
aliases to number SD/MMC slots.  Let's do that for sc7180 SoCs so that
if eMMC and SD are both used they have consistent numbers across boots
and kernel changes.

Picking numbers can be tricky.  Do we call these "1" and "2" to match
the name in documentation or "0" and "1" with the assertion that we
should always start at 0 and count up?

While the "start counting at 0" makes sense if there are not already
well-defined numbers for all sd/mmc controllers, in the case of sc7180
there _are_ well defined numbers.  IMO it is less confusing to use
those and match the docs.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4e7e58c63285..625e922c273d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -31,6 +31,8 @@ / {
 	chosen { };
 
 	aliases {
+		mmc1 = &sdhc_1;
+		mmc2 = &sdhc_2;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
-- 
2.29.2.222.g5d2a92d10f8-goog

