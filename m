Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA842BAF03
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgKTPcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbgKTPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:32:42 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DFC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:42 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d12so10368573wrr.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWLpASMBxVE+IPMT5Mp6WJ1oEGYYgS3ffEicpvS60qU=;
        b=QjmC/vYNDPg97/NVYbQCCrN7sYdOdulM4zrGr3bvsj+fbGazH/ZLGUdgcFoaNPY0Vi
         d2/Y+QFt3d81B4v/cPkFSDD1W4T5kNxoa8CLHgHUoEmg6yqKHyQ7NDTGZhzuPAwNWxIa
         Y5FeMVifvZVhHvJOabAw4d9IgwwfU2cqe5xJBTENkRMSUj25hdoe+BO1fXXaeRHTCkRg
         aVDA2s5MwCbvFnIk2yz5m6vURc4oQ4K7cC0bZhggJuw9Yz/g1DPiQX6LNbWYCAe65+NS
         ocKVWrMgSsP4uHPgAS7tX3vLpDu9/Ubr2LJIzKPRkc9uynwwCgJbVK/kBP1+PmDr1C3Q
         oj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWLpASMBxVE+IPMT5Mp6WJ1oEGYYgS3ffEicpvS60qU=;
        b=A1Sj6/JrRwG8KkKIw9qYzxPZVVm3I36BJF3KFEwmtWUGpo7B22tjljJ0qRBO76jRkh
         E7dj6bg7tsroGeSfx9mgFnJcMIL+RwaVGqekraqCuElLHfLxznA0yrLrwy/9JrI9+mVx
         u3Sd4RP3pOiUPCCYgkBESHOUdh2Qqeqvw2xVPLxNWF/NalDjt3CSd0cXUYSNTXbvbL87
         ehU95in74QKi/4KLLeYLL0Cl4xaepRukyIK5Y8Ddbh8kT9IQGnks9Inj+5QfLH7MiBYv
         OGCnc2hNcnlZ92lGKnfXmIVPovkuOB/jUp12POLDt5o8ydH0ujj1UKGKbDcm0yFCqpIs
         oy+Q==
X-Gm-Message-State: AOAM531w0oSv/3jznCmWpXp5nS1ifoi60s5po9YhzCkDZWgUD+zN2GtM
        g+6PtBEQyV+XorXGO88Ir79IAg==
X-Google-Smtp-Source: ABdhPJwpfwqS6yqXt9ilELkqNOY6AP9nT2FadVetjhTu1xFeukbk2Kt3NtiX3Lv87W5ZuPBwVcRsQg==
X-Received: by 2002:adf:a551:: with SMTP id j17mr18250041wrb.217.1605886360646;
        Fri, 20 Nov 2020 07:32:40 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:419f:dca4:d17a:66a7])
        by smtp.gmail.com with ESMTPSA id i16sm5398180wru.92.2020.11.20.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 07:32:39 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/4] arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots
Date:   Fri, 20 Nov 2020 16:32:29 +0100
Message-Id: <20201120153229.3920123-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120153229.3920123-1-narmstrong@baylibre.com>
References: <20201120153229.3920123-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 7740f97c240f..359589d1dfa9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -441,6 +441,16 @@ &pdm {
 	status = "okay";
 };
 
+&pcieA {
+	reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&pcieB {
+	reset-gpios = <&gpio GPIOZ_10 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+	status = "okay";
+};
+
 &pwm_ab {
 	status = "okay";
 	pinctrl-0 = <&pwm_a_x20_pins>;
-- 
2.25.1

