Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CEA23FDC7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 13:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgHILS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 07:18:56 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:60894 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgHILSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:18:54 -0400
Received: from localhost.localdomain ([93.22.150.139])
        by mwinf5d61 with ME
        id DPJn2300A30hzCV03PJo69; Sun, 09 Aug 2020 13:18:52 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2020 13:18:52 +0200
X-ME-IP: 93.22.150.139
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, sfr@canb.auug.org.au,
        longman@redhat.com, akpm@linux-foundation.org, mhocko@suse.com,
        hannes@cmpxchg.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] staging: ks7010: Do not use GFP_KERNEL in atomic context
Date:   Sun,  9 Aug 2020 13:18:46 +0200
Message-Id: <20200809111846.745826-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A possible call chain is as follow:
  ks_wlan_start_xmit                    (ks_wlan_net.c)
    --> hostif_data_request             (ks_hostif.c)
      --> michael_mic                   (ks_hostif.c)

'ks_wlan_start_xmit()' is a '.ndo_start_xmit()' function (see
net_device_ops structure). Such calls are guarded by the __netif_tx_lock
spinlock. So memory allocation must be atomic.

So, use GFP_ATOMIC instead of GFP_KERNEL 'in michael_mic()'

Fixes: ???
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is completely speculative. I don't know if the call chain given above
if possible in RL application.
So review carefully :)

If the fix is correct, it is also more the starting point of a bigger
change, because in 'michael_mic()' there is a call to
'crypto_alloc_shash()' and this function uses GFP_KERNEL internally (in
'crypto_create_tfm()')
Should this need to be changed, I don't know how 'ks_hostif.c' should be
fixed. Changing allocation in 'crypto/api.c' looks like an overkill.

In other word, I think that my patch is wrong, but don't know what else to
propose :).
---
 drivers/staging/ks7010/ks_hostif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index d70b671b06aa..c66f50e4a158 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -212,7 +212,7 @@ michael_mic(u8 *key, u8 *data, unsigned int len, u8 priority, u8 *result)
 	if (ret < 0)
 		goto err_free_tfm;
 
-	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_KERNEL);
+	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(tfm), GFP_ATOMIC);
 	if (!desc) {
 		ret = -ENOMEM;
 		goto err_free_tfm;
-- 
2.25.1

