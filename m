Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427E828807C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 04:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgJICuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 22:50:39 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40905 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgJICuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 22:50:39 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0992liiC054349;
        Fri, 9 Oct 2020 10:47:44 +0800 (GMT-8)
        (envelope-from ryan_chen@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Oct
 2020 10:49:41 +0800
From:   Ryan Chen <ryan_chen@aspeedtech.com>
To:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <bmc-sw@aspeedtech.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Ryan Chen <ryan_chen@aspeedtech.com>
Subject: [PATCH v2 0/3] Enable USB host for AST2600
Date:   Fri, 9 Oct 2020 10:49:34 +0800
Message-ID: <20201009024937.11246-1-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
References: <20200930040823.26065-4-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0992liiC054349
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
 -[1/3]: Add SCSI,BLK_DEV_SD,USB_STORAGE in defconfig.
 -[2/3]: Fix continuation lines.
v1:
 -The patches enable UHCI driver in AST2600 and also 
  enable USB host in aspeed-ast2600-evb.dts.

Ryan Chen (3):
  configs: aspeed: enable UHCI driver in defconfig
  usb: host: add uhci compatible support for ast2600-uhci
  ARM: dts: add ehci uhci enable in evb dts

 arch/arm/boot/dts/aspeed-ast2600-evb.dts | 8 ++++++++
 arch/arm/configs/aspeed_g5_defconfig     | 4 ++++
 drivers/usb/host/uhci-platform.c         | 3 ++-
 3 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.17.1

