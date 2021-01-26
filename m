Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7400B303ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404477AbhAZKtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:49:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:38914 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731855AbhAZCbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:31:50 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UMvlyiO_1611628265;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UMvlyiO_1611628265)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 10:31:05 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     lkp@intel.com, joseph.qi@linux.alibaba.com,
        caspar@linux.alibaba.com
Subject: [PATCH 1/2] byteorder: fix -Wsign-compare warnings
Date:   Tue, 26 Jan 2021 10:31:04 +0800
Message-Id: <20210126023105.13141-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

warning: comparison of integers of different signs: 'int' and 'size_t'
(aka 'unsigned long') [-Wsign-compare]
           for (i = 0; i < len; i++)

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/byteorder/generic.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/byteorder/generic.h b/include/linux/byteorder/generic.h
index 4b13e0a3e15b..c9a4c96c9943 100644
--- a/include/linux/byteorder/generic.h
+++ b/include/linux/byteorder/generic.h
@@ -190,7 +190,7 @@ static inline void be64_add_cpu(__be64 *var, u64 val)
 
 static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = cpu_to_be32(src[i]);
@@ -198,7 +198,7 @@ static inline void cpu_to_be32_array(__be32 *dst, const u32 *src, size_t len)
 
 static inline void be32_to_cpu_array(u32 *dst, const __be32 *src, size_t len)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < len; i++)
 		dst[i] = be32_to_cpu(src[i]);
-- 
2.27.0

