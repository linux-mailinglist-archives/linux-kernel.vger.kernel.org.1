Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4329E80C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgJ2J6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:58:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:44072 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727160AbgJ2J6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:58:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09T9uxbh005757;
        Thu, 29 Oct 2020 10:58:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=7qtb4voq8S3J6LHaryyzD5DZ5cmeEqaGfT7Bb48BCzg=;
 b=WqpyUPmsJrKscFqZRPOYZ9f+rAWDCqvgiaBzRVMmymNaIXwIOzC0GwvwjZ91Pq7bxPWa
 9yCsg28fy08sOEt7ewN5TWLv+aoeMVsESwGeSmIZDxJ8MiNEBM4olBPac36X2bUsmxQR
 hKhc+j7romu8/7lD+3MSZagd8wVXJBsziI2LSJNyR0EF1ERsnlRiqIAS+fmCGEN9093m
 xPU2qr555irEt/zLGKSxFhsTxbj65AhvbT4TR/i5NlfcV0BdEWuuX73JW2oA42kt4V81
 mr9sVVJyaOPeNdtN52HkqUFy+WQ2nHqtLuKK3pw0l7P6SzHVjTiy4UjUgG3JpS/w7yOM 7Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34ccffr5tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Oct 2020 10:58:13 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 560D010002A;
        Thu, 29 Oct 2020 10:58:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 40A08221F97;
        Thu, 29 Oct 2020 10:58:13 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 29 Oct 2020 10:58:12
 +0100
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [RESEND PATCH v3 1/4] dt-bindings: connector: add power-opmode optional property to usb-connector
Date:   Thu, 29 Oct 2020 10:58:03 +0100
Message-ID: <20201029095806.10648-2-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201029095806.10648-1-amelie.delaunay@st.com>
References: <20201029095806.10648-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-29_03:2020-10-29,2020-10-29 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power operation mode may depends on hardware design, so, add the optional
property power-opmode for usb-c connector to select the power operation
mode capability.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 .../bindings/connector/usb-connector.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 728f82db073d..200d19c60fd5 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -93,6 +93,24 @@ properties:
       - device
       - dual
 
+  power-opmode:
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
-- 
2.17.1

