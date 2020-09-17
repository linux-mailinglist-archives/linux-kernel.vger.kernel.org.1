Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7165626D8E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 12:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIQKY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgIQKTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 06:19:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54CC061353
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g189so1772658ybg.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 03:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=AKddxXKoSBr/Ui16sBeVbUiUy40nfOjktjv5vdlCV0c=;
        b=IyeJguhVM+MqT6WynOWJNvkjqJJoF6ckc/wY1084n4doa+8r/e0tMQ16vtJ7mwXl9a
         gvFinSRkiHUxe7jXD/E1BztmB9JGJ7iTtUfuVikjAakVmge7kf2sNprbXJcPf2taKr61
         8v1mFws5nXXM0oowPJnNw0ODyJGB28OYxFVARpr9psD8+z6AcAr2idaQsHeLnL9Fuvu3
         zeyUFDpz2OBhffjCROzvPDx7EEEF/YSIAbDYYi5TQT5rLnje2wgPOdmmRoxJvJrMX8iE
         I2aNY984oMoa/kmUDKiA2P5qFFQobYO36h95+CSZuA30NJc2VgXXHHbVXxGXDnQg2z8G
         qklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AKddxXKoSBr/Ui16sBeVbUiUy40nfOjktjv5vdlCV0c=;
        b=L1ib23fEYdJjsPm02GuLA1jMG1/Kdd/F/J14loU1Te6Ivr5JFF2mWc4o3Mc/jDwDSF
         SYsoGfQe8N1vI3z2Rc2O/z5dH5gx6dnJxRuBy6Ji4jUyM6h1TzN+KkJPV882r9MPiYKm
         C8BOgFhXJroV7FHdzLhbvR8QHlHDNLwQ6On4cpR6A2RPqcyZhU9Ne+JpzyjmTOeCCnka
         UDXWqxAKvZbiwX5VvPbmL+Z8qsl/J/s3FXnvud94oS7vy4PaMJ57nxqLzrHRXc2hZLTE
         AWR7znsqNU4iauCY+eEiKxxindmtyd7Tz+0wYjSx269SV5bA2sJFk3xaNgB8ax6ebPbN
         nDrQ==
X-Gm-Message-State: AOAM5337ZzZ2DaRcuvoz+HadmZ2D/vXlWpezgHQ9N6dTvGnjXkNm4Y2f
        l8IiTINY7GMrjC2010NMRh6bk1y24v4=
X-Google-Smtp-Source: ABdhPJzqCtkrgUGnjoOS9KZS2ntAuCcunV+rmSBkA1ZpLjJFjF+fBtIQ8ZZx26yNeMQgWLPA7zICr89/fVE=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a25:dc13:: with SMTP id y19mr25750484ybe.405.1600337950914;
 Thu, 17 Sep 2020 03:19:10 -0700 (PDT)
Date:   Thu, 17 Sep 2020 03:18:50 -0700
In-Reply-To: <20200917101856.3156869-1-badhri@google.com>
Message-Id: <20200917101856.3156869-5-badhri@google.com>
Mime-Version: 1.0
References: <20200917101856.3156869-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [PATCH v7 05/11] dt-bindings: connector: Add property to set initial
 current cap for FRS
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds frs-typec-current which allows setting the initial current
capability of the new source when vSafe5V is applied during PD3.0
sink Fast Role Swap.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Changes since v1:
- Changing patch version to v6 to fix version number confusion.

Changes since v6:
- Removed the redundant usb-connector.txt that I created by mistake.
- Moved to yaml.
---
 .../devicetree/bindings/connector/usb-connector.yaml   |  8 ++++++++
 include/dt-bindings/usb/pd.h                           | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 9bd52e63c935..1ca8e6a337e5 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -142,6 +142,14 @@ properties:
     required:
       - port@0
 
+  frs-typec-current:
+    description: Initial current capability of the new source when vSafe5V
+      is applied during PD3.0 Fast Role Swap. "Table 6-14 Fixed Supply PDO - Sink"
+      of "USB Power Delivery Specification Revision 3.0, Version 1.2" provides the
+      different power levels and "6.4.1.3.1.6 Fast Role Swap USB Type-C Current"
+      provides a detailed description of the field.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
 
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 985f2bbd4d24..db1ad4532197 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -35,6 +35,16 @@
 
 #define VSAFE5V 5000 /* mv units */
 
+/*
+ * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
+ * Version 1.2"
+ * Initial current capability of the new source when vSafe5V is applied.
+ */
+#define FRS_NOT_SUPPORTED	0
+#define FRS_DEFAULT_POWER	1
+#define FRS_5V_1P5A		2
+#define FRS_5V_3A		3
+
 #define PDO_BATT_MAX_VOLT_SHIFT	20	/* 50mV units */
 #define PDO_BATT_MIN_VOLT_SHIFT	10	/* 50mV units */
 #define PDO_BATT_MAX_PWR_SHIFT	0	/* 250mW units */
-- 
2.28.0.618.gf4bc123cb7-goog

