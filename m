Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8F02CBF0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388907AbgLBOHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388807AbgLBOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:07:52 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B864C061A51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:06:30 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ga15so4508815ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VViFxFAQk/Dkx4vjvV9oGNxK0PemXCTJcyLmBlIKKyA=;
        b=cL47bNhqpa3x5USkIcigZLKjV6p4UO236MRU5j/jpNIUbe72FhOmFeglcCDhruhmgd
         O8sRNLdcDXlY+1JiVphnRhQ7jfuZzOXJoEPb+OiZlN6GsWAdEPxR3+wPC/JCZwBAXh8P
         +kPyjQhoCgRU5fSJ8vZnNQ2WNGL0K+WH5exPUnjQrGDdRhJaThgdD8tAWlbcDkHbayJH
         0g6SQyvu6lK6oL/UacYDKiWoAKyPF9km/oBLOY8Q5+jBm+bEOoUIHPEZLHhdsfctFjgh
         aEddtvV2AXPu6YLLuzIxnRspskC/BdBX/WGcYgQ6Y0FeplRn/q20H24MzFG5gLxS6yXQ
         GFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VViFxFAQk/Dkx4vjvV9oGNxK0PemXCTJcyLmBlIKKyA=;
        b=i7A8iH6KdAokx5WO2m3gRzFAFvqMf/97k3z+cFwjN4kL21NGxHIfCYAc0iObCUAGan
         /akwM94e0XDquWFd7eMo8d7TiL2s+VyNZpzAIztMPjgMdqCec9mFK0zgIRdhaZrjhvuh
         xF1MK767zhVHo8nlzvdFI6Ms/d/LooREuS8UOdUnyJpGA36j340woMF8NWKI/KgyHMk/
         rb6ifAWhHIy8ktHvSsG6DcyE+ReBfPXHlIJBEK354jIECZYjlBnJNEhufQt6twV9Fktt
         PPmRUEysH+ybo5Mm/4rMh/m5XZGXG0a+k+l/sts7YlBE8ENb0ybvJfwc3SRZqCyMf/00
         lGRQ==
X-Gm-Message-State: AOAM532M4LEEEt5MokUyQC1LL3uaq/QPlc8AAlOy6YoD+iCvCB7P6lua
        6Tilx81pJ+M8Tmuqx5Rc1VjUTbPmKyLHr4xs
X-Google-Smtp-Source: ABdhPJzMLWC1zUilMeaUt+2C44lMS+bj//KaUelctZALEzJ6jI6HHccAyxryF32ur16l0qmPZft9Fg==
X-Received: by 2002:a17:907:a96:: with SMTP id by22mr2371741ejc.171.1606917988872;
        Wed, 02 Dec 2020 06:06:28 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q19sm1285936ejz.90.2020.12.02.06.06.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:06:28 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Venkatesh Yadav Abbarapu <venkatesh.abbarapu@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/12] arm64: dts: zynqmp: Add missing mio-bank properties to sdhcis
Date:   Wed,  2 Dec 2020 15:06:06 +0100
Message-Id: <67301f9bf40028a223ebf81a9dfd35deb4098e11.1606917949.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1606917949.git.michal.simek@xilinx.com>
References: <cover.1606917949.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing xlnx,mio-bank property to sdhci nodes. Also add properties with
0 value to have it listed in case that files are copied to different
projects where default case doesn't need to be handled in the same way.
That's why explicitly list them too.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on dt binding fix:
https://lore.kernel.org/r/5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 68ecd0f7b2f2..71ebcaadb7c8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -233,11 +233,13 @@ &sdhci0 {
 	status = "okay";
 	no-1-8-v;
 	disable-wp;
+	xlnx,mio-bank = <0>;
 };
 
 &sdhci1 {
 	status = "okay";
 	bus-width = <0x4>;
+	xlnx,mio-bank = <0>;
 	non-removable;
 	disable-wp;
 	cap-power-off-card;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index d92698ffbf8c..9abd10f6785a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -694,6 +694,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 5e2be9abc175..8ede619fea52 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -203,6 +203,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 	disable-wp;
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4ec6715abab7..d60a30787022 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -689,6 +689,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 2969c4b71384..758de05c4a4b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -572,6 +572,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
-- 
2.29.2

