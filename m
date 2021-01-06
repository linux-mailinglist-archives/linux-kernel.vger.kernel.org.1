Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F072EB9BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbhAFGBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:01:36 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29791 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbhAFGBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:01:35 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1065sEQM004599;
        Wed, 6 Jan 2021 13:54:14 +0800 (GMT-8)
        (envelope-from chiawei_wang@aspeedtech.com)
Received: from ChiaWeiWang-PC.aspeed.com (192.168.2.66) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 6 Jan
 2021 13:58:49 +0800
From:   "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <tglx@linutronix.de>, <maz@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 3/6] clk: ast2600: Add eSPI reset bit
Date:   Wed, 6 Jan 2021 13:59:36 +0800
Message-ID: <20210106055939.19386-4-chiawei_wang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
References: <20210106055939.19386-1-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.66]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1065sEQM004599
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bit field definition for the eSPI reset control.

Signed-off-by: Chia-Wei, Wang <chiawei_wang@aspeedtech.com>
---
 include/dt-bindings/clock/ast2600-clock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/ast2600-clock.h b/include/dt-bindings/clock/ast2600-clock.h
index 62b9520a00fd..964934b1caef 100644
--- a/include/dt-bindings/clock/ast2600-clock.h
+++ b/include/dt-bindings/clock/ast2600-clock.h
@@ -89,6 +89,7 @@
 #define ASPEED_CLK_MAC4RCLK		70
 
 /* Only list resets here that are not part of a gate */
+#define ASPEED_RESET_ESPI		57
 #define ASPEED_RESET_ADC		55
 #define ASPEED_RESET_JTAG_MASTER2	54
 #define ASPEED_RESET_I3C_DMA		39
-- 
2.17.1

