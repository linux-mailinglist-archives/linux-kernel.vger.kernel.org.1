Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF6F2AAA1C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 09:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgKHIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 03:41:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7155 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHIlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 03:41:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CTSK65FCqz15QkT;
        Sun,  8 Nov 2020 16:41:30 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.211) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sun, 8 Nov 2020 16:41:28 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "John Hubbard" <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] mm/gup_test: GUP_TEST depends on DEBUG_FS
Date:   Sun, 8 Nov 2020 21:37:32 +1300
Message-ID: <20201108083732.15336-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.211]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without DEBUG_FS, all the code in gup_test becomes meaningless. For sure
kernel provides debugfs stub while DEBUG_FS is disabled, but the point
here is that GUP_TEST can do nothing without DEBUG_FS.

Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: John Garry <john.garry@huawei.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2:
 add comment as a prompt to users as commented by John and Randy, thanks!

 mm/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 01b0ae0cd9d3..a7ff0d31afd5 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -836,6 +836,7 @@ config PERCPU_STATS
 
 config GUP_TEST
 	bool "Enable infrastructure for get_user_pages()-related unit tests"
+	depends on DEBUG_FS
 	help
 	  Provides /sys/kernel/debug/gup_test, which in turn provides a way
 	  to make ioctl calls that can launch kernel-based unit tests for
@@ -853,6 +854,9 @@ config GUP_TEST
 
 	  See tools/testing/selftests/vm/gup_test.c
 
+comment "GUP_TEST needs to have DEBUG_FS enabled"
+	depends on !GUP_TEST && !DEBUG_FS
+
 config GUP_GET_PTE_LOW_HIGH
 	bool
 
-- 
2.25.1

