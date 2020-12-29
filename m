Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7C42E74EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 22:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgL2VnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 16:43:11 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55242 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbgL2VnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 16:43:10 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTLUxpD017533
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=SrwbP9B2XkVgk7yVVn35fWe2Q0o+zmrvAUxRgAFV/BU=;
 b=TmpHBd3Q12lZpnXcXZrCQ/arbu1LbXpeYodE8qqQGrZa0Ouv4fbvaZranZTuM4NUU+zE
 wY4AOnphPF1nVZcG/x4aOx6AELtKvX8JAvqpbPau8uc+xCwKftWU2a6hRuXqhIGzswnx
 FYYb2fktZ1G94ua4r1AKRpb5fGaBzEy1Qeo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp3vs4h3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 13:42:30 -0800
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 29 Dec 2020 13:42:26 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 4C08C62E4F0A; Tue, 29 Dec 2020 13:42:25 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mark.rutland@arm.com>, <jolsa@redhat.com>, <kernel-team@fb.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH v7 2/3] perf: support build BPF skeletons with perf
Date:   Tue, 29 Dec 2020 13:42:13 -0800
Message-ID: <20201229214214.3413833-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201229214214.3413833-1-songliubraving@fb.com>
References: <20201229214214.3413833-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-29_16:2020-12-28,2020-12-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012290132
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF programs are useful in perf to profile BPF programs. BPF skeleton is
by far the easiest way to write BPF tools. Enable building BPF skeletons
in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
be added for different use cases.

Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/build/Makefile.feature        |  4 ++-
 tools/perf/Makefile.config          |  9 ++++++
 tools/perf/Makefile.perf            | 49 +++++++++++++++++++++++++++--
 tools/perf/util/bpf_skel/.gitignore |  3 ++
 tools/scripts/Makefile.include      |  1 +
 5 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/.gitignore

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 97cbfb31b7625..74e255d58d8d0 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=3D                  \
          clang                          \
          libbpf                         \
          libpfm4                        \
-         libdebuginfod
+         libdebuginfod			\
+         clang-bpf-co-re
+
=20
 FEATURE_TESTS ?=3D $(FEATURE_TESTS_BASIC)
=20
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ce8516e4de34f..d8e59d31399a5 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -621,6 +621,15 @@ ifndef NO_LIBBPF
   endif
 endif
=20
+ifdef BUILD_BPF_SKEL
+  $(call feature_check,clang-bpf-co-re)
+  ifeq ($(feature-clang-bpf-co-re), 0)
+    dummy :=3D $(error Error: clang too old. Please install recent clang=
)
+  endif
+  $(call detected,CONFIG_PERF_BPF_SKEL)
+  CFLAGS +=3D -DHAVE_BPF_SKEL
+endif
+
 dwarf-post-unwind :=3D 1
 dwarf-post-unwind-text :=3D BUG
=20
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 62f3deb1d3a8b..d182a2dbb9bbd 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -126,6 +126,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
+# Define BUILD_BPF_SKEL to enable BPF skeletons
+#
=20
 # As per kernel Makefile, avoid funny character set dependencies
 unexport LC_ALL
@@ -175,6 +177,12 @@ endef
=20
 LD +=3D $(EXTRA_LDFLAGS)
=20
+HOSTCC  ?=3D gcc
+HOSTLD  ?=3D ld
+HOSTAR  ?=3D ar
+CLANG   ?=3D clang
+LLVM_STRIP ?=3D llvm-strip
+
 PKG_CONFIG =3D $(CROSS_COMPILE)pkg-config
 LLVM_CONFIG ?=3D llvm-config
=20
@@ -731,7 +739,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-c=
mds.h archheaders $(drm_ioc
 	$(x86_arch_prctl_code_array) \
 	$(rename_flags_array) \
 	$(arch_errno_name_array) \
-	$(sync_file_range_arrays)
+	$(sync_file_range_arrays) \
+	bpf-skel
=20
 $(OUTPUT)%.o: %.c prepare FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=3D$(build-dir)=
 $@
@@ -1004,7 +1013,43 @@ config-clean:
 python-clean:
 	$(python-clean)
=20
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
+SKEL_OUT :=3D $(abspath $(OUTPUT)util/bpf_skel)
+SKEL_TMP_OUT :=3D $(abspath $(SKEL_OUT)/.tmp)
+SKELETONS :=3D
+
+ifdef BUILD_BPF_SKEL
+BPFTOOL :=3D $(SKEL_TMP_OUT)/bootstrap/bpftool
+LIBBPF_SRC :=3D $(abspath ../lib/bpf)
+BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/.. -I$(BPF_PATH) -I$(LIBBPF_SRC)/..
+
+$(SKEL_TMP_OUT):
+	$(Q)$(MKDIR) -p $@
+
+$(BPFTOOL): | $(SKEL_TMP_OUT)
+	CFLAGS=3D $(MAKE) -C ../bpf/bpftool \
+		OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
+
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OU=
T)
+	$(QUIET_CLANG)$(CLANG) -g -O2 -target bpf $(BPF_INCLUDE) \
+	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@ && $(LLVM_STRIP) -g $@
+
+$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
+	$(QUIET_GENSKEL)$(BPFTOOL) gen skeleton $< > $@
+
+bpf-skel: $(SKELETONS)
+
+.PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
+
+else # BUILD_BPF_SKEL
+
+bpf-skel:
+
+endif # BUILD_BPF_SKEL
+
+bpf-skel-clean:
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
+
+clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean bpf-ske=
l-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archiv=
e $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.=
cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/util/bpf_skel/.gitignore b/tools/perf/util/bpf_sk=
el/.gitignore
new file mode 100644
index 0000000000000..5263e9e6c5d83
--- /dev/null
+++ b/tools/perf/util/bpf_skel/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+.tmp
+*.skel.h
\ No newline at end of file
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
index 1358e89cdf7d6..62119ce69ad9a 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -127,6 +127,7 @@ ifneq ($(silent),1)
 			 $(MAKE) $(PRINT_DIR) -C $$subdir
 	QUIET_FLEX     =3D @echo '  FLEX     '$@;
 	QUIET_BISON    =3D @echo '  BISON    '$@;
+	QUIET_GENSKEL  =3D @echo '  GEN-SKEL '$@;
=20
 	descend =3D \
 		+@echo	       '  DESCEND  '$(1); \
--=20
2.24.1

