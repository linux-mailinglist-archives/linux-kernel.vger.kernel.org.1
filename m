Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD72AA6C2
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 18:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgKGRBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 12:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGRBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 12:01:17 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67FC0613CF;
        Sat,  7 Nov 2020 09:01:16 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id gn41so6341883ejc.4;
        Sat, 07 Nov 2020 09:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j1Mhg9zNZL9zm+d/ViVbeh1jFha9crRB2Lx0TDAGCGk=;
        b=YOyqblNoJ4457IwuVC7eytLfj4NWcLL5XXxnSZFl9Aww+VMzbXiaUMbG0KP9evo1tJ
         WPMNmBSnuxl8NcMYQjEBwOFAZuUdOiMdV8/6aTNYx3Ggg+89TPst5JdlSidDWec6VcbP
         msMvI7585Ro9/yBFeiNHarmT0FpXXTsYd+eyp2evtgPQC4U9cIl+WPNf9hfmwkTsK+T8
         5Hx71wUjIqrRITMMuUOMrrmGJbf5kxxCtcq4QEjCUBtDbCDDGnbUem3UlGQkKXsq3dz/
         eQtqUNLjQxNnOJPRkVXPLsD2snazRSRZTDGAALKbZYQuABAcl8T6VGTmVzkVK3x3YhfH
         tPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j1Mhg9zNZL9zm+d/ViVbeh1jFha9crRB2Lx0TDAGCGk=;
        b=nI+E4KB6Y/WmWepLeQXu+9dKnNfGe3nANGjQnIEUjkeCQcBRib31+rjC7QnKBy57lm
         pm4MK5dOW1NVuK70j7DkqfnE+II2rVzeqS0NfCoZwTHz/GeIoR3ZdOO7Jiq0C/nrT0dV
         Pqp5049Vlkhv6LeplDxQV8HZBcKewHX2jDpFLqHLLzNr6/I+SgoYEvW1X6nOUUZ5WhcX
         exz1bu/13klYktGD8oQE71BHVccIoia5fJkVHSaxc57xeHmD10aDz6djY9qMn2o+3m16
         kF1w9Ui9wcgwlqaPGau7EfNCCsUOVBE+sto2309HG+iPEkxJK3lgVSC7b6W1aWmqj7na
         /ZCQ==
X-Gm-Message-State: AOAM533TBylFuCN0j5L7h66LeCwUVw7dVP3sRYBYw7EMyD/0fuW2q5Nn
        Jl3RCUQwXm6hLrWAKS7usgI=
X-Google-Smtp-Source: ABdhPJxZLjCikhr2EYeBq7HnBrQ84tl0WX8qqH488I4GMNBHumXjNKTLNENvkIBHt9VoYSThgNRamg==
X-Received: by 2002:a17:906:6d52:: with SMTP id a18mr7356951ejt.224.1604768475385;
        Sat, 07 Nov 2020 09:01:15 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id t22sm3729700edq.64.2020.11.07.09.01.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2020 09:01:14 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/5] ARM: dts: rockchip: add QoS register compatibles for rk3066/rk3188
Date:   Sat,  7 Nov 2020 18:01:00 +0100
Message-Id: <20201107170103.25608-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201107170103.25608-1-jbx6244@gmail.com>
References: <20201107170103.25608-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the conversion of syscon.yaml minItems for compatibles
was set to 2. Current Rockchip dtsi files only use "syscon" for
QoS registers. Add Rockchip QoS compatibles for rk3066/rk3188
to reduce notifications produced with:

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/mfd/syscon.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3xxx.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 859a74779..eb9d25d23 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -151,42 +151,42 @@
 	};
 
 	qos_gpu: qos@1012d000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012d000 0x20>;
 	};
 
 	qos_vpu: qos@1012e000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012e000 0x20>;
 	};
 
 	qos_lcdc0: qos@1012f000 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f000 0x20>;
 	};
 
 	qos_cif0: qos@1012f080 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f080 0x20>;
 	};
 
 	qos_ipp: qos@1012f100 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f100 0x20>;
 	};
 
 	qos_lcdc1: qos@1012f180 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f180 0x20>;
 	};
 
 	qos_cif1: qos@1012f200 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f200 0x20>;
 	};
 
 	qos_rga: qos@1012f280 {
-		compatible = "syscon";
+		compatible = "rockchip,rk3066-qos","syscon";
 		reg = <0x1012f280 0x20>;
 	};
 
-- 
2.11.0

