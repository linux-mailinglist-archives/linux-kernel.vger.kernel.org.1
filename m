Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89E2273BBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729867AbgIVHZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:25:01 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:18751 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729748AbgIVHZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:25:00 -0400
X-Greylist: delayed 610 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 03:24:57 EDT
X-IronPort-AV: E=Sophos;i="5.77,289,1596470400"; 
   d="scan'208";a="99496002"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 22 Sep 2020 15:14:46 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9FBBC48990EC;
        Tue, 22 Sep 2020 15:14:44 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 22 Sep 2020 15:14:43 +0800
Received: from TSO.g08.fujitsu.local (10.167.226.60) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 22 Sep 2020 15:14:42 +0800
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <corbet@lwn.net>
Subject: [RFC PATCH] Documentation/x86/boot.rst: minor languge improvement
Date:   Tue, 22 Sep 2020 15:14:54 +0800
Message-ID: <20200922071454.21726-1-caoj.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9FBBC48990EC.AC552
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
for 64-bit protocol, setup data still needs to be mapped, as there is
operation on it in extract_kernel(), like:

        sanitize_boot_params(boot_params);

initrd doesn't need to be mapped, which is also what KASLR does in its
mem_avoid_init().

 Documentation/x86/boot.rst | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/Documentation/x86/boot.rst b/Documentation/x86/boot.rst
index 7fafc7ac00d7..392c6e147e70 100644
--- a/Documentation/x86/boot.rst
+++ b/Documentation/x86/boot.rst
@@ -1353,12 +1353,12 @@ In 32-bit boot protocol, the kernel is started by jumping to the
 32/64-bit kernel.
 
 At entry, the CPU must be in 32-bit protected mode with paging
-disabled; a GDT must be loaded with the descriptors for selectors
-__BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
-segment; __BOOT_CS must have execute/read permission, and __BOOT_DS
-must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
-must be __BOOT_DS; interrupt must be disabled; %esi must hold the base
-address of the struct boot_params; %ebp, %edi and %ebx must be zero.
+disabled and a GDT must be loaded with the descriptors for selectors
+__BOOT_CS(0x10) and __BOOT_DS(0x18): both descriptors must be 4G flat
+segment with __BOOT_CS having execute/read permission and __BOOT_DS
+having read/write permission. CS must be __BOOT_CS and DS, ES, SS
+must be __BOOT_DS. Interrupt must be disabled and %esi must hold the
+base address of the struct boot_params. %ebp, %edi and %ebx must be zero.
 
 64-bit Boot Protocol
 ====================
@@ -1379,7 +1379,7 @@ can be calculated as follows::
 In addition to read/modify/write the setup header of the struct
 boot_params as that of 16-bit boot protocol, the boot loader should
 also fill the additional fields of the struct boot_params as described
-in zero-page.txt.
+in zero-page.rst.
 
 After setting up the struct boot_params, the boot loader can load
 64-bit kernel in the same way as that of 16-bit boot protocol, but
@@ -1389,15 +1389,14 @@ In 64-bit boot protocol, the kernel is started by jumping to the
 64-bit kernel entry point, which is the start address of loaded
 64-bit kernel plus 0x200.
 
-At entry, the CPU must be in 64-bit mode with paging enabled.
-The range with setup_header.init_size from start address of loaded
-kernel and zero page and command line buffer get ident mapping;
-a GDT must be loaded with the descriptors for selectors
-__BOOT_CS(0x10) and __BOOT_DS(0x18); both descriptors must be 4G flat
-segment; __BOOT_CS must have execute/read permission, and __BOOT_DS
-must have read/write permission; CS must be __BOOT_CS and DS, ES, SS
-must be __BOOT_DS; interrupt must be disabled; %rsi must hold the base
-address of the struct boot_params.
+At entry, the CPU must be in 64-bit mode. The range with
+setup_header.init_size from start address of loaded kernel, the zero page,
+and the command line buffer get identity-mapped, and a GDT must be loaded
+with the descriptors for selectors __BOOT_CS(0x10) and __BOOT_DS(0x18):
+both descriptors must be 4G flat segment with __BOOT_CS having execute/read
+permission and __BOOT_DS having read/write permission. CS must be __BOOT_CS
+and DS, ES, SS must be __BOOT_DS. Interrupt must be disabled and %rsi must
+hold the base address of the struct boot_params.
 
 EFI Handover Protocol (deprecated)
 ==================================
-- 
2.21.0



