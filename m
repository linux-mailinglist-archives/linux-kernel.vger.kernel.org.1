Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1FF285C69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgJGKGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgJGKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E2C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 03:06:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k10so1456982wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKGC4aJ7pVGKjgcA5u7g3Rhoe0Civ0MEouVUNdh999U=;
        b=XpHsc9NMXnH0fXij5AfiKNqZa46H+xqUjDFSWAiOz/Yc2UBExH+OlCULSsM9CQyaRW
         fGa1BlUQo9Mp2hJd8VB8/jb7sTy0AbnLzgKT+T4TlzwvMpNoXf3EUcctvebFCIavwQpl
         VcLfEwiCKH5YzKiN/rHeoaznRqT7FiV13K8IBGYuVPBCK4UecSRkmzgaulepDw/4OdTH
         9zNd5qGCsZF5qxcxD3y6E1+seSqIYHQT16OtlP//xZ/zCLS2JXWrRyjkqngqnx9i4FXo
         zSHBvi0JZ4xm0Uu8m5Y/HoUKAiMxf4BHt6ps33CH3+TBkU42iE3ExQdzuwPEQKoFPgBR
         CkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKGC4aJ7pVGKjgcA5u7g3Rhoe0Civ0MEouVUNdh999U=;
        b=ePe0SYam17f7RUUI+RXmhdj704XqhZbz4NQYFRNS028tWoxpyrDoGUpsNUgPUM4Qi0
         GPt/DqjdE8YGnhb2Lx7yn5ON3Pu9Mfew+BdmEGm5qXIeckITmgDe8+hrIE1WD4hrMV28
         /9jEa0lLsvln8PHTsslh6YJenebDMgEgjr3MZ/kXK5xgJKRM1JD7FApLP0uJOjv92JJM
         q2DA95JhCh3W3T3QnlDQWmVFwTE/nsIP3eDvMtW+oDXsJmd6hfmLC7U8K4rA1/liEJrR
         XcM12I7IJ3zEuFJu/LXsXl7b9qqv41BDAPYVc+VHKflNnE1rhE6i8DRdq9fYXlwKTVVY
         5yxA==
X-Gm-Message-State: AOAM532i8kEgotFa6UxsPsCdMPdiN/GuaeUFni1Bs0dq7QCUr5ViDgZL
        6CHBcJoThI73+WsqfzFQecgMmg==
X-Google-Smtp-Source: ABdhPJy9x6oJ00YrXuOsPfoIio+5ofoiMcKffI+3mUrb4UJzBgSZWFtDkkkNLpiwpP4elSP0PSXASg==
X-Received: by 2002:adf:fd07:: with SMTP id e7mr2503089wrr.377.1602065196705;
        Wed, 07 Oct 2020 03:06:36 -0700 (PDT)
Received: from bojack.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h16sm2214981wre.87.2020.10.07.03.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 03:06:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: meson-axg-s400: enable PCIe M.2 Key E slots
Date:   Wed,  7 Oct 2020 12:06:31 +0200
Message-Id: <20201007100631.192348-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201007100631.192348-1-narmstrong@baylibre.com>
References: <20201007100631.192348-1-narmstrong@baylibre.com>
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
index 84129abb2399..96c384a7f49f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -395,6 +395,16 @@
 	};
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
 	pinctrl-0 = <&pwm_a_x20_pins>, <&pwm_b_z_pins>;
-- 
2.25.1

