Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4757526C63F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgIPRk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:40:59 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:62377 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbgIPRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:40:06 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 79812B021CC;
        Wed, 16 Sep 2020 21:07:57 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        harryxiyou@gmail.com, alex.shi@linux.alibaba.com,
        bailu.lin@vivo.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, wangqing@vivo.com
Subject: [PATCH v2] doc: zh_CN: index files in arm64 subdirectory
Date:   Wed, 16 Sep 2020 06:07:14 -0700
Message-Id: <20200916130714.42438-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916045720.33636-1-bailu.lin@vivo.com>
References: <20200916045720.33636-1-bailu.lin@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQkgfTh4YSU5DT00dVkpNS0tJTUpNTENLS0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MiI6LBw4Hz8uDhUUQxoCTzAq
        SThPFFFVSlVKTUtLSU1KTUxDT0pOVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSU1ZV1kIAVlBSEtOQjcG
X-HM-Tid: 0a749707634998b7kuuu79812b021cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm64 subdirectory into the table of Contents for zh_CN,
all translations residing on it would be indexed conveniently.

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
---
v2:
  -Fix patch description.
---
 Documentation/arm64/index.rst                    |  4 ++++
 Documentation/translations/zh_CN/arm64/index.rst | 16 ++++++++++++++++
 Documentation/translations/zh_CN/index.rst       |  1 +
 3 files changed, 21 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/arm64/index.rst

diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
index d9665d83c53a..907cda9c0f71 100644
--- a/Documentation/arm64/index.rst
+++ b/Documentation/arm64/index.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _arm64_index:
+
 ==================
 ARM64 Architecture
 ==================
diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rsts
index 000000000000..c236b648740d
--- /dev/null
+++ b/Documentation/translations/zh_CN/arm64/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/arm64/index.rst <arm64_index>`
+:Translator: Bailu Lin <bailu.lin@vivo.com>
+
+.. _cn_arm64_index:
+
+
+==========
+ARM64 架构
+==========
+
+.. toctree::
+    :maxdepth: 2
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 85643e46e308..be6f11176200 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -19,6 +19,7 @@
    admin-guide/index
    process/index
    filesystems/index
+   arm64/index
 
 目录和表格
 ----------
-- 
2.20.1

