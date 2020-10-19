Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0D292289
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 08:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgJSGgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 02:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgJSGgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 02:36:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4ABC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 23:36:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p3so2860739pjd.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=53aD8LnM8EvcZq8Zpynm6G2g3jQJzWqLNRO+Mau56UA=;
        b=V04DCFeRHjki2ZiumN65n5b2//Ug1hHXWswA9ouxj+3CI4XqmRJNMDEvXSd+8yfWmh
         RGIwe6Gwkj2nCJdM1mY3pqMVNUtHtzLpCtRQZyNvf1eaI8o+ilqXiu3LJbsnPzjYUcsb
         JiXtfmAtU7C352ptIBFS7yp8at2rG2mDd0XtgQzpagHb5BdYoL8PNvv4lMth4+4KSzgo
         OBZSd8ECw5/ybYwOtJUOhqoARXLHUoK3IPSrwRYOv2Y/nRGOtUUsMDxr3SfL/A0AL3L8
         CbrNqmbwIQk7+QrbNvYf/0CirXNvZ8zAD5Jm52icesF+8DuEl7GwwdnzdlycY9TACLAd
         iYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=53aD8LnM8EvcZq8Zpynm6G2g3jQJzWqLNRO+Mau56UA=;
        b=pWGWBtRzQLexNu4lWKmfyfFj0K+INTLdiR27asfiPM49qza46GaJYujuE0X76HSHAC
         /6GMFaqQwBHolqDbtyr0w9EJp1R4t2shbX08P0PHRwe7Kq8bs3wvPF5rpMNmK/0INUBM
         ydPthff1HO+OgPUNbxCaMQ7qnbujAzxvLiUjice/IUezaJlK6mugcZ9SNOeEr+hvhQx5
         wSvLNbw/ws1yp+hWiMrW0Dtnp60uh92xG9h6LI5/kfeKItznmMK1j5vCrRqC2yRSzD7D
         CmmRG4gU5waRUEfY8Wi1+HKkbgDH4N9rhD3R+XoSEsKTleL0QKiwo447viYNiC+t0rU7
         2I2A==
X-Gm-Message-State: AOAM531uA91isa1o9O/+fAFnYEMc6Y4E8MWjoy05444JtOUK2C24jXqW
        tKwrW7UkqhDhjOp7CtxsGTe09Q==
X-Google-Smtp-Source: ABdhPJzPcmWZR067emZlhIQl2ucKgT9SoF4z+qf5rA4tvNgOLkRfaOPkJzDm24192j7ykQMtQKOz+A==
X-Received: by 2002:a17:90a:5aa6:: with SMTP id n35mr15623738pji.55.1603089390363;
        Sun, 18 Oct 2020 23:36:30 -0700 (PDT)
Received: from localhost.localdomain ([163.172.76.58])
        by smtp.googlemail.com with ESMTPSA id x1sm10952514pjj.25.2020.10.18.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 23:36:29 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] arm64: dts: allwinner: Pine H64: Enable both RGMII RX/TX delay
Date:   Mon, 19 Oct 2020 06:34:49 +0000
Message-Id: <20201019063449.33316-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay config"),
the network is unusable on PineH64 model A.

This is due to phy-mode incorrectly set to rgmii instead of rgmii-id.

Fixes: 729e1ffcf47e ("arm64: allwinner: h6: add support for the Ethernet on Pine H64")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index af85b2074867..961732c52aa0 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -100,7 +100,7 @@ &ehci3 {
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ext_rgmii_pins>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_gmac_3v3>;
 	allwinner,rx-delay-ps = <200>;
-- 
2.26.2

