Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA0026BBAE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgIPE5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:57:55 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:35380 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPE5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:57:52 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.226])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 68BA1B0217A;
        Wed, 16 Sep 2020 12:57:35 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bailu Lin <bailu.lin@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wangqing@vivo.com
Subject: [PATCH] doc: zh_CN: index files in arm64 subdirectory
Date:   Tue, 15 Sep 2020 21:57:01 -0700
Message-Id: <20200916045720.33636-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSR4fGk9PGU1KQx9DVkpNS0tJSElJTk5CSElVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KyI6Lhw6UT8iKBURUTcUFkIi
        Fk4aCgpVSlVKTUtLSUhJSU5NSEtPVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSU1ZV1kIAVlBSUJOTjcG
X-HM-Tid: 0a749546713598b7kuuu68ba1b0217a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add filesystems subdirectory into the table of Contents for zh_CN,
all translations residing on it would be indexed conveniently.

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
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

