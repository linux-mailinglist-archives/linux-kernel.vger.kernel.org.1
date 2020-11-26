Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 325992C59C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404003AbgKZRA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 26 Nov 2020 12:00:57 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:52193 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403791AbgKZRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:00:57 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-Dm1FP_9MOZioLJ6V17qDNA-1; Thu, 26 Nov 2020 12:00:48 -0500
X-MC-Unique: Dm1FP_9MOZioLJ6V17qDNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59DF61009616;
        Thu, 26 Nov 2020 17:00:45 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7D0D60BFA;
        Thu, 26 Nov 2020 17:00:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/25] bpf: Add size arg to build_id_parse function
Date:   Thu, 26 Nov 2020 18:00:03 +0100
Message-Id: <20201126170026.2619053-3-jolsa@kernel.org>
In-Reply-To: <20201126170026.2619053-1-jolsa@kernel.org>
References: <20201126170026.2619053-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to have other build id types (other than default SHA1).
Currently there's also ld support for MD5 build id.

Adding size argument to build_id_parse function, that returns (if defined)
size of the parsed build id, so we can recognize the build id type.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/buildid.h |  3 ++-
 kernel/bpf/stackmap.c   |  2 +-
 lib/buildid.c           | 29 +++++++++++++++++++++--------
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 3be5b49719f1..72639d433873 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -6,6 +6,7 @@
 
 #define BUILD_ID_SIZE 20
 
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id);
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+		   __u32 *size);
 
 #endif
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 7df08f8af5a1..a05fac2cbb05 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -199,7 +199,7 @@ static void stack_map_get_build_id_offset(struct bpf_stack_build_id *id_offs,
 
 	for (i = 0; i < trace_nr; i++) {
 		vma = find_vma(current->mm, ips[i]);
-		if (!vma || build_id_parse(vma, id_offs[i].build_id)) {
+		if (!vma || build_id_parse(vma, id_offs[i].build_id, NULL)) {
 			/* per entry fall back to ips */
 			id_offs[i].status = BPF_STACK_BUILD_ID_IP;
 			id_offs[i].ip = ips[i];
diff --git a/lib/buildid.c b/lib/buildid.c
index e8d5feb7ef20..dbe1b7e247f3 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -12,6 +12,7 @@
  */
 static inline int parse_build_id(void *page_addr,
 				 unsigned char *build_id,
+				 __u32 *size,
 				 void *note_start,
 				 Elf32_Word note_size)
 {
@@ -38,6 +39,8 @@ static inline int parse_build_id(void *page_addr,
 			       nhdr->n_descsz);
 			memset(build_id + nhdr->n_descsz, 0,
 			       BUILD_ID_SIZE - nhdr->n_descsz);
+			if (size)
+				*size = nhdr->n_descsz;
 			return 0;
 		}
 		new_offs = note_offs + sizeof(Elf32_Nhdr) +
@@ -50,7 +53,8 @@ static inline int parse_build_id(void *page_addr,
 }
 
 /* Parse build ID from 32-bit ELF */
-static int get_build_id_32(void *page_addr, unsigned char *build_id)
+static int get_build_id_32(void *page_addr, unsigned char *build_id,
+			   __u32 *size)
 {
 	Elf32_Ehdr *ehdr = (Elf32_Ehdr *)page_addr;
 	Elf32_Phdr *phdr;
@@ -65,7 +69,7 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id)
 
 	for (i = 0; i < ehdr->e_phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id,
+		    !parse_build_id(page_addr, build_id, size,
 				    page_addr + phdr[i].p_offset,
 				    phdr[i].p_filesz))
 			return 0;
@@ -74,7 +78,8 @@ static int get_build_id_32(void *page_addr, unsigned char *build_id)
 }
 
 /* Parse build ID from 64-bit ELF */
-static int get_build_id_64(void *page_addr, unsigned char *build_id)
+static int get_build_id_64(void *page_addr, unsigned char *build_id,
+			   __u32 *size)
 {
 	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)page_addr;
 	Elf64_Phdr *phdr;
@@ -89,7 +94,7 @@ static int get_build_id_64(void *page_addr, unsigned char *build_id)
 
 	for (i = 0; i < ehdr->e_phnum; ++i) {
 		if (phdr[i].p_type == PT_NOTE &&
-		    !parse_build_id(page_addr, build_id,
+		    !parse_build_id(page_addr, build_id, size,
 				    page_addr + phdr[i].p_offset,
 				    phdr[i].p_filesz))
 			return 0;
@@ -97,8 +102,16 @@ static int get_build_id_64(void *page_addr, unsigned char *build_id)
 	return -EINVAL;
 }
 
-/* Parse build ID of ELF file mapped to vma */
-int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
+/*
+ * Parse build ID of ELF file mapped to vma
+ * @vma:      vma object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Returns 0 on success, otherwise error (< 0).
+ */
+int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+		   __u32 *size)
 {
 	Elf32_Ehdr *ehdr;
 	struct page *page;
@@ -126,9 +139,9 @@ int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id)
 		goto out;
 
 	if (ehdr->e_ident[EI_CLASS] == ELFCLASS32)
-		ret = get_build_id_32(page_addr, build_id);
+		ret = get_build_id_32(page_addr, build_id, size);
 	else if (ehdr->e_ident[EI_CLASS] == ELFCLASS64)
-		ret = get_build_id_64(page_addr, build_id);
+		ret = get_build_id_64(page_addr, build_id, size);
 out:
 	kunmap_atomic(page_addr);
 	put_page(page);
-- 
2.26.2

