Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA72B90B1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgKSLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:09:33 -0500
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:53841 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgKSLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:09:32 -0500
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5fb6525cb0b-ca8c3; Thu, 19 Nov 2020 19:09:16 +0800 (CST)
X-RM-TRANSID: 2eeb5fb6525cb0b-ca8c3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55fb6525a589-bf520;
        Thu, 19 Nov 2020 19:09:16 +0800 (CST)
X-RM-TRANSID: 2ee55fb6525a589-bf520
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] ARM: Fix the spelling mistake in vfpmodule.c
Date:   Thu, 19 Nov 2020 19:10:01 +0800
Message-Id: <20201119111001.14872-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the word 'THREAD_NOFTIFY_SWTICH','SWTICH' is wrong,
thus fix it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 arch/arm/vfp/vfpmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 8c9e7f9f0..dd0b875bc 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -140,7 +140,7 @@ static void vfp_thread_copy(struct thread_info *thread)
 /*
  * When this function is called with the following 'cmd's, the following
  * is true while this function is being run:
- *  THREAD_NOFTIFY_SWTICH:
+ *  THREAD_NOFTIFY_SWITCH:
  *   - the previously running thread will not be scheduled onto another CPU.
  *   - the next thread to be run (v) will not be running on another CPU.
  *   - thread->cpu is the local CPU number
-- 
2.20.1.windows.1



