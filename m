Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BF12B7708
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 08:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgKRHgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 02:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgKRHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 02:36:50 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A704C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:50 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so1743031wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 23:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=L71JUHPJijtIYlaUH4i117KgxxPInXwl4XFKy8umpenrwoj9ObiZuTOFvx7Ks2+dWp
         YYKLHboPTMlZrAS4rmp4hgAObHXIjeDgiUCazzP9ZL+khmxM/m0fvvGrq4nLeqTD4wNm
         x+2GQIVixAKOUu6z+njeq7IlFPuZxAGOMorvLYEQbxsVh9qM0Rk5uHJDwsM3mQCMeBsL
         ZGJsraubmFeBVQTFYlXXMBCzq9s4AulN33NOCxEwKz/2MiUC/Yg+4B5hdKoE1kAswXyV
         pbBhuVYBco/XAAc06ndLOq3DP7qqQl0zsFIp66+2nwl8AbJbEhCrzFYcIHa9YNWS3yde
         aC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=BYs+xwlk3egxS5/+wENltUCaARctyaKgDALsieNvZT5Do9fka78v/R4VqDbxjap4BP
         3ElJeUEq4sicAQbh1ny6swqm6Ppe+eU/+Hf/NRwjEFY7aW0vpEQKsfKpttd+2t9jR/Mn
         t3OYOZaR5ecXPvVIaet1CvOsfP/r0qSTomw3rphcQ3jClNMWMLI2TxZLwBRXgDULReVg
         eAnLVkzFy1n+gbHxkjRG+R1hOIUAFewzoBoA9ajt65MLezIdJ1ERvBHyHAjsjUJVlELJ
         pNVbP8rZrnYF5JfA2WJH0//5TQXyL5KvrXX5H8A7gfgl90s6mzKyydu/RoahQbeM/Z3E
         vf4A==
X-Gm-Message-State: AOAM5319C763EzkkSsZz6x41mSn27Orzb1r8DwzIq0U8sK41PSL0Wvhb
        yHCDeIwUmreMPcJbcwMdyTkfa0yFCJM=
X-Google-Smtp-Source: ABdhPJzm+eKHfVMwvTBAzkXVqTbAXkubHMAQR4ffHQnzhNKcp2kHScvi8fGbkV+jVw33B4KoUvn1HQ==
X-Received: by 2002:a1c:a548:: with SMTP id o69mr2162830wme.23.1605685009043;
        Tue, 17 Nov 2020 23:36:49 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id b14sm30188632wrq.47.2020.11.17.23.36.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 23:36:48 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org
Cc:     mikhail_durnev@mentor.com, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Subject: [PATCH 3/3] dt-bindings: panel: Add bindings for MRB2801
Date:   Wed, 18 Nov 2020 17:35:45 +1000
Message-Id: <1605684945-29727-4-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
References: <1605684945-29727-1-git-send-email-mikhail_durnev@mentor.com>
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

