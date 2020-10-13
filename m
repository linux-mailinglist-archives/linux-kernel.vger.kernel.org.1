Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB56D28C9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390660AbgJMIBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390588AbgJMIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:01:32 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E762C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:01:32 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o9so10234885plx.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 01:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PX6utEv95nZrK8Cio4KcHOFe3eh1+n1xQTOKgWru7Q8=;
        b=Yq/nvpaQ5Hpx/VK+3t8sVeKV8lzlwCiDy9N4+pw8gUCZpI3XS9cL9KwWtSFkhWhisR
         LGmwRdWOc8I/GXFP/OoRfZ5q2niv7Jht6WP1s7Niv6VRkxKqD+4GSHYXr/EGk+DgX4ts
         Psnki/01Xl8AnE4gxxe2SnN1XiYtoSXrDxcqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PX6utEv95nZrK8Cio4KcHOFe3eh1+n1xQTOKgWru7Q8=;
        b=C9Aag5JL+di9S9PO75xEolcEW/r9kOFjHKXC+imqN8Ah1SAQGW1k+nHLaaqtoxtCD9
         PDq7QPEUmuSmNhSKrEVsuLmZNYgl+eguivtLEP5cCvNdj+1F88FM+WImaADrbTxwdUdz
         tRCRn56un0M35RBA+90R3P5lbjR9/jF9CtXpOk6BHleSTlfNrnxvisORR9B42SQjICE5
         wbJzcBBE6kJ17X3C/g/GHpm99i/kE+dm2GXm964dC6TLIU4Yn0MVLVCfbhgv2gOtQvst
         37F2cwZJsxYe1oQhTMoN3ltOcIR6vNbSYA4NxLJtDqAXDPd+rMmMkrIMwbMK2hvMNfa8
         KM5w==
X-Gm-Message-State: AOAM530kSr89MFSesfEE2B5k+ldiqxGI8X6cIi5KhRmsSphnccnBXrjh
        68/Oyy3bpevf/AYrbYA/YFZdcQ==
X-Google-Smtp-Source: ABdhPJwy8G+WoGa8xfqN7S2NUeVNZqaFQcnZEV3UAVpca7MBw+WNfz5pRUiBOuT/fqofn7wEFblptA==
X-Received: by 2002:a17:90a:160f:: with SMTP id n15mr24051942pja.75.1602576092037;
        Tue, 13 Oct 2020 01:01:32 -0700 (PDT)
Received: from alex-desktop.lan (c-73-63-253-164.hsd1.ca.comcast.net. [73.63.253.164])
        by smtp.gmail.com with ESMTPSA id y124sm14956924pfy.28.2020.10.13.01.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 01:01:31 -0700 (PDT)
From:   Alexandru Stan <amstan@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/3] ARM: dts: rockchip: veyron: Remove 0 point from brightness-levels
Date:   Tue, 13 Oct 2020 01:01:02 -0700
Message-Id: <20201013010056.v2.2.I96b8d872ec51171f19274e43e96cadc092881271@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013080103.410133-1-amstan@chromium.org>
References: <20201013080103.410133-1-amstan@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the "PWM backlight interpolation adjustments" patches, the
backlight interpolation works a little differently. The way these
dts files were working before was relying on a bug (IMHO).

Remove the 0-3 range since otherwise we would have a 252 long
interpolation that would slowly go between 0 and 3, looking really bad
in userspace.

We don't need the 0% point, userspace seems to handle this just fine
because it uses the bl_power property to turn off the display.

Signed-off-by: Alexandru Stan <amstan@chromium.org>
---

 arch/arm/boot/dts/rk3288-veyron-jaq.dts    | 2 +-
 arch/arm/boot/dts/rk3288-veyron-minnie.dts | 2 +-
 arch/arm/boot/dts/rk3288-veyron-tiger.dts  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-veyron-jaq.dts b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
index af77ab20586d..4a148cf1defc 100644
--- a/arch/arm/boot/dts/rk3288-veyron-jaq.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-jaq.dts
@@ -20,7 +20,7 @@ / {
 
 &backlight {
 	/* Jaq panel PWM must be >= 3%, so start non-zero brightness at 8 */
-	brightness-levels = <0 8 255>;
+	brightness-levels = <8 255>;
 	num-interpolated-steps = <247>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-minnie.dts b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
index f8b69e0a16a0..82fc6fba9999 100644
--- a/arch/arm/boot/dts/rk3288-veyron-minnie.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-minnie.dts
@@ -39,7 +39,7 @@ volum_up {
 
 &backlight {
 	/* Minnie panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <0 3 255>;
+	brightness-levels = <3 255>;
 	num-interpolated-steps = <252>;
 };
 
diff --git a/arch/arm/boot/dts/rk3288-veyron-tiger.dts b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
index 069f0c2c1fdf..52a84cbe7a90 100644
--- a/arch/arm/boot/dts/rk3288-veyron-tiger.dts
+++ b/arch/arm/boot/dts/rk3288-veyron-tiger.dts
@@ -23,7 +23,7 @@ / {
 
 &backlight {
 	/* Tiger panel PWM must be >= 1%, so start non-zero brightness at 3 */
-	brightness-levels = <0 3 255>;
+	brightness-levels = <3 255>;
 	num-interpolated-steps = <252>;
 };
 
-- 
2.28.0

