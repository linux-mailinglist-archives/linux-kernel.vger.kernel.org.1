Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AACB2C7E35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgK3GZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgK3GZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:25:48 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58E2C0613D4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 22:25:07 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 3so18988099wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 22:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=GLQgkqJ2PW7rwSg7OMR5tsmHbARMKy8wN1upF7hvOgcmACidG4DZklGJZtE1/+raZK
         WsXq0T+NjkTDuTeE8QzEFVizd3B2bwyPTdv+SDAcHegFoinltPnzkI7RSNgsHo3tD/cO
         N89Uw8z4VCaG2BWo4EQ+RboZHfo6euHAqBMngaSay9c3K785MX8D71rpIQGENyhDQX4K
         CVhrbG82bEIPMYBVZNkyiSVEzFQRlVw4+i1lAct4lH44RPuahoY1KwJQIXHzmeoiKIb5
         Mp42ty8pH6Hce/PbfdGyblbJS0IYnaHY7k0gs8NsOftq5bW5P9c9uQzFL334wbyJca+3
         JTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=OELJmsiv7jzIDHKfFw5qBxvgy6fJBkXeB5a8YOjb8+8HVDd4TSQtslvOA7DQSsWEZl
         O2puUZ2dXvofdgn0VxxoaQb0vhZVKpDCz3iB2eunoA5VC0Z9MVOQLTrbMrrgThlbfXP9
         Sdz+3yyoLM0tna37L1joMUE0qt1qtw89zbiyToqxzJc+IPI9Vvrkh6Ne+hz6QsxDjGXq
         mdrDP2DcRhtv/3jEczF0y5kR7XT5WXwKS8PJk/1345XU42b9WhRAFgeB3dMsWqs6V4Eu
         RstwM2WGvZmS0B7ogRxofFSslhVR7cALz504OB5aAcbBmUSXf1Q0AbPbfDjasFf16I5x
         M/7w==
X-Gm-Message-State: AOAM530UOD6OUCfybecvYWt555189bb2rDsQSU0X/rdtpJepE2e5nL9u
        x51TZFa6BH7scoMKmccY/LR+wyT757kEUg==
X-Google-Smtp-Source: ABdhPJzzF7nyuLq9HYsSuTUbJnsAnZLfKAl5pXDUx87thw1mmbNsDOLi7nSBrKNTJU1/kHA+BKrS7w==
X-Received: by 2002:a05:600c:2209:: with SMTP id z9mr22015998wml.123.1606717506450;
        Sun, 29 Nov 2020 22:25:06 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id u129sm22594649wme.9.2020.11.29.22.25.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Nov 2020 22:25:05 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v1 3/3] dt-bindings: panel: Add bindings for MRB2801
Date:   Mon, 30 Nov 2020 16:23:59 +1000
Message-Id: <1606717439-18383-4-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606717439-18383-1-git-send-email-mikhail_durnev@mentor.com>
References: <1606717439-18383-1-git-send-email-mikhail_durnev@mentor.com>
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

