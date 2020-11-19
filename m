Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B902B2B8AAF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 05:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKSEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 23:51:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:65258 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgKSEvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 23:51:15 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJ4o7p9024299
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:51:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=fgLAoCHD5MDBFAwQ8EjZKp8mlqDBn58xz6F9w7xjulw=;
 b=cXYOh9EdFprIcp1sYqlUNKg2N8MLDMV/ppgClcQcJNs6JDPBU9R2OxYfdzlAjHa2OqeD
 JPOmj+3U2d405AXPVS9M+It2xogrc3/p20zRHaGGJSE+DJF+139CU8SLg+LjoIeYXNoG
 XiOnM9GUVWm7f+DDYVVi63jlWtifjhYK7Nk= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34vtwegn8d-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:51:14 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 20:51:10 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id ED2AD62E572B; Wed, 18 Nov 2020 20:50:54 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <kernel-team@fb.com>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, Song Liu <songliubraving@fb.com>
Subject: [RFC 1/2] perf: support build BPF skeletons with perf
Date:   Wed, 18 Nov 2020 20:50:45 -0800
Message-ID: <20201119045046.1491106-2-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201119045046.1491106-1-songliubraving@fb.com>
References: <20201119045046.1491106-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_01:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 clxscore=1015 suspectscore=1 mlxlogscore=999
 priorityscore=1501 phishscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011190035
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
 tools/build/Makefile.feature         |  3 +-
 tools/perf/Makefile.config           |  7 +++
 tools/perf/Makefile.perf             | 15 +++++-
 tools/perf/util/bpf_skel/.gitignore  |  3 ++
 tools/perf/util/bpf_skel/Makefile    | 71 ++++++++++++++++++++++++++++
 tools/perf/util/bpf_skel/dummy.bpf.c | 19 ++++++++
 6 files changed, 115 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/Makefile
 create mode 100644 tools/perf/util/bpf_skel/dummy.bpf.c

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
index ce8516e4de34f..1c2c0f4badd85 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -619,6 +619,13 @@ ifndef NO_LIBBPF
     msg :=3D $(warning BPF API too old. Please install recent kernel hea=
ders. BPF support in 'perf record' is disabled.)
     NO_LIBBPF :=3D 1
   endif
+
+  ifndef NO_BPF_SKEL
+    ifeq ($(feature-clang-bpf-co-re), 1)
+      BUILD_BPF_SKEL :=3D 1
+      $(call detected,CONFIG_PERF_BPF_SKEL)
+    endif
+  endif
 endif
=20
 dwarf-post-unwind :=3D 1
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7ce3f2e8b9c74..9a9fc71e2ffa4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -126,6 +126,8 @@ include ../scripts/utilities.mak
 #
 # Define NO_LIBDEBUGINFOD if you do not want support debuginfod
 #
+# Define NO_BPF_SKEL if you do not want build BPF skeletons
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
@@ -1008,7 +1011,15 @@ config-clean:
 python-clean:
 	$(python-clean)
=20
+ifdef BUILD_BPF_SKEL
+bpf-skel:
+	$(Q)$(MAKE) -C util/bpf_skel
+else
+bpf-skel:
+endif
+
 clean:: $(LIBTRACEEVENT)-clean $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBC=
MD)-clean $(LIBPERF)-clean config-clean fixdep-clean python-clean
+	$(call descend,util/bpf_skel,clean)
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archiv=
e $(OUTPUT)perf-with-kcore $(LANG_BINDINGS)
 	$(Q)find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.=
cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
@@ -1071,7 +1082,7 @@ endif
=20
 FORCE:
=20
-.PHONY: all install clean config-clean strip install-gtk
+.PHONY: all install clean config-clean strip install-gtk bpf-skel
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_=
shell
 .PHONY: $(GIT-HEAD-PHONY) TAGS tags cscope FORCE prepare
 .PHONY: libtraceevent_plugins archheaders
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
diff --git a/tools/perf/util/bpf_skel/Makefile b/tools/perf/util/bpf_skel=
/Makefile
new file mode 100644
index 0000000000000..853bece088f4b
--- /dev/null
+++ b/tools/perf/util/bpf_skel/Makefile
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+SKEL_OUTPUT :=3D $(abspath .)
+TMP_OUTPUT :=3D $(abspath .tmp)
+CLANG ?=3D clang
+LLC ?=3D llc
+LLVM_STRIP ?=3D llvm-strip
+DEFAULT_BPFTOOL :=3D $(TMP_OUTPUT)/sbin/bpftool
+BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
+LIBBPF_SRC :=3D $(abspath ../../../lib/bpf)
+BPFOBJ :=3D $(TMP_OUTPUT)/libbpf.a
+BPF_INCLUDE :=3D $(TMP_OUTPUT)
+INCLUDES :=3D -I$(TMP_OUTPUT) -I$(BPF_INCLUDE) -I$(abspath ../../../lib)=
        \
