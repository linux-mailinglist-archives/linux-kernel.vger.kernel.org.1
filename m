Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8829326B2EC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgIOW4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgIOPY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:24:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17258C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:24:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so3819653wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0gZ+YMPLfBO/R15jPy3oPKv0zNd05fNly8pHsr8U99U=;
        b=EGfeOw4+SDurso+Dyhq4JgPvPuNCfXkoF5QnHUhW0zyRByT6ESUh5yY24EgAkddZdp
         ES16D3aQqRdc2MR/AqU7vO6lq8TLl5CjS5pwYe4hFUvSaLFlxUiXGwpdMWcWrq4YKdQV
         8AkXGya0oC9dU1Hauzc7FDsgnC0zBI/no3zw/bu3XuH67AqWq5GuvR9pB4KjEKQf3Tqq
         S7oZZWQObIDARVrO8yUtmY/ptW6eBpVB+10wRoP42V3ICpu/mvdJ6fi9OPJjZuz4wiGZ
         wS7KZttndJL2wNMk7is2HT2ijtSNAdw4Gbo8NBNceVfx5cBHEHLX+oEiUraI6Q+zWCJk
         sEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0gZ+YMPLfBO/R15jPy3oPKv0zNd05fNly8pHsr8U99U=;
        b=MWE56hfVD5cTc0hiMxsTHbqtQuegmR8BUwwc+LXXaTlusHjJQG8/UOEagIxtGiywXm
         1zB0A6up0Hn7enqLamS7U3pEGJw7mTsT6qQvcbE++9BniAQrQM2Da4pPF7wO+8tYWqJB
         MsR7mMH7IeIg6tNUJudzJnHSz2YOzfh6knOJwq7c0+eDJtwDtzpuT/X7wueULv1UE4wo
         zDxfHkRAQblvcKr5zIQ7ywK2ciugAB1U4Gdwgk7NKFp4pBtf+m+KGruBPUlEyHqyn6qg
         VAQekjwwZItCBWPS33p3rL3S8iFvWh3igifaVOJMmt5+nGaksScZLjM0ID/QSOlG/PqV
         Epvw==
X-Gm-Message-State: AOAM532wYNbPvgVe4PNEIpU0tX2i9XNRsveQUvd9tP5sYyqYgFnkl5x4
        HuYRHPPkCFsfOoPv98QckfKUPA==
X-Google-Smtp-Source: ABdhPJw8JXVzziE+/esCJy0ADiwegrvSaUzt3GxV73kE8tnHfqeExlt4rZyZ4kAU6JSUYWyoT/DCJw==
X-Received: by 2002:adf:f843:: with SMTP id d3mr23628823wrq.226.1600183483547;
        Tue, 15 Sep 2020 08:24:43 -0700 (PDT)
Received: from bender.baylibre.local (home.beaume.starnux.net. [82.236.8.43])
        by smtp.gmail.com with ESMTPSA id 189sm25984960wmb.3.2020.09.15.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 08:24:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        tobetter@hardkernel.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 3/3] arm64: dts: meson: add support for the ODROID-N2+
Date:   Tue, 15 Sep 2020 17:24:32 +0200
Message-Id: <20200915152432.30616-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200915152432.30616-1-narmstrong@baylibre.com>
References: <20200915152432.30616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
clock speeds than the original ODROID-N2.

The rev. C support a slighly higher VDDCPU_A & VDDCPU_B voltages and supports
the same OPPs as the Amlogic A311D SoC from the same G12B family.

Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile          |  1 +
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 4e2239ffcaa5..b0b3d6791499 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
new file mode 100644
index 000000000000..5de2815ba99d
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+/dts-v1/;
+
+/* The Amlogic S922X Rev. C supports the same OPPs as the A311D variant */
+#include "meson-g12b-a311d.dtsi"
+#include "meson-g12b-odroid-n2.dtsi"
+
+/ {
+	compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
+	model = "Hardkernel ODROID-N2Plus";
+};
+
+&vddcpu_a {
+	regulator-min-microvolt = <680000>;
+	regulator-max-microvolt = <1040000>;
+
+	pwms = <&pwm_AO_cd 1 1500 0>;
+};
+
+&vddcpu_b {
+	regulator-min-microvolt = <680000>;
+	regulator-max-microvolt = <1040000>;
+
+	pwms = <&pwm_AO_cd 1 1500 0>;
+};
+
-- 
2.22.0

