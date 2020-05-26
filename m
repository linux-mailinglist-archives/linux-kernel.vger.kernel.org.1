Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2B11BB4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 05:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgD1Dqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 23:46:32 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbgD1Dqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:46:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3BA991195396E64954D1;
        Tue, 28 Apr 2020 11:46:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 28 Apr 2020 11:46:18 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Alexey Dobriyan" <adobriyan@gmail.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ipc: use GFP_ATOMIC under spin lock
Date:   Tue, 28 Apr 2020 03:47:36 +0000
Message-ID: <20200428034736.27850-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ipc_id_alloc() is called from ipc_addid(), in which
a spin lock is held, so we should use GFP_ATOMIC instead.

Fixes: de5738d1c364 ("ipc: convert ipcs_idr to XArray")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 ipc/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 723dc4b05208..093b31993d39 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -241,7 +241,7 @@ static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 					xas.xa_index;
 			xas_store(&xas, new);
 			xas_clear_mark(&xas, XA_FREE_MARK);
-		} while (__xas_nomem(&xas, GFP_KERNEL));
+		} while (__xas_nomem(&xas, GFP_ATOMIC));
 
 		xas_unlock(&xas);
 		err = xas_error(&xas);
@@ -250,7 +250,7 @@ static inline int ipc_id_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 		new->id = get_restore_id(ids);
 		new->seq = ipcid_to_seqx(new->id);
 		idx = ipcid_to_idx(new->id);
-		err = xa_insert(&ids->ipcs, idx, new, GFP_KERNEL);
+		err = xa_insert(&ids->ipcs, idx, new, GFP_ATOMIC);
 		if (err == -EBUSY)
 			err = -ENOSPC;
 		set_restore_id(ids, -1);



