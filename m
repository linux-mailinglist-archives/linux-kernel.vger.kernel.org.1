Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EF82E2128
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgLWUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgLWUJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:09:30 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B133C061794;
        Wed, 23 Dec 2020 12:08:50 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c133so414976wme.4;
        Wed, 23 Dec 2020 12:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=vcjD/mgYco37bqn/aZEyfuF3IgLhY02B5goKU5qZcxo=;
        b=rUDf234NiSP758+M2W5vQ+0Ku77iK8kg1QCuRfFzDRzkDQx5+4Bs7fSoYMZw5KZP+x
         tF+Ts+Z2y4cWebyggBuWo4yxD0uhyrMuJ7dtamkDqv7jccabeEf6kJPm8jKBhNkOMgJH
         p1fBvcf9o67YzWX2HZ4sPZQDeZA7sjQffBXoLL5/qyo9X+3dCD4fYkMCXGfACGY/nDPb
         BlrgbmInSz8aeyhjwjbNFOEUzJjS73Tr7weUw/NCWJqlg+frAh3lkxYysn0i+Kon4bRJ
         9p33I4+k1bC55UHGF4Yqgz3kWVaep48rGOWioEZO9CxnvaGwf3Qip96jXVdp5wxpflZt
         pVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=vcjD/mgYco37bqn/aZEyfuF3IgLhY02B5goKU5qZcxo=;
        b=lrDwfubO7CEdh2da7W9FK506KgjRbdkdds3SnT3/pYsX6U91yv0WLiexAETXa9XW2t
         fGcBpFZhf0WfZ99LeP4kWa5aQI+8c6UNyfIQQeeRmUGQRvM7SugKHnrZuBi5Zl5ePG44
         OcrwbLAsWkEryQptCkwaEHh1msqh44lR4nHDwiUsoMogDeFNcMhefgo8xeOiQHoPTts0
         8Q90FU01pCL5TemtaC0mJdGsdzN3IAI8kGtRmS7XO3JexapgfGlRzJy2wIp93aAONOao
         kZXYmbHwvWXE9Nnx2zCpDyVwXhiGufjLwfUb1fLQXT1ejoa29lEATA//U5fKGzWIoROQ
         /Hhg==
X-Gm-Message-State: AOAM533p4iGQGxgHaumkCe0eji38oh1YHCnWdfURV8rX2T4lsAbLTW4p
        NoW0ATrXr+wbdGXGT5LrbZg=
X-Google-Smtp-Source: ABdhPJxjSVqlOdnskT38CNxvzl3/d6kZiQDNtr09R3jbK1dJVqne3d+TZItMdVDRy5CyAuSSQyFX7w==
X-Received: by 2002:a1c:64c4:: with SMTP id y187mr1214986wmb.165.1608754129000;
        Wed, 23 Dec 2020 12:08:49 -0800 (PST)
Received: from [192.168.1.113] (250.red-81-35-222.dynamicip.rima-tde.net. [81.35.222.250])
        by smtp.gmail.com with ESMTPSA id b7sm34100997wrv.47.2020.12.23.12.08.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 12:08:48 -0800 (PST)
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pikaslabs@gmail.com
From:   Sergio Sota <pikaslabs@gmail.com>
Subject: [PATCH] ARM: dts sunxi: add A10s/A13 mali gpu support
Message-ID: <eeba726d-40fd-48cf-9587-8f801f3d6cf7@gmail.com>
Date:   Wed, 23 Dec 2020 21:08:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From c45753026b4868e32132348f8f2bf59e6ce5c820 Mon Sep 17 00:00:00 2001
From: Sergio Sota <pikaslabs@gmail.com>
Date: Wed, 23 Dec 2020 21:00:35 +0100
Subject: [PATCH] ARM: dts sunxi: add A10s/A13 mali gpu support

The A10s/A13 mali gpu was not defined in device tree
The A10 has a compatible mali gpu driver (same device)

Signed-off-by: Sergio Sota <pikaslabs@gmail.com>
---
  arch/arm/boot/dts/sun5i.dtsi | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 4ef14a8695ef..b4d46ecdf7ad 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -726,6 +726,18 @@ i2c2: i2c@1c2b400 {
              #size-cells = <0>;
          };

+        mali: gpu@1c40000 {
+            compatible = "allwinner,sun4i-a10-mali", "arm,mali-400";
+            reg = <0x01c40000 0x10000>;
+            interrupts = <69>, <70>, <71>, <72>,  <73>;
+            interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pmu";
+            clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+            clock-names = "bus", "core";
+            resets = <&ccu RST_GPU>;
+            assigned-clocks = <&ccu CLK_GPU>;
+            assigned-clock-rates = <320000000>;
+        };
+
          timer@1c60000 {
              compatible = "allwinner,sun5i-a13-hstimer";
              reg = <0x01c60000 0x1000>;
-- 
2.25.1

