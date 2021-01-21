Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22EC2FEA46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbhAUMjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729946AbhAUMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:36:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32781C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id w1so2328607ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xE3OhLnmXbxUKjHkNefjPhc/3dSXZBCmru/WTSvgaR8=;
        b=tbrYXpw6+nOXmYFeia8aflNtinnzN/frEHtVk0kpIKOT9L0Pc5/R3cthL8uwVqg6X4
         /waK/JdK6aFUyCztZnpkp0+9LwM/UBmUVSGaUa94x3ZTpQ55RWgHQ81xb0lneY1BxmVq
         pApqdpLuQ0iyeSmXOB8wpO9gxjU+Eh9nUKiC+qqwN7X3cYblaIf/AzvQUbCEtrFgQFHh
         0/2b20TsIUDRtKiVvu5/CS2qFzBc6a7ixy3isqD9jw6MijWkrjFM5v0BPDlJhX5tO9Yl
         bFZCiPuKCDn8HIDMKXH8hHnpLF9xmuBqh2W+nDllZa3hxbTWxYk+ZFnQvM4ALrcgKQYz
         tooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xE3OhLnmXbxUKjHkNefjPhc/3dSXZBCmru/WTSvgaR8=;
        b=J/WkAx9/i6B8CFkD5DnWh4Rcp/f0MBopLgoYgWIrOJru79JHocwghDB8+HTYU7rra8
         6NZJnab8RydmXFtUI1RPjvucDVYx0Ck6MyTG0CLf6MElXdCdKH+aIekBHOSc8v31Eid9
         xZL0ZkMDbplBVNZw0NNonZU8R20uZg5Tge50FiZegEKAgHKKMVwp1X6aoAPZ0bdx6z3h
         zxLa+fgsGlvEODrh837B+5iUZYfaJ38gZG7D9xwDWdzwr6UwtnFpPC+/7ltD68Z/QnzD
         GUmr85xZ6+QPnBpxVq2iGaRpAhnn7RV8Tc+sPOv+cnQ8hikZIaT0MyzK1OOEVmBfqzK2
         1w9A==
X-Gm-Message-State: AOAM533x1qaLnwqybnW9JE+FHDKvjEOD3TcbzSPBIAPfeSYzsWsoBeml
        l4DuSoI0FqrXun4zd8mKs6bmvxhdVPXeYq71
X-Google-Smtp-Source: ABdhPJwafBX6xg+Ed3ia5TSMrt86x9ev9+afIIt+AnDrOjprC8n0qxxdyig99LtjYfSZ05H+x+P7LA==
X-Received: by 2002:a17:906:447:: with SMTP id e7mr8976629eja.172.1611232570726;
        Thu, 21 Jan 2021 04:36:10 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id s18sm2742124edw.66.2021.01.21.04.36.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 04:36:10 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] arm64: dts: zynqmp: Add DPDMA node
Date:   Thu, 21 Jan 2021 13:36:05 +0100
Message-Id: <3d11015512a085592f2aca76eeddc04178d38bbe.1611232558.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611232558.git.michal.simek@xilinx.com>
References: <cover.1611232558.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Add a DT node for the DisplayPort DMA engine (DPDMA).

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changed node possition.
---
 arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
index 3ca7e4ee51b5..c676afc95f6d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
@@ -227,3 +227,7 @@ &watchdog0 {
 &lpd_watchdog {
 	clocks = <&zynqmp_clk LPD_WDT>;
 };
+
+&zynqmp_dpdma {
+	clocks = <&zynqmp_clk DPDMA_REF>;
+};
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 66d53521ec58..f12cd24adbee 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -847,5 +847,15 @@ lpd_watchdog: watchdog@ff150000 {
 			reg = <0x0 0xff150000 0x0 0x1000>;
 			timeout-sec = <10>;
 		};
+
+		zynqmp_dpdma: dma-controller@fd4c0000 {
+			compatible = "xlnx,zynqmp-dpdma";
+			status = "disabled";
+			reg = <0x0 0xfd4c0000 0x0 0x1000>;
+			interrupts = <0 122 4>;
+			interrupt-parent = <&gic>;
+			clock-names = "axi_clk";
+			#dma-cells = <1>;
+		};
 	};
 };
-- 
2.30.0

