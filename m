Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276B827AB78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgI1KDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:03:24 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:17757 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgI1KDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:03:23 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 303C54E2363;
        Mon, 28 Sep 2020 18:03:19 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Qing <wangqing@vivo.com>,
        Wang Wenhu <wenhu.wang@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Chucheng Luo <luochucheng@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5] doc: zh_CN: add translatation for btrfs
Date:   Mon, 28 Sep 2020 17:59:47 +0800
Message-Id: <1601287276-25406-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTB0ZHRpKSEtKSh8fVkpNS0pJQ0xIQkJOTUJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6Djo5MT8fGlYhNhwNDkIQ
        FikaFDpVSlVKTUtKSUNMT0tLS0lKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFITUpPNwY+
X-HM-Tid: 0a74d42aa8459376kuws303c54e2363
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/filesystems/btrfs.rst into Chinese.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
Changes in v5:
 - Fix ref errors in Original.
Changes in v4:
 - Add btrfs index.
Changes in v3:
 - Fix patch format issue.
---
 .../translations/zh_CN/filesystems/btrfs.rst       | 37 ++++++++++++++++++++++
 .../translations/zh_CN/filesystems/index.rst       |  1 +
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/filesystems/btrfs.rst

diff --git a/Documentation/translations/zh_CN/filesystems/btrfs.rst b/Documentation/translations/zh_CN/filesystems/btrfs.rst
new file mode 100644
index 0000000..8b8cca2
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/btrfs.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/btrfs.rst <btrfs_index>`
+
+translated by 王擎 Wang Qing<wangqing@vivo.com>
+
+=====
+BTRFS
+=====
+
+Btrfs是一个写时复制更新的文件系统，它注重容错、修复和易于管理。
+Btrfs由多家公司联合开发，并获得GPL许可，免费开放给所有人。
+
+Btrfs的主要功能包括：
+
+    *扩展大小的文件存储（文件最大支持2^64）
+    *填充方式使小文件更节省空间
+    *索引目录的方式更节省空间
+    *动态的索引节点分配方式
+    *写快照的特性
+    *支持子卷（独立的内部根文件系统）
+    *对象级别的镜像克隆
+    *基于数据和元数据的校验和（支持多种算法）
+    *支持压缩
+    *內建多种磁盘阵列算法，支持多种设备
+    *支持离线的文件系统检查
+    *高效的增量备份和文件系统镜像
+    *在线文件系统碎片整理
+
+更多有关信息，请参阅Wiki
+
+  https://btrfs.wiki.kernel.org
+
+维护信息包含管理任务、常见问题、用例、挂载选项、变更日志、
+特性、手册、源码仓、联系人等。
diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Documentation/translations/zh_CN/filesystems/index.rst
index 186501d..47e86397
--- a/Documentation/translations/zh_CN/filesystems/index.rst
+++ b/Documentation/translations/zh_CN/filesystems/index.rst
@@ -25,4 +25,5 @@ Linux Kernel中的文件系统
 
    virtiofs
    debugfs
+   btrfs
 
-- 
2.7.4

