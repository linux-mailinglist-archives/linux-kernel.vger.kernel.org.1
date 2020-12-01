Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B572CA79F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgLAQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:00:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391860AbgLAQAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:00:47 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED2D22242;
        Tue,  1 Dec 2020 16:00:06 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kk84T-002R60-OW; Tue, 01 Dec 2020 11:00:05 -0500
Message-ID: <20201201160005.618794714@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 10:58:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 04/12] docs: bootconfig: Update file format on initrd image
References: <20201201155835.647858317@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

To align the total file size, add padding null character when appending
the bootconfig to initrd image.

Link: https://lkml.kernel.org/r/160576522916.320071.4145530996151028855.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

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
 
-- 
2.28.0


