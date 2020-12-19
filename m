Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE06F2DF1B9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 22:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbgLSVGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 16:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLSVGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 16:06:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B9EC0613CF;
        Sat, 19 Dec 2020 13:05:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u19so5953726edx.2;
        Sat, 19 Dec 2020 13:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yCg0N5XHLdcvyzB8XtbsgLX0uVCGtu8p9OhsrWKEzmI=;
        b=ZOayuf5MpYctakbG05R3dem09hHqfNfXaxDYwUfuhENiSfcdDzV3Q+uRqNh2bfMTQt
         BAQQii6h83kwUyA+i32ljQELwP1RoaAdFBGJs6JGE9cFfbweOPT07zGKGE/Ge57mp6i9
         ocI/L0hJJdnpt1k2a0Q1t4PlMcwZKI2gosI9hSLLwmm/cFaFsoxq/GPG0Qdb6uB0fgBt
         cVfU32+72cdvm5WpU4Bi5B7rPrR1rHlImJUAec4fMexLk1/mjH33cuKU3HRVa0izDac5
         +XsDXAoDot7+qF6OwcvnN1MeOr//aCRFvNRcy5vmin6n0to87FT20uTOt3e28BgDtwDY
         1NZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yCg0N5XHLdcvyzB8XtbsgLX0uVCGtu8p9OhsrWKEzmI=;
        b=L8d2I1SUfszMgh4shdFRPMnTlV+56IIMMgk+Lc8C8jln8LnXeFwHTpWgDN1At0SrFf
         EcfIWinvn2Z47ZvfKmge4AQ7DMTeyIkONTNQUKxVTEkzK7rxcYHM6GJdtyobqMRA/Xii
         SgQ3mZuzA6IIQFHrT9+4JpLP2l4zq4L6I6oKHapcaJk7Jyv2PYl0M+mX0Gtn64UHQUUn
         SY+X/SsDieaCi5Mzs3FDN34dbdSX/fHNYACTYvBqKZg9zfQlbInaAnK5L5KcmFMBu30+
         r2FAOYVrXOjreKuXBmzOfsFK2BolT+lLpRukGZE6rCkaJtNbnP0Rw4Z4ri2x3nqCwN6A
         7qLQ==
X-Gm-Message-State: AOAM533DFYRozmRp7pOSIond+m1iwSunRHp5wYIbZlXP7yxCeJ/HwR1q
        iRQU7769sYmzjJ/BqXmJcxM=
X-Google-Smtp-Source: ABdhPJwUOLxMqZHFnWA+AM/Mc5tNkY09FqSU8RHM9licxpTkUPDZ6d6Rp7YMFP1kyyvbL2MzBmbfzQ==
X-Received: by 2002:a50:d491:: with SMTP id s17mr10004889edi.169.1608411908228;
        Sat, 19 Dec 2020 13:05:08 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id a6sm26960419edv.74.2020.12.19.13.05.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Dec 2020 13:05:07 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: assign a fixed index to mmc devices on rk3328 boards
Date:   Sat, 19 Dec 2020 22:05:00 +0100
Message-Id: <20201219210500.3855-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced async probe on mmc devices can shuffle block IDs.
Pin them to fixed values to ease booting in environments where UUIDs
are not practical. Use newly introduced aliases for mmcblk devices from [1].

[1] https://patchwork.kernel.org/patch/11747669/

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 957ebb70b..1ae129793 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -27,6 +27,9 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		mmc0 = &sdmmc;
+		mmc1 = &sdio;
+		mmc2 = &emmc;
 		ethernet0 = &gmac2io;
 		ethernet1 = &gmac2phy;
 	};
-- 
2.11.0

