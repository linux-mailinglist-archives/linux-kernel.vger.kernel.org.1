Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B04DA29A947
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897560AbgJ0KNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:13:08 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33335 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410349AbgJ0KNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:13:07 -0400
Received: by mail-pj1-f68.google.com with SMTP id k8so548670pjd.0;
        Tue, 27 Oct 2020 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGMhVGkOWdTn/0p2XdTQNQhvrf6bHXNE2N+5zOZaorY=;
        b=T2FCtEPH5GoptqgvaJULCqEp0zMARxcIGmLLFK7vAndzGvanN908eg1JcpY/QYLg/W
         CQuFM7gD4BxwVqWN9UsQ+D8XDEqTyv7tBYrJ/kQCfYFjSNHQ0KMLl+WRNwMHglTH+PUa
         iBsx0KIeL72kZ4zy0SWnnxVrzcnQmOpGodQLV9PuVl58BubP2EgrFGKM5Fwu00F6rmQe
         bNnjKzI2Ip1OrDGU4I+HdaXXS2f7eVZeGqQnvHLXLsUviSnBehr+z2HBwaHRL8Wyj0En
         FzqxuQM00xI8cvy2A3ykab0ICA7RVsIYDSxrrWUtH9qDP5djBbCSF2zOPf/Xcq+CkErL
         +aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGMhVGkOWdTn/0p2XdTQNQhvrf6bHXNE2N+5zOZaorY=;
        b=Vi46F+cJXjBcCzt2Yb63MJgmwDVASOv/uGB0J307BT44m4amJNCR0XmDmugl5aZ1/u
         hKjWkyjMH16GPmYT4OL+jsCHRkg6wQzkxFba7tmBaqmY5xYBMmufVhMqeAkXTh/ndd5N
         EI9K0XF+xMjs4i3u+0sDoRU+Jgip0BkDfaPWFxp5QLHTD272BwpjIO0lFZnDS2IY49G7
         Mpgz1THisCel4zzGs+GDW8iShHTNW7gDtbnuq82qAqjFH6PFrDbV5NgppUJ/peNbgAZ1
         WaqxfWsQR3BhG9u+IdLUdDKS5PqRe3wqNqEk6dwkGrWBpwnOHzlJa/6Fs8b0oCMuNRxZ
         T4nw==
X-Gm-Message-State: AOAM530rAnT/SDDgUynphtHlpunAtB3xchBC8+d3imSvePK3Af+rrhTs
        qo1UgqQjabfcJnJm2abMDF74XAgFVbMQfpdv
X-Google-Smtp-Source: ABdhPJwnjHAXzFVPp1Iv6aUHQ6W4YmpWeE9XmS6sZ7q0u1ddXvVi2GWGKQG/nxm/2oJnSFJ171s8Zw==
X-Received: by 2002:a17:902:740b:b029:d5:cbb0:fbe7 with SMTP id g11-20020a170902740bb02900d5cbb0fbe7mr1760544pll.27.1603793585954;
        Tue, 27 Oct 2020 03:13:05 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id x198sm1594117pfd.187.2020.10.27.03.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:13:05 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH] ARM: dts: sun8i: zeropi: remove useless pinctrl properties
Date:   Tue, 27 Oct 2020 18:12:58 +0800
Message-Id: <20201027101258.18094-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-zeropi.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
index 09c7e2988af6..7d3e7323b661 100644
--- a/arch/arm/boot/dts/sun8i-h3-zeropi.dts
+++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
@@ -52,8 +52,6 @@ aliases {
 
 	reg_gmac_3v3: gmac-3v3 {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
-		pinctrl-0 = <&gmac_power_pin_nanopi>;
 		regulator-name = "gmac-3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.29.0

