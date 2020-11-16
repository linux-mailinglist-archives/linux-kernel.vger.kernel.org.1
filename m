Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4A2B48D5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 16:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgKPPIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 10:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729833AbgKPPIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:08:13 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A166C0613CF;
        Mon, 16 Nov 2020 07:08:13 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id t9so19060009edq.8;
        Mon, 16 Nov 2020 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MgUuCGTUmTyQE2NB6kAdCs8A92pbip91+AhDDJogBCE=;
        b=vUilQHf/dfMmiU8OIpGWq8OlaxZ//XEeM4UsGoBqdWbgfPwOzkxGfinaBOg/9Ov4OW
         lGmhgOjEjfRDbMjs1y0xPirxM+8WsllL7TloZ/XIWZYemzlGtoR424O4VHsNbeh+2MGQ
         mqzgKhRme37BdP/lqqe57be3bTiNYrohVFpKps5aUjUnS8i9IZEU3BpGITiE+sNhleHB
         1kAeCBIojeZVVcFaKBhbaYuYc5ZLhhVb2J5JLv6XDf/t9t/f/odoJXDePXNCgwHbKyFz
         TJSKIiVKL5ZYCPYy6h5QceIWf5ApPaYoTe6MdERHzi9BL2T+dLBNecQl3sRTdYECWsAM
         EqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MgUuCGTUmTyQE2NB6kAdCs8A92pbip91+AhDDJogBCE=;
        b=GjFde6UR3mS9rPHlIoYzcbBtCvZHveZ8zs/8WHygSOQo3xhpVHGIKStM6zk6W2phYf
         9tKcwXh+dyj+vgmVsTZFdHJiHEfucFozy4psuEywLpIUTRIcp1fmMkhHIh/yS7UcNK1d
         jSBshFL44PV9LXtvJtft3IwHsEg2+MkKhc4G9hGcYKEpRRmG1CrTnnVmx7VuYZlP0vtA
         Qdt264xhf+hp+tDYw8+365cvUzPqd6QF7tjQf9Wn9dlbR9aaBcIUeXjmSl1QPUv73zfT
         lJkyWq+DLxAt7CJqUg7kakqQqd4opR/LEZUiPuulNjYPvUjCSNsMPpZhiJEtCl6psOhF
         1ZKg==
X-Gm-Message-State: AOAM530SD591g3vYhTupPNZ0o+uVTfPCSY6fxCFWTR6rb/xyN9hG9BOW
        hDMYd4QcCpjud4z578o4KLs=
X-Google-Smtp-Source: ABdhPJy6eWNJDroLJLz5B7pbw1omq0oWoGtj+TEf2+WuD0ZNaVgzuOjtwz8+YeMs8VZtKJhalCx79g==
X-Received: by 2002:a50:ef1a:: with SMTP id m26mr15477517eds.144.1605539292012;
        Mon, 16 Nov 2020 07:08:12 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x1sm11180827edl.82.2020.11.16.07.08.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 07:08:11 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rename wdt nodename to watchdog in rv1108.dtsi
Date:   Mon, 16 Nov 2020 16:07:56 +0100
Message-Id: <20201116150756.14265-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

/arch/arm/boot/dts/rv1108-evb.dt.yaml:
wdt@10360000: $nodename:0: 'wdt@10360000'
does not match '^watchdog(@.*|-[0-9a-f])?$'

Fix it by renaming the wdt nodename to watchdog
in the rv1108.dtsi file.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/snps,dw-wdt.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index a1a08cb93..e491964b1 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -299,7 +299,7 @@
 		clock-names = "timer", "pclk";
 	};
 
-	watchdog: wdt@10360000 {
+	watchdog: watchdog@10360000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x10360000 0x100>;
 		interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.11.0

