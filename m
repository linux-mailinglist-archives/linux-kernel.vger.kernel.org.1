Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5831AEA32
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 08:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDRGjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 02:39:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2357 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbgDRGjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:39:07 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A7C1F37D1FE2FD599D69;
        Sat, 18 Apr 2020 14:39:06 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 14:38:56 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <keescook@chromium.org>, <re.emese@gmail.com>,
        <kernel-hardening@lists.openwall.com>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] gcc-plugins: latent_entropy: remove unneeded semicolon
Date:   Sat, 18 Apr 2020 15:05:21 +0800
Message-ID: <20200418070521.10931-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

scripts/gcc-plugins/latent_entropy_plugin.c:539:2-3: Unneeded semicolon

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 scripts/gcc-plugins/latent_entropy_plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/latent_entropy_plugin.c b/scripts/gcc-plugins/latent_entropy_plugin.c
index cbe1d6c4b1a5..5c304061ad2a 100644
--- a/scripts/gcc-plugins/latent_entropy_plugin.c
+++ b/scripts/gcc-plugins/latent_entropy_plugin.c
@@ -536,7 +536,7 @@ static unsigned int latent_entropy_execute(void)
 	while (bb != EXIT_BLOCK_PTR_FOR_FN(cfun)) {
 		perturb_local_entropy(bb, local_entropy);
 		bb = bb->next_bb;
-	};
+	}
 
 	/* 4. mix local entropy into the global entropy variable */
 	perturb_latent_entropy(local_entropy);
-- 
2.21.1

