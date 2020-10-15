Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC628FB49
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 00:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732245AbgJOWqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 18:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731887AbgJOWqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 18:46:03 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A51C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:46:03 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so177968plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 15:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ko2kzVze2iskg0Vcc5M0juxxnsEhQoWtuPeFx/BNZ2Q=;
        b=gOpHuZi8RfT+aLDEXzp2x7i3U+7gSJw6r9d8T1JUP0/2G1E/eEb2kCUCqKX/1eSzcL
         Ev4Ml9eLkVf6J+ZveNKx62cOM0rIOKBu5nYd0KqMEb5uz8hzakc1psqUAJieIO+L75eR
         1H1b0IwTOxCVlhDYEtl96DWskGwb3lL/Qa7Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ko2kzVze2iskg0Vcc5M0juxxnsEhQoWtuPeFx/BNZ2Q=;
        b=H3Lg7zM7eK3bAVjTlxsEhx0aYdJvLfX/hgZ2gnlJQrLRvTcn92HAbtVa756SWCwdDF
         ScemxLJryx+MC1HqC/4BD16TmAaeBU9kIh/xoqJAiKmQC/hth1yr31xxh325auq/eCGN
         +E9+0rOPdLULyB9CckXGGRjAEWEkuOg8DHTndiNZzfbCrUtoVjYXqp10xel+2iNxcW3D
         rjnlONQoXjzR2583w4M3d6kP+P2COBccm4t1jkmAcyarJN5oCWQT1V5P5FaQOA3aFxN0
         ygHFIEuVZGqqJbU3XzHVp8xTqRfQ3flTbRdvoIKBxoV8CMOTOnZpWOJqinaDvEytca/F
         FeEw==
X-Gm-Message-State: AOAM533RaglQZ3Qvj4NbQ8LDQOVgbRBJ4Osz1nqkypM35nr5FdqvBR6p
        fIaBu8NuMwNquymCLuPqnRRo8w==
X-Google-Smtp-Source: ABdhPJxTufcSgQBLtXxVU0Ze5T1Zg9mWtwB4kTJzcALyam+WJt2W8aZD1PPDOI9pLp4M/L4QQ9xjTA==
X-Received: by 2002:a17:90a:f617:: with SMTP id bw23mr866687pjb.95.1602801962895;
        Thu, 15 Oct 2020 15:46:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c12sm356071pjq.50.2020.10.15.15.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 15:46:01 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH] docs: lkdtm: Modernize and improve details
Date:   Thu, 15 Oct 2020 15:45:59 -0700
Message-Id: <20201015224559.2137489-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The details on using LKDTM were overly obscure. Modernize the details
and expand examples to better illustrate how to use the interfaces.
Additionally add missing SPDX header.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../fault-injection/provoke-crashes.rst       | 56 +++++++++++--------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/Documentation/fault-injection/provoke-crashes.rst b/Documentation/fault-injection/provoke-crashes.rst
index 9279a3e12278..93775bd4e6c8 100644
--- a/Documentation/fault-injection/provoke-crashes.rst
+++ b/Documentation/fault-injection/provoke-crashes.rst
@@ -1,16 +1,19 @@
-===============
-Provoke crashes
-===============
+.. SPDX-License-Identifier: GPL-2.0
 
-The lkdtm module provides an interface to crash or injure the kernel at
-predefined crashpoints to evaluate the reliability of crash dumps obtained
-using different dumping solutions. The module uses KPROBEs to instrument
-crashing points, but can also crash the kernel directly without KRPOBE
-support.
+============================================================
+Provoking crashes with Linux Kernel Dump Test Module (LKDTM)
+============================================================
 
+The lkdtm module provides an interface to disrupt (and usually crash)
+the kernel at predefined code locations to evaluate the reliability of
+the kernel's exception handling and to test crash dumps obtained using
+different dumping solutions. The module uses KPROBEs to instrument the
+trigger location, but can also trigger the kernel directly without KPROBE
+support via debugfs.
 
-You can provide the way either through module arguments when inserting
-the module, or through a debugfs interface.
+You can select the location of the trigger ("crash point name") and the
+type of action ("crash point type") either through module arguments when
+inserting the module, or through the debugfs interface.
 
 Usage::
 
@@ -18,31 +21,38 @@ Usage::
 			[cpoint_count={>0}]
 
 recur_count
-	Recursion level for the stack overflow test. Default is 10.
+	Recursion level for the stack overflow test. By default this is
+	dynamically calculated based on kernel configuration, with the
+	goal of being just large enough to exhaust the kernel stack. The
+	value can be seen at `/sys/module/lkdtm/parameters/recur_count`.
 
 cpoint_name
-	Crash point where the kernel is to be crashed. It can be
+	Where in the kernel to trigger the action. It can be
 	one of INT_HARDWARE_ENTRY, INT_HW_IRQ_EN, INT_TASKLET_ENTRY,
 	FS_DEVRW, MEM_SWAPOUT, TIMERADD, SCSI_DISPATCH_CMD,
-	IDE_CORE_CP, DIRECT
+	IDE_CORE_CP, or DIRECT
 
 cpoint_type
 	Indicates the action to be taken on hitting the crash point.
-	It can be one of PANIC, BUG, EXCEPTION, LOOP, OVERFLOW,
-	CORRUPT_STACK, UNALIGNED_LOAD_STORE_WRITE, OVERWRITE_ALLOCATION,
-	WRITE_AFTER_FREE,
+	These are numerous, and best queried directly from debugfs. Some
+	of the common ones are PANIC, BUG, EXCEPTION, LOOP, and OVERFLOW.
+	See the contents of `/sys/kernel/debug/provoke-crash/DIRECT` for
+	a complete list.
 
 cpoint_count
 	Indicates the number of times the crash point is to be hit
-	to trigger an action. The default is 10.
+	before triggering the action. The default is 10 (except for
+	DIRECT, which always fires immediately).
 
 You can also induce failures by mounting debugfs and writing the type to
-<mountpoint>/provoke-crash/<crashpoint>. E.g.::
+<debugfs>/provoke-crash/<crashpoint>. E.g.::
 
-  mount -t debugfs debugfs /mnt
-  echo EXCEPTION > /mnt/provoke-crash/INT_HARDWARE_ENTRY
+  mount -t debugfs debugfs /sys/kernel/debug
+  echo EXCEPTION > /sys/kernel/debug/provoke-crash/INT_HARDWARE_ENTRY
 
+The special file `DIRECT` will induce the action directly without KPROBE
+instrumentation. This mode is the only one available when the module is
+built for a kernel without KPROBEs support::
 
-A special file is `DIRECT` which will induce the crash directly without
-KPROBE instrumentation. This mode is the only one available when the module
-is built on a kernel without KPROBEs support.
+  # Instead of having a BUG kill your shell, have it kill "cat":
+  cat <(echo WRITE_RO) >/sys/kernel/debug/provoke-crash/DIRECT
-- 
2.25.1

