Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673C02029A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 10:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgFUIdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 04:33:21 -0400
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:52693 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgFUIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 04:33:21 -0400
Received: from localhost.localdomain ([93.22.149.109])
        by mwinf5d20 with ME
        id tkZH220082MrWsD03kZH1v; Sun, 21 Jun 2020 10:33:18 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 21 Jun 2020 10:33:18 +0200
X-ME-IP: 93.22.149.109
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     swboyd@chromium.org, bjorn.andersson@linaro.org,
        dianders@chromium.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] kernel/cpu_pm: mark 1 function as __init to save some memory
Date:   Sun, 21 Jun 2020 10:33:15 +0200
Message-Id: <20200621083315.883209-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cpu_pm_init()' is only called via 'core_initcall'.
It can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 kernel/cpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 44a259338e33..6a4717ae6917 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -191,7 +191,7 @@ static struct syscore_ops cpu_pm_syscore_ops = {
 	.resume = cpu_pm_resume,
 };
 
-static int cpu_pm_init(void)
+static int __init cpu_pm_init(void)
 {
 	register_syscore_ops(&cpu_pm_syscore_ops);
 	return 0;
-- 
2.25.1

