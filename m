Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B38A20029B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 09:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbgFSHTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 03:19:00 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6289 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729080AbgFSHS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:18:59 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 264ADA909F44418C47F9;
        Fri, 19 Jun 2020 15:18:56 +0800 (CST)
Received: from localhost (10.175.101.6) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 19 Jun 2020
 15:18:47 +0800
From:   Weilong Chen <chenweilong@huawei.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>,
        <virtualization@lists.linux-foundation.org>, <lizefan@huawei.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] virtio-mem: Fix build error due to improper use 'select'
Date:   Fri, 19 Jun 2020 16:03:33 +0800
Message-ID: <20200619080333.194753-1-chenweilong@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As noted in:
https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
"select should be used with care. select will force a symbol to a
value without visiting the dependencies."
Config VIRTIO_MEM should not select CONTIG_ALLOC directly.
Otherwise it will cause an error:
https://bugzilla.kernel.org/show_bug.cgi?id=208245

Signed-off-by: Weilong Chen <chenweilong@huawei.com>
---
 drivers/virtio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 5809e5f5b157..5c92e4a50882 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -85,7 +85,7 @@ config VIRTIO_MEM
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG_SPARSE
 	depends on MEMORY_HOTREMOVE
-	select CONTIG_ALLOC
+	depends on CONTIG_ALLOC
 	help
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
-- 
2.17.1

