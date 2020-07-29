Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925DB231841
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 05:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgG2Dq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 23:46:26 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36562 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:46:26 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1183A200E2A;
        Wed, 29 Jul 2020 05:46:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F1494200E1C;
        Wed, 29 Jul 2020 05:46:20 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 014644031D;
        Wed, 29 Jul 2020 05:46:14 +0200 (CEST)
From:   Alison Wang <alison.wang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        kurt.kanzenbach@linutronix.de, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     alison.wang@nxp.com
Subject: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
Date:   Wed, 29 Jul 2020 11:39:34 +0800
Message-Id: <20200729033934.22349-1-alison.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current arm64 defconfig, CONFIG_IRQ_TIME_ACCOUNTING is enabled as
default. According to my tests on NXP's LayerScape and i.MX platforms,
the system hangs when running the command "stress-ng --hrtimers 1" with
CONFIG_IRQ_TIME_ACCOUNTING enabled. Disabling this option, the issue
disappears. CONFIG_IRQ_TIME_ACCOUNTING causes serious performance impact
when running hrtimer stress test at the same time.

Signed-off-by: Alison Wang <alison.wang@nxp.com>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e0f33826819f..ff1c11d8b10b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -4,7 +4,6 @@ CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_TASK_XACCT=y
-- 
2.17.1

