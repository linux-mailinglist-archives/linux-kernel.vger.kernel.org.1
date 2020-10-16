Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16982290757
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409059AbgJPOlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:41:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28958 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408896AbgJPOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:41:10 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09GEbTax028212;
        Fri, 16 Oct 2020 16:40:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=+xoyFgWKF9M39CdJct5WeDHycIdVDU9Tp6gD7JbDFWc=;
 b=uKNyqNJ2AOeJsSVMHI4yW8bTdNSOGr8huiK/mgyYPnQIAEy7lIk/LfI61fSQwnM8PHeV
 e5cmskMgfaGeeQF/8FqNVuswWsDC+epTZqvr8c+ocf6RyIXrJT6Odn3NkBph2jMpQKW/
 esG798Td+hmPCghum+39tRN1fPrgFVK+dLfI4NzZVZOwudyFPbrW9KADAxjujeYhULMB
 7J7XLVSu+yFb9Fe6b+0hCYckIuPEO/IpK/S9PieHMz4A1yc82OicP+sx8HTar6dUdvQc
 nv6yf6r9idDGkV5bMRFUC08vl16G2w2+vRKYnbZ8yR2gydNuL9zpXUJTG2A5ejUoXqhV uA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 343587kw0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Oct 2020 16:40:43 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id DA13D10002A;
        Fri, 16 Oct 2020 16:40:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag1node3.st.com [10.75.127.3])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B4E2A2AF739;
        Fri, 16 Oct 2020 16:40:42 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG1NODE3.st.com (10.75.127.3)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 16 Oct 2020 16:40:41
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <alexandre.torgue@st.com>
CC:     <robh+dt@kernel.org>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add STM32 LP timer EXTI interrupts
Date:   Fri, 16 Oct 2020 16:40:16 +0200
Message-ID: <1602859219-15684-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG1NODE3.st.com
 (10.75.127.3)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-16_07:2020-10-16,2020-10-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32 LP timer that's available on STM32MP15x can wakeup the platform
using EXTI interrupts.

This series add:
- LP timer EXTI - GIC interrupt events to EXTI driver and device-tree
- LP timer wakeup-source to device-tree

Fabrice Gasnier (3):
  irqchip/stm32-exti: Add all LP timer exti direct events support
  ARM: dts: stm32: Add LP timer irqs on stm32mp151
  ARM: dts: stm32: Add LP timer wakeup-source on stm32mp151

 arch/arm/boot/dts/stm32mp151.dtsi | 10 ++++++++++
 drivers/irqchip/irq-stm32-exti.c  |  4 ++++
 2 files changed, 14 insertions(+)

-- 
2.7.4

