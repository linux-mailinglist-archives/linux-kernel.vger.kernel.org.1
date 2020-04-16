Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655D61ABF6D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 13:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633759AbgDPLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 07:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506037AbgDPLEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:04:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECE5C03C1A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:47:50 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.pengutronix.de.)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jP23g-0006Fm-PR; Thu, 16 Apr 2020 12:47:48 +0200
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@pengutronix.de,
        patchwork-lst@pengutronix.de
Subject: [PATCH] tools/vm: fix cross-compile build
Date:   Thu, 16 Apr 2020 12:47:48 +0200
Message-Id: <20200416104748.25243-1-l.stach@pengutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7ed1c1901fe5 (tools: fix cross-compile var clobbering) moved the setup of
the CC variable to tools/scripts/Makefile.include to make the behavior
consistent across all the tools Makefiles. As the vm tools missed the
include we end up with the wrong CC in a cross-compiling evironment.

Fixes: 7ed1c1901fe5 (tools: fix cross-compile var clobbering)
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 tools/vm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/vm/Makefile b/tools/vm/Makefile
index 20f6cf04377f..9860622cbb15 100644
--- a/tools/vm/Makefile
+++ b/tools/vm/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for vm tools
 #
+include ../scripts/Makefile.include
+
 TARGETS=page-types slabinfo page_owner_sort
 
 LIB_DIR = ../lib/api
-- 
2.25.2

