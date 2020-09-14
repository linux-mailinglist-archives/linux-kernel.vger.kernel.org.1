Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1F268CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgINOIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:08:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726768AbgINN7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:49 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 901A18449679F6E808C5;
        Mon, 14 Sep 2020 21:59:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 14 Sep 2020
 21:59:44 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/4] ubifs: Fix some kernel-doc warnings in gc.c
Date:   Mon, 14 Sep 2020 21:56:52 +0800
Message-ID: <20200914135654.55120-3-wanghai38@huawei.com>
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

fs/ubifs/gc.c:70: warning: Excess function parameter 'buf' description in 'switch_gc_head'
fs/ubifs/gc.c:70: warning: Excess function parameter 'len' description in 'switch_gc_head'
fs/ubifs/gc.c:70: warning: Excess function parameter 'lnum' description in 'switch_gc_head'
fs/ubifs/gc.c:70: warning: Excess function parameter 'offs' description in 'switch_gc_head'

They're not in use. Remove them.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/ubifs/gc.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 62cb3db44e6e..a4aaeea63893 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -57,10 +57,6 @@
 /**
  * switch_gc_head - switch the garbage collection journal head.
  * @c: UBIFS file-system description object
- * @buf: buffer to write
- * @len: length of the buffer to write
- * @lnum: LEB number written is returned here
- * @offs: offset written is returned here
  *
  * This function switch the GC head to the next LEB which is reserved in
  * @c->gc_lnum. Returns %0 in case of success, %-EAGAIN if commit is required,
-- 
2.17.1

