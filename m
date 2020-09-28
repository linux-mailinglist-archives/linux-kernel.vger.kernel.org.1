Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BF327AAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1J0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1J0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:26:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7CAC0613CE;
        Mon, 28 Sep 2020 02:26:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so407035pfo.12;
        Mon, 28 Sep 2020 02:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vwyn4jhlyCUJ12eIYpSepswUnoOpxvJJ63W/OYA7PGU=;
        b=naAPnVjAA0vPKDoq59x+zjNL74O4Z3obOogbM3hiX0oWiY1UXXJymahauzU9SkaFqi
         CAis5ZPCnhs4Lv0wSAOY5B3rByJGBMFxcllnR3MTbo9NuTuzlTVons5XsW1bDuZ7EFdk
         OKpXqcZ9/6yRxicIoEEVI+6JRwrViaRXN2Wh8cIN4MP9xFzfU8at+AUyOJ+nLxAVGPaK
         6lx8ZL8YE2sqLz6v56MyoS2w40Ny4PxOXPo6zck5t2KmqeHIzGq5cwCeQR9EyVpswfFe
         Kh8Ii1Qbza9mEYz04kufEqrts+PLfa+HxphGp4kLsmfN/bvJzupDH64GglQVADB0m3tM
         i4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwyn4jhlyCUJ12eIYpSepswUnoOpxvJJ63W/OYA7PGU=;
        b=OhNoPEp5GgKcybc2urYYUciBzJSVQ2M5LO9esvpX2pNrMl/lJ/1fTJygLFTvfY704b
         NvdjMVpjTvB+VHjc4qP40JCpUyv+BKhYJfEsZ+Wp/MLJCRbJXJnIndmJ0haMKzf9w6wC
         n9TPTbRUZViKCrcBU96GK54bTcze8s3k02sKkh3aim3X24+gGF4ZHpKk+PXk0kXh98uw
         2fnpsxXRBGMAwC8bIzwS/ftMJEDRohqF+Ljg/ridr5m82B5dnVt9Qx/1vV/fCZWVPMiC
         j9H+hxyw4+tm7ZloQAkqlAqGrpiIHtuSZSFgJzJIX0SxdGRwuSgJzp59RPYLh71EjUXa
         73Kg==
X-Gm-Message-State: AOAM531IMY6C1QxhqH6xjvV6CNse3hcZ1CB+JU0KsOs/wMFOSjvIPa28
        YgleG8fcRIzgmaHrzbfbvWA=
X-Google-Smtp-Source: ABdhPJxgHo3bRpFJaffhsxpnrN2gJ2QQVEdNGNHMVeaOR5uqV8jz9ncKqI1Uv9yAEuJoAqdNZXGKrA==
X-Received: by 2002:a17:902:7681:b029:d2:88b1:b130 with SMTP id m1-20020a1709027681b02900d288b1b130mr801170pll.20.1601285195958;
        Mon, 28 Sep 2020 02:26:35 -0700 (PDT)
Received: from localhost.localdomain (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id mt8sm638606pjb.17.2020.09.28.02.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:26:35 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 2/2] arm64: dts: meson: change spifc max-frequency on Khadas VIM2 meson-gxm-khadas-vim2
Date:   Mon, 28 Sep 2020 17:26:13 +0800
Message-Id: <20200928092613.273998-3-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928092613.273998-1-art@khadas.com>
References: <20200928092613.273998-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change spifc max-frequency on Khadas VIM2 meson-gxm-khadas-vim2

max-frequency is 104Mhz

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 624632f06b5..23e6c63fefa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -341,7 +341,7 @@ w25q32: spi-flash@0 {
 		#size-cells = <1>;
 		compatible = "winbond,w25q16", "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <3000000>;
+		spi-max-frequency = <10400000>;
 	};
 };
 
-- 
2.25.1

