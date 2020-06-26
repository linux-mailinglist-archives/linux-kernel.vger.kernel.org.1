Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E820AE12
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgFZIHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgFZIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:01 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF15220857;
        Fri, 26 Jun 2020 08:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158761;
        bh=XDjdr5MiK7GXK9xIxnBBov3CQznIvioVNLtmyltdqQE=;
        h=From:To:Cc:Subject:Date:From;
        b=FOwqoErMfSOylfvwmOJnt2/tTtHsMJsp8ycHEGenkJbYVGePynmSCsUX7eTbJvhQ9
         Trk7hvbON4Uvi30vgEOgtA3EclA1m0Dz+da+mTrj3sgJRM+wuxfyRZvKL3LFAHe0Oo
         3XA1bHk4dlVzmkA7IRlQquydD2c8CKkVV4/7cyAQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] ARM: dts: spear: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:05:57 +0200
Message-Id: <20200626080557.3680-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache: $nodename:0: 'l2-cache' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/spear13xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
index f187da4485f4..c87b881b2c8b 100644
--- a/arch/arm/boot/dts/spear13xx.dtsi
+++ b/arch/arm/boot/dts/spear13xx.dtsi
@@ -43,7 +43,7 @@
 			      0 7 0x04>;
 	};
 
-	L2: l2-cache {
+	L2: cache-controller {
 		    compatible = "arm,pl310-cache";
 		    reg = <0xed000000 0x1000>;
 		    cache-unified;
-- 
2.17.1

