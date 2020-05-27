Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248291E5149
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 00:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbgE0Wex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 18:34:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49390 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726578AbgE0WeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:34:19 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RMFcDB001605
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=c0UeiR3c3qRtNHNW+AH+kziF1nAKRGkcQBYpmJo/3cI=;
 b=hBe6LJJOh+tIIwaL8gvq1FBbNFaFuPppSyUjwBTTlyw4nnzoIti5UANYj/vNW8NePxRB
 zcLajrg09Ek0Y5sp6B+I7TlS89KCDLopTCZI8Fp3wsOUOFhtVbdWmtwq+oP5yU9QOQPm
 DzIh1G0UKt5+jGAcQJTEmMMnoTxrn+zITAw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 317kp425qv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:34:17 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 27 May 2020 15:34:16 -0700
Received: by devvm1291.vll0.facebook.com (Postfix, from userid 111017)
        id E9084166903D; Wed, 27 May 2020 15:34:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1291.vll0.facebook.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: vll0c01
Subject: [PATCH v5 18/19] kselftests: cgroup: add kernel memory accounting tests
Date:   Wed, 27 May 2020 15:34:03 -0700
Message-ID: <20200527223404.1008856-19-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200527223404.1008856-1-guro@fb.com>
References: <20200527223404.1008856-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=2 priorityscore=1501 cotscore=-2147483648
 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270170
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some tests to cover the kernel memory accounting functionality.
These are covering some issues (and changes) we had recently.

1) A test which allocates a lot of negative dentries, checks memcg
slab statistics, creates memory pressure by setting memory.max
to some low value and checks that some number of slabs was reclaimed.

2) A test which covers side effects of memcg destruction: it creates
and destroys a large number of sub-cgroups, each containing a
multi-threaded workload which allocates and releases some kernel
memory. Then it checks that the charge ans memory.stats do add up
on the parent level.

3) A test which reads /proc/kpagecgroup and implicitly checks that it
doesn't crash the system.

4) A test which spawns a large number of threads and checks that
the kernel stacks accounting works as expected.

5) A test which checks that living charged slab objects are not
preventing the memory cgroup from being released after being deleted
by a user.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/testing/selftests/cgroup/.gitignore  |   1 +
 tools/testing/selftests/cgroup/Makefile    |   2 +
 tools/testing/selftests/cgroup/test_kmem.c | 382 +++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 tools/testing/selftests/cgroup/test_kmem.c

diff --git a/tools/testing/selftests/cgroup/.gitignore b/tools/testing/se=
lftests/cgroup/.gitignore
index aa6de65b0838..84cfcabea838 100644
--- a/tools/testing/selftests/cgroup/.gitignore
+++ b/tools/testing/selftests/cgroup/.gitignore
@@ -2,3 +2,4 @@
 test_memcontrol
 test_core
 test_freezer
+test_kmem
\ No newline at end of file
diff --git a/tools/testing/selftests/cgroup/Makefile b/tools/testing/self=
tests/cgroup/Makefile
index 967f268fde74..f027d933595b 100644
--- a/tools/testing/selftests/cgroup/Makefile
+++ b/tools/testing/selftests/cgroup/Makefile
@@ -6,11 +6,13 @@ all:
 TEST_FILES     :=3D with_stress.sh
 TEST_PROGS     :=3D test_stress.sh
 TEST_GEN_PROGS =3D test_memcontrol
+TEST_GEN_PROGS +=3D test_kmem
 TEST_GEN_PROGS +=3D test_core
 TEST_GEN_PROGS +=3D test_freezer
=20
 include ../lib.mk
=20
 $(OUTPUT)/test_memcontrol: cgroup_util.c ../clone3/clone3_selftests.h
