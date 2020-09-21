Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFA227333E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgIUT4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbgIUT4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:56:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF54EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:12 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 99so10007060qva.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 12:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5FrumbcAeu54idbHYrGk3eIL/4JmYNsuV6pzKeioD/A=;
        b=HQP4hkQPyaPQaPeZMQKr/WG/vHJn4/+lNs+7YQFMBIRpjgRBIWc5GE5fFu6RC9EG9k
         m4A3j598FJsGaCigKu7PPkymhVoROdhlrwEu3Ug2/44bgbSnnADhNwRtGYjvdfB01vu8
         flYwXyMU64kQv9unrHVlFj4+KGPFqIHWR3kAJsl0O8CSxhRXU4/jPDE4IA6hIN0REUvd
         y9Vtz83gghNTR/r0bl7Tin0b8wV2BVvEcTQtomFcbvhIQydH5BWMlY3NDl7P5umj0Hod
         +MBjvKJEYAkgs/E/yfV4ZWf+QpYARkLJIUwKmCm1J0kA5xJQoyP/OjjYVJgBkI/58xPs
         eJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5FrumbcAeu54idbHYrGk3eIL/4JmYNsuV6pzKeioD/A=;
        b=F1y/j9EheJrgVj0ATgFWCyecPsS6nt/1jjEROuACEvrQjjuP+fF6UM8op0KmsdnxET
         P+1zdDQoDHpL4zTR7O7sCWLxjb6h2bfwCXSDcokb+ieQ+SNyuyyAyFlkuD+OPfeE/VgW
         4rGGEWgnr8n69/e1gyJ7a6zcl9W7nxfOPNUoy4KSNhiyEQeCpwZh5x3AIi3HsVNxdC8m
         1P+JJenE8Lr6ykFn9pcG/vW0HQel3RZCzmoXz4SA1u1MBKlcITknlvLfvG48FwjiTBNm
         wtCLNZGboHeeT30SlBib1JspIbQmpN8xZsCsr5tIkaz/PG6/PBkne8N/0IaGdhTf3Rn2
         9QHQ==
X-Gm-Message-State: AOAM532MqKwpLLfCERgIS0aMimacsdGaqJIg4kQtC3r1DYddlGlF5+0I
        DBnVJ5GrRjMGFI7RO6T7Q1Sa3Euhza8=
X-Google-Smtp-Source: ABdhPJyywnIiDx/8snJDlo4oLbprY1kUapZltGvSNvHTc/9eF/ckRq07b7AMs57MSoSBQqlTFWXNIOPHmcU=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:ee86:: with SMTP id u6mr1826182qvr.56.1600718172071;
 Mon, 21 Sep 2020 12:56:12 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:55:49 -0700
In-Reply-To: <20200921195555.1050731-1-badhri@google.com>
Message-Id: <20200921195555.1050731-5-badhri@google.com>
Mime-Version: 1.0
References: <20200921195555.1050731-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v8 05/11] dt-bindings: connector: Add property to set initial
 current cap for FRS
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
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

Changes since v7:
- Rebase 
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
2.28.0.681.g6f77f65b4e-goog

