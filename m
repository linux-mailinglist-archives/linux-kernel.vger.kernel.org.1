Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D011CBCA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 04:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgEIC6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 22:58:48 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728353AbgEIC6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:58:48 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 680B9EEC3F1AFCA75810;
        Sat,  9 May 2020 10:58:46 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 10:58:37 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] mm/hmm/test: fix error return code in hmm_dmirror_init()
Date:   Sat, 9 May 2020 03:02:34 +0000
Message-ID: <20200509030234.14747-1-weiyongjun1@huawei.com>
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

Fix to return negative error code -ENOMEM from the alloc_page() error
handling case instead of 0, as done elsewhere in this function.

Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 lib/test_hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/test_hmm.c b/lib/test_hmm.c
index 00bca6116f93..b4d9434e49e7 100644
--- a/lib/test_hmm.c
+++ b/lib/test_hmm.c
@@ -1119,8 +1119,10 @@ static int __init hmm_dmirror_init(void)
 	 * make the code here simpler (i.e., we need a struct page for it).
 	 */
 	dmirror_zero_page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
-	if (!dmirror_zero_page)
+	if (!dmirror_zero_page) {
+		ret = -ENOMEM;
 		goto err_chrdev;
+	}
 
 	pr_info("HMM test module loaded. This is only for testing HMM.\n");
 	return 0;



