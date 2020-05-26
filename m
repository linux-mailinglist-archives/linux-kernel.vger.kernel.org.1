Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06F041A4ABC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgDJTl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:41:26 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:36243 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726683AbgDJTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:41:24 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 10 Apr 2020 12:38:53 -0700
Received: from sc9-mailhost3.vmware.com (unknown [10.166.69.226])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 8BFB0B2C9B;
        Fri, 10 Apr 2020 15:38:57 -0400 (EDT)
From:   Matt Helsley <mhelsley@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Julien Thierry <jthierry@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Matt Helsley <mhelsley@vmware.com>
Subject: [RFC][PATCH 28/36] objtool: mcount: Remove unused file mapping
Date:   Fri, 10 Apr 2020 12:35:51 -0700
Message-ID: <07c49b8d3b040b70821f44fbdef882ef5c977728.1586468801.git.mhelsley@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1586468801.git.mhelsley@vmware.com>
References: <cover.1586468801.git.mhelsley@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: None (EX13-EDG-OU-002.vmware.com: mhelsley@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF data is now accessed completely through objtool's
ELF code. We can remove the mapping of the original ELF
file and propagate elf_open(), elf_close(), and malloc()
up in place of mmap_file(), mmap_cleanup(), and umalloc()
respectively. This also eliminates the last use of the
umalloc() wrapper, reduces the number of global
variables, and limits the use of globals to:

	The struct elf for the file we're working on. This
	saves passing it to nearly every function as a parameter.

	Variables set depending on the ELF file endian, wordsize,
	and arch so that the appropriate relocation structures,
	offset sizes, architecture quirks, and nop encodings will
	be used.

	One command-line option

Note that we're still using the recordmcount wrapper to change
variable sizes and structure definitions we use to build the
mcount relocation data and call instruction offsets.

RFC Reviewer Question: Should these arch bits be broken out to fit
	objtool's arch directories similar to the way instruction
	parsing is done? (e.g. arch-specific nop insn writes)

Signed-off-by: Matt Helsley <mhelsley@vmware.com>
---
 tools/objtool/recordmcount.c | 99 +++---------------------------------
 tools/objtool/recordmcount.h |  4 +-
 2 files changed, 9 insertions(+), 94 deletions(-)

diff --git a/tools/objtool/recordmcount.c b/tools/objtool/recordmcount.c
index 409f0ef82211..5fdef8b2ac28 100644
--- a/tools/objtool/recordmcount.c
+++ b/tools/objtool/recordmcount.c
@@ -41,104 +41,14 @@
 #define R_AARCH64_ABS64	257
 #endif
 
-#define R_ARM_PC24		1
 #define R_ARM_THM_CALL		10
-#define R_ARM_CALL		28
 
-static int fd_map;	/* File descriptor for file being modified. */
-static int mmap_failed; /* Boolean flag. */
 static char gpfx;	/* prefix for global symbol name (sometimes '_') */
 static const char *altmcount;	/* alternate mcount symbol name */
 extern int warn_on_notrace_sect; /* warn when section has mcount not being recorded */
-static void *file_map;	/* pointer of the mapped file */
-static size_t file_map_size; /* original ELF file size */
 
 static struct elf *lf;
 
-static void mmap_cleanup(void)
-{
-	if (!mmap_failed)
-		munmap(file_map, file_map_size);
-	else
-		free(file_map);
-	file_map = NULL;
-	if (lf)
-		elf_close(lf);
-	lf = NULL;
-}
-
-static void * umalloc(size_t size)
-{
-	void *const addr = malloc(size);
-	if (addr == 0) {
-		fprintf(stderr, "malloc failed: %zu bytes\n", size);
-		mmap_cleanup();
-		return NULL;
-	}
-	return addr;
-}
-
-/*
- * Get the whole file as a programming convenience in order to avoid
- * malloc+lseek+read+free of many pieces.  If successful, then mmap
- * avoids copying unused pieces; else just read the whole file.
- * Open for both read and write; new info will be appended to the file.
- * Use MAP_PRIVATE so that a few changes to the in-memory ElfXX_Ehdr
- * do not propagate to the file until an explicit overwrite at the last.
- * This preserves most aspects of consistency (all except .st_size)
- * for simultaneous readers of the file while we are appending to it.
- * However, multiple writers still are bad.  We choose not to use
- * locking because it is expensive and the use case of kernel build
- * makes multiple writers unlikely.
- */
-static void *mmap_file(char const *fname)
-{
-	struct stat sb;
-
-	/* Avoid problems if early cleanup() */
-	fd_map = -1;
-	mmap_failed = 1;
-	file_map = NULL;
-	file_map_size = 0;
-
-	lf = elf_read(fname, O_RDWR);
-	if (!lf) {
-		perror(fname);
-		return NULL;
-	}
-	fd_map = lf->fd;
-	if (fstat(fd_map, &sb) < 0) {
-		perror(fname);
-		goto out;
-	}
-	if (!S_ISREG(sb.st_mode)) {
-		fprintf(stderr, "not a regular file: %s\n", fname);
-		goto out;
-	}
-	file_map = mmap(0, sb.st_size, PROT_READ|PROT_WRITE, MAP_PRIVATE,
-			fd_map, 0);
-	if (file_map == MAP_FAILED) {
-		mmap_failed = 1;
-		file_map = umalloc(sb.st_size);
-		if (!file_map) {
-			perror(fname);
-			goto out;
-		}
-		if (read(fd_map, file_map, sb.st_size) != sb.st_size) {
-			perror(fname);
-			mmap_cleanup();
-			goto out;
-		}
-	} else
-		mmap_failed = 0;
-	file_map_size = sb.st_size;
-out:
-	fd_map = -1;
-
-	return file_map;
-}
-
-
 static unsigned char ideal_nop5_x86_64[5] = { 0x0f, 0x1f, 0x44, 0x00, 0x00 };
 static unsigned char ideal_nop5_x86_32[5] = { 0x3e, 0x8d, 0x74, 0x26, 0x00 };
 static unsigned char *ideal_nop;
@@ -525,8 +435,11 @@ static int do_file(char const *const fname)
 	unsigned int reltype = 0;
 	int rc = -1;
 
-	if (!mmap_file(fname))
+	lf = elf_read(fname, O_RDWR);
+	if (!lf) {
+		perror(fname);
 		goto out;
+	}
 
 	w = w4nat;
 	w2 = w2nat;
@@ -656,7 +569,9 @@ static int do_file(char const *const fname)
 	}  /* end switch */
 
 out:
-	mmap_cleanup();
+	if (lf)
+		elf_close(lf);
+	lf = NULL;
 	return rc;
 }
 
diff --git a/tools/objtool/recordmcount.h b/tools/objtool/recordmcount.h
index 084f1eff0df0..9ce2d74df89a 100644
--- a/tools/objtool/recordmcount.h
+++ b/tools/objtool/recordmcount.h
@@ -188,13 +188,13 @@ static int do_func(unsigned const reltype)
 	totrelsz = tot_relsize(&rel_entsize);
 	if (totrelsz == 0)
 		return 0;
-	mrel0 = umalloc(totrelsz);
+	mrel0 = malloc(totrelsz);
 	mrelp = mrel0;
 	if (!mrel0)
 		return -1;
 
 	/* 2*sizeof(address) <= sizeof(Elf_Rel) */
-	mloc0 = umalloc(totrelsz>>1);
+	mloc0 = malloc(totrelsz>>1);
 	mlocp = mloc0;
 	if (!mloc0) {
 		free(mrel0);
-- 
2.20.1

