Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49171DA30E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 22:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgESUpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 16:45:12 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:56561 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESUpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:45:12 -0400
Received: from localhost.localdomain ([93.22.37.87])
        by mwinf5d40 with ME
        id gkl92200J1sokYV03klAAT; Tue, 19 May 2020 22:45:11 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 May 2020 22:45:11 +0200
X-ME-IP: 93.22.37.87
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jsrikanth@marvell.com, phemadri@marvell.com,
        gustavo@embeddedor.com, tglx@linutronix.de
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: cavium/nitrox - Fix 'nitrox_get_first_device()' when ndevlist is fully iterated
Date:   Tue, 19 May 2020 22:45:03 +0200
Message-Id: <20200519204503.281872-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a list is completely iterated with 'list_for_each_entry(x, ...)', x is
not NULL at the end.

Introduce an intermediate variable and test it instead, in order to
reliably know if something was found or not.

Fixes: f2663872f073 ("crypto: cavium - Register the CNN55XX supported crypto algorithms.")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/crypto/cavium/nitrox/nitrox_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
index 788c6607078b..172cafe7c039 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_main.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
@@ -278,15 +278,18 @@ static void nitrox_remove_from_devlist(struct nitrox_device *ndev)
 
 struct nitrox_device *nitrox_get_first_device(void)
 {
-	struct nitrox_device *ndev = NULL;
+	struct nitrox_device *ndev;
+	bool found = false;
 
 	mutex_lock(&devlist_lock);
 	list_for_each_entry(ndev, &ndevlist, list) {
-		if (nitrox_ready(ndev))
+		if (nitrox_ready(ndev)) {
+			found = true;
 			break;
+		}
 	}
 	mutex_unlock(&devlist_lock);
-	if (!ndev)
+	if (!found)
 		return NULL;
 
 	refcount_inc(&ndev->refcnt);
-- 
2.25.1

