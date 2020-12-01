Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039D42C9840
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:37:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgLAHhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:37:48 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbgLAHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:37:48 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B17Zoit017701
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:37:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cEEx9vbSgtXPBvgCF63BlWXZ5+eSYp/C/gH2woEtWHQ=;
 b=QvU9Ibt9mfdIK7RvZ8DAELXdn0TQL+/suz59B/ogml+Uqr4hdweQG1I4FQROJd7SeWTl
 awmpWb99aMftMqeYuh39+41lz37qaDvJVlsuEsUi9ACYxevjTdhGLoiOunWMIT8EjX5F
 johNVP1K7PfoikBwpOclXSbDknfz4VwwXMI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 354hsygkah-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:37:07 -0800
Received: from intmgw002.08.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 30 Nov 2020 23:37:04 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 000F962E5919; Mon, 30 Nov 2020 23:36:55 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [RFC v2 1/2] perf: support build BPF skeletons with perf
Date:   Mon, 30 Nov 2020 23:36:46 -0800
Message-ID: <20201201073647.753079-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201201073647.753079-1-songliubraving@fb.com>
References: <20201201073647.753079-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_01:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=1 mlxlogscore=999 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012010050
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
 tools/build/Makefile.feature         |  3 +-
 tools/perf/Makefile.config           |  9 +++++
 tools/perf/Makefile.perf             | 52 ++++++++++++++++++++++++++--
 tools/perf/util/bpf_skel/.gitignore  |  3 ++
 tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++++
 tools/scripts/Makefile.include       |  1 +
 7 files changed, 86 insertions(+), 3 deletions(-)
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
index 97cbfb31b7625..95a58b5564218 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -70,7 +70,8 @@ FEATURE_TESTS_BASIC :=3D                  \
         libaio				\
         libzstd				\
         disassembler-four-args		\
-        file-handle
+        file-handle			\
+        clang-bpf-co-re
=20
 # FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA is the complete list
 # of all feature tests
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index ce8516e4de34f..cb0cf06e0bb43 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -621,6 +621,15 @@ ifndef NO_LIBBPF
   endif
 endif
=20
+ifeq ($(feature-clang-bpf-co-re), 0)
+  BUILD_BPF_SKEL :=3D 0
+endif
+
+ifeq ($(BUILD_BPF_SKEL), 1)
+  $(call detected,CONFIG_PERF_BPF_SKEL)
+  CFLAGS +=3D -DBUILD_BPF_SKEL
+endif
+
 dwarf-post-unwind :=3D 1
 dwarf-post-unwind-text :=3D BUG
=20
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c74..37b7ffe1db27c 100644
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
@@ -735,7 +737,8 @@ prepare: $(OUTPUT)PERF-VERSION-FILE $(OUTPUT)common-c=
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
@@ -1008,7 +1011,52 @@ config-clean:
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
+CLANG ?=3D clang
+LLVM_STRIP ?=3D llvm-strip
+BPFTOOL_CFLAGS :=3D $(filter-out -D_GNU_SOURCE,$(CFLAGS))
+BPFTOOL :=3D $(SKEL_TMP_OUT)/bpftool-bootstrap
+LIBBPF_SRC :=3D $(abspath ../lib/bpf)
+BPFOBJ :=3D $(SKEL_TMP_OUT)/libbpf.a
+BPF_INCLUDE :=3D $(SKEL_TMP_OUT)
+submake_extras :=3D feature_display=3D0
+
+$(SKEL_TMP_OUT):
+	$(Q)$(MKDIR) -p $@
+
+$(BPFTOOL): | $(SKEL_TMP_OUT)
+	CFLAGS=3D $(MAKE) $(submake_extras) -C ../bpf/bpftool \
+		OUTPUT=3D$(SKEL_TMP_OUT)/ bootstrap
+
+$(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(BPFOBJ) | $(SKEL_TMP_OU=
T)
+	$(call QUIET_CLANG, $@)
+	$(Q)$(CLANG) -g -O2 -target bpf	-c $(filter util/bpf_skel/%.bpf.c,$^) -=
o $@ && \
+	$(LLVM_STRIP) -g $@
+
+$(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o | $(BPFTOOL)
+	$(call QUIET_GENSKEL, $@)
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+bpf-skel: $(SKELETONS)
+
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(S=
KEL_TMP_OUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
+		OUTPUT=3D$(abspath $(dir $@))/ $(abspath $@)
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

