Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DB1AD73F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 09:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729012AbgDQHRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 03:17:50 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:38929 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728808AbgDQHRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:17:49 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2020 03:17:48 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 37C2C665296;
        Fri, 17 Apr 2020 15:10:06 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] kmalloc_index optimization(add kmalloc max size check)
Date:   Fri, 17 Apr 2020 00:09:35 -0700
Message-Id: <1587107376-111722-1-git-send-email-bernard@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJS09CQkJCSUhMS01LTllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Myo6EQw6ATg4LA4jAxg#CQJD
        LTcKCz5VSlVKTkNMSktMT0tNT09CVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUtOQzcG
X-HM-Tid: 0a7186f922229373kuws37c2c665296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmalloc size should never exceed KMALLOC_MAX_SIZE.
kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
kmalloc_index just return index 26, but never check with OS`s max
kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
not create in function create_kmalloc_caches.
We can throw an warninginfo in kmalloc at the beginning, instead of
being guaranteed by the buddy alloc behind.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 include/linux/slab.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 6d45488..59b60d2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -351,6 +351,10 @@ static __always_inline unsigned int kmalloc_index(size_t size)
 	if (!size)
 		return 0;
 
+	/* size should never exceed KMALLOC_MAX_SIZE. */
+	if (size > KMALLOC_MAX_SIZE)
+		WARN(1, "size exceed max kmalloc size!\n");
+
 	if (size <= KMALLOC_MIN_SIZE)
 		return KMALLOC_SHIFT_LOW;
 
-- 
2.7.4

