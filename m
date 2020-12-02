Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BF82CBD44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 13:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbgLBMqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 07:46:37 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23584 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727183AbgLBMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 07:46:36 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2CWtXH011749;
        Wed, 2 Dec 2020 13:45:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=xMWvV8cjy7DCeGalzwJPa1w7rXpBTfmXiMBkDq6EFWQ=;
 b=2k87gMtIOSFqJo6H+dp2YriBNjuXn//AzY+H0L/YMQvemqGy2GNbrN1QMo/a3wEFXCWF
 nPKP2pc43x4S6Bp8hcB2Zg+IpaENGuBDIfBwlURw7gRA0o1E+LrWFGqhIgAVHBAIEUow
 dZvnc4Nrf/NSYMvcpqGXj0HUXOrZoRbkupF8+BIRkINfdi0tv+UAI0AUQvdTTn++JQmR
 5iS3oEQmtyhdJgTti2RqwJbc0CzuyC3gkGb3MKZ3nnsFdE5b1TeeRZlZmjMOoSXrGE14
 g8EAbAeGbER6ZbpwLOnJgi5B06SUYZtOmhPsmD+bd3w1HNTKxLF/MYcBq+BYby3YYkuw 1w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 355w3cbg9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 13:45:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 85861100034;
        Wed,  2 Dec 2020 13:45:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 70FEF2A4D74;
        Wed,  2 Dec 2020 13:45:42 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Dec 2020 13:45:42
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>
CC:     <alexandre.torgue@st.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: fix stm32 timers example
Date:   Wed, 2 Dec 2020 13:45:14 +0100
Message-ID: <1606913114-25693-1-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32 timers example name should match the pattern timer@. Also,
the example is based on stm32mp1 timer 2, so the identifier should be
'1' instead of '0' (e.g. timer 1).

Fixes: bfbcbf88f9db ("dt-bindings: timer: Convert stm32 timer bindings to json-schema")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
index f212fc6..0f16c88 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-timers.yaml
@@ -131,7 +131,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/stm32mp1-clks.h>
-    timers2: timers@40000000 {
+    timers2: timer@40000000 {
       #address-cells = <1>;
       #size-cells = <0>;
       compatible = "st,stm32-timers";
@@ -149,9 +149,9 @@ examples:
         #pwm-cells = <3>;
         st,breakinput = <0 1 5>;
       };
-      timer@0 {
+      timer@1 {
         compatible = "st,stm32-timer-trigger";
-        reg = <0>;
+        reg = <1>;
       };
       counter {
         compatible = "st,stm32-timer-counter";
-- 
2.7.4

