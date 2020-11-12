Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B012B0530
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgKLMwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgKLMwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:52:41 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14113C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:52:41 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id v4so6045507edi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 04:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VO5buX3O3865XeSNAiYdkmHwudPvyFuKPpXIgcQuiQo=;
        b=B6KAVAL2EmeGP3N+DEht9mufwYAaCbCfkacyMFL0brBEYT9mD0dCKeFFTplJf2Xvpb
         ZjDj/GJutnYrfwHF4Nfi0WfG8SjhVPLDlnWRD0l+Qch6xKkbgxECp+jsSqP9J49DuE41
         4fdoc6Pafv5lHMcf2Qs3RDODPOCTkuZ20mFXs9eTU+Oikpy3jiddtOqv2HyKMvZvLohN
         w5akI2+/HrvAiK9P8CxLnGD8Cwfm8WLUApIaTRr0vymEcZHTbkcMSiYDKI3NvyCMvRtY
         niFVY/pWUaUZ4oNPqMYMyqU/+d9+0yvxRoiRtFUnTIBugeV5SYOL9dbIGCvrwdXJH/7m
         wgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VO5buX3O3865XeSNAiYdkmHwudPvyFuKPpXIgcQuiQo=;
        b=iIS90BiMo2fWeE4DZZiPR19qX/+5xbsSLZccHSrr+hkZ5QHxSRQ77gbKiC7unRyqYK
         AUS0lDCyd0YYxdqTpYAYGGJ4FzHwPl8n3iJNv1ZutTvSatKavBNSr2WR0vLS4BFK/HCE
         COp6s5+69w4e4uOhemiLAbvTovP/5mO770iQHG9CgzeihNBx6pGRUZhyWnOz+KMzvihn
         RFWT1oWVqEBVqhBr3pn1NeiI5/7fedNVvtTf7TCOF/RjlWU7cIq4rBYzGYYLvaU/vyro
         8GCLdo+0Lm8WFWKpqN5MXA5q7u1dnCd7EkbwrF1SDWuoymlevZ2ZMsC9o2+fpTroa5uW
         cB/w==
X-Gm-Message-State: AOAM5336cwxuyU1Q4bMLIBBSFSkTwfrH3LsmBlXbZBjfSJpr5u+2Ldec
        mSWtQwHmNnFbz96thBr88qcZPZjy3mal6cxL
X-Google-Smtp-Source: ABdhPJx2CKi0jnU8tN9TzrbbmKHvJWYTcuNCg5vCINCVEJ0w7herYQ+R+s/dwi6a680loLwitZyRNQ==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr4921489edw.378.1605185559553;
        Thu, 12 Nov 2020 04:52:39 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n22sm2366989edr.11.2020.11.12.04.52.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Nov 2020 04:52:38 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Wire mailbox with zynqmp-power driver
Date:   Thu, 12 Nov 2020 13:52:34 +0100
Message-Id: <5d3523150890e494df308ee69523d0f0e7b33b22.1605185549.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The support to driver was added by commit ffdbae28d9d1 ("drivers: soc:
xilinx: Use mailbox IPI callback") that's why also enable it via DT by
default. It setups communication with firmware via IPI interface.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 66dad22b8a76..68923fbd0e89 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -99,6 +99,29 @@ opp03 {
 		};
 	};
 
+	zynqmp_ipi {
+		compatible = "xlnx,zynqmp-ipi-mailbox";
+		interrupt-parent = <&gic>;
+		interrupts = <0 35 4>;
+		xlnx,ipi-id = <0>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ipi_mailbox_pmu1: mailbox@ff990400 {
+			reg = <0x0 0xff9905c0 0x0 0x20>,
+			      <0x0 0xff9905e0 0x0 0x20>,
+			      <0x0 0xff990e80 0x0 0x20>,
+			      <0x0 0xff990ea0 0x0 0x20>;
+			reg-names = "local_request_region",
+				    "local_response_region",
+				    "remote_request_region",
+				    "remote_response_region";
+			#mbox-cells = <1>;
+			xlnx,ipi-id = <4>;
+		};
+	};
+
 	dcc: dcc {
 		compatible = "arm,dcc";
 		status = "disabled";
@@ -128,6 +151,8 @@ zynqmp_power: zynqmp-power {
 				compatible = "xlnx,zynqmp-power";
 				interrupt-parent = <&gic>;
 				interrupts = <0 35 4>;
+				mboxes = <&ipi_mailbox_pmu1 0>, <&ipi_mailbox_pmu1 1>;
+				mbox-names = "tx", "rx";
 			};
 
 			zynqmp_clk: clock-controller {
-- 
2.29.2

