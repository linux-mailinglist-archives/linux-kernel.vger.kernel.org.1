Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C552768E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgIXG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:29:10 -0400
Received: from m17618.mail.qiye.163.com ([59.111.176.18]:46869 "EHLO
        m17618.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIXG3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:29:09 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m17618.mail.qiye.163.com (Hmail) with ESMTPA id 91C574E180D;
        Thu, 24 Sep 2020 14:29:06 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Qing <wangqing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2] doc: zh_CN: add translatation for btrfs
Date:   Thu, 24 Sep 2020 14:28:06 +0800
Message-Id: <1600928938-22829-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0ofT0oYGEgdTRlPVkpNS0tCSUNCT01DTkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PDI6Qgw5TT8aFgMxKjwTNTw6
        KEwKFA5VSlVKTUtLQklDQk9MSExKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJTEtINwY+
X-HM-Tid: 0a74becd1a629376kuws91c574e180d
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

