Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451521B8675
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Apr 2020 14:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYMX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Apr 2020 08:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbgDYMXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:23:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C294C09B04B;
        Sat, 25 Apr 2020 05:23:54 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d15so13089548wrx.3;
        Sat, 25 Apr 2020 05:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dAhthcMUJWS2ryatnNvAlRrirnhiWLRrICwYDcnU0fU=;
        b=OgS4LoLMviUc9jZmo5CSUiyC5d06/R2NSa9J963Y+HkIKq5+pRtOFC/HoVz26io9Gm
         XXEVsl7fFl/F7kmcMCLu3KXY9ShPMruVjZjopmR0FyVRKHbr1lqueJQh3uRuVbp83ZlH
         nkKTRBggeC/ln0K4h8BKr9S1OqKBlA6gAZpT3YmB1krU5g86L3BAEBaXOs7W0jhMB6SP
         QnqEOsp0MEvIJwliL4bprN0KQInkKwK9VTBETZkEQzMhHo34BTbHvzsmEfo2I3SheNDc
         GG2jBRVjLRdtxGx0z4ehEiMMgXHSZjwDRwMTQxzzTy2EwYA9nfihxRbvEpXHZFa/IhdN
         xurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dAhthcMUJWS2ryatnNvAlRrirnhiWLRrICwYDcnU0fU=;
        b=W0JtlLQ/AHpEa4F0qXoCsNt0GLa/FgAFesWgnPE9XC0rxqtS2Cnm/Gr2yq3lkp5CAK
         CLxphDYpe6jXUeXpfOv/a5RsadYZxJZMN5+BV2Psu52qG+LQxFEMrKXjQ5knsdl64tuO
         aHWwIylXQjGmi8nGKg1u/vI1BU1u715MwyQm4gnyOpElvO9Ut7N5pSUBS/l2tjCd7QR+
         TnVQPS40Yub3CqsVYjh1oF/3MlbTgpozLNGnrRAk6/1PxBWdoOcM9L/oGgmH7bIxUFiH
         qqaetMu8RpYf+TbSTHLYEbU6JHiE42HyIw5IRGFyFaLUbMag+b2bnwOMzTDebvD7pO3R
         1BFg==
X-Gm-Message-State: AGi0PuZ+AJgr5G/azoWkFoUSpsGONsR36LlIJkFPHC5qzubd4H3Gg6xF
        co+WqQ/2zgzA5Q30sZnureHB2IqV
X-Google-Smtp-Source: APiQypKQLmemHLqJ6Pk25SKVqUP6thUl0EKreCGpgy8kTT3VtJXfWo6ASj6ee9VF9buJyhEACMw7AA==
X-Received: by 2002:a5d:408d:: with SMTP id o13mr18100044wrp.249.1587817433437;
        Sat, 25 Apr 2020 05:23:53 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id o6sm3248461wrw.63.2020.04.25.05.23.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 05:23:52 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: rockchip: fix status for &gmac2phy in rk3328-evb.dts
Date:   Sat, 25 Apr 2020 14:23:45 +0200
Message-Id: <20200425122345.12902-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200425122345.12902-1-jbx6244@gmail.com>
References: <20200425122345.12902-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status was removed of the '&gmac2phy' node with the apply
of a patch long time ago, so fix status for '&gmac2phy'
in 'rk3328-evb.dts'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index ab69b493d..ceba9f8d1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -85,7 +85,7 @@
 	assigned-clock-rate = <50000000>;
 	assigned-clocks = <&cru SCLK_MAC2PHY>;
 	assigned-clock-parents = <&cru SCLK_MAC2PHY_SRC>;
-
+	status = "okay";
 };
 
 &i2c1 {
-- 
2.11.0

