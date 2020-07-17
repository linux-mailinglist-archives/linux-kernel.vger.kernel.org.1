Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7805D224012
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGQQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgGQQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:01:00 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43C58207EA;
        Fri, 17 Jul 2020 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001660;
        bh=QbFFDHcfMK18BVTPneujdXF5wa9/BSrZb6nRcGZq4MM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNAOaOValywCqZggHF3hZsetoRgt5WU+G8oRE17V15JRWkBAXzXM5V+3aTmPv2Sny
         KGnKJvOoQfe1yD2fZD1A5ViNM39AbzdbIZeZCzOkcNrxaxIzrAh2dhW90px2H7oJKy
         XhMGJpXqzZyUo2MZao17oCOe2U2u2+0Gjnr8q4N8=
Received: by wens.tw (Postfix, from userid 1000)
        id 5106B600AA; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] arm64: dts: allwinner: h5: bananapi-m2-plus-v1.2: Tie in CPU OPPs
Date:   Sat, 18 Jul 2020 00:00:53 +0800
Message-Id: <20200717160053.31191-9-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717160053.31191-1-wens@kernel.org>
References: <20200717160053.31191-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

The Bananapi M2 Plus H5 v1.2 can work with the standard H5 OPPs.
Tie them in to enable CPU frequency scaling.

The original Bananapi M2 Plus H5 is left out for now, as adding
the fixed regulator along with the enable pin seemed to cause some
glitching in Linux.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
index 2e2b14c0ae75..8857a3791593 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
@@ -3,6 +3,7 @@
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
+#include "sun50i-h5-cpu-opp.dtsi"
 #include <arm/sunxi-bananapi-m2-plus-v1.2.dtsi>
 
 / {
-- 
2.27.0

