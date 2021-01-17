Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3DC2F947E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 19:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbhAQSSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 13:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbhAQSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 13:17:45 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A18C061575;
        Sun, 17 Jan 2021 10:17:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s11so7801825edd.5;
        Sun, 17 Jan 2021 10:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2JtWKNyDRARawQO+6zhdJOxEt3nWiQDJWt9SIw5zWcQ=;
        b=mZiNuxsvPbyMDex2+YoSTHol1Bmdo+HuPHVMRE5CDHe5TZz7s/mOgrQrk+bGP/ps92
         zWhLuSqPMBJzvffJc4XbvhA2mgPlkCIW9aTOLZ/R5E65NlSPvBfnCjodEQFhkm2kCrdy
         84Ni7K8MNlRtLhq8smnlRChz9HxrjPB0sQrhx80FA0eeN5Fy+BvD1HW3FXwScAtNWxsv
         oyFdrzZqAFMw9cjURH62N2sFATvBXVHWgfin2nkm7+Rk8RWFZ3pspMW8FOldSHUfeCem
         o6BE/rFnweRUxdX5RuT54YRgzHRwAi86YE+imCFru/VQQpDVP4hypMOTV6D+Un+8UP28
         Tqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2JtWKNyDRARawQO+6zhdJOxEt3nWiQDJWt9SIw5zWcQ=;
        b=BnoPb8v+HSYHFQmmhONLya3br3xdqDGG5q9Tz6UxqsqJgJiqOfscbLYT1OFj1eCysA
         hjoB+SzgWVA+MZ+pKMPZuGcN+8URrqOP6xAYK7HdXibnSIwfcjCKiSDutXFjDMyCk+Vp
         pi8xdgWecN1fWQoGc56Tf+TeT/wooW0TtrUXYQzizEVWida9TG9v9B/vQUmLXYXtg5pL
         JOTCLy1+dBVwKabRecevFU5Zju8CTCQtYxWpehTJniGsp6uXirV6GfyOnQTAeEA7DP07
         aw6R/sB5gvU6ervJmKD2Jl7VTSohtOnHRjNKffDCuiQZJT0ABo9oQZQiO4SsmNVanYPX
         u3xQ==
X-Gm-Message-State: AOAM532Tah/xJyQygIjsNqd7RF3tfZUQwIHnaRHPrtrZjXLWml0+vlG7
        qdItj4d28DkW674jczsynAc=
X-Google-Smtp-Source: ABdhPJwRU8gsjM8P1npn0q7DNNkS2ZHeR/5FzHHPq/SUp3D4Xkz8+WaWK7oymmdAKqDt1b7QoVmzfg==
X-Received: by 2002:a50:d552:: with SMTP id f18mr16563922edj.168.1610907422276;
        Sun, 17 Jan 2021 10:17:02 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id zn8sm8745158ejb.39.2021.01.17.10.17.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 10:17:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove interrupt-names property from rk3399 vdec node
Date:   Sun, 17 Jan 2021 19:16:53 +0100
Message-Id: <20210117181653.24886-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:
/arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: video-codec@ff660000:
'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'

The rkvdec driver gets it irq with help of the platform_get_irq()
function, so remove the interrupt-names property from the rk3399
vdec node.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
media/rockchip,vdec.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index b18d6cc26..08f163964 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1275,7 +1275,6 @@
 		compatible = "rockchip,rk3399-vdec";
 		reg = <0x0 0xff660000 0x0 0x400>;
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH 0>;
-		interrupt-names = "vdpu";
 		clocks = <&cru ACLK_VDU>, <&cru HCLK_VDU>,
 			 <&cru SCLK_VDU_CA>, <&cru SCLK_VDU_CORE>;
 		clock-names = "axi", "ahb", "cabac", "core";
-- 
2.11.0

