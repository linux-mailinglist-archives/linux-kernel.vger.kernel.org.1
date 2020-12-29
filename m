Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EAF2E741A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgL2VSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL2VSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:18:14 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F112BC0613D6;
        Tue, 29 Dec 2020 13:17:33 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cm17so13736823edb.4;
        Tue, 29 Dec 2020 13:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MCY+sEyyl2Oz9uQwE8NpC9+be8Ioq/uV7gHwSLiNbH0=;
        b=f+eyeRalfs43WfZhxzte0P9wdAJbqIrBdNFNwOlCDgkjW1m4kLLH+SoFGdSCL6OoEr
         ywoYandxbhdD14azgQVYgL1yya2IuVjaIGBk+CHttw7aYi8kqFKeQPgt7qvCcUPmejW+
         JtzIIpIR59Hzg4kBlet2TkmDHXbGFKLW+JXT9UMWyKmTCFc2Oajm0IP6wpqCw/mMKZAG
         XsAxv7ioUMFo9+SPtxpeNcvXa89i8peBsGjrb0bj5W9MXrTaS8hlmgTYwWINrE/59c2t
         JMy1a9/9h+iIthPzlDKYb029qGIggCBTHQDBhnf/Ks8vGYigN8NVrZd0IuU4SJnUfjqW
         lzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MCY+sEyyl2Oz9uQwE8NpC9+be8Ioq/uV7gHwSLiNbH0=;
        b=T3SGe5H6LeCJjgD0Akur4qeuYYWE/0+STkAmOMOTLCmfgREUrpP1swPiS23YWq69i3
         0WHKb65QePtuYaeG8gWbCqm95SZeE0raeMJatmaVMMNU4LW98b8x9IUikGriXDbxMiZX
         s8aMfRKWUaetXXTJLp2mAk2G4AsQprd4Uy0EajmVGi+sOwjmy1qqKaRwWdF8aXeFjFkk
         8NgCZYBrHIi+78iqeUIRDmYXJyIz6P9W4fBJ2To4rjPbQ2Eg79r1ZGVm8FHOiFViI5ll
         342moL9sq4E/+OdrIDFvwLy8ATUDnsMaxcsN/dItoVFojilUpWkJwnp36EhY1GAU/1vE
         aO9Q==
X-Gm-Message-State: AOAM533KLb4wG0k+29ZuxTwpxCtR5kZ5/Qu1Nig+jmEG7knaX4O9pQVv
        L0bR8o0DV5djmkDeWZho7+8=
X-Google-Smtp-Source: ABdhPJx5PQUATir9V+va+z/rawqMKGwQYY3cFZI+P49haleVVrctlZh1y5KmmRGz1g7wO3dH1RwnZg==
X-Received: by 2002:a05:6402:b4d:: with SMTP id bx13mr48023724edb.93.1609276652699;
        Tue, 29 Dec 2020 13:17:32 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id u9sm37354553edd.54.2020.12.29.13.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 13:17:31 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 01/13] arm: dts: owl-s500: Add Clock Management Unit
Date:   Tue, 29 Dec 2020 23:17:16 +0200
Message-Id: <d05d2d0907ffcd090b36e17918039867780b8355.1609263738.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
References: <cover.1609263738.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Reviewed-by from Mani

 arch/arm/boot/dts/owl-s500.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 1dbe4e8b38ac..5d5ad9db549b 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -5,6 +5,7 @@
  * Copyright (c) 2016-2017 Andreas Färber
  */
 
+#include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
 
@@ -70,6 +71,12 @@ hosc: hosc {
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -169,6 +176,13 @@ uart6: serial@b012c000 {
 			status = "disabled";
 		};
 
+		cmu: clock-controller@b0160000 {
+			compatible = "actions,s500-cmu";
+			reg = <0xb0160000 0x8000>;
+			clocks = <&hosc>, <&losc>;
+			#clock-cells = <1>;
+		};
+
 		timer: timer@b0168000 {
 			compatible = "actions,s500-timer";
 			reg = <0xb0168000 0x8000>;
-- 
2.30.0

