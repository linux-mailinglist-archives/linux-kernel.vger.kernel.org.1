Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E2E2004C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 11:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgFSJOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 05:14:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725290AbgFSJOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:14:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 706DC7A08262838512E1;
        Fri, 19 Jun 2020 17:14:38 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 19 Jun 2020 17:14:27 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to check page dirty status before writeback
Date:   Fri, 19 Jun 2020 17:14:19 +0800
Message-ID: <20200619091419.47374-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f2fs_write_raw_pages(), we need to check page dirty status before
writeback, because there could be a racer (e.g. reclaimer) helps
writebacking the dirty page.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/compress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 5643aa2b8377..ce5645b5c833 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1322,6 +1322,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				congestion_wait(BLK_RW_ASYNC,
 						DEFAULT_IO_TIMEOUT);
 				lock_page(cc->rpages[i]);
+
+				if (!PageDirty(cc->rpages[i])) {
+					unlock_page(cc->rpages[i]);
+					continue;
+				}
+
 				clear_page_dirty_for_io(cc->rpages[i]);
 				goto retry_write;
 			}
-- 
2.26.2

