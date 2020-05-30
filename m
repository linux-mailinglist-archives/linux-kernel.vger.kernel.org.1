Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9661E91BD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgE3Nfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 May 2020 09:35:48 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:59019 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbgE3Nfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 09:35:48 -0400
Received: from localhost.localdomain ([93.23.15.192])
        by mwinf5d05 with ME
        id l1bf2200548dfat031bfFy; Sat, 30 May 2020 15:35:46 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 30 May 2020 15:35:46 +0200
X-ME-IP: 93.23.15.192
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        phemadri@marvell.com, jsrikanth@marvell.com, horia.geanta@nxp.com,
        gustavo@embeddedor.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2] crypto: cavium/nitrox - Fix 'nitrox_get_first_device()' when ndevlist is fully iterated
Date:   Sat, 30 May 2020 15:35:37 +0200
Message-Id: <20200530133537.582843-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a list is completely iterated with 'list_for_each_entry(x, ...)', x is
not NULL at the end.

While at it, remove a useless initialization of the ndev variable. It
is overridden by 'list_for_each_entry'.

Fixes: f2663872f073 ("crypto: cavium - Register the CNN55XX supported crypto algorithms.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v2: Do not introduce an extra variable to check if the list has been fully
    iterated. Test with "if (&ndev->list == &ndevlist)" instead
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 788c6607078b..cee2a2713038 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -278,7 +278,7 @@ static void nitrox_remove_from_devlist(struct nitrox_device *ndev)
 
 struct nitrox_device *nitrox_get_first_device(void)
 {
-	struct nitrox_device *ndev = NULL;
+	struct nitrox_device *ndev;
 
 	mutex_lock(&devlist_lock);
 	list_for_each_entry(ndev, &ndevlist, list) {
@@ -286,7 +286,7 @@ struct nitrox_device *nitrox_get_first_device(void)
 			break;
 	}
 	mutex_unlock(&devlist_lock);
-	if (!ndev)
+	if (&ndev->list == &ndevlist)
 		return NULL;
 
 	refcount_inc(&ndev->refcnt);
-- 
2.25.1

