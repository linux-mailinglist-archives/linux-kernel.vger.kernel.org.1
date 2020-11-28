Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA52C713C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbgK1VzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:55:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8163 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgK1T4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:56:33 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ck2KT6fHzz15JqJ;
        Sun, 29 Nov 2020 03:55:25 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Sun, 29 Nov 2020 03:55:39 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v2] Documentation/admin-guide: mark memmap parameter is supported by a few architectures
Date:   Sun, 29 Nov 2020 08:51:21 +1300
Message-ID: <20201128195121.2556-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.202.220]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

early_param memmap is only implemented on X86, MIPS and XTENSA. To avoid
wasting users’ time on trying this on platform like ARM, mark it clearly.

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 -v2:
 * add reviewed-by of Mike, thanks!

 Documentation/admin-guide/kernel-parameters.rst | 1 +
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 6d421694d98e..06fb1b4aa849 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -172,6 +172,7 @@ parameter is applicable::
 	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
 	X86_UV	SGI UV support is enabled.
 	XEN	Xen support is enabled
+	XTENSA	xtensa architecture is enabled.
 
 In addition, the following text indicates that the option::
 
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 526d65d8573a..8bdbc555f221 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2709,7 +2709,7 @@
 			option description.
 
 	memmap=nn[KMG]@ss[KMG]
-			[KNL] Force usage of a specific region of memory.
+			[KNL, X86, MIPS, XTENSA] Force usage of a specific region of memory.
 			Region of memory to be used is from ss to ss+nn.
 			If @ss[KMG] is omitted, it is equivalent to mem=nn[KMG],
 			which limits max address to nn[KMG].
-- 
2.25.1

