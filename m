Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4375226B788
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIPAYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:24:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgIOORJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:17:09 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FCA21D7D;
        Tue, 15 Sep 2020 14:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600179320;
        bh=2GNqkOv+TkZIIOeHxKUCnazxE94h8uN5hght1x1Vblc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=azOdlEYQCTSur74j1V5L2pYiwwzshF06C90BnMWz7EaOmQLDpOg6wYSbUS0JEo1m4
         3EEmY5LbmXz9YFxOX8GQwsdxTTckA2s8TcF1iEiXxHTLOZxBjZa0ILmmOpAiwF+ZX9
         88gqM7+xZPD4srLGS6yGR/tLPAlYdVjeB+gMMoLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 14/78] ARM: dts: NSP: Fixed QSPI compatible string
Date:   Tue, 15 Sep 2020 16:12:39 +0200
Message-Id: <20200915140634.255645479@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915140633.552502750@linuxfoundation.org>
References: <20200915140633.552502750@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit d1ecc40a954fd0f5e3789b91fa80f15e82284e39 ]

The string was incorrectly defined before from least to most
specific, swap the compatible strings accordingly.

Fixes: 329f98c1974e ("ARM: dts: NSP: Add QSPI nodes to NSPI and bcm958625k DTSes")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 273a316045798..b395cb195db21 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -274,7 +274,7 @@
 		};
 
 		qspi: spi@27200 {
-			compatible = "brcm,spi-bcm-qspi", "brcm,spi-nsp-qspi";
+			compatible = "brcm,spi-nsp-qspi", "brcm,spi-bcm-qspi";
 			reg = <0x027200 0x184>,
 			      <0x027000 0x124>,
 			      <0x11c408 0x004>,
-- 
2.25.1



