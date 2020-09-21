Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AD9271919
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIUCC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:02:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgIUCC5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:02:57 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A042E89730D559E4C866;
        Mon, 21 Sep 2020 10:02:55 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:02:47 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <catalin.marinas@arm.com>, <akpm@linux-foundation.org>,
        <rui.xiang@huawei.com>, <weiyongjun1@huawei.com>
Subject: [PATCH -next 2/5] mm/kmemleak: skip update_checksum for OBJECT_NO_SCAN objects
Date:   Mon, 21 Sep 2020 02:00:04 +0000
Message-ID: <20200921020007.35803-3-chenjun102@huawei.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200921020007.35803-1-chenjun102@huawei.com>
References: <20200921020007.35803-1-chenjun102@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.208]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Objects marked with OBJECT_NO_SCAN are never scanned.
So there is no need to update checksum for them.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/kmemleak.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index b3f603fd9fc3..c09c6b59eda6 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1166,6 +1166,10 @@ static bool update_checksum(struct kmemleak_object *object)
 {
 	u32 old_csum = object->checksum;
 
+	/* always return false for not scan object */
+	if (object->flags & OBJECT_NO_SCAN)
+		return false;
+
 	kasan_disable_current();
 	kcsan_disable_current();
 	object->checksum = crc32(0, (void *)object->pointer, object->size);
-- 
2.25.0

