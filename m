Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35C1D5F41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 08:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgEPGxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 02:53:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgEPGxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:53:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1361D51F117A3E29C82F;
        Sat, 16 May 2020 14:53:47 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 14:53:37 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Kostenzer Felix <fkostenzer@live.at>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] lib/sort: Remove unused pr_fmt
Date:   Sat, 16 May 2020 14:52:28 +0800
Message-ID: <1589611948-61207-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No pr_* is called in sort.c, let's remove the unused pr_fmt macro.

Cc: Kostenzer Felix <fkostenzer@live.at>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 lib/sort.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/sort.c b/lib/sort.c
index 3ad454411997..99ecab8d6f41 100644
--- a/lib/sort.c
+++ b/lib/sort.c
@@ -10,8 +10,6 @@
  * quicksort's O(n^2) worst case.
  */
 
-#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/sort.h>
-- 
2.7.4

