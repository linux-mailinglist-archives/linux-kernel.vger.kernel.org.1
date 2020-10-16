Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0737290759
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409070AbgJPOlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:41:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:26708 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2408928AbgJPOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:41:11 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GEaXdh005795;
        Fri, 16 Oct 2020 16:40:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=gFP4tTVRCdOj5EAPNVvSbqJO8MZmPCYvvb2ZqMaGmX8=;
 b=e9t3W8ILBCztgc8JqZPFwAc5BbPX+gXgrPY/jr7Q189XKBdqfEHGkTfXnVbmMO4Mrgkv
 u1f/BAQWptihBfNOyrHix7rF72ickGN/o/3zmqlvayzqWLTpkJvxwgG69eoUooK8s4Y9
 qVr89Ac++rLWOLXgGNjYYl7Z1RyGdxW845WPIrtGPz5daWT9smL9jedvRlazRPEkImqi
 C1V3kYo7ZJz+mnLg6GB9l1Q7ZM2bjwA6EHrBkA/IGM/h+sH/nLTemV8UemOLviLFmHEN
 i+gDe41bBHcuCEP5H76fksSedieL6dm7gBgnk9gK+jQ2nScJkBUAcRfYJQIqfuqZyLWF 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34353wx43c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:40:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D9CDA10002A;
        Fri, 16 Oct 2020 16:40:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C5B632AF739;
        Fri, 16 Oct 2020 16:40:44 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct 2020 16:40:43
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] irqchip/stm32-exti: Add all LP timer exti direct events support
Date:   Fri, 16 Oct 2020 16:40:17 +0200
Message-ID: <1602859219-15684-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
References: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_07:2020-10-16,2020-10-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all remaining LP timer exti direct events, e.g. for LP Timer 2 to 5.
LP timer 1 is already listed (e.g. exti 47).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/irqchip/irq-stm32-exti.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0c2c61d..8662d7b 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -195,6 +195,10 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 52, .irq_parent = 140, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 53, .irq_parent = 141, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
-- 
2.7.4

