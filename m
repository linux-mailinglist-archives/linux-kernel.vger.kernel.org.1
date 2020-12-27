Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEBC2E31A7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 16:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgL0PLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 10:11:46 -0500
Received: from mail-m965.mail.126.com ([123.126.96.5]:44576 "EHLO
        mail-m965.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgL0PLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 10:11:45 -0500
X-Greylist: delayed 2016 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Dec 2020 10:11:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=arGaXfT9hHcCAzWG5e
        5RPiv2ifF/YyMiSpUcRiFWkhA=; b=cBq4bAg8gey0S0eJo1WsgVykCED+dnYNnb
        Kpr3YT0JmpRyRppWX60t4QYAajIEg8CEsSsTwM1THTdyeGhJ0tMfIyuFvMBE8iuA
        RFSeBpxSc+mdfCAbbZZp89FBDDqfxTRHDbHFGHp6xSzL82k0Lb6wTsykO1LvR7ia
        +J3HjPTSE=
Received: from localhost.localdomain (unknown [36.112.86.14])
        by smtp10 (Coremail) with SMTP id NuRpCgBHWKvQm+hf44Isig--.54645S2;
        Sun, 27 Dec 2020 22:36:01 +0800 (CST)
From:   Defang Bo <bodefang@126.com>
To:     gerg@linux-m68k.org, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Defang Bo <bodefang@126.com>
Subject: [PATCH 2/2] m68k: let clk_enable() return immediately if clk is NULL
Date:   Sun, 27 Dec 2020 22:35:53 +0800
Message-Id: <1609079753-4038536-1-git-send-email-bodefang@126.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: NuRpCgBHWKvQm+hf44Isig--.54645S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RRUDXUUUUU
X-Originating-IP: [36.112.86.14]
X-CM-SenderInfo: pergvwxdqjqiyswou0bp/1tbiCxEI11x5cpoSBQAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should be a check for clk to prevent NULL pointer dereference.

Signed-off-by: Defang Bo <bodefang@126.com>
---
 arch/m68k/coldfire/clk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
index 7bc666e..cf1ed97 100644
--- a/arch/m68k/coldfire/clk.c
+++ b/arch/m68k/coldfire/clk.c
@@ -90,6 +90,9 @@ EXPORT_SYMBOL(clk_get);
 int clk_enable(struct clk *clk)
 {
 	unsigned long flags;
+	if (!clk)
+		return;
+
 	spin_lock_irqsave(&clk_lock, flags);
 	if ((clk->enabled++ == 0) && clk->clk_ops)
 		clk->clk_ops->enable(clk);
-- 
2.7.4

