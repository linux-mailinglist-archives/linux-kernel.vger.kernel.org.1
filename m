Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57BB2535CB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 19:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHZRMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 13:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHZRMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:12:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47719C061574;
        Wed, 26 Aug 2020 10:12:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h2so1191154plr.0;
        Wed, 26 Aug 2020 10:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=foFtRttkojftmX4pY4pyI5q5jMC4/A1XtpwKxw5ra3U=;
        b=RabYfrQO/VyKQRW/Ewp/P9Hi4+pn7atkXUXjA6FN1k8Oe0Qq80gdJEVUFrzd4xZmId
         /n9qNtjOlRi2ToCO+guN4FSSOFrOU9UK17ByWhxJ/cY7JONFPt/jvV5/MG3Jy5NX4sOp
         313dduRI+Az6ws9TFXSVOOS5mSYEbOp+3cjC8QnfN8xwkrvx+3wERHsF6VPw2J0Hqycy
         gc0KnYEzTvVy4BSuwbiPj1kevPL/cvpieZckDqVNwPg3qDrfCoL5fvbM8HH9ZXD7Plj0
         hACH64k/1qPw2iW2DFrO9IsAS2AIpIn0XhvKrVSpGxgnaemlI+3NsIVROU2v5XG3bAsr
         dgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=foFtRttkojftmX4pY4pyI5q5jMC4/A1XtpwKxw5ra3U=;
        b=dNlciVGAa7uLuQokpJnDXcJ5OGmd5cOAC7HLF0rCb0283B9jZZqe653Xptz2NduwEx
         2kCGBfs19BjDeJrYBsWSY4L7qFhP3fWoR7iueBy51YEpW8jN4L3p7cMFgXnIohyJrDdn
         xKnErAdlWFX4Ly3XuYE274gx8Z/Y7r+qB99PXaLLrBorHBqdnBVi3XEyAPdu8pd4m/tM
         ckSxe1OvUPzxc7YKvWafOiMVNmm4RyJeLU2bOVmSduiQXJQfLv4JsZnNmOiWHbSSORqB
         SERLnrDj6D1WWC4xz32sMp3vZTlWCmaV05maDu0nCdxB1/OA3EmCxiuGF2scxMyQV86R
         tDDQ==
X-Gm-Message-State: AOAM533LQOAvVemvOqPVc3Lb31uyEA90NaT65pc4zEx4g5XiTSM4t/Tj
        AuwZCSC22jPEIdlzI1UWVEez32HDsLs=
X-Google-Smtp-Source: ABdhPJzkPfG8CS5m+0FMlo14AoxxxwmRlGR9ERwxyG1rptAqQXc7gSAS3CfJKXeT1cxGTQ6TYM5wGg==
X-Received: by 2002:a17:90a:d594:: with SMTP id v20mr7273635pju.227.1598461960747;
        Wed, 26 Aug 2020 10:12:40 -0700 (PDT)
Received: from localhost.localdomain (cpe-172-112-234-200.socal.res.rr.com. [172.112.234.200])
        by smtp.gmail.com with ESMTPSA id z10sm1957870pjt.30.2020.08.26.10.12.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:12:40 -0700 (PDT)
From:   lindsey.stanpoor@gmail.com
To:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org, heiko@sntech.de,
        balbi@kernel.org, cnemo@tutanota.com
Subject: [PATCH 4/4] arm64: dts: rockchip: enable rk3328-rock64 usb3 nodes
Date:   Wed, 26 Aug 2020 10:12:30 -0700
Message-Id: <20200826171230.17041-2-lindsey.stanpoor@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826171230.17041-1-lindsey.stanpoor@gmail.com>
References: <20200826170623.15469-1-travelvia@airmail.cc>
 <20200826171230.17041-1-lindsey.stanpoor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cameron Nemo <cnemo@tutanota.com>

Enable USB3 nodes for the rk3328-based PINE Rock64 board.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index 86cfb5c50a94..82c27eab6a52 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -363,10 +363,6 @@ &tsadc {
 	status = "okay";
 };
 
-&uart2 {
-	status = "okay";
-};
-
 &u2phy {
 	status = "okay";
 
@@ -379,11 +375,24 @@ u2phy_otg: otg-port {
 	};
 };
 
+&uart2 {
+	status = "okay";
+};
+
 &usb20_otg {
 	dr_mode = "host";
 	status = "okay";
 };
 
+&usbdrd3 {
+	status = "okay";
+};
+
+&usbdrd_dwc3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.28.0

