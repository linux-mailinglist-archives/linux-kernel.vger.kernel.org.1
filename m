Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F5C1B7AD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgDXP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 11:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgDXP4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:56:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31316C09B046;
        Fri, 24 Apr 2020 08:56:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so2492531wmj.3;
        Fri, 24 Apr 2020 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2dfe96YGRwdkJIStyF40QT5+e8yw/JJFrPUrA9ri3jw=;
        b=rpnKX0diuZmEefFJBlH4p0uiZ6nT/Uzyd6C8V+ar2sPq3giyBG+MSqmgtQqykf61K3
         J8s8b6qq9CHsb7VZ+hAgBPpNw0N29/Dx0xZX8yrxDlEymZtAMd0jgz7kR9P09TORmBhC
         TTLx7LLxBi0/qCjROKIvm7dtrRFClB6x/emlo+op9lkWO+yvfjxN1P3ho2PJ25atistF
         3OfY3NIrXmYYuxtFfPxwJV6jy/6mJcjHqBZCamamz/gUOG9Jcuu1cEy5zcTMYCgtpQY3
         eUhzOQdnUt3slZLmWzgh6lJO+UFYWZL2T1F7x+/XI6xSt4/tJvebLm+Z9yAdJn0077jd
         58EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2dfe96YGRwdkJIStyF40QT5+e8yw/JJFrPUrA9ri3jw=;
        b=LSAsAazEf6X/VbNPknm2QSwQOkHWtARmR1Ykd2lxvocw9zLD4xrBhetdOVNTt9ADqr
         DfbjVKZhHn/n3FuImTW+jPCG+k4JWnl9SQ8HmHBxzwQaMj50Ma2Aqc7KayWz7Ct08xf2
         05RiGA5ilKYIurpHrBz+wa+tyOMfX1DtyLRCpGn+jWGtq2T8jtGT3QsCqOE8XDjx5oy+
         XdB3pkS5JUfOCXJTNT52oULRQLO3xyXmvg4kY67B/VnF0ZF2qm0xmKbrc1f8vJxOFf64
         OLhwK5TYVdcrwAW9iOkWSDv1ra8HTYeYVm0JvtZTvpLsWAcuk5bajH+62188nl3vRxe8
         bwLg==
X-Gm-Message-State: AGi0PuZGoZAHu+91gFb20l1+uaGIcvmjqFoFOWfZ0ClYPXDMUCKtAP/s
        sUauNRPCpuN/uBLufMkt/jc=
X-Google-Smtp-Source: APiQypI/huoG9jnHh4iIH+SQGJJR1gdn4nDg2DnrOfJ4docI19S96D0R3OPHztWOl24tnzb8TeUURw==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr11008806wme.33.1587743768021;
        Fri, 24 Apr 2020 08:56:08 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g69sm3554317wmg.17.2020.04.24.08.56.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 08:56:07 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: rockchip: remove #sound-dai-cells from &i2s1 node of rk3399-pinebook-pro.dts
Date:   Fri, 24 Apr 2020 17:55:59 +0200
Message-Id: <20200424155600.24254-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '#sound-dai-cells' property is already defined in rk3399.dtsi
at the 'i2s1' node, so remove it from the '&i2s1' node in
'rk3399-pinebook-pro.dts'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
index 5ea281b55..b20062890 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
@@ -743,7 +743,6 @@
 };
 
 &i2s1 {
-	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2s_8ch_mclk_gpio>, <&i2s1_2ch_bus>;
 	rockchip,capture-channels = <8>;
-- 
2.11.0

