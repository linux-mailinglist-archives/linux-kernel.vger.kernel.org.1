Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869AF1A1C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 09:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgDHH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 03:27:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12695 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbgDHH1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:27:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CF5A5AEDFCA8666080F;
        Wed,  8 Apr 2020 15:27:35 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Wed, 8 Apr 2020 15:27:27 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
CC:     YueHaibing <yuehaibing@huawei.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] dm integrity: remove set but not used variables
Date:   Wed, 8 Apr 2020 07:29:48 +0000
Message-ID: <20200408072948.156175-1-yuehaibing@huawei.com>
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

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/md/dm-integrity.c: In function 'integrity_metadata':
drivers/md/dm-integrity.c:1557:12: warning:
 variable 'save_metadata_offset' set but not used [-Wunused-but-set-variable]
drivers/md/dm-integrity.c:1556:12: warning:
 variable 'save_metadata_block' set but not used [-Wunused-but-set-variable]

They are never used, so remove it.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/md/dm-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b989d109d55d..94fb584854b8 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1553,8 +1553,6 @@ static void integrity_metadata(struct work_struct *w)
 		char checksums_onstack[max((size_t)HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 		sector_t sector;
 		unsigned sectors_to_process;
-		sector_t save_metadata_block;
-		unsigned save_metadata_offset;
 
 		if (unlikely(ic->mode == 'R'))
 			goto skip_io;
@@ -1605,8 +1603,6 @@ static void integrity_metadata(struct work_struct *w)
 			goto skip_io;
 		}
 
-		save_metadata_block = dio->metadata_block;
-		save_metadata_offset = dio->metadata_offset;
 		sector = dio->range.logical_sector;
 		sectors_to_process = dio->range.n_sectors;



