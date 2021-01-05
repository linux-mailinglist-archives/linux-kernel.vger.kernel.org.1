Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19E32EA526
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 07:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbhAEGE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 01:04:56 -0500
Received: from spam.zju.edu.cn ([61.164.42.155]:36694 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725298AbhAEGE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 01:04:56 -0500
Received: from localhost.localdomain (unknown [222.205.25.254])
        by mail-app2 (Coremail) with SMTP id by_KCgCnjok9AfRfTnUJAA--.6901S4;
        Tue, 05 Jan 2021 14:03:44 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: Fix memleak in ubifs_init_authentication
Date:   Tue,  5 Jan 2021 14:03:40 +0800
Message-Id: <20210105060340.7990-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgCnjok9AfRfTnUJAA--.6901S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFW8Gr48CF1fGw4DJF47Arb_yoW3twbEy3
        y7Zr4rur48GFnak34Ykay8Gr1fu397Za4rKr4fXF9rua4Iy3Z8ArZ7GrZ5WrW7Ar4a9ryk
        Jayvvryfur9IqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
        wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
        vE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GF1l42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7VUjHUDJUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgMQBlZdtR1gpwADsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When crypto_shash_digestsize() fails, c->hmac_tfm
has not been freed before returning, which leads
to memleak.

Fixes: 49525e5eecca5 ("ubifs: Add helper functions for authentication support")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 fs/ubifs/auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
index 51a7c8c2c3f0..e564d5ff8781 100644
--- a/fs/ubifs/auth.c
+++ b/fs/ubifs/auth.c
@@ -327,7 +327,7 @@ int ubifs_init_authentication(struct ubifs_info *c)
 		ubifs_err(c, "hmac %s is bigger than maximum allowed hmac size (%d > %d)",
 			  hmac_name, c->hmac_desc_len, UBIFS_HMAC_ARR_SZ);
 		err = -EINVAL;
-		goto out_free_hash;
+		goto out_free_hmac;
 	}
 
 	err = crypto_shash_setkey(c->hmac_tfm, ukp->data, ukp->datalen);
-- 
2.17.1

