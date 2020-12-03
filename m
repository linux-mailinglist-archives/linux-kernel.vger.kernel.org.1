Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51C2CD37E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 11:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388772AbgLCK33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 05:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388753AbgLCK3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 05:29:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4BC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 02:28:44 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so2238001wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 02:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=WZdCZpNNkYwJQy1PMA1V3fogDhD7ZD/zN1Yf9DH7sYbl4u5XR2MtQEjpX5LfBJcr7u
         1nkLLgIMzTayRyionh3rsS9LzZxkzyrmhFcsdwG2JMWBLO9avVUK0hxVRXLKVbaaqUUe
         HJDoj+XXS7ACoW++Mu7+iUgO+bE56KAJnKKOChENS2oe+XqjpEY08DUeN+esbv0bEWn5
         xSb9SG+/dg7AgWq3KPedojWriCdYGgoDh6X8qgfTW4wb5UQ+0MkiMINJoL5Idqn097sq
         xTLNq/hQK7tQc8x99gpXOSe1ymBoTXtqhVqsUZZz4I0qxXL/fQrQG32m/SBVrVqLQ60M
         2nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=o7avP/y0r7OgIg+ryyOizF8BZDx9/hjKYsDDt42i39x4/eiEZUYIaBA5cXUl1EZr7C
         fFwhz3fm0c3G6NltbSa44+rCUJTCiGN0K38sCvSugkumpKOa2RoA297ubmwdjpmBugb6
         wmgO/gZw/LMeVQF+l7Su/fFg5rZkGmLwG76rjLLHiHxAOMjZmlnMsW4YEC2mKPb8+tzB
         ku/bvgd7HCRFFKUspENxv4npEg6jT7a+QfoOLyO8vPADMrO1AEmZcYkOE2kLaM61rw3B
         ledPiBqauhwB4FOeXkSeXaJ9nxZokSVdvYatwcOP5Qce2/QhiDlmKxKkiz0Gm7gM/w8A
         wySA==
X-Gm-Message-State: AOAM5333U5amX0VmY3FxgrmwVxlOzyiA6+USrO43f7nS0XHihhn7nhep
        8bwVCChh5Nqma12WPp2abetfW3BEQcmC5w==
X-Google-Smtp-Source: ABdhPJwpHO4xvvBiQOWKTr03b1Js+htVYuOqDGAa/WLxWwnBsnsKk/EljKQpSEaK085VLYgK9coukQ==
X-Received: by 2002:a1c:67c5:: with SMTP id b188mr2562533wmc.147.1606991323260;
        Thu, 03 Dec 2020 02:28:43 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id o13sm847589wmc.44.2020.12.03.02.28.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 02:28:42 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v3 3/3] dt-bindings: panel: Add bindings for MRB2801
Date:   Thu,  3 Dec 2020 20:28:13 +1000
Message-Id: <1606991293-29539-4-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606991293-29539-1-git-send-email-mikhail_durnev@mentor.com>
References: <1606991293-29539-1-git-send-email-mikhail_durnev@mentor.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Durnev <mikhail_durnev@mentor.com>

Add binding for Ronbo MRB2801 display module.

This binding is for display panels using an Ilitek ILI9341 controller in
parallel mode.

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
---
 .../devicetree/bindings/display/ronbo,mrb2801.txt  | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ronbo,mrb2801.txt

diff --git a/Documentation/devicetree/bindings/display/ronbo,mrb2801.txt b/Documentation/devicetree/bindings/display/ronbo,mrb2801.txt
new file mode 100644
index 0000000..db1a861e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ronbo,mrb2801.txt
@@ -0,0 +1,42 @@
+MRB2801 display panel
+
+This binding is for display panels using an Ilitek ILI9341 controller in
+parallel mode.
+
+Required properties:
+- compatible:		"ronbo,mrb2801"
+- dc-gpios:		D/C pin
+- wr-gpios:		W/R pin
+- db-gpios:		8 or 16 DB pins
+- reset-gpios:		Reset pin
+- wr-up-down-delays:	Delays in ns for changing W/R from down to up and from up to down
+
+Optional properties:
+- backlight:	phandle of the backlight device attached to the panel
+- rotation:	panel rotation in degrees counter clockwise (0,90,180,270)
+
+Example:
+	mrb2801{
+		compatible = "ronbo,mrb2801";
+		db-gpios = <&gpio 17 0>, /* DB0 */
+			   <&gpio 18 0>, /* DB1 */
+			   <&gpio 27 0>, /* DB2 */
+			   <&gpio 22 0>, /* DB3 */
+			   <&gpio 23 0>, /* DB4 */
+			   <&gpio 24 0>, /* DB5 */
+			   <&gpio 25 0>, /* DB6 */
+			   <&gpio  4 0>, /* DB7 */
+			   <&gpio 14 0>, /* DB8 */
+			   <&gpio 15 0>, /* DB9 */
+			   <&gpio  5 0>, /* DB10 */
+			   <&gpio  6 0>, /* DB11 */
+			   <&gpio 13 0>, /* DB12 */
+			   <&gpio 19 0>, /* DB13 */
+			   <&gpio 26 0>, /* DB14 */
+			   <&gpio 12 0>; /* DB15 */
+		dc-gpios = <&gpio 16 0>; /* D/C */
+		wr-gpios = <&gpio 20 0>; /* W/R */
+		wr-up-down-delays = <10 51>;
+		reset-gpios = <&gpio 21 0>; /* RST */
+		backlight = <&backlight>;
+	};
-- 
2.7.4

