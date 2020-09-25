Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFE277E89
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 05:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgIYDaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 23:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgIYDaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 23:30:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D1C0613CE;
        Thu, 24 Sep 2020 20:30:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so1854966pfd.3;
        Thu, 24 Sep 2020 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxfWggxlCNiPgOT3zzYw/A1cG478tHhARlp7JZfrg1c=;
        b=IBhuusYfYUggClU+tuE/hbihGaGSJrO+908pYJNnm+U4YyDjQn64WactETvGH8aV5Y
         DOyUZQnOvMNRRcqyvbAOAnjflehDH61mo3x3TZRyn/AnfOI2A9Ex5ccIbQu4br9oxJD7
         /CT3uWzzFCVNhDJP8BH2Y+NbCtQ2ZMAIYjj6Wz7ivPCZs372uasVqIIBoTjkP2mjqDOB
         JsVJf/+p0OGFfb/avWfBOW/HwsDFNobAfKBs38+pNF1iluzNZnlGxHRfNcfWBPbPbFhJ
         FZ6mRakMO3/WNp5DFlblnXgbeibVzDDRwri+A8c5cbhFaYs1ulPW4/BpNNrwarvhBckv
         CEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxfWggxlCNiPgOT3zzYw/A1cG478tHhARlp7JZfrg1c=;
        b=eNdGyQFYSt9jrPCWj+VIVaQG91OeTW67VK1WajVIFWd2gomsQi+WXGIv3kRYdSyrfJ
         0SfRP6ZUHubJE0v/rmMWDcjRGZTrK4KXrK9dJZxmisevlttzVI03qatYH91lrQ4+Sc90
         Amg1zwrfrB4mXRvnLxfvka1wF5TVxZBUp2zQdbfSbkAIFn5Q6LcxY5IJFic/44e+ANfK
         R8KngjLkl9ggfq3r3yttlNTw8e8ebws21vC5tGo9Hk8OoM8z4mL2SUZMJeQXDkXQOFF5
         hkTvs18LJMsTMEYl2O6enQ+pQslzb8M6W7Y7E/xFAfX+M5QS1F61UbOHD9jXyQ6si48C
         hV2g==
X-Gm-Message-State: AOAM530gJwRZFAGCqlfQijmb/B6ld4cpd6J/vwOAR3ywZkJXNDXRBXW5
        Ov0Maud0Rh0C2tB4p+T+PBQ=
X-Google-Smtp-Source: ABdhPJzZiw2VY3TseQ9QC6u++rycdtznfY0tG3gFg40eaOSkTX49BURQwQMVZIJ5wECgvbgIQrntRw==
X-Received: by 2002:a17:902:6bc9:b029:d0:cb2d:f272 with SMTP id m9-20020a1709026bc9b02900d0cb2df272mr2242820plt.11.1601004651562;
        Thu, 24 Sep 2020 20:30:51 -0700 (PDT)
Received: from universe.lan (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id o5sm571670pjs.13.2020.09.24.20.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 20:30:51 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 1/8] arm64: dts: meson: update spifc node on Khadas VIM2 meson-gxm-khadas-vim2
Date:   Fri, 25 Sep 2020 11:30:10 +0800
Message-Id: <20200925033017.1790973-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200925033017.1790973-1-art@khadas.com>
References: <20200925033017.1790973-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) The VIM2 Boards use w25q128 spi chip only not w25q32 or w25q16
   it's not really seriously becouse have 'jedec,spi-nor' which
   have auto chips identifications

2) max-frequency is 104Mhz

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c7..a6baf865aa2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -336,12 +336,12 @@ &spifc {
 	pinctrl-0 = <&nor_pins>;
 	pinctrl-names = "default";
 
-	w25q32: spi-flash@0 {
+	w25q128: spi-flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = "winbond,w25q16", "jedec,spi-nor";
+		compatible = "winbond,w25q128fw", "jedec,spi-nor";
 		reg = <0>;
-		spi-max-frequency = <3000000>;
+		spi-max-frequency = <104000000>;
 	};
 };
 
-- 
2.25.1

