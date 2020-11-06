Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7786C2A9A07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 17:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727664AbgKFQ6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 11:58:43 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36752 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbgKFQ6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 11:58:39 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6GwCkp010238;
        Fri, 6 Nov 2020 17:58:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=EtuYOrqCs0Fxb2hFUZ6Z3gtrK51CMI3ATE1ilZwoDvo=;
 b=j2QBrG1V7i2kBCF039Z8iWaiXy02wUAbisTh2iKRwpr4rkse3zZSQpMlyjW8oVjUKlHn
 qbIRzf81F249tk52YIhE13ZpVKTX/bluMlcXsp4041CwxiyJVP7Rd72cTu7Zuc6PPMki
 YLdeown922cGEy8i8uDMxomKUUIHQQNxPDLGFCnJGGrhQmDTWmaeSjYwxBkHYqE/2ywy
 nM2KhXIBcv4xSYp2IWTj5g1ni9u3cJgo2Mq40Nafo6SepCo50kCtwocCkwEUuW4S9QIh
 Xap67uGvSZySsLNbgyzWNTepr85J9Oo9yO6Jq7VFmgnrmknA5R9hR2bMMEhNnNo4LCWT BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34gywrfkuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 17:58:12 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E202810002A;
        Fri,  6 Nov 2020 17:58:11 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id CC0D62C41F5;
        Fri,  6 Nov 2020 17:58:11 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov 2020 17:58:11
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
Subject: [PATCH v5 1/5] dt-bindings: connector: add typec-power-opmode property to usb-connector
Date:   Fri, 6 Nov 2020 17:58:01 +0100
Message-ID: <20201106165805.31534-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106165805.31534-1-amelie.delaunay@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_06:2020-11-05,2020-11-06 signatures=0
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

