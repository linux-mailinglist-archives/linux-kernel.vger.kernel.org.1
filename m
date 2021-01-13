Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD0C2F4714
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbhAMJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:04:34 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:32965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727324AbhAMJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:04:33 -0500
X-UUID: ab70a5be833e41edb6ddeadd820fe4b1-20210113
X-UUID: ab70a5be833e41edb6ddeadd820fe4b1-20210113
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91106704; Wed, 13 Jan 2021 17:03:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 17:03:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 17:03:47 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kasan-dev@googlegroups.com>
CC:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        <dan.j.williams@intel.com>, <aryabinin@virtuozzo.com>,
        <glider@google.com>, <dvyukov@google.com>,
        <akpm@linux-foundation.org>, <linux-mediatek@lists.infradead.org>,
        <yj.chiang@mediatek.com>, Lecopzer Chen <lecopzer@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [RESEND PATCH] kasan: fix incorrect arguments passing in kasan_add_zero_shadow
Date:   Wed, 13 Jan 2021 17:03:40 +0800
Message-ID: <20210113090340.23129-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan_remove_zero_shadow() shall use original virtual address, start
and size, instead of shadow address.

Fixes: 0207df4fa1a86 ("kernel/memremap, kasan: make ZONE_DEVICE with work with KASAN")
Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/kasan/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index bc0ad208b3a7..67051cfae41c 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -481,7 +481,6 @@ int kasan_add_zero_shadow(void *start, unsigned long size)
 
 	ret = kasan_populate_early_shadow(shadow_start, shadow_end);
 	if (ret)
-		kasan_remove_zero_shadow(shadow_start,
-					size >> KASAN_SHADOW_SCALE_SHIFT);
+		kasan_remove_zero_shadow(start, size);
 	return ret;
 }
-- 
2.25.1
