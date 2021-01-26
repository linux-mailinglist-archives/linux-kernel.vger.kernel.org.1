Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5AC7303ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404494AbhAZKtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:21 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40416 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731879AbhAZCbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:31:51 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UMw3dyi_1611628266;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UMw3dyi_1611628266)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 10:31:06 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, joseph.qi@linux.alibaba.com,
        caspar@linux.alibaba.com
Subject: [PATCH 2/2] thread_info: fix -Wsign-compare warnings
Date:   Tue, 26 Jan 2021 10:31:05 +0800
Message-Id: <20210126023105.13141-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210126023105.13141-1-jefflexu@linux.alibaba.com>
References: <20210126023105.13141-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning: comparison of integers of different signs: 'int' and 'size_t'
(aka 'unsigned long') [-Wsign-compare]
           if (unlikely(sz >= 0 && sz < bytes)) {

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/thread_info.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c8a974cead73..11b4b36116fa 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -179,15 +179,15 @@ __bad_copy_from(void);
 extern void __compiletime_error("copy destination size is too small")
 __bad_copy_to(void);
 
-static inline void copy_overflow(int size, unsigned long count)
+static inline void copy_overflow(unsigned long size, unsigned long count)
 {
-	WARN(1, "Buffer overflow detected (%d < %lu)!\n", size, count);
+	WARN(1, "Buffer overflow detected (%lu < %lu)!\n", size, count);
 }
 
 static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
-	int sz = __compiletime_object_size(addr);
+	size_t sz = __compiletime_object_size(addr);
 	if (unlikely(sz >= 0 && sz < bytes)) {
 		if (!__builtin_constant_p(bytes))
 			copy_overflow(sz, bytes);
-- 
2.27.0

