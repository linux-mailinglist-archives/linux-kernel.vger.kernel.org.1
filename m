Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A0830006F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbhAVKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:33:21 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:52826 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbhAVJdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 04:33:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UMVZgVS_1611307935;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMVZgVS_1611307935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jan 2021 17:32:19 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     roopa@nvidia.com
Cc:     nikolay@nvidia.com, davem@davemloft.net, kuba@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] bridge: Use PTR_ERR_OR_ZERO instead if(IS_ERR(...)) + PTR_ERR
Date:   Fri, 22 Jan 2021 17:32:13 +0800
Message-Id: <1611307933-115887-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck suggested using PTR_ERR_OR_ZERO() and looking at the code.

Fix the following coccicheck warnings:

./net/bridge/br_multicast.c:1295:7-13: WARNING: PTR_ERR_OR_ZERO can be
used.

Reported-by: Abaci <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 net/bridge/br_multicast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 257ac4e..2229d10 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -1292,7 +1292,7 @@ static int br_multicast_add_group(struct net_bridge *br,
 	pg = __br_multicast_add_group(br, port, group, src, filter_mode,
 				      igmpv2_mldv1, false);
 	/* NULL is considered valid for host joined groups */
-	err = IS_ERR(pg) ? PTR_ERR(pg) : 0;
+	err = PTR_ERR_OR_ZERO(pg);
 	spin_unlock(&br->multicast_lock);
 
 	return err;
-- 
1.8.3.1

