Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E960222498F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jul 2020 09:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgGRHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jul 2020 03:02:56 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:22973 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgGRHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 03:02:55 -0400
Received: from localhost.localdomain ([93.22.133.66])
        by mwinf5d03 with ME
        id 4X2o2300J1S6l4V03X2qwb; Sat, 18 Jul 2020 09:02:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 18 Jul 2020 09:02:52 +0200
X-ME-IP: 93.22.133.66
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/2] misc: hpilo: avoid a useless memset
Date:   Sat, 18 Jul 2020 09:02:46 +0200
Message-Id: <20200718070246.338016-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a memset after a call to 'dma_alloc_coherent()'.
This is useless since
commit 518a2f1925c3 ("dma-mapping: zero memory returned from dma_alloc_*")

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/misc/hpilo.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/hpilo.c b/drivers/misc/hpilo.c
index c9539c89a925..fea3ae9d8686 100644
--- a/drivers/misc/hpilo.c
+++ b/drivers/misc/hpilo.c
@@ -281,8 +281,6 @@ static int ilo_ccb_setup(struct ilo_hwinfo *hw, struct ccb_data *data, int slot)
 	dma_va = (char *)data->dma_va;
 	dma_pa = data->dma_pa;
 
-	memset(dma_va, 0, data->dma_size);
-
 	dma_va = (char *)roundup((unsigned long)dma_va, ILO_START_ALIGN);
 	dma_pa = roundup(dma_pa, ILO_START_ALIGN);
 
-- 
2.25.1

