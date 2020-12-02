Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2D12CB90F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388186AbgLBJiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:38:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52270 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387860AbgLBJiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:38:07 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B29Nj5Z028145
        for <linux-kernel@vger.kernel.org>; Wed, 2 Dec 2020 01:37:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=kWGy8Vz2RrEFszqOo1nCjdPME97FtLexEcL9rndI4mw=;
 b=KT1pSFocqLxMXV5dEAQRS30Gu+oKxlxp59/2mTTl42U/UoPJrkgmlchVX877EzINXCyY
 /Yrin7LXqBMPBrFXz/IfimNoeYD5Kpizobg0mVsUOv1oonh+RHCqoJtc5A3fKCSlxsvd
 wZXpkPcN32nZxf4Rp6aYQqx8YSmrpGCpNfo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 355agst16g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:37:25 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 01:37:24 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 6FD1B62E59A5; Wed,  2 Dec 2020 01:37:18 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [PATCH v1 1/2] perf: support build BPF skeletons with perf
Date:   Wed, 2 Dec 2020 01:37:08 -0800
Message-ID: <20201202093709.3374099-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201202093709.3374099-1-songliubraving@fb.com>
References: <20201202093709.3374099-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_04:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 malwarescore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020055
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BPF programs are useful in perf to profile BPF programs. BPF skeleton is
by far the easiest way to write BPF tools. Enable building BPF skeletons
in util/bpf_skel. A dummy bpf skeleton is added. More bpf skeletons will
be added for different use cases.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/bpf/bpftool/Makefile           |  2 ++
 tools/build/Makefile.feature         |  4 ++-
 tools/perf/Makefile.config           | 10 ++++++
 tools/perf/Makefile.perf             | 46 ++++++++++++++++++++++++++--
 tools/perf/util/bpf_skel/.gitignore  |  3 ++
 tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++++++
 tools/scripts/Makefile.include       |  1 +
 7 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index f60e6ad3a1dff..a01407ec78dc5 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -120,6 +120,8 @@ endif
=20
 BPFTOOL_BOOTSTRAP :=3D $(if $(OUTPUT),$(OUTPUT)bpftool-bootstrap,./bpfto=
ol-bootstrap)
=20
+bootstrap: $(BPFTOOL_BOOTSTRAP)
+
 BOOTSTRAP_OBJS =3D $(addprefix $(OUTPUT),main.o common.o json_writer.o g=
en.o btf.o)
 OBJS =3D $(patsubst %.c,$(OUTPUT)%.o,$(SRCS)) $(OUTPUT)disasm.o
=20
diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 97cbfb31b7625..4eeeabbaa2947 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -99,7 +99,9 @@ FEATURE_TESTS_EXTRA :=3D                  \
          clang                          \
          libbpf                         \
          libpfm4                        \
-         libdebuginfod
+         libdebuginfod			\
+	 clang-bpf-co-re
+
=20
 FEATURE_TESTS ?=3D $(FEATURE_TESTS_BASIC)
=20
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ce8516e4de34f..c8ff82b4fc1b2 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -621,6 +621,16 @@ ifndef NO_LIBBPF
   endif
 endif
=20
+$(call feature_check,clang-bpf-co-re)
+ifeq ($(feature-clang-bpf-co-re), 0)
+  undefine BUILD_BPF_SKEL
+endif
+
+ifdef BUILD_BPF_SKEL
+    $(call detected,CONFIG_PERF_BPF_SKEL)
+    CFLAGS +=3D -DBUILD_BPF_SKEL
+endif
+
 dwarf-post-unwind :=3D 1
 dwarf-post-unwind-text :=3D BUG
=20
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c74..f46f0cd012b2d 100644
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
@@ -178,6 +180,8 @@ LD +=3D $(EXTRA_LDFLAGS)
 HOSTCC  ?=3D gcc
 HOSTLD  ?=3D ld
 HOSTAR  ?=3D ar
+CLANG ?=3D clang
+LLVM_STRIP ?=3D llvm-strip
=20
 PKG_CONFIG =3D $(CROSS_COMPILE)pkg-config
 LLVM_CONFIG ?=3D llvm-config
@@ -735,7 +739,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-c=
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
@@ -1008,7 +1013,44 @@ config-clean:
 python-clean:
 	$(python-clean)
=20
-clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
+SKEL_OUT :=3D $(abspath util/bpf_skel)
+SKEL_TMP_OUT :=3D $(abspath util/bpf_skel/.tmp)
+SKELETONS :=3D $(SKEL_OUT)/dummy.skel.h
+
+ifdef BUILD_BPF_SKEL
+BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
+LIBBPF_SRC :=3D $(abspath ../lib/bpf)
+BPF_INCLUDE :=3D -I$(SKEL_TMP_OUT)/..
+submake_extras :=3D feature_display=3D0
+
+$(SKEL_TMP_OUT):
+	$(Q)$(MKDIR) -p $@
+
+$(BPFTOOL): | $(SKEL_TMP_OUT)
+	CFLAGS=3D $(MAKE) $(submake_extras) -C ../bpf/bpftool \
+		OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
+
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) | $(SKEL_TMP_OU=
T)
+	$(call QUIET_CLANG, $@)
+	$(Q)$(CLANG) -g -O2 -target bpf $(BPF_INCLUDE) -c $(filter util/bpf_ske=
l/%.bpf.c,$^) \
+	-o $@ && $(LLVM_STRIP) -g $@
+
+$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
+	$(call QUIET_GENSKEL, $@)
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+bpf-skel: $(SKELETONS)
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
diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_s=
kel/dummy.bpf.c
new file mode 100644
index 0000000000000..492a43a851deb
--- /dev/null
+++ b/tools/perf/util/bpf_skel/dummy.bpf.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2020 Facebook
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(__u32));
+	__uint(value_size, sizeof(__u64));
+} counts SEC(".maps");
+
+SEC("fentry/dummy")
+int BPF_PROG(fentry_dummy)
+{
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.incl=
ude
index a7974638561ca..ed1720dc12194 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -126,6 +126,7 @@ ifneq ($(silent),1)
 	QUIET_CLEAN    =3D @printf '  CLEAN    %s\n' $1;
 	QUIET_INSTALL  =3D @printf '  INSTALL  %s\n' $1;
 	QUIET_UNINST   =3D @printf '  UNINST   %s\n' $1;
+	QUIET_GENSKEL  =3D @printf '  GEN-SKEL   %s\n' $1;
   endif
 endif
=20
--=20
2.24.1

