Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5B226C74F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgIPSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:23:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42010 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727868AbgIPSXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:23:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B36DA57718313850004C;
        Wed, 16 Sep 2020 22:17:42 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 22:17:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <jiri@mellanox.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] genetlink: Remove unused function genl_err_attr()
Date:   Wed, 16 Sep 2020 22:17:28 +0800
Message-ID: <20200916141728.34796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is never used, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/net/genetlink.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/include/net/genetlink.h b/include/net/genetlink.h
index 6e5f1e1aa822..b9eb92f3fe86 100644
--- a/include/net/genetlink.h
+++ b/include/net/genetlink.h
@@ -101,14 +101,6 @@ static inline void genl_info_net_set(struct genl_info *info, struct net *net)
 
 #define GENL_SET_ERR_MSG(info, msg) NL_SET_ERR_MSG((info)->extack, msg)
 
-static inline int genl_err_attr(struct genl_info *info, int err,
-				const struct nlattr *attr)
-{
-	info->extack->bad_attr = attr;
-
-	return err;
-}
-
 enum genl_validate_flags {
 	GENL_DONT_VALIDATE_STRICT		= BIT(0),
 	GENL_DONT_VALIDATE_DUMP			= BIT(1),
-- 
2.17.1

