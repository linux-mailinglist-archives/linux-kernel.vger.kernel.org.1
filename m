Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB7329D2B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgJ1VeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:34:11 -0400
Received: from mail-m1272.qiye.163.com ([115.236.127.2]:7159 "EHLO
        mail-m1272.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJ1VeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:34:07 -0400
Received: from ubuntu.localdomain (unknown [58.250.176.229])
        by mail-m1272.qiye.163.com (Hmail) with ESMTPA id EB3D0B02446;
        Wed, 28 Oct 2020 21:48:49 +0800 (CST)
From:   Bailu Lin <bailu.lin@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Bailu Lin <bailu.lin@vivo.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] Documentation: Chinese translation of  Documentation/arm64/perf.rst
Date:   Wed, 28 Oct 2020 06:48:24 -0700
Message-Id: <20201028134831.79592-1-bailu.lin@vivo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHh9PSx9MH0oaTU8fVkpNS0hDQklCSEtPTkJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6Dyo6ET8eDS4CGE1RTzQW
        GkhPCjlVSlVKTUtIQ0JJQkhLQ0JLVTMWGhIXVRkaEhcOVRcSFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOS1VKTE1VSUlCWVdZCAFZQU5OTkI3Bg++
X-HM-Tid: 0a756f77e6ed98b7kuuueb3d0b02446
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a Chinese translated version of
 Documentation/arm64/perf.rst

Signed-off-by: Bailu Lin <bailu.lin@vivo.com>
---
 Documentation/arm64/perf.rst                  |  2 +
 .../translations/zh_CN/arm64/index.rst        |  1 +
 .../translations/zh_CN/arm64/perf.rst         | 85 +++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/arm64/perf.rst

diff --git a/Documentation/arm64/perf.rst b/Documentation/arm64/perf.rst
index 9c76a97baf28..b567f177d385 100644
--- a/Documentation/arm64/perf.rst
+++ b/Documentation/arm64/perf.rst
@@ -1,5 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+.. _perf_index:
+
 =====================
 Perf Event Attributes
 =====================
diff --git a/Documentation/translations/zh_CN/arm64/index.rst b/Documentation/translations/zh_CN/arm64/index.rst
index e31a6090384d..f51fed166326 100644
--- a/Documentation/translations/zh_CN/arm64/index.rst
+++ b/Documentation/translations/zh_CN/arm64/index.rst
@@ -15,3 +15,4 @@ ARM64 架构
 
     amu
     hugetlbpage
+    perf
diff --git a/Documentation/translations/zh_CN/arm64/perf.rst b/Documentation/translations/zh_CN/arm64/perf.rst
new file mode 100644
index 000000000000..be8269dd5d9a
--- /dev/null
+++ b/Documentation/translations/zh_CN/arm64/perf.rst
@@ -0,0 +1,85 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/arm64/perf.rst <perf_index>`
+
+Translator: Bailu Lin <bailu.lin@vivo.com>
+
+=============
+Perf 事件属性
+=============
+
+:作者: Andrew Murray <andrew.murray@arm.com>
+:日期: 2019-03-06
+
+exclude_user
+------------
+
+该属性排除用户空间。
+
+用户空间始终运行在 EL0，因此该属性将排除 EL0。
+
+
+exclude_kernel
+--------------
+
+该属性排除内核空间。
+
+打开 VHE 时内核运行在 EL2，不打开 VHE 时内核运行在 EL1。客户端
+内核总是运行在 EL1。
+
+对于主机端，该属性排除 EL1 和 VHE 上的 EL2。
+
+对于客户端，该属性排除 EL1。请注意客户端从来不会运行在 EL2。
+
+
+exclude_hv
+----------
+
+该属性排除虚拟机监控器。
+
+对于 VHE 主机端该属性将被忽略，因为此时主机端内核是虚拟机监控器。
+
+对于 non-VHE 主机端该属性将排除 EL2，因为虚拟机监控器运行在 EL2
+的任何代码主要用于客户端和主机端的切换。
+
+对于客户端该属性无效。请注意客户端从来不会运行在 EL2。
+
+
+exclude_host / exclude_guest
+----------------------------
+
+这些属性分别排除了 KVM 主机端和客户端。
+
+KVM 主机端可能运行在 EL0（用户空间），EL1（non-VHE 内核）和
+EL2（VHE 内核 或 non-VHE 虚拟机监控器）。
+
+KVM 客户端可能运行在 EL0（用户空间）和 EL1（内核）。
+
+由于主机端和客户端之间重叠的异常级别，我们不能仅仅依靠 PMU 的硬件异
+常过滤机制-因此我们必须启用/禁用对于客户端进入和退出的计数。而这在
+VHE 和 non-VHE 系统上表现不同。
+
+对于 non-VHE 系统的 exclude_host 属性排除 EL2 -  在进入和退出客户
+端时，我们会根据 exclude_host 和 exclude_guest 属性在适当的情况下
+禁用/启用该事件。
+
+对于 VHE 系统的 exclude_guest 属性排除 EL1，而对其中的 exclude_host
+属性同时排除 EL0，EL2。在进入和退出客户端时，我们会适当地根据
+exclude_host 和 exclude_guest 属性包括/排除 EL0。
+
+以上声明也适用于在 not-VHE 客户端使用这些属性时，但是请注意客户端从
+来不会运行在 EL2。
+
+
+准确性
+------
+
+在 non-VHE 主机端上，我们在 EL2 进入/退出主机端/客户端的切换时启用/
+关闭计数器 -但是在启用/禁用计数器和进入/退出客户端之间存在一段延时。
+对于 exclude_host， 我们可以通过过滤 EL2 消除在客户端进入/退出边界
+上用于计数客户端事件的主机端事件计数器。但是当使用 !exclude_hv 时，
+在客户端进入/退出有一个小的暗窗口无法捕获到主机端的事件。
+
+在VHE系统尚没有暗窗口。
-- 
2.20.1

