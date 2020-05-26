Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86CA1AFC8F
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgDSRMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:12:40 -0400
Received: from v6.sk ([167.172.42.174]:44094 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgDSRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:37 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 68275610B1;
        Sun, 19 Apr 2020 17:12:06 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH 02/15] ARM: dts: dove: Fix interrupt controller node name
Date:   Sun, 19 Apr 2020 19:11:44 +0200
Message-Id: <20200419171157.672999-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current ones makes validation unhappy:

  dove-d3plug.dt.yaml: main-interrupt-ctrl@20200: $nodename:0:
      'main-interrupt-ctrl@20200' does not match
      '^interrupt-controller(@[0-9a-f,]+)*$'

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/dove.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 3081b04e8c08f..ddd4653f52811 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -248,7 +248,7 @@ bridge_intc: bridge-interrupt-ctrl@20110 {
 				marvell,#interrupts = <5>;
 			};
 
-			intc: main-interrupt-ctrl@20200 {
+			intc: interrupt-controller@20200 {
 				compatible = "marvell,orion-intc";
 				interrupt-controller;
 				#interrupt-cells = <1>;
-- 
2.26.0

