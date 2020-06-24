Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF79207130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 12:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390455AbgFXKbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 06:31:16 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:45050 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgFXKbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8KetnYH1ctebfjbdRXdQEyAgS9HTWZVO1zqVlNtPXiQ=; b=a/SjBuw6aJpw/OiPJul+arL5GR
        zy/ERa2YO73oyfm1qi+c0+MFEfioqBKcKRgFBFFpGvcxS+OTDLS2lBNfhAPQAWmLk3YyHNmFdi4/a
        u4nZat9+cxEatmOTUu/IN1cQqtlu/agFuIbz1YVyCwk+hTqjOq+Bk6W/OlVOFjDz8H68=;
Received: from lfbn-mar-1-578-97.w109-208.abo.wanadoo.fr ([109.208.124.97] helo=xps9380.mn.codeweavers.com)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <rbernon@codeweavers.com>)
        id 1jo2gP-0007lh-68; Wed, 24 Jun 2020 05:31:11 -0500
From:   Remi Bernon <rbernon@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     Remi Bernon <rbernon@codeweavers.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: [PATCH 1/3] perf dso: Use libbfd to read build_id and .gnu_debuglink section
Date:   Wed, 24 Jun 2020 12:30:39 +0200
Message-Id: <20200624103041.825746-1-rbernon@codeweavers.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -25.4
X-Spam-Report: Spam detection software, running on the system "mail.codeweavers.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Wine generates PE binaries for most of its modules and perf
    is unable to parse these files to get build_id or .gnu_debuglink section.
    Using libbfd when available, instead of libelf, makes it possible to resolve
    debug file location regardless of the dso binary format. 
 Content analysis details:   (-25.4 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  -20 USER_IN_WHITELIST      From: address is in the user's white-list
 -6.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -0.5 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
  1.1 AWL                    AWL: Adjusted score from AWL reputation of From: address
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wine generates PE binaries for most of its modules and perf is unable
to parse these files to get build_id or .gnu_debuglink section.

Using libbfd when available, instead of libelf, makes it possible to
resolve debug file location regardless of the dso binary format.

Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jacek Caban <jacek@codeweavers.com>
---

As a follow up to https://lkml.org/lkml/2020/6/1/402, I believe the 5.8
merge window is about to close (or is closed?), so I felt like it was
maybe the right time for an update.

This new version includes:
* a few style changes that were previously requested,
* a regression fix where the bfd filename__read_build_id did not return
  the correct size on success,
* a small test case with sample PE file and separate debug file.

Cheers,
Remi

 tools/perf/util/symbol-elf.c | 80 ++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 5e43054bffea..2489ca5a2284 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -50,6 +50,10 @@ typedef Elf64_Nhdr GElf_Nhdr;
 #define DMGL_ANSI        (1 << 1)       /* Include const, volatile, etc */
 #endif
 
+#ifdef HAVE_LIBBFD_SUPPORT
+#define PACKAGE 'perf'
+#include <bfd.h>
+#else
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
 extern char *cplus_demangle(const char *, int);
 
@@ -65,9 +69,7 @@ static inline char *bfd_demangle(void __maybe_unused *v,
 {
 	return NULL;
 }
-#else
-#define PACKAGE 'perf'
-#include <bfd.h>
+#endif
 #endif
 #endif
 
@@ -530,6 +532,36 @@ static int elf_read_build_id(Elf *elf, void *bf, size_t size)
 	return err;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+
+int filename__read_build_id(const char *filename, void *bf, size_t size)
+{
+	int err = -1;
+	bfd *abfd;
+
+	abfd = bfd_openr(filename, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	if (!abfd->build_id || abfd->build_id->size > size)
+		goto out_close;
+
+	memcpy(bf, abfd->build_id->data, abfd->build_id->size);
+	memset(bf + abfd->build_id->size, 0, size - abfd->build_id->size);
+	err = abfd->build_id->size;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+#else
+
 int filename__read_build_id(const char *filename, void *bf, size_t size)
 {
 	int fd, err = -1;
@@ -557,6 +589,8 @@ int filename__read_build_id(const char *filename, void *bf, size_t size)
 	return err;
 }
 
+#endif
+
 int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 {
 	int fd, err = -1;
@@ -608,6 +642,44 @@ int sysfs__read_build_id(const char *filename, void *build_id, size_t size)
 	return err;
 }
 
+#ifdef HAVE_LIBBFD_SUPPORT
+
+int filename__read_debuglink(const char *filename, char *debuglink,
+			     size_t size)
+{
+	int err = -1;
+	asection *section;
+	bfd *abfd;
+
+	abfd = bfd_openr(filename, NULL);
+	if (!abfd)
+		return -1;
+
+	if (!bfd_check_format(abfd, bfd_object)) {
+		pr_debug2("%s: cannot read %s bfd file.\n", __func__, filename);
+		goto out_close;
+	}
+
+	section = bfd_get_section_by_name(abfd, ".gnu_debuglink");
+	if (!section)
+		goto out_close;
+
+	if (section->size > size)
+		goto out_close;
+
+	if (!bfd_get_section_contents(abfd, section, debuglink, 0,
+				      section->size))
+		goto out_close;
+
+	err = 0;
+
+out_close:
+	bfd_close(abfd);
+	return err;
+}
+
+#else
+
 int filename__read_debuglink(const char *filename, char *debuglink,
 			     size_t size)
 {
@@ -660,6 +732,8 @@ int filename__read_debuglink(const char *filename, char *debuglink,
 	return err;
 }
 
+#endif
+
 static int dso__swap_init(struct dso *dso, unsigned char eidata)
 {
 	static unsigned int const endian = 1;
-- 
2.27.0

