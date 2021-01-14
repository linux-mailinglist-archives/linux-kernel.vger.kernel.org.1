Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A03C2F6125
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbhANMlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:41:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbhANMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:41:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB0DF23A55;
        Thu, 14 Jan 2021 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610628054;
        bh=b/W4PW0EPKvJmL/a7kdBwOgnv6EmKKIvACBIhLF4GSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cSvzfDppnXS3YOrvtrucH9SxIqyNG6S2sGq9J4nOy/VSbCE5u9NgUvAvwc85P0QIM
         Q0RFrgMkLTd92bihmna1PPFjmDptKgN8DPeY8pVOZUXaYPn/jD5oqLRUizjNMdgYRT
         WInskiDP2K3Kj7CLy6zbvak96yzquRY0ZmoLEBbb+QNdgk2GPUvzraqhVTO9IrmVEl
         Gh9USvDMdBBtpIznjp9y8i7OzXq3n3OrKKUmDn0HjubrgN5yT8uGEF2ZCzzuRHYU2b
         sKVxh33TA1ce3UxT2AXltXsKhtuEfQpc/bDhRZdgmYyI4Yo8WJALjKMCm0yiiFD208
         G32GTWcAmir0A==
Received: by pali.im (Postfix)
        id 15944621; Thu, 14 Jan 2021 13:40:53 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        "Luka Perkov" <luka.perkov@sartura.hr>,
        "Andre Heider" <a.heider@gmail.com>,
        "Vladimir Vid" <vladimir.vid@sartura.hr>,
        "Russell King" <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH mvebu v2 01/10] arm64: dts: marvell: armada-37xx: add syscon compatible to NB clk node
Date:   Thu, 14 Jan 2021 13:40:23 +0100
Message-Id: <20210114124032.12765-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210114124032.12765-1-pali@kernel.org>
References: <20210114124032.12765-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

Add "syscon" compatible to the North Bridge clocks node to allow the
cpufreq driver to access these registers via syscon API.

This is needed for a fix of cpufreq driver.

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: e8d66e7927b2 ("arm64: dts: marvell: armada-37xx: add nodes...")
Cc: stable@vger.kernel.org
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index d5b6c0a1c54a..a89e47d95eef 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -156,7 +156,8 @@
 			};
 
 			nb_periph_clk: nb-periph-clk@13000 {
-				compatible = "marvell,armada-3700-periph-clock-nb";
+				compatible = "marvell,armada-3700-periph-clock-nb",
+					     "syscon";
 				reg = <0x13000 0x100>;
 				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
 				<&tbg 3>, <&xtalclk>;
-- 
2.20.1

