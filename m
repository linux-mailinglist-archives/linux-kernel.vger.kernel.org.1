Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE56224013
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 18:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgGQQBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 12:01:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgGQQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:01:00 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DD721702;
        Fri, 17 Jul 2020 16:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001660;
        bh=EDAiKVyDRZa0BuQZjdZBf0u9WtT9aK8yahINeuOAY10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXnJHUMRLUmLZQkRxnwVQV/sVxKlxojK+hEne/JEo7zMI9oFZrFrrXznE3AOnCq1D
         JNc3+VFbGm3qtSXQ8GWtO3WDkwR+vXTzLaSMqL4kDTwf6D4aBQM0EpJjwswXlxnSig
         AYPYWwZGMQ39yW4Lr4P+PyI7Rxskg5x+o/kLnI1o=
Received: by wens.tw (Postfix, from userid 1000)
        id 4B5A05FDD7; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/8] arm64: dts: allwinner: h5: libretech-all-h3-cc: Tie in CPU OPPs
Date:   Sat, 18 Jul 2020 00:00:52 +0800
Message-Id: <20200717160053.31191-8-wens@kernel.org>
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

The Libre Computer ALL-H3-CC H5 variant can work with the standard H5
OPPs. Tie them in to enable CPU frequency scaling.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
index 64d35daf2023..d811df332824 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-libretech-all-h3-cc.dts
@@ -4,6 +4,7 @@
 
 /dts-v1/;
 #include "sun50i-h5.dtsi"
+#include "sun50i-h5-cpu-opp.dtsi"
 #include <arm/sunxi-libretech-all-h3-cc.dtsi>
 
 / {
-- 
2.27.0

