Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB022FA53E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406063AbhARPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405846AbhARPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:53:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A739BC061575;
        Mon, 18 Jan 2021 07:52:51 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id ox12so47063ejb.2;
        Mon, 18 Jan 2021 07:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bpv56niFjct5w6LbQ/DkAciW7isXZ8qi5X4Zeb1XX6Y=;
        b=IpHuRpIFuVFujFy5t9HcQNNG/7HGMeq6IPbI118FOlbOKiCNMUiYo2EB6e6iYuNUc5
         HCUQxQ+WRrk53KVYiL4yppa4qgCeXzBL8MGLTJxVGJjb4xfX7ltqH0amF6XFEoGwpWnr
         PGRHHG6nAyJVt2jaoetXvuouBCxixHdEgMDb0XsrGTIAxGXdRb1KCGzFGo8j782DB5nP
         6Ze7+LnRqdpI9Jo2ffadmsFIgCMS6CfS5X7GYBqVJxCJEA5RohPA/Y2DFRHBTfAwLUol
         wara7zYTapg8myTlm3FvRskfjWAqxqaXH+RF25woqIl2fogZQIujkm+uEMDuWdAD6UAk
         sDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bpv56niFjct5w6LbQ/DkAciW7isXZ8qi5X4Zeb1XX6Y=;
        b=bmBW+xGg0K2bJYa9yDQfGhud3+/vzBiA0C8Y3bx6PWQqY+Eo+H9twANuCBZj7g+ope
         zi/kDOmGhZhIqjc7CmLY/mp+brOqnfp5wety0ogaRJqQrb45ILx76Fc71o2tYpSAAbs3
         ns+tM1nhK1PQ85bnFMDFKIPjri/MOybvvN8Bp38Igrb4KbS+4Ol8+hIzOBAZH8gJWJhm
         NQHcainBgwzc+oWFj2WHVsUGjIVxNSVaL1NXFYCM7q2ub0smBt8iMgjnxEEk4a0tpwKM
         yz+P/tjxroJSjwrBAoSA28JN3RtaiEGG4hqSulAWYW4iL01ApVXilsZGyjGUaE9jInpW
         MPiA==
X-Gm-Message-State: AOAM531KVROvBoZziC7XiA9PrQ7zFXckrFXO8rYxU0q1hXDPdxmkGMJB
        DTt+z4TrkKorMLXdFVqaLAY=
X-Google-Smtp-Source: ABdhPJzCkES0uIah85lOrhLCxqlNpN6TfPMxHwPwGpmokPHpCfuVQ2ublkAr1ApqwXEQh+RWsmLlgA==
X-Received: by 2002:a17:906:59a:: with SMTP id 26mr206706ejn.309.1610985170471;
        Mon, 18 Jan 2021 07:52:50 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id f13sm9561694ejf.42.2021.01.18.07.52.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 07:52:49 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ARM: dts: rockchip: assign a fixed index to mmc devices on rk322x boards
Date:   Mon, 18 Jan 2021 16:52:38 +0100
Message-Id: <20210118155242.7172-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced async probe on mmc devices can shuffle block IDs.
Pin them to fixed values to ease booting in environments where UUIDs are
not practical. Use newly introduced aliases for mmcblk devices from [1].
The sort order is based on reg address.

[1] https://patchwork.kernel.org/patch/11747669/

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 9910f9b5c..f10c4d2fa 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -14,6 +14,9 @@
 	interrupt-parent = <&gic>;
 
 	aliases {
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

