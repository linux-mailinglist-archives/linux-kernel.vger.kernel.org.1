Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BC92309B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 14:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgG1MNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 08:13:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728896AbgG1MNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:13:41 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5009447AC61F34E300ED;
        Tue, 28 Jul 2020 20:13:40 +0800 (CST)
Received: from huawei.com (10.175.104.82) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 20:13:34 +0800
From:   Huang Guobin <huangguobin4@huawei.com>
To:     <haren@us.ibm.com>, <herbert@gondor.apana.org.au>,
        <ddstreet@ieee.org>, <linux-crypto@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] lib: Verify array index is correct before using it
Date:   Tue, 28 Jul 2020 08:21:57 -0400
Message-ID: <20200728122157.23120-1-huangguobin4@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.82]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code reads from the array before verifying that "c" is a valid
index. Move test array offset code before use to fix it.

Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")
Signed-off-by: Huang Guobin <huangguobin4@huawei.com>
---
 lib/842/842_compress.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
index c02baa4168e1..c37bfe0b9346 100644
--- a/lib/842/842_compress.c
+++ b/lib/842/842_compress.c
@@ -11,6 +11,7 @@
 #define MODULE_NAME "842_compress"
 
 #include <linux/hashtable.h>
+#include <linux/nospec.h>
 
 #include "842.h"
 #include "842_debugfs.h"
@@ -222,12 +223,14 @@ static int add_bits(struct sw842_param *p, u64 d, u8 n)
 static int add_template(struct sw842_param *p, u8 c)
 {
 	int ret, i, b = 0;
-	u8 *t = comp_ops[c];
+	u8 *t = NULL;
 	bool inv = false;
 
 	if (c >= OPS_MAX)
 		return -EINVAL;
+	c = array_index_nospec(c, OPS_MAX);
 
+	t = comp_ops[c];
 	pr_debug("template %x\n", t[4]);
 
 	ret = add_bits(p, t[4], OP_BITS);
@@ -379,12 +382,14 @@ static int add_end_template(struct sw842_param *p)
 
 static bool check_template(struct sw842_param *p, u8 c)
 {
-	u8 *t = comp_ops[c];
+	u8 *t = NULL;
 	int i, match, b = 0;
 
 	if (c >= OPS_MAX)
 		return false;
+	c = array_index_nospec(c, OPS_MAX);
 
+	t = comp_ops[c];
 	for (i = 0; i < 4; i++) {
 		if (t[i] & OP_ACTION_INDEX) {
 			if (t[i] & OP_AMOUNT_2)
-- 
2.17.1

