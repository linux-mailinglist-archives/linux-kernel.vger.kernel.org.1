Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857CA2E414C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439075AbgL1OKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:10:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439023AbgL1OKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:10:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D597206D4;
        Mon, 28 Dec 2020 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609164585;
        bh=bg4iWmhUG3PAZQooEuRtYgGQkI6PZIC7q8omJTXnOMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rU85E0uWFfhPb4PrbhiaAM/R9FoPLfew1pcgaiRy4Gpj2hrA4Rh3ow1jS3JGDtCAb
         4tFNIdjt8XuX4EJFsfb+aYDuXQjx5Olb8zxKpvEEHPvqBCbnqJC2dsHhdkA5N/dF9a
         RAasUyXmhGc6m6tY4QTj0kEhmmQLQOUDSJ1vNrXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 227/717] arm64: dts: armada-3720-turris-mox: update ethernet-phy handle name
Date:   Mon, 28 Dec 2020 13:43:45 +0100
Message-Id: <20201228125031.863145578@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228125020.963311703@linuxfoundation.org>
References: <20201228125020.963311703@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

[ Upstream commit 3aa669a994c9110a2dc7e08a5c0958a9ea5eb17c ]

Use property name `phy-handle` instead of the deprecated `phy` to
connect eth2 to the PHY.

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index f3a678e0fd99b..bf76ebe463794 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -146,7 +146,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
 	phy-mode = "rgmii-id";
-	phy = <&phy1>;
+	phy-handle = <&phy1>;
 	status = "okay";
 };
 
-- 
2.27.0



