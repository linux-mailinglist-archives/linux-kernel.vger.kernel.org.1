Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5DD2B9EC0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgKSX4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgKSX4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:56:19 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC792C0613CF;
        Thu, 19 Nov 2020 15:56:17 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id k4so7726632edl.0;
        Thu, 19 Nov 2020 15:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJVuP/tyLcDqKRyLoSC2QJxi4itDqwjxdPjdLIEaQNQ=;
        b=LuP0EqUwZN+CIESqxFLQ/REgMtM1M/WVChS0HjLB9jtjY0Wp6jl1wLJWY7lbgiLO6j
         lzkC4Fahy7sV35k7MLmCob1PT0NhXKPAQahaYAqu2+VQ6b05oApTzyfcYi8LEKqSc+ys
         AjiFvA6JEoKxrm5qBPXAGyDqXBZYmSCb52xOXGMX2gyS13hBKPSmFJHQAn3L0whGdD8U
         acMjGSjAqb3p70FHqks2KkV25M/QSYqnADdDXlt1yHVaGKIfe3BPZSvJS5hJQ+o3T/Fq
         NGyaeTrREbBt7N7q9/X+/Z1A/gdZvxWYMlX9zN+aUDYrSe6yG8W8zCdpq/IE7/85Qp/h
         x/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJVuP/tyLcDqKRyLoSC2QJxi4itDqwjxdPjdLIEaQNQ=;
        b=TiNOtCkCa1ZB0kxRV5I83BHzXqyDOd8XTyOdLhMw6s8wqIyOE2xioj22BIsS3BNFRr
         HTc2IDp9qK45rTF2gtlRzr3b60fyDsLjH/K/BW55Q0sSPm1QJhKi5nstKfx9UmMeNDgQ
         6dEN5/uwd54wlyVcJ8Tp+bdLJKkfG+l4/hCdcFQS85gJrRfpCz50cQv6O1A0aPvv6OlK
         xNzRCZhpKKTWcGAHIPazHNaS1ss5ocfuYRPtporMmh6J3zpXH0q3/Pg/1lE1KEy/AwAo
         pPhEhPKKYo71nFSsDUHAp+b0fUs6r/6TcveDNLlrwEkm7jXYwBKGP0Kxfc6EumE1Us+h
         31+g==
X-Gm-Message-State: AOAM53319uqK/VAjhuHS1Yq+c+4C0jcZkdPTllvFGDUeJpiyARRiciBx
        c5Ln+LGgXfSZzIGPRlMSJok=
X-Google-Smtp-Source: ABdhPJxps4CNBce0UR77q/bKrS9yzvkFDfqhnjewUSVCc3ZgZIw2GdtBX4e88p2ivRMbAOMLl79Lvw==
X-Received: by 2002:aa7:d2d2:: with SMTP id k18mr31928769edr.290.1605830176431;
        Thu, 19 Nov 2020 15:56:16 -0800 (PST)
Received: from localhost.localdomain ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id i3sm452987ejh.80.2020.11.19.15.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 15:56:15 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/18] arm: dts: owl-s500: Add Clock Management Unit
Date:   Fri, 20 Nov 2020 01:55:55 +0200
Message-Id: <7c45642753b94e2b2f4fcef0d3206b4c237e3135.1605823502.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
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
2.29.2

