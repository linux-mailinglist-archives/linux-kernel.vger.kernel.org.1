Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD90B2CBF57
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgLBOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbgLBOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:15:47 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EE3C0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 06:15:00 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so4591685ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 06:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+2HhTD5jTn+vklEh4aL5/wMsPXq9tv2fr1AHIakSbyA=;
        b=rblOepbVJChntb5pg5cBLGVX3v5Npt5ASjgefyud4GisFo2yFRCTCLQcnHLv57iJZy
         FZjtA/ifq/EDkjfS0l3JHXPmP2cdOXhs+QN6ZKrucHFvH2GJSJlAzf1Rwm1aqfc5zCCc
         EFzyofbZFHOb/XGKTWCoy1oj+Z6t36qZziiighBXILmtEKnXff210NjSvUZfOgLY9Acb
         mXwf8UhknA358OtTYehSJdZwuX7AFRj75iv+wdDPi7xXGWvD+NUxyftJkMqQCmlwbpIc
         FQDXqe9nJY8S0gg6I7VBEmVgYmYH1yWmE/86lDoFae28hkw97olHAQ3fZjM8bAKfWRsr
         BdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+2HhTD5jTn+vklEh4aL5/wMsPXq9tv2fr1AHIakSbyA=;
        b=TJnOT4xqUkxYsaTDaThixSTb0iL9hCWWOQQTiC/zAvm8GX7hET+lgunIML3DiVZZFp
         xLxmB/XYb2syEKjpWrZ7/o1SDkA34tnsSdWzYx1OEiHH8BY2D+mi2pLPwygp799OzCOK
         tVD3s65OZBbkGPTVSIKyBdoqZiE1lRxqMr6VuKqHGhZkm5FtrGhZ53ptMHGPvhWZe3i4
         JBFoqbRjqUg4L0Ik3Q+0PY1pwcyco753D9+L6XLTSBiE7woKrTxOMNAfBeZGtM4FoA1t
         JPj3hNcKIshSTuo9mekH5TuRCC54uTTYxYuhwRpMVt0lreuDhyzaIFOwuQfmYR5EUqni
         k3cQ==
X-Gm-Message-State: AOAM532h6XzcUU1sEMM9qqU0oUyG7exOB6mxZ8f9EHue1spwJWZXWGsD
        XY8vUK74WI5kwmYh1vhCEt1bNb2F4d+cOQVf
X-Google-Smtp-Source: ABdhPJxnHneDF4S7sioqi9JTCEQu+HKLJ0bOri7kp9DYkz53zZhgEMxhLu+jj3lvj4omuauMDnAt8w==
X-Received: by 2002:a17:906:22c7:: with SMTP id q7mr2526176eja.486.1606918499010;
        Wed, 02 Dec 2020 06:14:59 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e19sm20742edr.61.2020.12.02.06.14.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Dec 2020 06:14:58 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: dts: zynqmp: Add address-cells property to interrupt controllers
Date:   Wed,  2 Dec 2020 15:14:57 +0100
Message-Id: <e4f54ddce33b79a783aa7c76e0dc6e9787933610.1606918493.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
commit
"81e0919a3e21 checks: Add interrupt provider test"
where reasons for this checking are mentioned as
"A missing #address-cells property is less critical, but creates
ambiguities when used in interrupt-map properties, so warn about this as
well now."

That's why add address-cells property to gic and gpio nodes to get rid of
this warning.

CC: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

I was grepping DTSes in the kernel and most of them list it as 0.
In gicv3 case where its node is added it needs to be filled property that's
why also non 0 values are there.
Definitely please let me know if 0 is not the right value here.

Based on https://lore.kernel.org/r/cover.1606917949.git.michal.simek@xilinx.com/

---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 14a2e69cf98b..5b2051ac6965 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -368,6 +368,7 @@ fpd_dma_chan8: dma@fd570000 {
 
 		gic: interrupt-controller@f9010000 {
 			compatible = "arm,gic-400";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x0 0xf9010000 0x0 0x10000>,
 			      <0x0 0xf9020000 0x0 0x20000>,
@@ -574,6 +575,7 @@ gem3: ethernet@ff0e0000 {
 		gpio: gpio@ff0a0000 {
 			compatible = "xlnx,zynqmp-gpio-1.0";
 			status = "disabled";
+			#address-cells = <0>;
 			#gpio-cells = <0x2>;
 			gpio-controller;
 			interrupt-parent = <&gic>;
-- 
2.29.2

