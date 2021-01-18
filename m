Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968D62F9754
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbhARBZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:25:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11398 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730763AbhARBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:25:43 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DJvFS6R34z7WYN;
        Mon, 18 Jan 2021 09:23:56 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Mon, 18 Jan 2021
 09:24:58 +0800
From:   Chengyang Fan <cy.fan@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <richard.weiyang@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/memcontrol: Remove unneeded semicolons
Date:   Mon, 18 Jan 2021 09:52:29 +0800
Message-ID: <20210118015229.2599778-1-cy.fan@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove superfluous semicolons after function definitions.

Signed-off-by: Chengyang Fan <cy.fan@huawei.com>
---
 include/linux/memcontrol.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d827bd7f3bfe..77802cc217ff 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1587,8 +1587,8 @@ extern void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
 				   int nid, int shrinker_id);
 #else
 #define mem_cgroup_sockets_enabled 0
-static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
-static inline void mem_cgroup_sk_free(struct sock *sk) { };
+static inline void mem_cgroup_sk_alloc(struct sock *sk) { }
+static inline void mem_cgroup_sk_free(struct sock *sk) { }
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
-- 
2.25.1

