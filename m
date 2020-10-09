Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A0C28807F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgJICus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:50:48 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40911 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731012AbgJICuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:50:39 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0992ljQ6054350;
        Fri, 9 Oct 2020 10:47:45 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Oct
 2020 10:49:42 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <bmc-sw@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 1/3] configs: aspeed: enable UHCI driver in defconfig
Date:   Fri, 9 Oct 2020 10:49:35 +0800
Message-ID: <20201009024937.11246-2-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009024937.11246-1-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
 <20201009024937.11246-1-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0992ljQ6054350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 -Changed : Add SCSI, BLK_DEV_SD, USB_STORAGE support.
v1:
 -Enable UHCI driver in aspeed_g5_defconfig.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm/configs/aspeed_g5_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 2bacd8c90f4b..7a6b0b79be9f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -90,6 +90,8 @@ CONFIG_BLK_DEV_NBD=y
 CONFIG_MCTP_LPC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_AT25=y
+CONFIG_SCSI=y
+CONFIG_BLK_DEV_SD=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_DM=y
 CONFIG_DM_VERITY=y
@@ -212,6 +214,8 @@ CONFIG_USB_DYNAMIC_MINORS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_UHCI_HCD=y
+CONFIG_USB_STORAGE=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_ASPEED_VHUB=y
 CONFIG_USB_CONFIGFS=y
-- 
2.17.1

