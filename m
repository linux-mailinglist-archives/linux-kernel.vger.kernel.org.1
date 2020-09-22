Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722B12741C3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVMGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:06:44 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:19121 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgIVMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:06:44 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 8790C4E163F;
        Tue, 22 Sep 2020 20:06:40 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Qing <wangqing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] doc: zh_CN: add translatation for btrfs
Date:   Tue, 22 Sep 2020 20:03:34 +0800
Message-Id: <1600776267-20146-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkkfTxpKTUJJHU8ZVkpNS0tMTE1PS0tDSE9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Qxw*TD8sCg4yGhouGi4T
        GSsaCzJVSlVKTUtLTExNT0tKSUhOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJTUNCNwY+
X-HM-Tid: 0a74b5b56f6a9376kuws8790c4e163f
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate Documentation/filesystems/btrfs.rst into Chinese.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 .../translations/zh_CN/filesystems/btrfs.rst       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/translations/zh_CN/filesystems/btrfs.rst b/Documentation/translations/zh_CN/filesystems/btrfs.rst
index 0000000..8b8cca2
--- /dev/null
+++ b/Documentation/translations/zh_CN/filesystems/btrfs.rst
@@ -0,0 +1,37 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/filesystems/ext3.rst <ext3_index>`
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
+    *可写快照的特性
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
-- 
2.7.4

