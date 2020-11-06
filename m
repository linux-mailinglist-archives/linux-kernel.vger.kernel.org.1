Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884CF2A8C4F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 02:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgKFBwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 20:52:22 -0500
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:9123 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbgKFBwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 20:52:22 -0500
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Nov 2020 20:52:22 EST
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 4D4C64E177F;
        Fri,  6 Nov 2020 09:46:29 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arm: Add clk_get_rate input parameter null check
Date:   Fri,  6 Nov 2020 09:46:15 +0800
Message-Id: <1604627175-16710-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQ0hKSk5PSx1OGBhCVkpNS09NSUxKQ0JNSk5VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OiI6Lxw4Dz8oCR0NEAw#TRQo
        SChPC01VSlVKTUtPTUlMSkJLS0hOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTk9ONwY+
X-HM-Tid: 0a759b3bcf079376kuws4d4c64e177f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input parameter of clk_get_rate() is checked with IS_ERR(),
so here we need to check null on clk.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/mach-ep93xx/clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
index 2810eb5..4313b2f
--- a/arch/arm/mach-ep93xx/clock.c
+++ b/arch/arm/mach-ep93xx/clock.c
@@ -321,6 +321,9 @@ static unsigned long get_uart_rate(struct clk *clk)
 
 unsigned long clk_get_rate(struct clk *clk)
 {
+	if (!clk)
+		return 0;
+
 	if (clk->get_rate)
 		return clk->get_rate(clk);
 
-- 
2.7.4