+       -I$(abspath ../../../include/uapi)
+CFLAGS :=3D -g -Wall
+
+# Try to detect best kernel BTF source
+KERNEL_REL :=3D $(shell uname -r)
+VMLINUX_BTF_PATHS :=3D /sys/kernel/btf/vmlinux /boot/vmlinux-$(KERNEL_RE=
L)
+VMLINUX_BTF_PATH :=3D $(or $(VMLINUX_BTF),$(firstword			       \
+					  $(wildcard $(VMLINUX_BTF_PATHS))))
+ifeq ($(V),1)
+Q =3D
+msg =3D
+else
+Q =3D @
+msg =3D @printf '  %-8s %s%s\n' "$(1)" "$(notdir $(2))" "$(if $(3), $(3)=
)";
+MAKEFLAGS +=3D --no-print-directory
+submake_extras :=3D feature_display=3D0
+endif
+
+SKELETONS :=3D $(SKEL_OUTPUT)/dummy.skel.h
+
+.DELETE_ON_ERROR:
+
+.PHONY: all clean
+all: $(SKELETONS)
+
+clean:
+	$(call msg,CLEAN,bpf_skel)
+	$(Q)rm -rf $(TMP_OUTPUT) $(SKELETONS)
+
+$(SKEL_OUTPUT)/%.skel.h: $(TMP_OUTPUT)/%.bpf.o | $(BPFTOOL)
+	$(call msg,GEN-SKEL,$@)
+	$(Q)$(BPFTOOL) gen skeleton $< > $@
+
+$(TMP_OUTPUT)/%.bpf.o: %.bpf.c $(TMP_OUTPUT)/vmlinux.h $(BPFOBJ) | $(TMP=
_OUTPUT)
+	$(call msg,BPF,$@)
+	$(Q)$(CLANG) -g -O2 -target bpf $(INCLUDES)			      \
+		 -c $(filter %.c,$^) -o $@ &&				      \
+	$(LLVM_STRIP) -g $@
+
+$(TMP_OUTPUT):
+	$(call msg,MKDIR,$@)
+	$(Q)mkdir -p $(TMP_OUTPUT)
+
+$(TMP_OUTPUT)/vmlinux.h: $(VMLINUX_BTF_PATH) | $(TMP_OUTPUT) $(BPFTOOL)
+	$(call msg,GEN,$@)
+	$(Q)if [ ! -e "$(VMLINUX_BTF_PATH)" ] ; then \
+		echo "Couldn't find kernel BTF; set VMLINUX_BTF to"	       \
+			"specify its location." >&2;			       \
+		exit 1;\
+	fi
+	$(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
+
+$(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(T=
MP_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C $(LIBBPF_SRC)			       \
+		    OUTPUT=3D$(abspath $(dir $@))/ $(abspath $@)
+
+$(DEFAULT_BPFTOOL): | $(TMP_OUTPUT)
+	$(Q)$(MAKE) $(submake_extras) -C ../../../bpf/bpftool		      \
+		    prefix=3D OUTPUT=3D$(TMP_OUTPUT)/ DESTDIR=3D$(TMP_OUTPUT) install
diff --git a/tools/perf/util/bpf_skel/dummy.bpf.c b/tools/perf/util/bpf_s=
kel/dummy.bpf.c
new file mode 100644
index 0000000000000..085fcee1f52cf
--- /dev/null
+++ b/tools/perf/util/bpf_skel/dummy.bpf.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+// Copyright (c) 2020 Facebook
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
+	__uint(key_size, sizeof(u32));
+	__uint(value_size, sizeof(u64));
+} counts SEC(".maps");
+
+SEC("fentry/dummy")
+int BPF_PROG(fentry_dummy)
+{
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "Dual BSD/GPL";
--=20
2.24.1

