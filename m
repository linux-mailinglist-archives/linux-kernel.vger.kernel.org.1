Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45F129189D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgJRRYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:24:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E515C061755;
        Sun, 18 Oct 2020 10:24:16 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n15so8834942wrq.2;
        Sun, 18 Oct 2020 10:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLdfSAR0LwOOtqwUC8udPXOOYAtdKU3B5mmLxtalmVY=;
        b=jTzRpx++WPceEK9RoYdLVnjHAf4Oy/71STRL4VcaJ7/IHjbAURWV3bnpeoIex3mwYu
         ho8AV7D6wJ8GYaiN2dzi8PHwkk8voiaoUjdGMJYlxBo+mW5y1DKbHOrC51LR5WyhSlON
         S4LAndxXEQvWVr3PaYSt3suUrmrIsgU2mVF15hPp9OixdPjM9TbL4iKru0ovwV92ZJ6w
         QrdlPFCI0U8r9Rke5iubYvcRHO8wEAs2zc6cYZjrMTYHsXUKA++I3CANF+P7VlgtgUg1
         2uHCq3BbtnBPMS9mu7G1ZSpcTcXFRP2nwyRWLvbqwpjgl7xhgHZ0qhAQC8DHnfBjL5h/
         ID7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mLdfSAR0LwOOtqwUC8udPXOOYAtdKU3B5mmLxtalmVY=;
        b=GABDbMr+UF/ElLmNmh9c6o4glEuUDCboppt3di+t70ZJEDAA6OoAC7pQU9WUJbsvbg
         p+1nX5L66K7TvJPLtkOwqnLk6BJJK4j/uKYku83Sz7tXm4UtlBhMm6zQVOWaBnwKC8MU
         v6Ic14bAuCcaDl3mzfhvMTwIq9mo3jENG+RsT6yTyixh/xO7gdKs7JHQZH/hzU5RQNpn
         SMJdJBban9ZFy/jNLnaZ/q1TaELFLILLeCpP0fYBRWLIzdbMfWJr6Zlo5YHPCPdtc3iY
         YsYfoM3fGrddW+l2PlFodsQjfK6Utj/mCPuuM5B0hUZSsLJzNuWlsPuJSl7HadwUja9w
         vALA==
X-Gm-Message-State: AOAM530y6G8Ed8iqhD0+/c21I3+/ivh5F3lVfv+eDP08jJnygix7dajL
        cJ31OM744GH84tUwAFeUr5U=
X-Google-Smtp-Source: ABdhPJzqeAG7+AstLsB9Ivo+7f37ckUYlHOxLO7uMV0wguDsRO7FcNYu7MRIF0rSl2Ot7PEoUNV8MQ==
X-Received: by 2002:adf:f1cd:: with SMTP id z13mr15757991wro.197.1603041855000;
        Sun, 18 Oct 2020 10:24:15 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q7sm9697505wrr.39.2020.10.18.10.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 10:24:14 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: allwinner: beelink-gs1: Enable both RGMII RX/TX delay
Date:   Sun, 18 Oct 2020 19:24:09 +0200
Message-Id: <20201018172409.1754775-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before the commit:
net: phy: realtek: fix rtl8211e rx/tx delay config

The software overwrite for RX/TX delays of the RTL8211e were not
working properly and the Beelink GS1 had both RX/TX delay of RGMII
interface set using pull-up on the TXDLY and RXDLY pins.

Now that these delays are working properly they overwrite the HW
config and set this to 'rgmii' meaning no delay on both RX/TX.
This makes the ethernet of this board not working anymore.

Set the phy-mode to 'rgmii-id' meaning RGMII with RX/TX delays
in the device-tree to keep the correct configuration.

Fixes: 089bee8dd119 ("arm64: dts: allwinner: h6: Introduce Beelink GS1 board")
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index a364cb4e5b3f..6ab53860e447 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -99,7 +99,7 @@ &ehci0 {
 &emac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ext_rgmii_pins>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&ext_rgmii_phy>;
 	phy-supply = <&reg_aldo2>;
 	status = "okay";
-- 
2.25.1

