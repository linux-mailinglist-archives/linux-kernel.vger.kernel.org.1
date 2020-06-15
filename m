Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 681DD1F8CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 05:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFOD6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 23:58:02 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727971AbgFOD6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:58:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC6FE1D69C05C425FA7A;
        Mon, 15 Jun 2020 11:57:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 15 Jun 2020
 11:57:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-hardening@lists.openwall.com>
CC:     Jason Yan <yanaijie@huawei.com>, Kees Cook <keescook@chromium.org>,
        "Ming Lei" <ming.lei@redhat.com>
Subject: [PATCH] block: Eliminate usage of uninitialized_var() macro
Date:   Mon, 15 Jun 2020 11:58:43 +0800
Message-ID: <20200615035843.3334350-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an effort to eliminate the uninitialized_var() macro[1].

The use of this macro is the wrong solution because it forces off ANY
analysis by the compiler for a given variable. It even masks "unused
variable" warnings.

Quoted from Linus[2]:

"It's a horrible thing to use, in that it adds extra cruft to the
source code, and then shuts up a compiler warning (even the _reliable_
warnings from gcc)."

The gcc option "-Wmaybe-uninitialized" has been disabled and this change
will not produce any warnnings even with "make W=1".

[1] https://github.com/KSPP/linux/issues/81
[2] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Cc: Kees Cook <keescook@chromium.org>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index f0b0bae075a0..006402edef6b 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -473,7 +473,7 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
 			     struct scatterlist *sglist,
 			     struct scatterlist **sg)
 {
-	struct bio_vec uninitialized_var(bvec), bvprv = { NULL };
+	struct bio_vec bvec, bvprv = { NULL };
 	struct bvec_iter iter;
 	int nsegs = 0;
 	bool new_bio = false;
-- 
2.25.4

