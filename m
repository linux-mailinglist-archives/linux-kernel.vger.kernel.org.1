Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A38B277E94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgIYDbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A0C0613CE;
        Thu, 24 Sep 2020 20:31:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b17so1080091pji.1;
        Thu, 24 Sep 2020 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtNtO+Cr0GQID7L6TUSjs7iQgumN/SXyPWODrwazKkg=;
        b=qJiAkF45ucqS9gS/ZNpoXHj4LbXoq3VVmy4eUL4P74gEZ8YMPloEmebxaqrv3lKuve
         7WbRuC1Sz01L3wLqtJKAaHHR3UIfWVwtJiJICWug40VtMrNCZA0cRmgmYFDTXNlf7I9M
         lykHcCPZhauPFh+HpL8FgDt8rMAM2XtXJCJ843KLxf77juYnZ83AGPxs0tvxymbU/YGR
         R94r2jwcjxBT+DIZCAnC9jsTrEdfkQ1hq/h2TR+YCgUjj0hDKGxr/C5J+bu6r1NkcIox
         kNNQCJZ2P9FKtoT2htIVQS/JlFIxL+9QBDhZUs2j8jzxWcOxbLkL92KPoWVabqMmP0jZ
         ioPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtNtO+Cr0GQID7L6TUSjs7iQgumN/SXyPWODrwazKkg=;
        b=WCkpALQdnWQZn32xIvyQ0J5fAo7fYZljxSs+yqAhhqmltOIb2YE0IFYX6Q/aIsTz6f
         v6O/FG8rsxEk+OGwFN2rirWa3xHl4IfXNCvadjGkRKbAAfwU5jHpuXBCGN2mTixeG/Uh
         rQTJdq8WgOYs6VEWLNdZnwYubmVILrzCVHvmEnYsuvKn26DOMkFsnx0TnJ1JunnO7xyO
         hNY4mPqT7DU18CcAK8Uz6mpGCYDQNcSpz7NneMlJkBm+UoZYBxQ2Lm6M0WkIFZVimXe4
         KxN+EXwy9a7xM2AXlD/30lpvKvO7w0mOjVRDMuk/AwCq1bGPQX6/tVAgpZXujB3gKQKJ
         fCVA==
X-Gm-Message-State: AOAM533RMfM5AfOMvzCUSalQnBgp+7a45dcO627EwOYEsP92Rvo3GLc9
        hw2bYMIF+joXzdyFGbLSnu0=
X-Google-Smtp-Source: ABdhPJwbio+Z43nB0tgbrugOdb36C7ZjEzxv9FJJekfEhiSoOduLBjFm09cVQhVvJcONcnSFJufVsw==
X-Received: by 2002:a17:90a:ec0b:: with SMTP id l11mr729435pjy.144.1601004672080;
        Thu, 24 Sep 2020 20:31:12 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:11 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 5/8] arm64: dts: meson: remove reset-gpios from ethernet node for VIM2 meson-gxm-khadas-vim2
Date:   Fri, 25 Sep 2020 11:30:14 +0800
Message-Id: <20200925033017.1790973-6-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) fix down/up ethernet interface - need remove reset-gpios for ethernet node

`ifconfig eth0 down && ifconfig eth0 up` # didnt works with reset-gpios

2) add max-speed 1Gbit

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index a6baf865aa2..70343da2811 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -195,7 +195,7 @@ external_phy: ethernet-phy@0 {
 
 		reset-assert-us = <10000>;
 		reset-deassert-us = <30000>;
-		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
+		max-speed = <1000>;
 
 		interrupt-parent = <&gpio_intc>;
 		/* MAC_INTR on GPIOZ_15 */
-- 
2.25.1

