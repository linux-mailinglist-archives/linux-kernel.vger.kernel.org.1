Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644E22A9251
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKFJTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:19:40 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:19138 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbgKFJTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:19:31 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6986vc017489;
        Fri, 6 Nov 2020 10:19:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=EtuYOrqCs0Fxb2hFUZ6Z3gtrK51CMI3ATE1ilZwoDvo=;
 b=OJ5gUzVRSkS/KyH0RXjEcTP8FF1N9xRH4pMjWQbpcg1buDlgQbtt2QJYPhxU49mJ0hEr
 VPFQuQur5clee+73+Ar2OgszgTTiS3FLTpZTKKPdj6xqqlKLcIpriNovzyqWjMfNbycm
 UOsTN5i+VWXdIOIaYD2z5yyNo5lDOOKObBWn62HIVgf+rufUw3WPxgGwezt2KWEQmpjF
 3Yi3+Inax1oZFbuhawzf/cU+xehlKYHn1eTblzd3lrBSICaF9rgGnEDMhx3XbUhL0WpZ
 zrog5kCFmGmr2OMY1rixHLRq6tOekItN0A0f77XnBtrmPknSMfXxnjgRg2EQNVqVtGhz CA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34h00eu8ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 10:19:09 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B437D100038;
        Fri,  6 Nov 2020 10:19:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A43A8233E9D;
        Fri,  6 Nov 2020 10:19:08 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 10:19:08
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v4 1/5] dt-bindings: connector: add typec-power-opmode property to usb-connector
Date:   Fri, 6 Nov 2020 10:18:50 +0100
Message-ID: <20201106091854.14958-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106091854.14958-1-amelie.delaunay@st.com>
References: <20201106091854.14958-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power operation mode may depends on hardware design, so, add the optional
property typec-power-opmode for usb-c connector to select the power
operation mode capability.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
Hi Bahdri, Rob,

I've added the exlusion with FRS property, but new FRS property name
should be use here so, be careful.

---
 .../bindings/connector/usb-connector.yaml     | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 62781518aefc..a84464b3e1f2 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -93,6 +93,24 @@ properties:
       - device
       - dual
 
+  typec-power-opmode:
+    description: Determines the power operation mode that the Type C connector
+      will support and will advertise through CC pins when it has no power
+      delivery support.
+      - "default" corresponds to default USB voltage and current defined by the
+        USB 2.0 and USB 3.2 specifications, 5V 500mA for USB 2.0 ports and
+        5V 900mA or 1500mA for USB 3.2 ports in single-lane or dual-lane
+        operation respectively.
+      - "1.5A" and "3.0A", 5V 1.5A and 5V 3.0A respectively, as defined in USB
+        Type-C Cable and Connector specification, when Power Delivery is not
+        supported.
+    allOf:
+      - $ref: /schemas/types.yaml#definitions/string
+    enum:
+      - default
+      - 1.5A
+      - 3.0A
+
   # The following are optional properties for "usb-c-connector" with power
   # delivery support.
   source-pdos:
@@ -192,6 +210,12 @@ allOf:
         type:
           const: micro
 
+anyOf:
+  - not:
+      required:
+        - typec-power-opmode
+        - new-source-frs-typec-current
+
 additionalProperties: true
 
 examples:
-- 
2.17.1