+$(OUTPUT)/test_kmem: cgroup_util.c ../clone3/clone3_selftests.h
 $(OUTPUT)/test_core: cgroup_util.c ../clone3/clone3_selftests.h
 $(OUTPUT)/test_freezer: cgroup_util.c ../clone3/clone3_selftests.h
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/s=
elftests/cgroup/test_kmem.c
new file mode 100644
index 000000000000..5224dae216e5
--- /dev/null
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+
+#include <linux/limits.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <sys/sysinfo.h>
+#include <pthread.h>
+
+#include "../kselftest.h"
+#include "cgroup_util.h"
+
+
+static int alloc_dcache(const char *cgroup, void *arg)
+{
+	unsigned long i;
+	struct stat st;
+	char buf[128];
+
+	for (i =3D 0; i < (unsigned long)arg; i++) {
+		snprintf(buf, sizeof(buf),
+			"/something-non-existent-with-a-long-name-%64lu-%d",
+			 i, getpid());
+		stat(buf, &st);
+	}
+
+	return 0;
+}
+
+/*
+ * This test allocates 100000 of negative dentries with long names.
+ * Then it checks that "slab" in memory.stat is larger than 1M.
+ * Then it sets memory.high to 1M and checks that at least 1/2
+ * of slab memory has been reclaimed.
+ */
+static int test_kmem_basic(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *cg =3D NULL;
+	long slab0, slab1, current;
+
+	cg =3D cg_name(root, "kmem_basic_test");
+	if (!cg)
+		goto cleanup;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	if (cg_run(cg, alloc_dcache, (void *)100000))
+		goto cleanup;
+
+	slab0 =3D cg_read_key_long(cg, "memory.stat", "slab ");
+	if (slab0 < (1 << 20))
+		goto cleanup;
+
+	cg_write(cg, "memory.high", "1M");
+	slab1 =3D cg_read_key_long(cg, "memory.stat", "slab ");
+	if (slab1 <=3D 0)
+		goto cleanup;
+
+	current =3D cg_read_long(cg, "memory.current");
+	if (current <=3D 0)
+		goto cleanup;
+
+	if (slab1 < slab0 / 2 && current < slab0 / 2)
+		ret =3D KSFT_PASS;
+cleanup:
+	cg_destroy(cg);
+	free(cg);
+
+	return ret;
+}
+
+static void *alloc_kmem_fn(void *arg)
+{
+	alloc_dcache(NULL, (void *)100);
+	return NULL;
+}
+
+static int alloc_kmem_smp(const char *cgroup, void *arg)
+{
+	int nr_threads =3D 2 * get_nprocs();
+	pthread_t *tinfo;
+	unsigned long i;
+	int ret =3D -1;
+
+	tinfo =3D calloc(nr_threads, sizeof(pthread_t));
+	if (tinfo =3D=3D NULL)
+		return -1;
+
+	for (i =3D 0; i < nr_threads; i++) {
+		if (pthread_create(&tinfo[i], NULL, &alloc_kmem_fn,
+				   (void *)i)) {
+			free(tinfo);
+			return -1;
+		}
+	}
+
+	for (i =3D 0; i < nr_threads; i++) {
+		ret =3D pthread_join(tinfo[i], NULL);
+		if (ret)
+			break;
+	}
+
+	free(tinfo);
+	return ret;
+}
+
+static int cg_run_in_subcgroups(const char *parent,
+				int (*fn)(const char *cgroup, void *arg),
+				void *arg, int times)
+{
+	char *child;
+	int i;
+
+	for (i =3D 0; i < times; i++) {
+		child =3D cg_name_indexed(parent, "child", i);
+		if (!child)
+			return -1;
+
+		if (cg_create(child)) {
+			cg_destroy(child);
+			free(child);
+			return -1;
+		}
+
+		if (cg_run(child, fn, NULL)) {
+			cg_destroy(child);
+			free(child);
+			return -1;
+		}
+
+		cg_destroy(child);
+		free(child);
+	}
+
+	return 0;
+}
+
+/*
+ * The test creates and destroys a large number of cgroups. In each cgro=
up it
+ * allocates some slab memory (mostly negative dentries) using 2 * NR_CP=
US
+ * threads. Then it checks the sanity of numbers on the parent level:
+ * the total size of the cgroups should be roughly equal to
+ * anon + file + slab + kernel_stack.
+ */
+static int test_kmem_memcg_deletion(const char *root)
+{
+	long current, slab, anon, file, kernel_stack, sum;
+	int ret =3D KSFT_FAIL;
+	char *parent;
+
+	parent =3D cg_name(root, "kmem_memcg_deletion_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_run_in_subcgroups(parent, alloc_kmem_smp, NULL, 100))
+		goto cleanup;
+
+	current =3D cg_read_long(parent, "memory.current");
+	slab =3D cg_read_key_long(parent, "memory.stat", "slab ");
+	anon =3D cg_read_key_long(parent, "memory.stat", "anon ");
+	file =3D cg_read_key_long(parent, "memory.stat", "file ");
+	kernel_stack =3D cg_read_key_long(parent, "memory.stat", "kernel_stack =
");
+	if (current < 0 || slab < 0 || anon < 0 || file < 0 ||
+	    kernel_stack < 0)
+		goto cleanup;
+
+	sum =3D slab + anon + file + kernel_stack;
+	if (abs(sum - current) < 4096 * 32 * 2 * get_nprocs()) {
+		ret =3D KSFT_PASS;
+	} else {
+		printf("memory.current =3D %ld\n", current);
+		printf("slab + anon + file + kernel_stack =3D %ld\n", sum);
+		printf("slab =3D %ld\n", slab);
+		printf("anon =3D %ld\n", anon);
+		printf("file =3D %ld\n", file);
+		printf("kernel_stack =3D %ld\n", kernel_stack);
+	}
+
+cleanup:
+	cg_destroy(parent);
+	free(parent);
+
+	return ret;
+}
+
+/*
+ * The test reads the entire /proc/kpagecgroup. If the operation went
+ * successfully (and the kernel didn't panic), the test is treated as pa=
ssed.
+ */
+static int test_kmem_proc_kpagecgroup(const char *root)
+{
+	unsigned long buf[128];
+	int ret =3D KSFT_FAIL;
+	ssize_t len;
+	int fd;
+
+	fd =3D open("/proc/kpagecgroup", O_RDONLY);
+	if (fd < 0)
+		return ret;
+
+	do {
+		len =3D read(fd, buf, sizeof(buf));
+	} while (len > 0);
+
+	if (len =3D=3D 0)
+		ret =3D KSFT_PASS;
+
+	close(fd);
+	return ret;
+}
+
+static void *pthread_wait_fn(void *arg)
+{
+	sleep(100);
+	return NULL;
+}
+
+static int spawn_1000_threads(const char *cgroup, void *arg)
+{
+	int nr_threads =3D 1000;
+	pthread_t *tinfo;
+	unsigned long i;
+	long stack;
+	int ret =3D -1;
+
+	tinfo =3D calloc(nr_threads, sizeof(pthread_t));
+	if (tinfo =3D=3D NULL)
+		return -1;
+
+	for (i =3D 0; i < nr_threads; i++) {
+		if (pthread_create(&tinfo[i], NULL, &pthread_wait_fn,
+				   (void *)i)) {
+			free(tinfo);
+			return(-1);
+		}
+	}
+
+	stack =3D cg_read_key_long(cgroup, "memory.stat", "kernel_stack ");
+	if (stack >=3D 4096 * 1000)
+		ret =3D 0;
+
+	free(tinfo);
+	return ret;
+}
+
+/*
+ * The test spawns a process, which spawns 1000 threads. Then it checks
+ * that memory.stat's kernel_stack is at least 1000 pages large.
+ */
+static int test_kmem_kernel_stacks(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *cg =3D NULL;
+
+	cg =3D cg_name(root, "kmem_kernel_stacks_test");
+	if (!cg)
+		goto cleanup;
+
+	if (cg_create(cg))
+		goto cleanup;
+
+	if (cg_run(cg, spawn_1000_threads, NULL))
+		goto cleanup;
+
+	ret =3D KSFT_PASS;
+cleanup:
+	cg_destroy(cg);
+	free(cg);
+
+	return ret;
+}
+
+/*
+ * This test sequentionally creates 30 child cgroups, allocates some
+ * kernel memory in each of them, and deletes them. Then it checks
+ * that the number of dying cgroups on the parent level is 0.
+ */
+static int test_kmem_dead_cgroups(const char *root)
+{
+	int ret =3D KSFT_FAIL;
+	char *parent;
+	long dead;
+	int i;
+
+	parent =3D cg_name(root, "kmem_dead_cgroups_test");
+	if (!parent)
+		goto cleanup;
+
+	if (cg_create(parent))
+		goto cleanup;
+
+	if (cg_write(parent, "cgroup.subtree_control", "+memory"))
+		goto cleanup;
+
+	if (cg_run_in_subcgroups(parent, alloc_dcache, (void *)100, 30))
+		goto cleanup;
+
+	for (i =3D 0; i < 5; i++) {
+		dead =3D cg_read_key_long(parent, "cgroup.stat",
+					"nr_dying_descendants ");
+		if (dead =3D=3D 0) {
+			ret =3D KSFT_PASS;
+			break;
+		}
+		/*
+		 * Reclaiming cgroups might take some time,
+		 * let's wait a bit and repeat.
+		 */
+		sleep(1);
+	}
+
+cleanup:
+	cg_destroy(parent);
+	free(parent);
+
+	return ret;
+}
+
+#define T(x) { x, #x }
+struct kmem_test {
+	int (*fn)(const char *root);
+	const char *name;
+} tests[] =3D {
+	T(test_kmem_basic),
+	T(test_kmem_memcg_deletion),
+	T(test_kmem_proc_kpagecgroup),
+	T(test_kmem_kernel_stacks),
+	T(test_kmem_dead_cgroups),
+};
+#undef T
+
+int main(int argc, char **argv)
+{
+	char root[PATH_MAX];
+	int i, ret =3D EXIT_SUCCESS;
+
+	if (cg_find_unified_root(root, sizeof(root)))
+		ksft_exit_skip("cgroup v2 isn't mounted\n");
+
+	/*
+	 * Check that memory controller is available:
+	 * memory is listed in cgroup.controllers
+	 */
+	if (cg_read_strstr(root, "cgroup.controllers", "memory"))
+		ksft_exit_skip("memory controller isn't available\n");
+
+	if (cg_read_strstr(root, "cgroup.subtree_control", "memory"))
+		if (cg_write(root, "cgroup.subtree_control", "+memory"))
+			ksft_exit_skip("Failed to set memory controller\n");
+
+	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
+		switch (tests[i].fn(root)) {
+		case KSFT_PASS:
+			ksft_test_result_pass("%s\n", tests[i].name);
+			break;
+		case KSFT_SKIP:
+			ksft_test_result_skip("%s\n", tests[i].name);
+			break;
+		default:
+			ret =3D EXIT_FAILURE;
+			ksft_test_result_fail("%s\n", tests[i].name);
+			break;
+		}
+	}
+
+	return ret;
+}
--=20
2.25.4

