Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5420ADE3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgFZIFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:36852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729160AbgFZIFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5151208C7;
        Fri, 26 Jun 2020 08:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158752;
        bh=1fZMJ3y3iXanBoUJxpiehdkGjNQckPHcelxa/DFVciM=;
        h=From:To:Cc:Subject:Date:From;
        b=LI4nHCU9gWKR3R6AgIuCPrfqdNwDLAgeVWqMVwMUxZqJLdnfCRcRrCIbgpkALwjjn
         ZCznLqwAMZdi+GaN8wTlaGARr1fbUeZ6S4ckwdYsmhhqD7easK7HHHfiVv0vaHPS0Y
         x8Wo2agJ9JFMCBNaVnE8d1MmAJD6N/f5RuDctf2w=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: vf610: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:47 +0200
Message-Id: <20200626080547.3569-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache@40006000: $nodename:0:
        'l2-cache@40006000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/vf610.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
index 7fd39817f8ab..956182d08e74 100644
--- a/arch/arm/boot/dts/vf610.dtsi
+++ b/arch/arm/boot/dts/vf610.dtsi
@@ -10,7 +10,7 @@
 };
 
 &aips0 {
-	L2: l2-cache@40006000 {
+	L2: cache-controller@40006000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x40006000 0x1000>;
 		cache-unified;
-- 
2.17.1

