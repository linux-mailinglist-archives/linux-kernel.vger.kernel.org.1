Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEB0A2F0505
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 04:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbhAJD7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 22:59:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbhAJD7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 22:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 513C622EBF;
        Sun, 10 Jan 2021 03:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610251130;
        bh=3MHx5UbB1ooomqCTWXY1+5z312KLXluxdGw1tLFu/Co=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+qPkbrdFRRNxUndCzWiKVuhfbKCUaT1gEje8QHFvG0CXnaJOn+Dyyx5LP679ejvb
         ygFM0o9fXt81AEFgWgXUn8uLFnRD9DSe8YLHuMWVUGkmo64sBLLNaekVd0RGkG7RR0
         1MAhLvRQSIspzZmu1eqjGayO957zAL2QZPOBJR+DUCBq8BcQJDtTvo347MNvLlPG7y
         JfxPFk5FclKJN/F05Y4mkTE13q8SdNv/CGnVeUJLO5slYoaavffOWgclwKBHUIQ62V
         v1m1yDmRdGevmWWLwB73/i8VYm7+wOnMxE2TrmyhJYd9juk7jSWjzO2zKZfy6BDpMA
         z5cuzQFo0iUqg==
Received: by wens.tw (Postfix, from userid 1000)
        id 0C72B5FB72; Sun, 10 Jan 2021 11:58:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: rockchip: rk3328: Add clock_in_out property to gmac2phy node
Date:   Sun, 10 Jan 2021 11:58:44 +0800
Message-Id: <20210110035846.9155-2-wens@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210110035846.9155-1-wens@kernel.org>
References: <20210110035846.9155-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The gmac2phy is integrated with the PHY within the SoC. Any properties
related to this integration can be included in the .dtsi file, instead
of having board dts files specify them separately.

Add the clock_in_out property to specify the direction of the PHY clock.
This is the minimum required to have gmac2phy working on Linux. Other
examples include assigned-clocks, assigned-clock-rates, and
assigned-clock-parents properties, but the hardware default plus the
implementation requesting the appropriate clock rate also works.

Fixes: 9c4cc910fe28 ("ARM64: dts: rockchip: Add gmac2phy node support for rk3328")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index db0d5c8e5f96..93c734d8a46c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -928,6 +928,7 @@ gmac2phy: ethernet@ff550000 {
 		phy-mode = "rmii";
 		phy-handle = <&phy>;
 		snps,txpbl = <0x4>;
+		clock_in_out = "output";
 		status = "disabled";
 
 		mdio {
-- 
2.29.2

