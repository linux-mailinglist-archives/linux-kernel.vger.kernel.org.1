Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E07268CBD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgINODW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:03:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726800AbgINN7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8C47C74032D5AE028E6D;
        Mon, 14 Sep 2020 21:59:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 21:59:44 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 3/4] ubifs: Fix some kernel-doc warnings in replay.c
Date:   Mon, 14 Sep 2020 21:56:53 +0800
Message-ID: <20200914135654.55120-4-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914135654.55120-1-wanghai38@huawei.com>
References: <20200914135654.55120-1-wanghai38@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/ubifs/replay.c:942: warning: Excess function parameter 'ref_lnum' description in 'validate_ref'
fs/ubifs/replay.c:942: warning: Excess function parameter 'ref_offs' description in 'validate_ref'

They're not in use. Remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/ubifs/replay.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index b69ffac7e415..2f8d8f4f411a 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -931,8 +931,6 @@ static int add_replay_bud(struct ubifs_info *c, int lnum, int offs, int jhead,
  * validate_ref - validate a reference node.
  * @c: UBIFS file-system description object
  * @ref: the reference node to validate
- * @ref_lnum: LEB number of the reference node
- * @ref_offs: reference node offset
  *
  * This function returns %1 if a bud reference already exists for the LEB. %0 is
  * returned if the reference node is new, otherwise %-EINVAL is returned if
-- 
2.17.1

