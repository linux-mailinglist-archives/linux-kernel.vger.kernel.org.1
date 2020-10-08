Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912E7286C78
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 03:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgJHBwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 21:52:02 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:10441 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbgJHBwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 21:52:02 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 0981VLjC057070;
        Thu, 8 Oct 2020 09:31:22 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.9) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 8 Oct
 2020 09:51:10 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/2] Fix the memory layout and add sgpio node for aspeed g6
Date:   Thu, 8 Oct 2020 09:51:04 +0800
Message-ID: <20201008015106.3198-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.10.9]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 0981VLjC057070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the memory layout and add sgpio node for aspeed g6

Billy Tsai (2):
  Arm: dts: aspeed-g6: Fix the register range of gpio
  Arm: dts: aspeed-g6: Add sgpio node and pinctrl setting

 arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi   |  5 ++
 arch/arm/boot/dts/aspeed-g6.dtsi           | 55 +++++++++++++++++++++-
 drivers/pinctrl/aspeed/pinctrl-aspeed-g6.c | 30 ++++++++++--
 3 files changed, 85 insertions(+), 5 deletions(-)

-- 
2.17.1

