Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2126D415
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgIQHCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgIQHAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:00:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F184C06178B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:03 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c18so777819wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Sr8oVzKvyD/zquOuBfsibXPcOOdCUHxve0EXAZkgxo=;
        b=zAxziCPISkzSXUnEHDjswb1aWbCu/F/BgQ37nODlVtfT7XQxc3p+BB7uTBkX6ifJzF
         y9u7LKoOphxoUm60u1XcFt1Gj8Ck+ohOzAU86JxyEPPurTfDqxhGtDl4ZF2G3pruZvWQ
         gDqeZa6RlXly7ApknGR4IA26N9gUADNnyDgxf6wiYzts2Ef4WKHPU9v/RQLJrMA0YwHS
         RlKwbBuy193Irpy25bB++7/APngy9hCbRTEkl2Y7uryqPB9MDloSuc/m/3iNTRNkNNF3
         tmyF3fpRfqXLWUFpb2SOVIVV2OmqNEyehJg6BOgIGHrabOk4PhfDTt9qakpbly9ayxeM
         jHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Sr8oVzKvyD/zquOuBfsibXPcOOdCUHxve0EXAZkgxo=;
        b=C5Qe+8Z7ODTQmk6z8bECXsm/XsSxu+KOt1vozisFuZitKRAfdFydzlR7h6QKU6PAHi
         PFQEf3haZYBWuWcOE9DiPX1W0z2zIyh0Ik1fYeZj7ucV/PtM1tQj+zsRU4WpaLOOMH49
         M3TIrzgT/CpUOK1xdbBNUlUxkZP6BvOH0Z5W76Y3nMlmwRh7qi+nWDIC8MCKxKbEUpot
         bQoaRzQlGnutFfou6KRJHeRMBOenYHjR9UiBnmJV04uuBjdBJ90P/enKzLG6StI+18bX
         mdQnVpo3nAYqsfUbgsWWce+WevJ1PXU+bqNdWdcCh41qjrqcwezb4oxV9AExohU76Tnn
         nLww==
X-Gm-Message-State: AOAM530sjCbCHaoC6PJrETWDqOO2Jd8RdSRKprC55EeKiXdf21EliF0+
        FE4oxHXiAaXZ2UVnPpXqNOx/Ww==
X-Google-Smtp-Source: ABdhPJxZcc1dB/8PenT4vG8pyjqgyZKjF4FfZZo+k5kkR1VqWS7d/qJLCfVQ1jjZVVPcRSk9o9jyiA==
X-Received: by 2002:adf:9c93:: with SMTP id d19mr31158974wre.275.1600326001840;
        Thu, 17 Sep 2020 00:00:01 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z14sm35709055wrh.14.2020.09.16.23.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 00:00:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 2/5] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG Families USB Glue Bindings
Date:   Thu, 17 Sep 2020 08:59:46 +0200
Message-Id: <20200917065949.3476-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917065949.3476-1-narmstrong@baylibre.com>
References: <20200917065949.3476-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG is close to the GXL Glue but with a single OTG PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index 5b04a7dfa018..c0058332b967 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -25,13 +25,14 @@ description: |
   The Amlogic A1 embeds a DWC3 USB IP Core configured for USB2 in
   host-only mode.
 
-  The Amlogic GXL & GXM SoCs doesn't embed an USB3 PHY.
+  The Amlogic GXL, GXM & AXG SoCs doesn't embed an USB3 PHY.
 
 properties:
   compatible:
     enum:
       - amlogic,meson-gxl-usb-ctrl
       - amlogic,meson-gxm-usb-ctrl
+      - amlogic,meson-axg-usb-ctrl
       - amlogic,meson-g12a-usb-ctrl
       - amlogic,meson-a1-usb-ctrl
 
@@ -151,6 +152,25 @@ allOf:
 
       required:
         - clock-names
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-usb-ctrl
+
+    then:
+      properties:
+        phy-names:
+          items:
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: usb_ctrl
+            - const: ddr
+      required:
+        - clock-names
   - if:
       properties:
         compatible:
-- 
2.22.0

