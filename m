Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4042C36E3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 03:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKYCkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 21:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKYCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:40:08 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD296C0613D4;
        Tue, 24 Nov 2020 18:40:07 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id i2so401482wrs.4;
        Tue, 24 Nov 2020 18:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2DCnZPa11FhjnY6LNsxv2jfgvHUVsLu9/gulnrkgaWA=;
        b=jrSzE+TpJrRF+iIv5NMouE2PfzpLpkKELPrmJ7Ky0zuruNumq/G6t8W/nffoxWE1+L
         aEQddZebyF9ggEs1Dqlzm4mMXI3KFusflAvb1BGrLWZojjM5Q6VJvEeamFdsknBonTWz
         lsOwzmvWbmUoab8A7F0cI4FjCu/hDe4rgUzcUpmP1/ykbB+GzNDJJ7AY0DYIFQZnLXFp
         tw6JCz7gWLUmqolTa4avG88vDvlipVdpSeSWmrAOuyt1vzofrFwWgH2xDvlLAVQ+1sTL
         BRyLklC6NeyYMBKuWMVDOr0Wm0fVKpQZg5+I7GAkUIvVhYl07uxRIHSPoh0305XsYeWI
         sZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2DCnZPa11FhjnY6LNsxv2jfgvHUVsLu9/gulnrkgaWA=;
        b=h38FbnuxzfEshusjHAsX95yhcmU9IiaDZZzhpel5dDalibvnNh6turfUcEcLlq1VMk
         P3/eOL6Aa4Izqytl7iYqmAVuoppSKYt/2trq+aWYjhoQORei3WrVHqzL5uDY1jaFCmEF
         tjfZTTWYRAUXO+LVrllN1iJumkLYw8Ph2p6z9ekJkKiGRDXpmTgTc1jpAXCnTVDtCR1e
         V9lKxnpjbpJ/2WjiEkk1K5GmOxn1Pc7lqsTL4104YsvvSkhTjhlSZih5qse9uRhISsPz
         /xPw0dZu7VCvJy4dmonxSlfywlUSNOmb3hDSQ8jdJyHjeKbM3/HFfSywXz9jL+BnSDCy
         O2Pg==
X-Gm-Message-State: AOAM533mS5vhG+LtYHRuMknTXcMozhN1H11k0qZHkNjWdKHrDk5W8kPZ
        GNQK8Q67l2JXug+z3afJskg=
X-Google-Smtp-Source: ABdhPJzdmzCm13OlX43VhOcew3MqUkCBjjePrJJij0TKd6+NPs2L2Lo1n24hFiH6A1TK66jNnn5P+w==
X-Received: by 2002:adf:e481:: with SMTP id i1mr1447426wrm.282.1606272005815;
        Tue, 24 Nov 2020 18:40:05 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id q1sm1668653wrj.8.2020.11.24.18.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 18:40:05 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Artem Lapkin <art@khadas.com>
Subject: [PATCH] arm64: dts: meson: fix spi-max-frequency on Khadas VIM2
Date:   Wed, 25 Nov 2020 02:40:01 +0000
Message-Id: <20201125024001.19036-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Lapkin <art@khadas.com>

The max frequency for the w25q32 (VIM v1.2) and w25q128 (VIM v1.4) spifc
chip should be 104Mhz not 30MHz.

Fixes: b8b74dda3908 ("ARM64: dts: meson-gxm: Add support for Khadas VIM2")
Signed-off-by: Artem Lapkin <art@khadas.com>
---
This change was previously submitted as [0] which has style issues and
remains unmerged. It is also part of a two patch series where the other
patch needs further work to convert to newer LED bindings.

[0] https://patchwork.kernel.org/project/linux-amlogic/patch/20200928092613.273998-3-art@khadas.com/

 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 39e6047056b2..079500ed5066 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -391,7 +391,7 @@
 		#size-cells = <1>;
 		compatible = "winbond,w25q16", "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <3000000>;
+		spi-max-frequency = <104000000>;
 	};
 };
 
-- 
2.17.1

