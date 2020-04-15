Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C95CC1A9449
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 09:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404644AbgDOHbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 03:31:13 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:34948 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408029AbgDOH2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 03:28:30 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 9A0CF261E55;
        Wed, 15 Apr 2020 15:28:21 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Wang Qing <wangqing@vivo.com>, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] Bitmap: Optimized division operation to shift operation
Date:   Wed, 15 Apr 2020 15:27:40 +0800
Message-Id: <1586935667-4792-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLTE1LS0tJSkhNSUhLTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MQw6Vgw5Azg4NAkQCCk2CAkq
        T04KCS5VSlVKTkNNQkhOTEtKQkxNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhJSkM3Bg++
X-HM-Tid: 0a717cbd216b9375kuws9a0cf261e55
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some processors, the / operate will call the compiler`s div lib,
which is low efficient. Bitmap is performance sensitive, We can
replace the / operation with shift.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 include/linux/bitmap.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99058eb..85ff982 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -337,7 +337,7 @@ static inline int bitmap_equal(const unsigned long *src1,
 		return !((*src1 ^ *src2) & BITMAP_LAST_WORD_MASK(nbits));
 	if (__builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 	    IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		return !memcmp(src1, src2, nbits / 8);
+		return !memcmp(src1, src2, nbits >> 3);
 	return __bitmap_equal(src1, src2, nbits);
 }
 
@@ -411,7 +411,7 @@ static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0xff, nbits / 8);
+		memset((char *)map + (start >> 3), 0xff, nbits >> 3);
 	else
 		__bitmap_set(map, start, nbits);
 }
@@ -425,7 +425,7 @@ static __always_inline void bitmap_clear(unsigned long *map, unsigned int start,
 		 IS_ALIGNED(start, BITMAP_MEM_ALIGNMENT) &&
 		 __builtin_constant_p(nbits & BITMAP_MEM_MASK) &&
 		 IS_ALIGNED(nbits, BITMAP_MEM_ALIGNMENT))
-		memset((char *)map + start / 8, 0, nbits / 8);
+		memset((char *)map + (start >> 3), 0, nbits >> 3);
 	else
 		__bitmap_clear(map, start, nbits);
 }
-- 
2.7.4

