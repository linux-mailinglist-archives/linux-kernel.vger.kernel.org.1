Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7AD2EFAF8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbhAHWRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAHWRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:17:48 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5AEC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 14:17:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x18so6402124pln.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 14:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjEIPfAVcs3gvKNx7qo/y+ZN6/GFQFUSelSnLMyBbKM=;
        b=AHOfCa3KDAvwViNbxGSDxxAEgeRhouqgX/PnG194y1JB8/hlqJT2sBVOkexcvvxXHg
         lWVfTKnaqBo0JKM6AUisnmPsB76AQd1mL/M849kfaiaVxapEYrmszE10dsJ+TbIeAH6U
         QWjU8qubuFuC2qmfuuCWEFNykB1U9PzNWOM44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bjEIPfAVcs3gvKNx7qo/y+ZN6/GFQFUSelSnLMyBbKM=;
        b=BZz//kWNTA8x4CdaXDqxoSD0p9C7d8pNDr3ZkvR0FfAgYji5w72ot7IwbEi6y399gc
         1GQmdcA0te64twEIG5eFk5L3BU9enx1oQVv+cIgEn/KRdMPaWDezNJtkwjiE57iJSIve
         t+hlYNq7sWBB0TCxPW4sa4SOjuqgVDbx1hdtcyYyA+SnSvAg9HX9hFTeJo8j/HqlVO4U
         lGl3mhl2jdtPvqEinAd5+ooBOsilrjIQUF6DBTMli6qA6N4Etr0IILoPB+FGntyMb/hJ
         1nUQ1GXD9uXNnSrdW9bPERPeuQpc6ElipaChcDmQ07swVFdDOXkbnK0IMpQgTCMMs4D6
         wyFg==
X-Gm-Message-State: AOAM531Ot8jXcVqwn6SxOMOewpzooLw5Wo7cDHAatSKUYTYsvBWzYKr7
        tYDL1Uj38gET2TIwbXaZJXsmMA==
X-Google-Smtp-Source: ABdhPJzAHLjnmF4GvlVRhrnonjX1EETvvJY+osxKXojwVbp7pymJ+bXYDRr8La8qPkZy8RzFscLVDw==
X-Received: by 2002:a17:90b:11d7:: with SMTP id gv23mr5978542pjb.2.1610144228367;
        Fri, 08 Jan 2021 14:17:08 -0800 (PST)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id k7sm9638595pfh.201.2021.01.08.14.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 14:17:07 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: sc7180: Add labels for cpuN-thermal nodes
Date:   Fri,  8 Jan 2021 14:16:50 -0800
Message-Id: <20210108141648.1.Ia8019b8b303ca31a06752ed6ceb5c3ac50bd1d48@changeid>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add labels to the cpuN-thermal nodes to allow board files to use
a phandle instead replicating the node hierarchy when adjusting
certain properties.

Due to the 'sustainable-power' property CPU thermal zones are
more likely to need property updates than other SC7180 zones,
hence only labels for CPU zones are added for now.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 22b832fc62e3..b5c0eead935d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3596,7 +3596,7 @@ lpass_hm: clock-controller@63000000 {
 	};
 
 	thermal-zones {
-		cpu0-thermal {
+		cpu0_thermal: cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3645,7 +3645,7 @@ map1 {
 			};
 		};
 
-		cpu1-thermal {
+		cpu1_thermal: cpu1-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3694,7 +3694,7 @@ map1 {
 			};
 		};
 
-		cpu2-thermal {
+		cpu2_thermal: cpu2-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3743,7 +3743,7 @@ map1 {
 			};
 		};
 
-		cpu3-thermal {
+		cpu3_thermal: cpu3-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3792,7 +3792,7 @@ map1 {
 			};
 		};
 
-		cpu4-thermal {
+		cpu4_thermal: cpu4-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3841,7 +3841,7 @@ map1 {
 			};
 		};
 
-		cpu5-thermal {
+		cpu5_thermal: cpu5-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3890,7 +3890,7 @@ map1 {
 			};
 		};
 
-		cpu6-thermal {
+		cpu6_thermal: cpu6-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3931,7 +3931,7 @@ map1 {
 			};
 		};
 
-		cpu7-thermal {
+		cpu7_thermal: cpu7-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -3972,7 +3972,7 @@ map1 {
 			};
 		};
 
-		cpu8-thermal {
+		cpu8_thermal: cpu8-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
@@ -4013,7 +4013,7 @@ map1 {
 			};
 		};
 
-		cpu9-thermal {
+		cpu9_thermal: cpu9-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <0>;
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

