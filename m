Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B7027AAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgI1J0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgI1J0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:26:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B18E9C061755;
        Mon, 28 Sep 2020 02:26:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x123so428553pfc.7;
        Mon, 28 Sep 2020 02:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CZrt3Fm5XKUtoI9fFOTZ8f2A2zRfVtH0JANKYInl63s=;
        b=dO768NCrvQk0DFPnwUtOzpNp8oFZb+sEms26ZzN4aQaQPSyB9Ayr0BlmtT1pcINN+9
         gEmlKeZMm0Ef1XDms6JcfOh6M3OPc5SUImriHMOxaEgi5JBKfSUuYxxo6dOLrvRorBcK
         TfNODYuneBvEk+0zrl2AS80D+xQ0kt/nx31J3fqszi1D+k7G7lkOCW1Xwie4VyHECBKO
         ClfTadPmhvXl8OQpOOysiluV1+Pl+Qhr9Qddou7aAfwdgc4InGi4ZMoK6lf5+9/6wIq2
         0LgE9oP3PO276G9bYiS2PkmUzZaPsKClAE8heX5xDFx2N1k45ckhrYV5bL8o76fVR7bW
         VPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZrt3Fm5XKUtoI9fFOTZ8f2A2zRfVtH0JANKYInl63s=;
        b=BFMxK6eUxJKLzZbTXHs3PQtqVLyDRAsSBIwLEqTgaIXh47PSuaCehR8Bl3BH6v8JOM
         L5k8+phYO9pvbOgu+DWBU+sztN7kiGn3bAXdpeiHPZ2UgTdgBioquqReubX+xcqgSA+8
         VvhQqz9P0vkEmuzeM9GpnvbdfTBqCvFvjXjRP3vvwMZ2YFW+KZT+WXIcHx05Q5kV88UN
         cu2rzJ+BRmK8pHD4sl+Zo2GItPSwF3gTzoPR96tmrsMBfbkJ8NKc6dLFwCDw/G0RBkmg
         4HiWQb+QXeJaCaZdOt/yCBr1cJi4+Ek4qJxLW+IzQN8kGLqsGR4JEbFtXZX33FGb8BFc
         6kfw==
X-Gm-Message-State: AOAM531x/IpfnQURgmFbIANI0q9DFfqo+6zkQLl2/UBeahHfEQi8DMu3
        +9IHuZjudoQesEPYnplwgAzy3zJYTiFXqIBi
X-Google-Smtp-Source: ABdhPJymHFV4oe/iHvShHYc4kpMWoMpmZZeo3j2yWlJH737z2UpPvUEZIDdzcgCqPjWiP4hwhHSXIQ==
X-Received: by 2002:a17:902:a987:b029:d2:8a38:5bbe with SMTP id bh7-20020a170902a987b02900d28a385bbemr757044plb.60.1601285191204;
        Mon, 28 Sep 2020 02:26:31 -0700 (PDT)
Received: from localhost.localdomain (80.251.221.29.16clouds.com. [80.251.221.29])
        by smtp.gmail.com with ESMTPSA id mt8sm638606pjb.17.2020.09.28.02.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:26:30 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     khilman@baylibre.com, robh+dt@kernel.org, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 1/2] arm64: dts: meson: rename led name on Khadas VIM2  meson-gxm-khadas-vim2
Date:   Mon, 28 Sep 2020 17:26:12 +0800
Message-Id: <20200928092613.273998-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928092613.273998-1-art@khadas.com>
References: <20200928092613.273998-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rename led name on Khadas VIM2 meson-gxm-khadas-vim2
rename vim:red:power to vim2:white:sys

becouse this led is white system led its not power led

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c7..624632f06b5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -84,8 +84,8 @@ hdmi_connector_in: endpoint {
 	pwmleds {
 		compatible = "pwm-leds";
 
-		power {
-			label = "vim:red:power";
+		system {
+			label = "vim2:white:sys";
 			pwms = <&pwm_AO_ab 1 7812500 0>;
 			max-brightness = <255>;
 			linux,default-trigger = "default-on";
-- 
2.25.1

