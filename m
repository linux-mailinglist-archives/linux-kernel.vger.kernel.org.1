Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC75288A29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgJIN7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:59:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14810 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387861AbgJIN7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:59:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85992501CC98135D3D78;
        Fri,  9 Oct 2020 21:59:29 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 21:59:22 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <ziy@nvidia.com>, <alexander.h.duyck@linux.intel.com>,
        <willy@infradead.org>, <osalvador@suse.de>, <steven.price@arm.com>,
        <ying.huang@intel.com>, <yang.shi@linux.alibaba.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] page-flags: Remove unused __[Set|Clear]PagePrivate
Date:   Fri, 9 Oct 2020 09:59:14 -0400
Message-ID: <20201009135914.64826-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are unused anymore.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/page-flags.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba9379112..50cbf5e931bc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -363,8 +363,7 @@ PAGEFLAG(SwapBacked, swapbacked, PF_NO_TAIL)
  * for its own purposes.
  * - PG_private and PG_private_2 cause releasepage() and co to be invoked
  */
-PAGEFLAG(Private, private, PF_ANY) __SETPAGEFLAG(Private, private, PF_ANY)
-	__CLEARPAGEFLAG(Private, private, PF_ANY)
+PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
 PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 	TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
-- 
2.19.1

