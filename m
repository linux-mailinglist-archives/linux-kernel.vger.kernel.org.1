Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 397CC23E2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 22:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgHFUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 16:06:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49442 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725272AbgHFUGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:06:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 90EBA1000D0A56ACABF6;
        Thu,  6 Aug 2020 19:54:55 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Thu, 6 Aug 2020
 19:54:48 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pshelar@ovn.org>,
        <martin.varghese@nokia.com>, <fw@strlen.de>, <willemb@google.com>,
        <edumazet@google.com>, <dcaratti@redhat.com>,
        <steffen.klassert@secunet.com>, <pabeni@redhat.com>,
        <shmulik@metanetworks.com>, <kyk.segfault@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] net: Use helper function ip_is_fragment()
Date:   Thu, 6 Aug 2020 19:57:18 +0800
Message-ID: <1596715038-25429-1-git-send-email-linmiaohe@huawei.com>
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

Use helper function ip_is_fragment() to check ip fragment.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8a0c39e4ab0a..fa823405829c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4853,7 +4853,7 @@ static int skb_checksum_setup_ipv4(struct sk_buff *skb, bool recalculate)
 	if (err < 0)
 		goto out;
 
-	if (ip_hdr(skb)->frag_off & htons(IP_OFFSET | IP_MF))
+	if (ip_is_fragment(ip_hdr(skb)))
 		fragment = true;
 
 	off = ip_hdrlen(skb);
-- 
2.19.1

