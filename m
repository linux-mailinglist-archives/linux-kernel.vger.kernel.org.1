Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E40281813
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388039AbgJBQic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBQib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:38:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 209CE20758;
        Fri,  2 Oct 2020 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601656711;
        bh=qkh510WIJUIXJC6EjQReA8lvb6hAq2pILbQUF1B+RGQ=;
        h=From:To:Cc:Subject:Date:From;
        b=z+9u2/qmKroPCQwuYp/qNYIeTNX+Goy5hltz9eDc7xxxxjl+9c2Y4moDo0KmtiKsj
         a8JDALNZnZwp5RPzoXnFDu1MKViUmr3a9Y5XnL5X5aO9ViBMJjYQo7oCBkqMeFmXQE
         M8wplfB3NIbKSHb3a7wiPye9ilPzVBr0VoUyGhS4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v3 1/2] ARM: dts: aspeed: fix PCA95xx GPIO expander properties on Portwell
Date:   Fri,  2 Oct 2020 18:38:21 +0200
Message-Id: <20201002163822.7678-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCA95xx GPIO expander requires GPIO controller properties to operate
properly.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts | 2 ++
 1 file changed, 2 insertions(+)

The dt-schema changes were applied.

diff --git a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
index 4a1ca8f5b6a7..03c161493ffc 100644
--- a/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-portwell-neptune.dts
@@ -121,6 +121,8 @@
 	pca9555@27 {
 		compatible = "nxp,pca9555";
 		reg = <0x27>;
+		gpio-controller;
+		#gpio-cells = <2>;
 	};
 };
 
-- 
2.17.1

