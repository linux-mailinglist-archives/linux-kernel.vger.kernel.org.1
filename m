Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59A23518A
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 11:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHAJm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 05:42:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9310 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbgHAJm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 05:42:58 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1D381CBE594CBAD2D62A;
        Sat,  1 Aug 2020 17:42:38 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Sat, 1 Aug 2020
 17:42:28 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <johannes.berg@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH] netlink: remove duplicated nla_need_padding_for_64bit() check
Date:   Sat, 1 Aug 2020 17:45:04 +0800
Message-ID: <1596275104-24792-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

The need for padding 64bit is implicitly checked by nla_align_64bit(), so
remove this explicit one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 lib/nlattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/nlattr.c b/lib/nlattr.c
index bc5b5cf608c4..98f596bfbfd8 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -816,8 +816,7 @@ EXPORT_SYMBOL(__nla_reserve);
 struct nlattr *__nla_reserve_64bit(struct sk_buff *skb, int attrtype,
 				   int attrlen, int padattr)
 {
-	if (nla_need_padding_for_64bit(skb))
-		nla_align_64bit(skb, padattr);
+	nla_align_64bit(skb, padattr);
 
 	return __nla_reserve(skb, attrtype, attrlen);
 }
-- 
2.19.1

