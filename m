Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37E1526D51C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgIQHty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:49:54 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:49054 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgIQHts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:49:48 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.226])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 1708D4E16F8;
        Thu, 17 Sep 2020 15:49:43 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arm/mach-omap2: fix spellint typo
Date:   Thu, 17 Sep 2020 15:49:35 +0800
Message-Id: <1600328977-32001-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZS01IShpOGU5CTEwdVkpNS0tISUNCQ0hOSENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6Ihw6Mz8pOBQPD0scPkJL
        IgsaC0xVSlVKTUtLSElDQkNIQkJDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFJSk9CNwY+
X-HM-Tid: 0a749b0a637f9376kuws1708d4e16f8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the comment typo: "ununsed" -> "unused".

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/mach-omap2/clockdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index dedd47e..1feb009
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -1299,7 +1299,7 @@ int clkdm_hwmod_disable(struct clockdomain *clkdm, struct omap_hwmod *oh)
  * Due to a suspend or hibernation operation, the state of the registers
  * controlling this clkdm will be lost, save their context.
  */
-static int _clkdm_save_context(struct clockdomain *clkdm, void *ununsed)
+static int _clkdm_save_context(struct clockdomain *clkdm, void *unused)
 {
 	if (!arch_clkdm || !arch_clkdm->clkdm_save_context)
 		return -EINVAL;
@@ -1312,7 +1312,7 @@ static int _clkdm_save_context(struct clockdomain *clkdm, void *ununsed)
  *
  * Restore the register values for this clockdomain.
  */
-static int _clkdm_restore_context(struct clockdomain *clkdm, void *ununsed)
+static int _clkdm_restore_context(struct clockdomain *clkdm, void *unused)
 {
 	if (!arch_clkdm || !arch_clkdm->clkdm_restore_context)
 		return -EINVAL;
-- 
2.7.4

