Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460BE240203
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 08:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgHJGfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 02:35:11 -0400
Received: from mail1.windriver.com ([147.11.146.13]:63742 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgHJGfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:35:11 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 07A6Yvip023751
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Sun, 9 Aug 2020 23:34:57 -0700 (PDT)
Received: from pek-lpggp1.wrs.com (128.224.153.74) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.487.0; Sun, 9 Aug 2020
 23:34:56 -0700
From:   <yanfei.xu@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <mhocko@suse.com>
Subject: [PATCH] mempolicy.h: fix typo
Date:   Mon, 10 Aug 2020 14:34:54 +0800
Message-ID: <20200810063454.9357-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

Change "interlave" to "interleave".

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 include/linux/mempolicy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index ea9c15b60a96..4dc41428b095 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -28,7 +28,7 @@ struct mm_struct;
  * the process policy is used. Interrupts ignore the memory policy
  * of the current process.
  *
- * Locking policy for interlave:
+ * Locking policy for interleave:
  * In process context there is no locking because only the process accesses
  * its own state. All vma manipulation is somewhat protected by a down_read on
  * mmap_lock.
-- 
2.18.2

