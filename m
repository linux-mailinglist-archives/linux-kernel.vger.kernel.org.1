Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF44296C46
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 11:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461629AbgJWJlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 05:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S461514AbgJWJlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 05:41:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAD2C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:41:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e17so1043559wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 02:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v+BRYKpLF85NN75H+Cg4QVm6ILks7BYKSUstLByCSA=;
        b=oJb60JlqLfIPB3mYZlJZW1WfSN6XWa6RPumJBVEtsy/6axY6bbAq6u8xHFHg6HZNxJ
         3Ps6GFAictfqzt/K8+GFutVZJTgML8R/FAef3D6uUngWtyLssceUu24Eo1mp4Py/bW0O
         RXqnuVJyeev6/0nHYXm8UCn3d+y8FfyegBnOF3rWcJ4lLmBqD3jQ4JdDAhaK7ICYvVG3
         CUZeoN10Pl4j+22yT/iW81VkVWazCaMk4dU5pRMABr7SenEWUkvNp6+jvBH1baC458LH
         RUL7L0AQMTxK8UDxiYGedJoRZ75cZqWqjzR5iI4yFAa3zKmfhS1YtLi5gg7VVbaUjLLv
         Ut3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v+BRYKpLF85NN75H+Cg4QVm6ILks7BYKSUstLByCSA=;
        b=SBWd2gTJmYiylzl3RI5hX45XAlzhEZl9TkQlp2VuGhab3hYkxsuhwy8QHBrmPMmsVv
         MRhuMmx6GX+qXQzMASTJbCcAQFbrMX9FfifTeZDCUaplCPeKPkRty1wvFzIVjPbC5HOp
         wd+6hQHztiJci0Ybd6JFBEJyuZu29eS5GtXSNZ+4fiVpqXY4JLLg/jqXVZOaYeSqM5xp
         TODIw/acDt75salvgvEMRuuFfC2HKzRJtN6C7jluWpF/faiexpERrBc143N3w/Vh9KFE
         qJgT7b+7zvACXYnsbvMKgfQxiqzRgdwA/9a9uHDN+TNgLw5fypZWBQwvU/RAExUzrQSY
         YtnA==
X-Gm-Message-State: AOAM530aCjGOuDqHorNi9R7rxwV3uuZE6VG0IGF6uYhgCbgEcA7zz2Ub
        Cpm6yUvhWMqIF1FA5H2aEI7SrQ==
X-Google-Smtp-Source: ABdhPJwDPdzCYwR9mXKv2Bg6I8v/LszFvMGCXhdz5/Gevez4gwbQglfp6HED2cYJ6awSzPcjAx1Vkg==
X-Received: by 2002:adf:97cb:: with SMTP id t11mr1801202wrb.292.1603446108704;
        Fri, 23 Oct 2020 02:41:48 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id t5sm2543023wrb.21.2020.10.23.02.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 02:41:47 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: odroid-n2 plus: fix vddcpu_a pwm
Date:   Fri, 23 Oct 2020 11:41:39 +0200
Message-Id: <20201023094139.809379-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the odroid N2 plus, cpufreq is not available due to an error on the cpu
regulators. vddcpu a and b get the same PWM. The one provided to vddcpu A
is incorrect. Because vddcpu B PWM is busy the regulator cannot register:

> pwm-regulator regulator-vddcpu-b: Failed to get PWM: -16

Like on the odroid n2, use PWM A out of GPIOE_2 for vddcpu A to fix the
problem

Fixes: 98d24896ee11 ("arm64: dts: meson: add support for the ODROID-N2+")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
index 5de2815ba99d..ce1198ad34e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
@@ -19,7 +19,7 @@ &vddcpu_a {
 	regulator-min-microvolt = <680000>;
 	regulator-max-microvolt = <1040000>;
 
-	pwms = <&pwm_AO_cd 1 1500 0>;
+	pwms = <&pwm_ab 0 1500 0>;
 };
 
 &vddcpu_b {
-- 
2.25.4

