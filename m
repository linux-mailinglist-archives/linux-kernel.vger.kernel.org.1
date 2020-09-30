Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1830027DF2B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 06:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgI3EJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 00:09:11 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:30674 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3EJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 00:09:11 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 08U3n7Vx071703;
        Wed, 30 Sep 2020 11:49:07 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Sep
 2020 12:08:30 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <bmc-sw@aspeedtech.com>
CC:     Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH 1/3] configs: aspeed: enable UHCI driver in defconfig
Date:   Wed, 30 Sep 2020 12:08:21 +0800
Message-ID: <20200930040823.26065-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 08U3n7Vx071703
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable UHCI driver in aspeed_g5_defconfig.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm/configs/aspeed_g5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 2bacd8c90f4b..a57009d1a3b8 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -212,6 +212,7 @@ CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ASPEED_VHUB=y
 CONFIG_USB_CONFIGFS=y
-- 
2.17.1

