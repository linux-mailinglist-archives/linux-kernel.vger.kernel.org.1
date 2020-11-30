Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FEC2C920A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgK3XGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730281AbgK3XGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:06:52 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45AC0617A6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so18584724wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=s0zassctoH8n02oQHks/DKQgmIxXJvp0+pGaAJ5Z7zstCbNvY1h+lryQqKeFU4ArEw
         2vTRujPBkS8+7Fxxme6nYq1CJt3xeb4Bd+bUmED+2CAxS/hSZBYTD/0Yaakq9xhXfMgN
         zvPPk0YfEXz0mLIExfdcvywGG8sbt9xXisC/p/Z7t3VexAuZBy5TTUL5yyxjiaEqRhfS
         aL3eyWdd0otiJD2JfZCF/bpcn8nXfLm3dzhr5kbPObt1fESzVbdgHSikvb9h4d/XXnH/
         MlhrW6KHA9pymEzxZeflRC9xhzc0vqKJhf9mZJ+AMkKLBx9Y2dgGL7oe64fEs8xogUow
         IAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HwnFymWMQTV9oikYfEqk9Alj6I5f+hN6S3yVGaHyZC0=;
        b=CCylqSGgkcJvD6YdgFKBZFFDjXd7ntKYuN4ymDQrbQOmK6AfEx/WQ9VoPScbBViM9b
         MEHO9M4N8SN1T/u2njZ5emAvn4yYB515ZgSy3EWa9EBYNYYFKsAHyZlIZ5XPACZzloLV
         60//ZF8x/ACkzHhPQp/zciCFkm1JYnSv+dwJvCbtxY3oBEXSIrG0ExHgGKhe0bfystyN
         tgzQ4yCKntm2D1lMP+cCnH7xGQvQBRAgtDeyYfzRonTIW2wSNPIj+yGAV54SE1ebOFge
         YRkjZkS//jDmD9QHB2FR/HoSET/hSDoNww/XIv1ID83LDyCB4KnGLCIAOdaKPicCNcKG
         OMrQ==
X-Gm-Message-State: AOAM530NYLNqyFZft4y40Tj3g+zy7SoJvtXBOJ+S76PLpGCeybI2rQwp
        eWQNFaF2TuuCXvbmsHw0HdSaUsaHkIyXWQ==
X-Google-Smtp-Source: ABdhPJwjJU070XxJynPiqttnwBLHDlKswKPyoUaRS3l5vHPhaQdcULTnfMTuiYnFTst9gDkx5n56rw==
X-Received: by 2002:adf:f84b:: with SMTP id d11mr31419411wrq.216.1606777570513;
        Mon, 30 Nov 2020 15:06:10 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id p4sm30427985wrm.51.2020.11.30.15.06.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Nov 2020 15:06:10 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        noralf@tronnes.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v2 3/3] dt-bindings: panel: Add bindings for MRB2801
Date:   Tue,  1 Dec 2020 09:05:36 +1000
Message-Id: <1606777536-14783-4-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606777536-14783-1-git-send-email-mikhail_durnev@mentor.com>
References: <1606777536-14783-1-git-send-email-mikhail_durnev@mentor.com>
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

