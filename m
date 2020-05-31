Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AF91E9699
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEaJek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 05:34:40 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:40352 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727866AbgEaJek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:34:40 -0400
Received: from localhost.localdomain ([93.23.14.245])
        by mwinf5d05 with ME
        id lMaZ220075HDzGl03MaZai; Sun, 31 May 2020 11:34:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 31 May 2020 11:34:38 +0200
X-ME-IP: 93.23.14.245
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] ARM: riscpc: mark a function as __init to save some memory
Date:   Sun, 31 May 2020 11:34:29 +0200
Message-Id: <20200531093429.596642-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ecard_bus_init()' is only called via 'postcore_initcall'.
It can be marked as __init to save a few bytes of memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/arm/mach-rpc/ecard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 75cfad2cb143..9f4e7106efb9 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -1135,7 +1135,7 @@ struct bus_type ecard_bus_type = {
 	.shutdown	= ecard_drv_shutdown,
 };
 
-static int ecard_bus_init(void)
+static int __init ecard_bus_init(void)
 {
 	return bus_register(&ecard_bus_type);
 }
-- 
2.25.1

