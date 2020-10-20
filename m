Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB52293375
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbgJTDKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:10:21 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52522 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390963AbgJTDKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:10:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 02930A3FA46EE92B8C80;
        Tue, 20 Oct 2020 11:10:19 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 11:10:09 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <dave.rodgman@arm.com>, <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] lib/lzo: make lzogeneric1x_1_compress() static
Date:   Tue, 20 Oct 2020 11:14:15 +0800
Message-ID: <20201020031415.136874-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warning:

lib/lzo/lzo1x_compress.c:304:5: warning: symbol
'lzogeneric1x_1_compress' was not declared. Should it be static?

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 lib/lzo/lzo1x_compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lzo/lzo1x_compress.c b/lib/lzo/lzo1x_compress.c
index 8ad5ba2b86e2..76758e9296ba 100644
--- a/lib/lzo/lzo1x_compress.c
+++ b/lib/lzo/lzo1x_compress.c
@@ -301,7 +301,7 @@ lzo1x_1_do_compress(const unsigned char *in, size_t in_len,
 	return in_end - (ii - ti);
 }
 
-int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
+static int lzogeneric1x_1_compress(const unsigned char *in, size_t in_len,
 		     unsigned char *out, size_t *out_len,
 		     void *wrkmem, const unsigned char bitstream_version)
 {
-- 
2.25.4

