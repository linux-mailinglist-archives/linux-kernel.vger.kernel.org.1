Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B9120ADE2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgFZIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:05:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:36716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729138AbgFZIFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:05:47 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C6402082E;
        Fri, 26 Jun 2020 08:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158746;
        bh=Pw00uDHv0w9ajiJYnlNTh7BVUE/3W1DjnoMCQt50UtA=;
        h=From:To:Cc:Subject:Date:From;
        b=VufpYp/+0rkAKScNxAbMJqVnMsByfP2KkL5cOFVOHwVK/d+MIl76KGjbHuoWzY+1r
         ftWwzq3qorW4OUmxHbPVHphhb5akmPxiftD5uP3fDM9QgoN1iWPoy5+oNm+41yfkV3
         dy/8oZe0eVG5y9qxxCSyO91wAzdMzOG+yNtWsNxE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: tango: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:43 +0200
Message-Id: <20200626080543.3511-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache-controller@20100000: $nodename:0:
        'l2-cache-controller@20100000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/tango4-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
index 54fd522badfc..d584da314500 100644
--- a/arch/arm/boot/dts/tango4-common.dtsi
+++ b/arch/arm/boot/dts/tango4-common.dtsi
@@ -51,7 +51,7 @@
 		};
 	};
 
-	l2cc: l2-cache-controller@20100000 {
+	l2cc: cache-controller@20100000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x20100000 0x1000>;
 		cache-level = <2>;
-- 
2.17.1

