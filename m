Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A37729075C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409081AbgJPOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:41:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21080 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408938AbgJPOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:41:11 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GEaXdi005795;
        Fri, 16 Oct 2020 16:40:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=uWA1bx9jQvPuk7yy9+gJUevbMdehUxJMVfuVa4kreuk=;
 b=UYFokRQWIGyuNmK0Cb30A2WeeWENUjbFi5cuNymnZHFBVcZLSkU2JR1leQWqyTyf+QqY
 j5qUGIw+GzOxlN/ZNMCAum7vCRxAhBhM6OHJ7HMXqLJKWBUv3ImGIUstJ1Sbqsj1gLec
 JuNSLbHE7z9ppDuzqPResJ6gbTubFTZfvKVZz6P+4mNIlkhOcVn39Tbnq3f1bEkv3MO7
 2s+4CTA5dnW5l4eZfKgCH6wPkVYXHiePbJr4/gq2HQz3yuyBwEB4IQjQp17m78GCZmqB
 LfdKpqThGtzQ3RqUlkXRN0ah2wiZxyIvY8XQABzjjU31EQWKeT8p39WBhBF5cAPT2hkg tw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34353wx43u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:40:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F1A1F10002A;
        Fri, 16 Oct 2020 16:40:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E45652AF739;
        Fri, 16 Oct 2020 16:40:48 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct 2020 16:40:48
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] ARM: dts: stm32: Add LP timer wakeup-source on stm32mp151
Date:   Fri, 16 Oct 2020 16:40:19 +0200
Message-ID: <1602859219-15684-4-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
References: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_07:2020-10-16,2020-10-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LP timer can be used to wakeup from stop mode on stm32mp151.
Add wakeup-source properties to all LP timer instances.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 10d5e2b..0bf5fc2 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -358,6 +358,7 @@
 			interrupts-extended = <&exti 47 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc LPTIM1_K>;
 			clock-names = "mux";
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1153,6 +1154,7 @@
 			interrupts-extended = <&exti 48 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc LPTIM2_K>;
 			clock-names = "mux";
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1181,6 +1183,7 @@
 			interrupts-extended = <&exti 50 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc LPTIM3_K>;
 			clock-names = "mux";
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1202,6 +1205,7 @@
 			interrupts-extended = <&exti 52 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc LPTIM4_K>;
 			clock-names = "mux";
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
@@ -1217,6 +1221,7 @@
 			interrupts-extended = <&exti 53 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&rcc LPTIM5_K>;
 			clock-names = "mux";
+			wakeup-source;
 			status = "disabled";
 
 			pwm {
-- 
2.7.4

