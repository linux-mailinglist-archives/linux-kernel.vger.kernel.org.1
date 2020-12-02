Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5681D2CB23F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 02:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgLBBXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 20:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbgLBBXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:23:23 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82BF8221E2;
        Wed,  2 Dec 2020 01:22:41 +0000 (UTC)
Date:   Tue, 1 Dec 2020 20:22:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] bootconfig: Always use little endian for size and
 checksum
Message-ID: <20201201202239.5618b84c@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Have bootconfig size and checksum be little endian

In case the bootconfig is created on one kind of endian machine, and then
read on the other kind of endian kernel, the size and checksum will be
incorrect. Instead, have both the size and checksum always be little
endian and have the tool and the kernel convert it from little endian to
or from the host endian.


Please pull the latest trace-v5.10-rc6-bootconfig tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.10-rc6-bootconfig

Tag SHA1: 35eb7b93d6ded6c1540d799c7118497e2e2f4531
Head SHA1: 05227490c5f0f1bbd3693a7a70b3fb5b09d2a996


Masami Hiramatsu (3):
      bootconfig: Load size and checksum in the footer as le32
      tools/bootconfig: Store size and checksum in footer as le32
      docs: bootconfig: Add the endianness of fields

----
 Documentation/admin-guide/bootconfig.rst | 4 +++-
 init/main.c                              | 4 ++--
 tools/bootconfig/main.c                  | 7 +++++--
 3 files changed, 10 insertions(+), 5 deletions(-)
---------------------------
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
diff --git a/init/main.c b/init/main.c
index 20baced721ad..32b2a8affafd 100644
--- a/init/main.c
+++ b/init/main.c
@@ -288,8 +288,8 @@ static void * __init get_boot_config_from_initrd(u32 *_size, u32 *_csum)
 
 found:
 	hdr = (u32 *)(data - 8);
-	size = hdr[0];
-	csum = hdr[1];
+	size = le32_to_cpu(hdr[0]);
+	csum = le32_to_cpu(hdr[1]);
 
 	data = ((void *)hdr) - size;
 	if ((unsigned long)data < initrd_start) {
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 4a445b6304bb..7362bef1a368 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
+#include <endian.h>
 
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
@@ -183,9 +184,11 @@ static int load_xbc_from_initrd(int fd, char **buf)
 
 	if (read(fd, &size, sizeof(u32)) < 0)
 		return pr_errno("Failed to read size", -errno);
+	size = le32toh(size);
 
 	if (read(fd, &csum, sizeof(u32)) < 0)
 		return pr_errno("Failed to read checksum", -errno);
+	csum = le32toh(csum);
 
 	/* Wrong size error  */
 	if (stat.st_size < size + 8 + BOOTCONFIG_MAGIC_LEN) {
@@ -407,10 +410,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Add a footer */
 	p = data + size;
-	*(u32 *)p = size;
+	*(u32 *)p = htole32(size);
 	p += sizeof(u32);
 
-	*(u32 *)p = csum;
+	*(u32 *)p = htole32(csum);
 	p += sizeof(u32);
 
 	memcpy(p, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
