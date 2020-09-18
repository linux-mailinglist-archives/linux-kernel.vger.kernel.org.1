Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B049026F800
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIRIUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 04:20:12 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:55746 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgIRIUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 04:20:11 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 04:20:02 EDT
Received: from ubuntu.localdomain (unknown [58.250.176.229])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id 897C6B0163A;
        Fri, 18 Sep 2020 16:11:35 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net,
        harryxiyou@gmail.com, alex.shi@linux.alibaba.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     bailu.lin@vivo.com, kernel@vivo.com
Subject: [PATCH v3] doc: zh_CN: index files in arm64 subdirectory
Date:   Fri, 18 Sep 2020 01:11:26 -0700
Message-Id: <20200918081126.20765-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200916130714.42438-1-bailu.lin@vivo.com>
References: <20200916130714.42438-1-bailu.lin@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTkpJGEgdGEIaSx5NVkpNS0tPSk1NQk5CQ0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nww6Mhw4PT8pHgo*ERAwHS4T
        D0IaCRNVSlVKTUtLT0pNTUJNT0hMVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQUhLQkM3Bg++
X-HM-Tid: 0a74a044c65598b7kuuu897c6b0163a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add arm64 subdirectory into the table of Contents for zh_CN,
then add other translations in arm64 conveniently.

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
---
Changes in v3:
 - Correct email encoding format.
Changes in v2:
 - Fix patch description.
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
diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
new file mode 100644
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

