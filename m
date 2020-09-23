Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8978D27555E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIWKMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgIWKMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:12:39 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D15C0613CE;
        Wed, 23 Sep 2020 03:12:39 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s14so2517532pju.1;
        Wed, 23 Sep 2020 03:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PnqHt4jS0alkdyVRgXzqAWUQbwleCthomnxJbBt7S2Y=;
        b=QDxpN6Dv4DUNiekr5C54Z+o+Dyts3MAuvYPa1O2YghEQ+tZdHKWz5CyLjSVoGzGjzS
         9YuFAf/fAK0JiZmGR1NmsePtmAKsu4pqj0alyCVd+9zZt/7aSCFxrXZWPeWrMMXhIj/y
         S8vbZyJPhd9JXI0xh9mR++EZNhrj/yOiIQIKDC9LCe7rS//0HXk1OhsCuAW5FzOHjQAH
         8alWp6GWCt3zkaHIqgbQ53G2azQmigYcJEOYvBzq5fRrKAVD3j1i9Kj9KInxJiLQymmp
         tbK4IMt3Zmd9RybhcwsrQlRHgdX2w9uzkpT43si9uS6VDPkTI0DCeKeEKLlKMoVOqjxv
         glQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PnqHt4jS0alkdyVRgXzqAWUQbwleCthomnxJbBt7S2Y=;
        b=AFYk/KW+ASXIt1wO+8vl9Mb1L6Rl5xT/CY/WqhPV0XW71efTdjiMjXm5Q57MuY38+j
         HZBBGYZPH6saXgOjzFZe/h32gKBzU3zUh1eyQviujZKTpWeM0pTjJs1jfoINSnOKyZS+
         yozPDCKKr/s9PdPqQ6Z5KLq0Wpd7UmxanqvTNKMba7gHzjW102oLVL3LGt/sqrUIZi4R
         5A+PDzkWF7cgDcYFfg5+xQl/FaVyyxEuZiNvkmKhlhgBSc8lKWEX34FRn8MMCtethCFU
         UQdWG2gNrGXknPUqcpqyJt7rc4Azbm1fv1PZlZp3h0oQ6mz+92c47fLb5FPRZlpuAMj0
         Uwhw==
X-Gm-Message-State: AOAM530BXeFoEFaasfSq81Km57hadIhN7XOyoFABIdSzdJUIC8xSjK99
        Yl9ecFv9AJOYzAf7ricGhlI=
X-Google-Smtp-Source: ABdhPJx7XnTc1uvthm5IBdL+cQfy0PJfQVwbZVm/GbL82fctfyr2vrH+734UjNXIKbJxxfVx9G1l+w==
X-Received: by 2002:a17:902:7b93:b029:d2:172:7d9e with SMTP id w19-20020a1709027b93b02900d201727d9emr8996755pll.83.1600855958896;
        Wed, 23 Sep 2020 03:12:38 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id i1sm17678549pfk.21.2020.09.23.03.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 03:12:38 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        art@khadas.com, jbx6244@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nick@khadas.com
Subject: [PATCH 1/2] arm64: dts: rockchip: rk3399-khadas-edge: add missed spiflash node
Date:   Wed, 23 Sep 2020 18:12:24 +0800
Message-Id: <20200923101225.1513392-2-email2tema@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923101225.1513392-1-email2tema@gmail.com>
References: <20200923101225.1513392-1-email2tema@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artem Lapkin <art@khadas.com>

The Khadas Edge Boards uses winbond - w25q128 spi flash with 104Mhz
---
 .../boot/dts/rockchip/rk3399-khadas-edge.dtsi      | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
index e36837c04dc..42ebbd6fa46 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-khadas-edge.dtsi
@@ -805,3 +805,17 @@ &vopl {
 &vopl_mmu {
 	status = "okay";
 };
+
+
+&spi1 {
+    max-freq = <104000000>;
+    status = "okay";
+
+    spiflash: flash@0 {
+    u-boot,dm-pre-reloc;
+    compatible = "winbond,w25q128fw", "jedec,spi-nor";
+    reg = <0>;
+    spi-max-frequency = <104000000>;
+    };
+};
+
-- 
2.25.1

