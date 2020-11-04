Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2BD2A6137
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgKDKJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:09:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7048 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728522AbgKDKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:09:55 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CR2St5X04zhgfH;
        Wed,  4 Nov 2020 18:09:50 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.215) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 18:09:43 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
Date:   Wed, 4 Nov 2020 23:05:52 +1300
Message-ID: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without DEBUG_FS, all the code in gup_benchmark becomes meaningless.
For sure kernel provides debugfs stub while DEBUG_FS is disabled, but
the point here is that GUP_BENCHMARK can do nothing without DEBUG_FS.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Inspired-by: John Garry <john.garry@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 * inspired by John's comment in this patch:
 https://lore.kernel.org/linux-iommu/184797b8-512e-e3da-fae7-25c7d662648b@huawei.com/

 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index d42423f..91fa923 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -836,6 +836,7 @@ config PERCPU_STATS
 
 config GUP_BENCHMARK
 	bool "Enable infrastructure for get_user_pages() and related calls benchmarking"
+	depends on DEBUG_FS
 	help
 	  Provides /sys/kernel/debug/gup_benchmark that helps with testing
 	  performance of get_user_pages() and related calls.
-- 
2.7.4

