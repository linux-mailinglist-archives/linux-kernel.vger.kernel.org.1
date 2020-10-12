Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D966828C357
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731570AbgJLUwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJLUwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:52:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9292CC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:52:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so20859587wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e+bkzKiAfFdHWo2iBUMur2DQuOMcGF3zo5qvmeIt97g=;
        b=17HX+CBl3cCBM8alB53y26WgGSoL4yOdOTcjv5H317ipfio7nzX8ecLju5ILpEI5EN
         VsxVuJSujCOxvw7fq0mDp/2Dgv52ZJTIIQb19saH7DtAo5qpg3tChqg9LVDrjN2Weyvy
         lAd50rifN+a/W7r/4Or3BhSU4izPchvEdBWItIk5lzLatuRPePwdT1UpdXlSlFQAMnsN
         YXoq5oXhCvHs4VFJocaCRnFiy6SGJzbou78OKfH604JXyekoYmWvAHnuO9yvrdBNKFN9
         rNusTFsKDIRfhZ7KO6P3kiaxVrY5Bo9uaHmuqGTFujq0MzdKrlnAGDU4fENxWa6QHSi1
         ZD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e+bkzKiAfFdHWo2iBUMur2DQuOMcGF3zo5qvmeIt97g=;
        b=OBkGjqjC3d7B+Sb6DN60suMQ9MlCu/MuDtIraXqWPg1NKj/ETnOVhaGqRrqWPFcnLY
         CJjoLnHaDaC58OoY15iNzb9J48rxbiFUw+Ik7wG95qqi3RmecafMDGQ6t4IC9BW1VIqM
         hmVzBwmo7Etqrffx03kvWxlWOyr2p+YJZvxr8G0a+Az970Eur8N1BgudvTzKlzofgLXn
         BHUcpYE+jGZe1WM51bMb1Vr7+9OvzHhlMzlDrvpxAxp7afeIdD9REb3CBxMr/QC+nWYw
         LrsF54F6xjHHinFoRv8mmEFIwCr7CsqqjJWg/jeiOmlD+vcExcwZ9TXTiy11NbUlQtCn
         Uz9g==
X-Gm-Message-State: AOAM531lwFw/lRH9ipokJmOod7UfM2kZH45KmlRSP3uYFImryRsRntz2
        Jzgxm2Xmvk+IbBVNhkK4euHH+iro1baWzGte
X-Google-Smtp-Source: ABdhPJxM+7DnCHKyvrcJBWveKSAlmwc8SbAavQH79tcH238Z72uusz7nKP34YEXTbOsLpmRNUG4YmQ==
X-Received: by 2002:adf:df07:: with SMTP id y7mr34659457wrl.347.1602535952752;
        Mon, 12 Oct 2020 13:52:32 -0700 (PDT)
Received: from localhost.localdomain (170.175.185.81.rev.sfr.net. [81.185.175.170])
        by smtp.gmail.com with ESMTPSA id o184sm3623936wmo.37.2020.10.12.13.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 13:52:31 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, pmeerw@pmeerw.net,
        lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8516: add auxadc node
Date:   Mon, 12 Oct 2020 22:52:18 +0200
Message-Id: <20201012205218.3010868-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012205218.3010868-1-fparent@baylibre.com>
References: <20201012205218.3010868-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node for the auxadc IP. The IP is compatible with the one found
in MT8173 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8516.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8516.dtsi b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
index 89af661e7f63..943c426e9aaf 100644
--- a/arch/arm64/boot/dts/mediatek/mt8516.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8516.dtsi
@@ -470,5 +470,15 @@ usb0_port: usb-phy@11110800 {
 				#phy-cells = <1>;
 			};
 		};
+
+		auxadc: adc@11003000 {
+			compatible = "mediatek,mt8516-auxadc",
+				     "mediatek,mt8173-auxadc";
+			reg = <0 0x11003000 0 0x1000>;
+			clocks = <&topckgen CLK_TOP_AUX_ADC>;
+			clock-names = "main";
+			#io-channel-cells = <1>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.28.0

