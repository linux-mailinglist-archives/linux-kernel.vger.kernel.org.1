Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFDC28D868
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 04:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgJNCUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 22:20:14 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:50288 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJNCUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 22:20:14 -0400
Received: from ubuntu.localdomain (unknown [58.250.176.229])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 6AE8DB02537;
        Wed, 14 Oct 2020 10:20:10 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     alex.shi@linux.alibaba.com
Cc:     bailu.lin@vivo.com, catalin.marinas@arm.com, corbet@lwn.net,
        harryxiyou@gmail.com, kernel@vivo.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org
Subject: [PATCH v3] Documentation: Chinese translation of  Documentation/arm64/hugetlbpage.rst
Date:   Tue, 13 Oct 2020 19:20:03 -0700
Message-Id: <20201014022003.43862-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <ab3df28a-cde4-67d1-d0a3-abaa5ada58a1@linux.alibaba.com>
References: <ab3df28a-cde4-67d1-d0a3-abaa5ada58a1@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUpCSUlLHhofTEpJVkpNS0lNT0lLSktCSUlVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PTY6Ejo6CD8uFT8iFjwePzcJ
        KxIKFB1VSlVKTUtJTU9JS0pKT0hKVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQU9ITkw3Bg++
X-HM-Tid: 0a7524e8629298b7kuuu6ae8db02537
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Chinese translated version of
 Documentation/arm64/hugetlbpage.rst

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
---
Changes in v3:
 - Modify a translation as Alex sugguested.
Changes in v2:
 - Fix Sphinx 2.4.4's waring by increasing underline' size.
---
 Documentation/arm64/hugetlbpage.rst           |  2 +
 .../translations/zh_CN/arm64/hugetlbpage.rst  | 45 +++++++++++++++++++
 .../translations/zh_CN/arm64/index.rst        |  1 +
 3 files changed, 48 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/arm64/hugetlbpage.rst

diff --git a/Documentation/arm64/hugetlbpage.rst b/Documentation/arm64/hugetlbpage.rst
index b44f939e5210..a110124c11e3 100644
--- a/Documentation/arm64/hugetlbpage.rst
+++ b/Documentation/arm64/hugetlbpage.rst
@@ -1,3 +1,5 @@
+.. _hugetlbpage_index:
+
 ====================
 HugeTLBpage on ARM64
 ====================
diff --git a/Documentation/translations/zh_CN/arm64/hugetlbpage.rst b/Documentation/translations/zh_CN/arm64/hugetlbpage.rst
new file mode 100644
index 000000000000..13304d269d0b
--- /dev/null
+++ b/Documentation/translations/zh_CN/arm64/hugetlbpage.rst
@@ -0,0 +1,45 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/arm64/hugetlbpage.rst <hugetlbpage_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+
+=====================
+ARM64中的 HugeTLBpage
+=====================
+
+大页依靠有效利用 TLBs 来提高地址翻译的性能。这取决于以下
+两点 -
+
+  - 大页的大小
+  - TLBs 支持的条目大小
+
+ARM64 接口支持2种大页方式。
+
+1) pud/pmd 级别的块映射
+-----------------------
+
+这是常规大页，他们的 pmd 或 pud 页面表条目指向一个内存块。
+不管 TLB 中支持的条目大小如何，块映射可以减少翻译大页地址
+所需遍历的页表深度。
+
+2) 使用连续位
+-------------
+
+架构中转换页表条目(D4.5.3, ARM DDI 0487C.a)中提供一个连续
+位告诉 MMU 这个条目是一个连续条目集的一员，它可以被缓存在单
+个 TLB 条目中。
+
+在 Linux 中连续位用来增加 pmd 和 pte(最后一级)级别映射的大
+小。受支持的连续页表条目数量因页面大小和页表级别而异。
+
+
+支持以下大页尺寸配置 -
+
+  ====== ========   ====    ========    ===
+  -      CONT PTE    PMD    CONT PMD    PUD
+  ====== ========   ====    ========    ===
+  4K:         64K     2M         32M     1G
+  16K:         2M    32M          1G
+  64K:         2M   512M         16G
+  ====== ========   ====    ========    ===
diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
index 646ed1f7aea3..e31a6090384d 100644
--- a/Documentation/translations/zh_CN/arm64/index.rst
+++ b/Documentation/translations/zh_CN/arm64/index.rst
@@ -14,3 +14,4 @@ ARM64 架构
     :maxdepth: 2
 
     amu
+    hugetlbpage
-- 
2.20.1

