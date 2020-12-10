Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6CC2D5707
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388831AbgLJJYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:24:00 -0500
Received: from s2.neomailbox.net ([5.148.176.60]:20485 "EHLO s2.neomailbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731643AbgLJJXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:23:38 -0500
From:   Antonio Quartulli <a@unstable.cc>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Antonio Quartulli <a@unstable.cc>
Subject: [PATCH] dm ebs: avoid double unlikely() notation when using IS_ERR()
Date:   Thu, 10 Dec 2020 09:50:49 +0100
Message-Id: <20201210085049.14528-1-a@unstable.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of IS_ERR() already applies the unlikely() notation
when checking the error status of the passed pointer. For this
reason there is no need to have the same notation outside of
IS_ERR() itself.

Clean up code by removing redundant notation.

Signed-off-by: Antonio Quartulli <a@unstable.cc>
---
 drivers/md/dm-ebs-target.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index cb85610527c2..55bcfb74f51f 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -86,7 +86,7 @@ static int __ebs_rw_bvec(struct ebs_c *ec, int rw, struct bio_vec *bv, struct bv
 		else
 			ba = dm_bufio_new(ec->bufio, block, &b);
 
-		if (unlikely(IS_ERR(ba))) {
+		if (IS_ERR(ba)) {
 			/*
 			 * Carry on with next buffer, if any, to issue all possible
 			 * data but return error.
-- 
2.29.2

