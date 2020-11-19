Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E942B9074
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSK5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:57:01 -0500
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:26562 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgKSK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:57:01 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75fb64f49603-cb57b; Thu, 19 Nov 2020 18:56:10 +0800 (CST)
X-RM-TRANSID: 2ee75fb64f49603-cb57b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95fb64f48b9b-c05b7;
        Thu, 19 Nov 2020 18:56:10 +0800 (CST)
X-RM-TRANSID: 2ee95fb64f48b9b-c05b7
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] sh: boards: Fix the cacography in irq.c
Date:   Thu, 19 Nov 2020 18:56:56 +0800
Message-Id: <20201119105656.11068-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The world 'swtich' is wrong, so fix it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/sh/boards/mach-landisk/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-landisk/irq.c b/arch/sh/boards/mach-landisk/irq.c
index 29b8b1f85..0b672b80c 100644
--- a/arch/sh/boards/mach-landisk/irq.c
+++ b/arch/sh/boards/mach-landisk/irq.c
@@ -26,8 +26,8 @@ enum {
 	PCI_INTD, /* PCI int D */
 	ATA,	  /* ATA */
 	FATA,	  /* CF */
-	POWER,	  /* Power swtich */
-	BUTTON,	  /* Button swtich */
+	POWER,	  /* Power switch */
+	BUTTON,	  /* Button switch */
 };
 
 /* Vectors for LANDISK */
-- 
2.20.1.windows.1



