Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8DA2CB225
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgLBBN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:13:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727455AbgLBBNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:13:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14B102222A;
        Wed,  2 Dec 2020 01:13:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kkGhh-002W3i-VS; Tue, 01 Dec 2020 20:13:09 -0500
Message-ID: <20201202011309.867238431@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 01 Dec 2020 20:12:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-linus][PATCH 3/3] docs: bootconfig: Add the endianness of fields
References: <20201202011224.839590843@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add a description about the endianness of the size and the checksum
fields. Those must be stored as le32 instead of u32. This will allow
us to apply bootconfig to the cross build initrd without caring
the endianness.

Link: https://lkml.kernel.org/r/160583936246.547349.10964204130590955409.stgit@devnote2

Reported-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/admin-guide/bootconfig.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 363599683784..9b90efcc3a35 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -140,7 +140,9 @@ Since the boot configuration file is loaded with initrd, it will be added
 to the end of the initrd (initramfs) image file with padding, size,
 checksum and 12-byte magic word as below.
 
-[initrd][bootconfig][padding][size(u32)][checksum(u32)][#BOOTCONFIG\n]
+[initrd][bootconfig][padding][size(le32)][checksum(le32)][#BOOTCONFIG\n]
+
+The size and checksum fields are unsigned 32bit little endian value.
 
 When the boot configuration is added to the initrd image, the total
 file size is aligned to 4 bytes. To fill the gap, null characters
-- 
2.28.0


