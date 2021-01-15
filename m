Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 305E62F725F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbhAOFlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:41:35 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11017 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732038AbhAOFlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:41:31 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH9430s17zj7ng;
        Fri, 15 Jan 2021 13:39:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:40:40 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 1/4] initrd: Add the preprocessor guard in initrd.h
Date:   Fri, 15 Jan 2021 13:46:03 +0800
Message-ID: <20210115054606.124502-2-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the preprocessor guard in initrd.h to prevent possible
build error from the multiple inclusion of same header file
multiple time.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/initrd.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 8db6f8c8030b..fc30ac30e10e 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#ifndef __LINUX_INITRD_H
+#define __LINUX_INITRD_H
+
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 /* starting block # of image */
@@ -24,3 +27,5 @@ extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 
 void console_on_rootfs(void);
+
+#endif /* __LINUX_INITRD_H */
-- 
2.26.2

