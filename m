Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288A12B8B23
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 06:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgKSFxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 00:53:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgKSFxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 00:53:53 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF31A22227;
        Thu, 19 Nov 2020 05:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605765232;
        bh=Te2tFxY1BOS4uysqvA7qp8kR0pfzUS27egjsYkCWDd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EUeepXHBFRXs061r95yHg1npdl2tQ0iT70IrPQcwxZd9EM36TbjMsnSFuUCbZzaNc
         NaowggaRtMKuwrQZy59/mjecoBZrSRX70tL9BHQya/w+2619X/lSPD4U/1Z5znNkUY
         RyHn3xtvYIYc3Pl7u1gSGw+jbp1jVqPXVeOI7gXc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chen Yu <yu.c.chen@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v5 4/4] docs: bootconfig: Update file format on initrd image
Date:   Thu, 19 Nov 2020 14:53:49 +0900
Message-Id: <160576522916.320071.4145530996151028855.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160576519277.320071.14260402851742732108.stgit@devnote2>
References: <160576519277.320071.14260402851742732108.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align the total file size, add padding null character when appending
the bootconfig to initrd image.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index a22024f9175e..363599683784 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -137,15 +137,22 @@ Boot Kernel With a Boot Config
 ==============================
 
 Since the boot configuration file is loaded with initrd, it will be added
-to the end of the initrd (initramfs) image file with size, checksum and
-12-byte magic word as below.
+to the end of the initrd (initramfs) image file with padding, size,
+checksum and 12-byte magic word as below.
 
-[initrd][bootconfig][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+[initrd][bootconfig][padding][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+
+When the boot configuration is added to the initrd image, the total
+file size is aligned to 4 bytes. To fill the gap, null characters
+(``\0``) will be added. Thus the ``size`` is the length of the bootconfig
+file + padding bytes.
 
 The Linux kernel decodes the last part of the initrd image in memory to
 get the boot configuration data.
 Because of this "piggyback" method, there is no need to change or
-update the boot loader and the kernel image itself.
+update the boot loader and the kernel image itself as long as the boot
+loader passes the correct initrd file size. If by any chance, the boot
+loader passes a longer size, the kernel feils to find the bootconfig data.
 
 To do this operation, Linux kernel provides "bootconfig" command under
 tools/bootconfig, which allows admin to apply or delete the config file
@@ -176,7 +183,8 @@ up to 512 key-value pairs. If keys contains 3 words in average, it can
 contain 256 key-value pairs. In most cases, the number of config items
 will be under 100 entries and smaller than 8KB, so it would be enough.
 If the node number exceeds 1024, parser returns an error even if the file
-size is smaller than 32KB.
+size is smaller than 32KB. (Note that this maximum size is not including
+the padding null characters.)
 Anyway, since bootconfig command verifies it when appending a boot config
 to initrd image, user can notice it before boot.
 

