Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A718C1BD519
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 08:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgD2Gws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 02:52:48 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:29059 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgD2Gws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:52:48 -0400
Received: from localhost.localdomain ([92.148.159.11])
        by mwinf5d18 with ME
        id YWsl2201j0F2omL03WsmNo; Wed, 29 Apr 2020 08:52:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 29 Apr 2020 08:52:46 +0200
X-ME-IP: 92.148.159.11
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4 v2] firmware: stratix10-svc: Unmap some previously memremap'ed memory
Date:   Wed, 29 Apr 2020 08:52:43 +0200
Message-Id: <43505dc3a4b405d1c7d4a0fa74c67eda3e8bdb75.1588142343.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 'svc_create_memory_pool()' we memremap some memory. This has to be
undone in case of error and if the driver is removed.

The easiest way to do it is to use 'devm_memremap()'.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/firmware/stratix10-svc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 3a176e62754a..de5870f76c5e 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -631,7 +631,7 @@ svc_create_memory_pool(struct platform_device *pdev,
 	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
 	paddr = begin;
 	size = end - begin;
-	va = memremap(paddr, size, MEMREMAP_WC);
+	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
 	if (!va) {
 		dev_err(dev, "fail to remap shared memory\n");
 		return ERR_PTR(-EINVAL);
-- 
2.25.1

