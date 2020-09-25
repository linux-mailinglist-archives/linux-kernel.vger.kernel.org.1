Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7041D277E98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgIYDbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:31:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9E6C0613CE;
        Thu, 24 Sep 2020 20:31:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g29so1383874pgl.2;
        Thu, 24 Sep 2020 20:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9gQAgZSv973+dBTaKrbsbpx8GcPHmOUBh5NqZ+BH3Qk=;
        b=mWcxDydNQITjPvSieO4SexuAQDqzL7t81vPCPsb5gooiW54IzjTtux1sNdnw+xW6ax
         pIS1+NHZ+LNV6vbgaK4d5xQxwzzglfDdV+G68wt8b7ou8obRBFoDXYPaNBlqLYKekP0L
         ywEx4GG1t23FpXlrvdDJnd7eX5vuql96YlHXD2Dl+omlOsI7Awx8HDCjUgI/x24aN+TG
         w8Eb2KuA97v93Y7xb7wfxpMZ93ZNsUR0eIbGKyUFFfwF5bxp+s4kTS11RaKrFLMGSkW6
         0ST0+KlCG3+1OFEXvQnKym3hU7NI/WcrxG2leuAFJIQa9wdPUXr9R/yrJ5Bjsnu9w2GH
         rvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9gQAgZSv973+dBTaKrbsbpx8GcPHmOUBh5NqZ+BH3Qk=;
        b=iqbuWg7pf0XSLJq2hqZgDu9NK9ZYlwHaJLJoapRb4yvOPwPnjs7vRE6rs+ODx8CO3R
         kkUuhAn4lA1zmric0gViog3xdoroU7F25f6t0yFrd16MQjGQ2Ic58F8riZNgbVbq1uY1
         6kFetfy7a4uZfoJzikoOzvJpH67D5Bs/Qd2LfZgWiQzLqg462I/ghJfG1vKyVbTmmLTf
         x7AWYzZlX9WLuTG6mFDNc2+wbCBgOQBhXDjjuB4qsKayavzfQeIpmKe/q8t6iZ81XamQ
         LDS41NMEFIROEhbWSwt2n45fKQVZDxma/re7bScJ1Qnq6yZ3fTaE1B+lTwwLgGQWHLx3
         hlXQ==
X-Gm-Message-State: AOAM532U0VcJhGp4ujIDNf8uIpbmpXOM8ZUV9lJt9HE4lIXp27ElroSj
        8PSvrXJHkB55QHvgnUSq9m0=
X-Google-Smtp-Source: ABdhPJyiPbeyfrGRU+MOW9srDk2nrCkL4TU43GjHC42bEyn4TN0OW4QMS/IRcVdPZz+I5/ZWuftPGg==
X-Received: by 2002:a17:902:7c0c:b029:d1:f38b:713b with SMTP id x12-20020a1709027c0cb02900d1f38b713bmr2343352pll.44.1601004683316;
        Thu, 24 Sep 2020 20:31:23 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:31:22 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 7/8] arm64: dts: meson: enable RTC for VIM1 meson-gxl-s905x-khadas-vim
Date:   Fri, 25 Sep 2020 11:30:16 +0800
Message-Id: <20200925033017.1790973-8-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable RTC for VIM1 meson-gxl-s905x-khadas-vim

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 8bcdffdf55d..354f21d4171 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -98,7 +98,7 @@ &i2c_B {
 
 	rtc: rtc@51 {
 		/* has to be enabled manually when a battery is connected: */
-		status = "disabled";
+		status = "okay";
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
-- 
2.25.1

