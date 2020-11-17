Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909182B5B37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgKQIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgKQIox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:44:53 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62B5C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:44:52 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so22259688wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MLQVEogLPpntY7/K46szj62exzsJj4q8MDOgKu+50fs=;
        b=UwXYEJojzUWxuZWpoyALqr99KGTx93FqzgQE0G5qJdDTQq4GMPGDSFwSpEeMm/xeXp
         Hl099niw1Dj7HM0JGkXGcXV2NY/Ojnrg5xr7g00JeztTpcgM2Q7HOwIl/32oCg2rCvzP
         Mjvd8ZytXAMUIEgWGndAVc625d/Zm/t3W2wEln66xGXULcLjz8EHZKcw9dgiP4eAPlJi
         rfhvftbtYSlWVm92G8MGHc5PQ/KiDN8MRWbvEAmCdfpjKgCZpZAtdsQ59SwkyU0DtxA9
         3qsQP9DhgXVix2xiTF31NQaK+H7G00lLxmqE8Okonti3Dvy0zA+uToYhYTCoMMz7WZft
         4J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MLQVEogLPpntY7/K46szj62exzsJj4q8MDOgKu+50fs=;
        b=LCLQM9Fzycie3M3/im3V5ZoWCgQTIVYQimuNiuno8bnYGsU5yzpSPkCLooSr2+3Z93
         ixr2UfHdA1O6BK3nuHTUgV5CQvjCPn/4BBukt8R6fWKsFzRF1SxHEjtkY8ebPrYO82kb
         vRwhOqCv2NZqb8zF5Asr0cTH8xuMHFzG9DP16mkw0dOxkPiET94lnc8ShwgIYhQ7S9ta
         PvzISVrmOlPwaODSHN+Kdi99rlW/+8OLLjoCmBtcosvAXtkLFqIZBchVbucyGUp0jot2
         +4/j/gyPKnVBmogK+LHAEtsbTvA6Wh2+tCm/7niTHNZ9c/YoCFf4/31Hj4QTfMJWQY1M
         +MXw==
X-Gm-Message-State: AOAM532NdE+QWJf38xGmepYL8JEnGYHi3nnztf58lzn6ajIqPT+/OzOs
        siE6soztC7iY4jm8a9HwvrTxGg==
X-Google-Smtp-Source: ABdhPJy4mPCg/pB0fVmr1u4LTHLg4BZ8blydsOJL6dwkknwKcwDSczWGuEad0rzYeHrP98k4eq/aGw==
X-Received: by 2002:adf:f607:: with SMTP id t7mr23588748wrp.169.1605602691496;
        Tue, 17 Nov 2020 00:44:51 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:1561:9f4b:5829:8e26])
        by smtp.gmail.com with ESMTPSA id s4sm25631423wro.10.2020.11.17.00.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:44:50 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] arm64: dts: meson-axg: add GE2D node
Date:   Tue, 17 Nov 2020 09:44:40 +0100
Message-Id: <20201117084440.578540-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201117084440.578540-1-narmstrong@baylibre.com>
References: <20201117084440.578540-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the node for the GE2D accelerator unit.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b9efc8469265..376f5c3f6188 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1563,6 +1563,15 @@ saradc: adc@9000 {
 			};
 		};
 
+		ge2d: ge2d@ff940000 {
+			compatible = "amlogic,axg-ge2d";
+			reg = <0x0 0xff940000 0x0 0x10000>;
+			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&clkc CLKID_VAPB>;
+			resets = <&reset RESET_GE2D>;
+			reset-names = "core";
+		};
+
 		gic: interrupt-controller@ffc01000 {
 			compatible = "arm,gic-400";
 			reg = <0x0 0xffc01000 0 0x1000>,
-- 
2.25.1

