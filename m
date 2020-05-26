Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8696C1A9633
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635854AbgDOIWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 04:22:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40588 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2635838AbgDOIWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:22:20 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E800ADEF80EC8DF914A;
        Wed, 15 Apr 2020 16:22:18 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 15 Apr 2020
 16:22:07 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <yanaijie@huawei.com>, <linux-kernel@vger.kernel.org>,
        <gustavo@embeddedor.com>, <yamada.masahiro@socionext.com>,
        <miguel.ojeda.sandonis@gmail.com>
CC:     Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] lib: zstd: remove FSE_sizeof_CTable()
Date:   Wed, 15 Apr 2020 16:48:34 +0800
Message-ID: <20200415084834.5573-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No users of FSE_sizeof_CTable() now, so remove it.
This fixes a sparse warning:

lib/zstd/fse_compress.c:477:8: warning: symbol 'FSE_sizeof_CTable' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 lib/zstd/fse_compress.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/zstd/fse_compress.c b/lib/zstd/fse_compress.c
index ef3d1741d532..0c059bef379c 100644
--- a/lib/zstd/fse_compress.c
+++ b/lib/zstd/fse_compress.c
@@ -466,20 +466,6 @@ size_t FSE_count_wksp(unsigned *count, unsigned *maxSymbolValuePtr, const void *
 /*-**************************************************************
 *  FSE Compression Code
 ****************************************************************/
-/*! FSE_sizeof_CTable() :
-	FSE_CTable is a variable size structure which contains :
-	`U16 tableLog;`
-	`U16 maxSymbolValue;`
-	`U16 nextStateNumber[1 << tableLog];`                         // This size is variable
-	`FSE_symbolCompressionTransform symbolTT[maxSymbolValue+1];`  // This size is variable
-Allocation is manual (C standard does not support variable-size structures).
-*/
-size_t FSE_sizeof_CTable(unsigned maxSymbolValue, unsigned tableLog)
-{
-	if (tableLog > FSE_MAX_TABLELOG)
-		return ERROR(tableLog_tooLarge);
-	return FSE_CTABLE_SIZE_U32(tableLog, maxSymbolValue) * sizeof(U32);
-}
 
 /* provides the minimum logSize to safely represent a distribution */
 static unsigned FSE_minTableLog(size_t srcSize, unsigned maxSymbolValue)
-- 
2.21.1

