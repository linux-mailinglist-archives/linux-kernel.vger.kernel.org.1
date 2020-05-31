Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989CD1E96AC
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 11:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEaJv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 05:51:58 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:38019 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:51:57 -0400
Received: from localhost.localdomain ([93.23.14.245])
        by mwinf5d05 with ME
        id lMrs2200E5HDzGl03MrtmT; Sun, 31 May 2020 11:51:55 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 31 May 2020 11:51:55 +0200
X-ME-IP: 93.23.14.245
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@armlinux.org.uk, tglx@linutronix.de, allison@lohutok.net,
        kstewart@linuxfoundation.org, info@metux.net,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ARM: smp_twd: mark a function as __init to save some memory
Date:   Sun, 31 May 2020 11:51:51 +0200
Message-Id: <20200531095151.597393-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'twd_clk_init()' is only called via 'core_initcall'.
It can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
For the records, this function has been introduced in commit 4fd7f9b12810
("ARM: 7212/1: smp_twd: reconfigure clockevents after cpufreq change")
---
 arch/arm/kernel/smp_twd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index 9a14f721a2b0..e0a0b0d820bc 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -129,7 +129,7 @@ static struct notifier_block twd_clk_nb = {
 	.notifier_call = twd_rate_change,
 };
 
-static int twd_clk_init(void)
+static int __init twd_clk_init(void)
 {
 	if (twd_evt && raw_cpu_ptr(twd_evt) && !IS_ERR(twd_clk))
 		return clk_notifier_register(twd_clk, &twd_clk_nb);
-- 
2.25.1

