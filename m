Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07DF2FF48F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 20:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbhAUSvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbhAUS0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:26:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE63C0617AA;
        Thu, 21 Jan 2021 10:23:34 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h7so3885079lfc.6;
        Thu, 21 Jan 2021 10:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//LXOze+13I5z/FYLaqJrmRyfxqFIxZ8QuJGcysQP04=;
        b=ILNk7kZOFLktb1B+0n3AOelwsojeupbuz1w+mYzPTPthZ//GML5v/JApFJiV+uiDxt
         oMe6TooMGKi318/YGOnAyxUWGY2wuNVuvMpV6SQP/2llovUKTT8FkvhyNezuwaqsMo3n
         bz3W5mOHtshtQFqyPtoxpxYzTkQa14+csY5uCcbe1o3241aBU5d86kvl+h7/w7TvLB0I
         3XUtwb9aJIxDDpxYm0xcnFg0F+cuC/ZxJCOUoa6pLW7f/BwYBniYyq9UY+O7eBaa8NhV
         QQYWT6ByEBMdy3ihrzxKbpTmqCmJXqT/tU7UK9kIa3y2DEnUXmTru/vU9FHci92L4mUx
         Vhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//LXOze+13I5z/FYLaqJrmRyfxqFIxZ8QuJGcysQP04=;
        b=iCzINsXpk+funlVgJy5KMzDTCmT3QqZ4+zriHPWr5v/qnPpY7U8Zq0TWke0gowQxM4
         1x62tFr1upHYfnFhTZsptn18TN8fxGzIVL3hqXCHsoQGs22kMgNAHkRfBi8EhClvJAFq
         BjkmHJ1xOFmI4B4Jf/38sWJvAGEzB/prpgEJtwf26DlWwLgs+BvX+JTsU3eJRpaEbAJv
         rwBjoneaNAQVNXJN6FNMt6a73pKJTRAKgM57BsxFGkpQu1BByPUzEKwnUoEMrbXWVbvx
         N6lSQaVGV0MFyBtargFK7li0JsS+8xKqjMwyoqTHu8EkKC/CPydE1swxJ6PaBH1Pwcbq
         pnFA==
X-Gm-Message-State: AOAM533yqGTBmpoulZWg/3qxC9uqFekqCwKnEkhy0Hi+qeKz38KMkL9T
        C1eYfUXsQeAAU5et+T724SxEPyyCeVY=
X-Google-Smtp-Source: ABdhPJwP2zhd2mBJVn1OszotEVigAHiIMyTmGFkiuhpZDca0PwKDhWShHQeS7sGQ2Ed6a+0juBWusA==
X-Received: by 2002:a19:4801:: with SMTP id v1mr228337lfa.628.1611253412729;
        Thu, 21 Jan 2021 10:23:32 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id f186sm600537lfd.289.2021.01.21.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 10:23:32 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 13/13] ARM: tegra: Specify memory suspend OPP in device-tree
Date:   Thu, 21 Jan 2021 21:23:08 +0300
Message-Id: <20210121182308.16080-14-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121182308.16080-1-digetx@gmail.com>
References: <20210121182308.16080-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify memory suspend OPP in a device-tree, just for consistency.
Now memory will always suspend on the same frequency.

Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
Tested-by: Dmitry Osipenko <digetx@gmail.com> # A500 T20 and Nexus7 T30
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra124-peripherals-opp.dtsi | 5 +++++
 arch/arm/boot/dts/tegra20-peripherals-opp.dtsi  | 1 +
 arch/arm/boot/dts/tegra30-peripherals-opp.dtsi  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
index 49d9420a3289..781ac8601030 100644
--- a/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra124-peripherals-opp.dtsi
@@ -128,24 +128,28 @@ opp@204000000,800 {
 			opp-microvolt = <800000 800000 1150000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0003>;
+			opp-suspend;
 		};
 
 		opp@204000000,950 {
 			opp-microvolt = <950000 950000 1150000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0008>;
+			opp-suspend;
 		};
 
 		opp@204000000,1050 {
 			opp-microvolt = <1050000 1050000 1150000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0010>;
+			opp-suspend;
 		};
 
 		opp@204000000,1110 {
 			opp-microvolt = <1110000 1110000 1150000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0004>;
+			opp-suspend;
 		};
 
 		opp@264000000,800 {
@@ -360,6 +364,7 @@ opp@204000000 {
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x001F>;
 			opp-peak-kBps = <3264000>;
+			opp-suspend;
 		};
 
 		opp@264000000 {
diff --git a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
index b84afecea154..ef3ad2e5f270 100644
--- a/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra20-peripherals-opp.dtsi
@@ -68,6 +68,7 @@ opp@216000000 {
 			opp-microvolt = <1000000 1000000 1300000>;
 			opp-hz = /bits/ 64 <216000000>;
 			opp-supported-hw = <0x000F>;
+			opp-suspend;
 		};
 
 		opp@300000000 {
diff --git a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
index cbe84d25e726..2c9780319725 100644
--- a/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
+++ b/arch/arm/boot/dts/tegra30-peripherals-opp.dtsi
@@ -128,12 +128,14 @@ opp@204000000,1000 {
 			opp-microvolt = <1000000 1000000 1350000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0007>;
+			opp-suspend;
 		};
 
 		opp@204000000,1250 {
 			opp-microvolt = <1250000 1250000 1350000>;
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x0008>;
+			opp-suspend;
 		};
 
 		opp@333500000,1000 {
@@ -312,6 +314,7 @@ opp@204000000 {
 			opp-hz = /bits/ 64 <204000000>;
 			opp-supported-hw = <0x000F>;
 			opp-peak-kBps = <1632000>;
+			opp-suspend;
 		};
 
 		opp@333500000 {
-- 
2.29.2

