Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484232976B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464743AbgJWSQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S370817AbgJWSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:16:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7E1C0613CE;
        Fri, 23 Oct 2020 11:16:34 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 184so3181096lfd.6;
        Fri, 23 Oct 2020 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgzcJanOtbB8ayQ+kiIz5HlevCgPPzDSXuFBsBzfzgw=;
        b=COKoTY6bBNMDEhrNUCwfe0PSeTmqzg6KeKk3FLIWTCs4ABrO5BXgAXkKwSLnrW22d/
         lwc1x7Dc4wInGPDIkJ+UwApBF+YfKGZh22dsUTdb8iwkhr+INFO/xplaW8cYqbz77nmI
         1ttkAvXUlAyVfXHIk0Dj/ZHaO9E2n+RbgaXVSe/sfXY0l8rwpwuLaL9UHgqWhT8qwbK6
         IgKvGM8xhwsCeGHuoeCHpx3ckYdC0w70F60dHE31yg2NijGPbRCUCNcbvReKDao1qHG8
         oN6YEATAmbFJTH51xFNk4Kif2EgbjeEddbWWt4pPPG+HGn+4ZjKDhSNy+uk6mViq7QE9
         rd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jgzcJanOtbB8ayQ+kiIz5HlevCgPPzDSXuFBsBzfzgw=;
        b=DwFkIYey5BN1qqgHf2RJmdC4q0b8vLu7HKoA9m8AZE34yeb4ptWscqyuiN1iPyVZHZ
         HZTEWdizKA8sVwFiLxUbZjM9v+XMEwVRCViF6ookhAvaZZUZnLRAQKHJqM1v1AUCpTSG
         LgrjwKfFTEoPVra5Rm12PtxrZJYTMKLxKZKym/qgZmuFdV8XL6GaNEVnViGIx2xB6tdF
         P5O7M09Jk702VCkCo1hSW9v5XnEs6YK9bbKDGimzoiTMz+Y3Bd9NzWpbe+l3ME/H9oaP
         LYWEEp5LOhsKRWCET849HuoscUn9bl07fMTD8Z0+t4Mq00puxpY78+I3vQYvHPwmK6tm
         3x0g==
X-Gm-Message-State: AOAM532vGFDp1L1fGGURqleIgGFcjZZGJyGL9mwNSnZJevILCL47XGah
        4HgTKtlHedDpLrPAjkBrOxA=
X-Google-Smtp-Source: ABdhPJz6dnqB4MNO7eUYQIREgtgBPqL+k+1Okg6aZvhLKsEVPgt0sNQZQl7/VTyf1vs8OVXchLV/nw==
X-Received: by 2002:a19:408b:: with SMTP id n133mr489667lfa.564.1603476992897;
        Fri, 23 Oct 2020 11:16:32 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a31a:4241:5400:113e:58f9:4c3d:30])
        by smtp.gmail.com with ESMTPSA id r6sm204143lfm.242.2020.10.23.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 11:16:32 -0700 (PDT)
From:   Maciej Matuszczyk <maccraft123mc@gmail.com>
To:     robh+dt@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Maciej Matuszczyk <maccraft123mc@gmail.com>
Subject: [PATCH] Fix poweroff issue on Odroid Go Advance
Date:   Fri, 23 Oct 2020 20:16:29 +0200
Message-Id: <20201023181629.119727-1-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
index 35bd6b904b9c..337681038519 100644
--- a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2.dts
@@ -243,7 +243,6 @@ rk817: pmic@20 {
 		interrupts = <RK_PB2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pmic_int>;
-		rockchip,system-power-controller;
 		wakeup-source;
 		#clock-cells = <1>;
 		clock-output-names = "rk808-clkout1", "xin32k";
-- 
2.28.0

