Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2434C3011F9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbhAWBUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbhAWBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:17:54 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E85C061788
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:14 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id k193so7078875qke.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoqTQgNGMGx4kyUIprUTU4kJbFqYXkmXZDDcCxTR/d4=;
        b=Cmt1Kpw1sTeAdB9DMigDV/L564KF3Lv6YpV/7Wpcln4jevOTK+b8R70SWOxhiyRmMB
         YnQDAYlKCb+yQBTQiIyDFrnYN2aEIfvvLNSgzp7ogrFLPWe9zT1HqTp+3p47cA4/kqmR
         9pJvYzBPdBWEaiDQqUXMpj6aI8/uj+x/siekA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoqTQgNGMGx4kyUIprUTU4kJbFqYXkmXZDDcCxTR/d4=;
        b=MXOWij/tGiadqTJ0TQUnxnjuSrnP9N5tfb+U+SRPWDFkx3adt2udMbJCopnXN6aYl1
         AAw8yX9aFsXNqkSeuKiUKb7+Ss1pC2JKEK/czj+EEXkJY2z6WFabbNu9y2cR4hwRn+Zu
         Ek1x6q8ZYeebS0I1Y84SumlHs/hazq449uWcMg15eREykiI0h9rf0yZIYxuFQJsXKGuC
         ZzeJfCeoeoyxIKAymMVn+R4J8Sg0YmpawSXpJrjefzdl4G4OObVA3PTRHQdVthsxAFsu
         kNStZNHyJ0AmVJh2FnD7FC2DoWdglka5B/S/dnfMkg2NuumpFt6C5t3DXvZxWJW+bm6c
         4KXA==
X-Gm-Message-State: AOAM531IDkBnKsazsFbh/H8ipMXMQksTZtoUdVr4sI89BKpHis2adBw1
        zVvWvbANd4cRcOIszk0lZUE0Jg==
X-Google-Smtp-Source: ABdhPJz1AHTL1pg9lHU2fO1Hi84GDWN/1pV5fafN1qE/DXUYWLPHqdZNOSibZs4X6pGpuM2vHYf3yg==
X-Received: by 2002:a37:6244:: with SMTP id w65mr2319953qkb.307.1611364633047;
        Fri, 22 Jan 2021 17:17:13 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x15sm2516840qtr.72.2021.01.22.17.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 17:17:12 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v10 3/5] kselftest: Add tests for core-sched interface
Date:   Fri, 22 Jan 2021 20:17:02 -0500
Message-Id: <20210123011704.1901835-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123011704.1901835-1-joel@joelfernandes.org>
References: <20210123011704.1901835-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kselftest test to ensure that the core-sched interface is working
correctly.

Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Reviewed-by: Josh Don <joshdon@google.com>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/sched/.gitignore      |   1 +
 tools/testing/selftests/sched/Makefile        |  14 +
 tools/testing/selftests/sched/config          |   1 +
 .../testing/selftests/sched/test_coresched.c  | 716 ++++++++++++++++++
 4 files changed, 732 insertions(+)
 create mode 100644 tools/testing/selftests/sched/.gitignore
 create mode 100644 tools/testing/selftests/sched/Makefile
 create mode 100644 tools/testing/selftests/sched/config
 create mode 100644 tools/testing/selftests/sched/test_coresched.c

diff --git a/tools/testing/selftests/sched/.gitignore b/tools/testing/selftests/sched/.gitignore
new file mode 100644
index 000000000000..4660929b0b9a
--- /dev/null
+++ b/tools/testing/selftests/sched/.gitignore
@@ -0,0 +1 @@
+test_coresched
diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selftests/sched/Makefile
new file mode 100644
index 000000000000..e43b74fc5d7e
--- /dev/null
+++ b/tools/testing/selftests/sched/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
+CLANG_FLAGS += -no-integrated-as
+endif
+
+CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/  -Wl,-rpath=./ \
+	  $(CLANG_FLAGS)
+LDLIBS += -lpthread
+
+TEST_GEN_FILES := test_coresched
+TEST_PROGS := test_coresched
+
+include ../lib.mk
diff --git a/tools/testing/selftests/sched/config b/tools/testing/selftests/sched/config
new file mode 100644
index 000000000000..e8b09aa7c0c4
--- /dev/null
+++ b/tools/testing/selftests/sched/config
@@ -0,0 +1 @@
+CONFIG_SCHED_DEBUG=y
diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
new file mode 100644
index 000000000000..4d18a0a727c8
--- /dev/null
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -0,0 +1,716 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Core-scheduling selftests.
+ *
+ * Copyright (C) 2020, Joel Fernandes.
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#ifndef PR_SCHED_CORE_SHARE
+#define PR_SCHED_CORE_SHARE 59
+# define PR_SCHED_CORE_CLEAR            0
+# define PR_SCHED_CORE_SHARE_FROM       1
+# define PR_SCHED_CORE_SHARE_TO         2
+#endif
+
+#ifndef DEBUG_PRINT
+#define dprint(...)
+#else
+#define dprint(str, args...) printf("DEBUG: %s: " str "\n", __func__, ##args)
+#endif
+
+void print_banner(char *s)
+{
+	printf("coresched: %s:  ", s);
+}
+
+void print_pass(void)
+{
+	printf("PASS\n");
+}
+
+void assert_cond(int cond, char *str)
+{
+	if (!cond) {
+		printf("Error: %s\n", str);
+		abort();
+	}
+}
+
+char *make_group_root(void)
+{
+	char *mntpath, *mnt;
+	int ret;
+
+	mntpath = malloc(50);
+	if (!mntpath) {
+		perror("Failed to allocate mntpath\n");
+		abort();
+	}
+
+	sprintf(mntpath, "/tmp/coresched-test-XXXXXX");
+	mnt = mkdtemp(mntpath);
+	if (!mnt) {
+		perror("Failed to create mount: ");
+		exit(-1);
+	}
+
+	ret = mount("nodev", mnt, "cgroup", 0, "cpu");
+	if (ret == -1) {
+		perror("Failed to mount cgroup: ");
+		exit(-1);
+	}
+
+	return mnt;
+}
+
+char *read_group_cookie(char *cgroup_path)
+{
+	char path[50] = {}, *val;
+	int fd;
+
+	sprintf(path, "%s/cpu.core_group_cookie", cgroup_path);
+	fd = open(path, O_RDONLY, 0666);
+	if (fd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	val = calloc(1, 50);
+	if (read(fd, val, 50) == -1) {
+		perror("Failed to read group cookie: ");
+		abort();
+	}
+
+	val[strcspn(val, "\r\n")] = 0;
+
+	close(fd);
+	return val;
+}
+
+void assert_group_tag(char *cgroup_path, char *tag)
+{
+	char tag_path[50] = {}, rdbuf[8] = {};
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_RDONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (read(tfd, rdbuf, 1) != 1) {
+		perror("Failed to enable coresched on cgroup: ");
+		abort();
+	}
+
+	if (strcmp(rdbuf, tag)) {
+		printf("Group tag does not match (exp: %s, act: %s)\n", tag,
+		       rdbuf);
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+}
+
+void tag_group(char *cgroup_path)
+{
+	char tag_path[50];
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (write(tfd, "1", 1) != 1) {
+		perror("Failed to enable coresched on cgroup: ");
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+
+	assert_group_tag(cgroup_path, "1");
+}
+
+void untag_group(char *cgroup_path)
+{
+	char tag_path[50];
+	int tfd;
+
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
+
+	if (write(tfd, "0", 1) != 1) {
+		perror("Failed to disable coresched on cgroup: ");
+		abort();
+	}
+
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
+
+	assert_group_tag(cgroup_path, "0");
+}
+
+char *make_group(char *parent, char *name)
+{
+	char *cgroup_path;
+	int ret;
+
+	if (!parent && !name)
+		return make_group_root();
+
+	cgroup_path = malloc(50);
+	if (!cgroup_path) {
+		perror("Failed to allocate cgroup_path\n");
+		abort();
+	}
+
+	/* Make the cgroup node for this group */
+	sprintf(cgroup_path, "%s/%s", parent, name);
+	ret = mkdir(cgroup_path, 0644);
+	if (ret == -1) {
+		perror("Failed to create group in cgroup: ");
+		abort();
+	}
+
+	return cgroup_path;
+}
+
+static void del_group(char *path)
+{
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
+
+	free(path);
+}
+
+static void del_root_group(char *path)
+{
+	if (umount(path) != 0) {
+		perror("umount of cgroup failed\n");
+		abort();
+	}
+
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
+
+	free(path);
+}
+
+void assert_group_cookie_equal(char *c1, char *c2)
+{
+	char *v1, *v2;
+
+	v1 = read_group_cookie(c1);
+	v2 = read_group_cookie(c2);
+	if (strcmp(v1, v2)) {
+		printf("Group cookies not equal\n");
+		abort();
+	}
+
+	free(v1);
+	free(v2);
+}
+
+void assert_group_cookie_not_equal(char *c1, char *c2)
+{
+	char *v1, *v2;
+
+	v1 = read_group_cookie(c1);
+	v2 = read_group_cookie(c2);
+	if (!strcmp(v1, v2)) {
+		printf("Group cookies equal\n");
+		abort();
+	}
+
+	free(v1);
+	free(v2);
+}
+
+void assert_group_cookie_not_zero(char *c1)
+{
+	char *v1 = read_group_cookie(c1);
+
+	v1[1] = 0;
+	if (!strcmp(v1, "0")) {
+		printf("Group cookie zero\n");
+		abort();
+	}
+	free(v1);
+}
+
+void assert_group_cookie_zero(char *c1)
+{
+	char *v1 = read_group_cookie(c1);
+
+	v1[1] = 0;
+	if (strcmp(v1, "0")) {
+		printf("Group cookie not zero");
+		abort();
+	}
+	free(v1);
+}
+
+struct task_state {
+	int pid_share;
+	char pid_str[50];
+	pthread_mutex_t m;
+	pthread_cond_t cond;
+	pthread_cond_t cond_par;
+};
+
+struct task_state *add_task(char *p)
+{
+	struct task_state *mem;
+	pthread_mutexattr_t am;
+	pthread_condattr_t a;
+	char tasks_path[50];
+	int tfd, pid, ret;
+
+	sprintf(tasks_path, "%s/tasks", p);
+	tfd = open(tasks_path, O_WRONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tasks path failed: ");
+		abort();
+	}
+
+	mem = mmap(NULL, sizeof(*mem), PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	memset(mem, 0, sizeof(*mem));
+
+	pthread_condattr_init(&a);
+	pthread_condattr_setpshared(&a, PTHREAD_PROCESS_SHARED);
+	pthread_mutexattr_init(&am);
+	pthread_mutexattr_setpshared(&am, PTHREAD_PROCESS_SHARED);
+
+	pthread_cond_init(&mem->cond, &a);
+	pthread_cond_init(&mem->cond_par, &a);
+	pthread_mutex_init(&mem->m, &am);
+
+	pid = fork();
+	if (pid == 0) {
+		while (1) {
+			pthread_mutex_lock(&mem->m);
+			while (!mem->pid_share)
+				pthread_cond_wait(&mem->cond, &mem->m);
+
+			pid = mem->pid_share;
+			mem->pid_share = 0;
+
+			if (pid == -1) {
+				if (prctl
+				    (PR_SCHED_CORE_SHARE, PR_SCHED_CORE_CLEAR,
+				     getpid(), 0, 0))
+					perror
+					    ("prctl() PR_SCHED_CORE_CLEAR failed");
+			} else {
+				if (prctl
+				    (PR_SCHED_CORE_SHARE,
+				     PR_SCHED_CORE_SHARE_FROM, pid, 0, 0))
+					perror
+					    ("prctl() PR_SCHED_CORE_SHARE_FROM failed");
+			}
+			pthread_mutex_unlock(&mem->m);
+			pthread_cond_signal(&mem->cond_par);
+		}
+	}
+
+	sprintf(mem->pid_str, "%d", pid);
+	dprint("add task %d to group %s", pid, p);
+
+	ret = write(tfd, mem->pid_str, strlen(mem->pid_str));
+	assert_cond(ret != -1, "Failed to write pid into tasks");
+
+	close(tfd);
+	return mem;
+}
+
+/* Make t1 share with t2 */
+void make_tasks_share(struct task_state *t1, struct task_state *t2)
+{
+	int p2 = atoi(t2->pid_str);
+
+	dprint("task %s %s", t1->pid_str, t2->pid_str);
+
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = p2;
+	pthread_mutex_unlock(&t1->m);
+
+	pthread_cond_signal(&t1->cond);
+
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
+}
+
+/* Make t1 share with t2 */
+void reset_task_cookie(struct task_state *t1)
+{
+	dprint("task %s", t1->pid_str);
+
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = -1;
+	pthread_mutex_unlock(&t1->m);
+
+	pthread_cond_signal(&t1->cond);
+
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
+}
+
+char *get_task_core_cookie(char *pid)
+{
+	char proc_path[50];
+	int found = 0;
+	char *line;
+	int i, j;
+	FILE *fp;
+
+	line = malloc(1024);
+	assert_cond(!!line, "Failed to alloc memory");
+
+	sprintf(proc_path, "/proc/%s/sched", pid);
+
+	fp = fopen(proc_path, "r");
+	while ((fgets(line, 1024, fp)) != NULL) {
+		if (!strstr(line, "core_cookie"))
+			continue;
+
+		for (j = 0, i = 0; i < 1024 && line[i] != '\0'; i++)
+			if (line[i] >= '0' && line[i] <= '9')
+				line[j++] = line[i];
+		line[j] = '\0';
+		found = 1;
+		break;
+	}
+
+	fclose(fp);
+
+	if (found)
+		return line;
+
+	free(line);
+	printf("core_cookie not found. Enable SCHED_DEBUG?\n");
+	abort();
+	return NULL;
+}
+
+void assert_tasks_share(struct task_state *t1, struct task_state *t2)
+{
+	char *c1, *c2;
+
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("check task (%s) cookie (%s) == task (%s) cookie (%s)",
+	       t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(!strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1);
+	free(c2);
+}
+
+void assert_tasks_dont_share(struct task_state *t1, struct task_state *t2)
+{
+	char *c1, *c2;
+
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("check task (%s) cookie (%s) != task (%s) cookie (%s)",
+	       t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1);
+	free(c2);
+}
+
+void assert_task_has_cookie(char *pid)
+{
+	char *tk;
+
+	tk = get_task_core_cookie(pid);
+
+	assert_cond(strcmp(tk, "0"), "Task does not have cookie");
+
+	free(tk);
+}
+
+void kill_task(struct task_state *t)
+{
+	int pid = atoi(t->pid_str);
+
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
+}
+
+/*
+ * Test that a group's children have a cookie inherrited
+ * from their parent group _after_ the parent was tagged.
+ *
+ *   p ----- c1 - c11
+ *     \ c2 - c22
+ */
+static void test_cgroup_parent_child_tag_inherit(char *root)
+{
+	char *p, *c1, *c11, *c2, *c22;
+
+	print_banner("TEST-CGROUP-PARENT-CHILD-TAG");
+
+	p = make_group(root, "p");
+	assert_group_cookie_zero(p);
+
+	c1 = make_group(p, "c1");
+	assert_group_tag(c1, "0");	/* Child tag is "0" but inherits cookie from parent. */
+	assert_group_cookie_zero(c1);
+	assert_group_cookie_equal(c1, p);
+
+	c11 = make_group(c1, "c11");
+	assert_group_tag(c11, "0");
+	assert_group_cookie_zero(c11);
+	assert_group_cookie_equal(c11, p);
+
+	c2 = make_group(p, "c2");
+	assert_group_tag(c2, "0");
+	assert_group_cookie_zero(c2);
+	assert_group_cookie_equal(c2, p);
+
+	tag_group(p);
+
+	/* Verify c1 got the cookie */
+	assert_group_tag(c1, "0");
+	assert_group_cookie_not_zero(c1);
+	assert_group_cookie_equal(c1, p);
+
+	/* Verify c2 got the cookie */
+	assert_group_tag(c2, "0");
+	assert_group_cookie_not_zero(c2);
+	assert_group_cookie_equal(c2, p);
+
+	/* Verify c11 got the cookie */
+	assert_group_tag(c11, "0");
+	assert_group_cookie_not_zero(c11);
+	assert_group_cookie_equal(c11, p);
+
+	/*
+	 * Verify c22 which is a nested group created
+	 * _after_ tagging got the cookie.
+	 */
+	c22 = make_group(c2, "c22");
+
+	assert_group_tag(c22, "0");
+	assert_group_cookie_not_zero(c22);
+	assert_group_cookie_equal(c22, c1);
+	assert_group_cookie_equal(c22, c11);
+	assert_group_cookie_equal(c22, c2);
+	assert_group_cookie_equal(c22, p);
+
+	del_group(c22);
+	del_group(c11);
+	del_group(c1);
+	del_group(c2);
+	del_group(p);
+	print_pass();
+}
+
+/*
+ * Test that a tagged group's children have a cookie inherrited
+ * from their parent group.
+ */
+static void test_cgroup_parent_tag_child_inherit(char *root)
+{
+	char *p, *c1, *c2, *c3;
+
+	print_banner("TEST-CGROUP-PARENT-TAG-CHILD-INHERIT");
+
+	p = make_group(root, "p");
+	assert_group_cookie_zero(p);
+	tag_group(p);
+	assert_group_cookie_not_zero(p);
+
+	c1 = make_group(p, "c1");
+	assert_group_cookie_not_zero(c1);
+	/* Child tag is "0" but it inherits cookie from parent. */
+	assert_group_tag(c1, "0");
+	assert_group_cookie_equal(c1, p);
+
+	c2 = make_group(p, "c2");
+	assert_group_tag(c2, "0");
+	assert_group_cookie_equal(c2, p);
+	assert_group_cookie_equal(c1, c2);
+
+	c3 = make_group(c1, "c3");
+	assert_group_tag(c3, "0");
+	assert_group_cookie_equal(c3, p);
+	assert_group_cookie_equal(c1, c3);
+
+	del_group(c3);
+	del_group(c1);
+	del_group(c2);
+	del_group(p);
+	print_pass();
+}
+
+static void test_prctl_in_group(char *root)
+{
+	char *p;
+	struct task_state *tsk1, *tsk2, *tsk3;
+
+	print_banner("TEST-PRCTL-IN-GROUP");
+
+	p = make_group(root, "p");
+	assert_group_cookie_zero(p);
+	tag_group(p);
+	assert_group_cookie_not_zero(p);
+
+	tsk1 = add_task(p);
+	assert_task_has_cookie(tsk1->pid_str);
+
+	tsk2 = add_task(p);
+	assert_task_has_cookie(tsk2->pid_str);
+
+	tsk3 = add_task(p);
+	assert_task_has_cookie(tsk3->pid_str);
+
+	/* tsk2 share with tsk3 -- both get disconnected from CGroup. */
+	make_tasks_share(tsk2, tsk3);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_task_has_cookie(tsk3->pid_str);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+
+	/* now reset tsk3 -- get connected back to CGroup. */
+	reset_task_cookie(tsk3);
+	assert_task_has_cookie(tsk3->pid_str);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);	// tsk3 is back.
+	assert_tasks_dont_share(tsk1, tsk2);	// but tsk2 is still zombie
+
+	/* now reset tsk2 as well to get it connected back to CGroup. */
+	reset_task_cookie(tsk2);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);
+	assert_tasks_share(tsk1, tsk2);
+
+	/* Test the rest of the cases (2 to 4)
+	 *
+	 *          t1              joining         t2
+	 * CASE 1:
+	 * before   0                               0
+	 * after    new cookie                      new cookie
+	 *
+	 * CASE 2:
+	 * before   X (non-zero)                    0
+	 * after    0                               0
+	 *
+	 * CASE 3:
+	 * before   0                               X (non-zero)
+	 * after    X                               X
+	 *
+	 * CASE 4:
+	 * before   Y (non-zero)                    X (non-zero)
+	 * after    X                               X
+	 */
+
+	/* case 2: */
+	dprint("case 2");
+	make_tasks_share(tsk1, tsk1);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	assert_task_has_cookie(tsk1->pid_str);
+	make_tasks_share(tsk1, tsk2);	/* Will reset the task cookie. */
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+
+	/* case 3: */
+	dprint("case 3");
+	make_tasks_share(tsk2, tsk2);
+	assert_tasks_dont_share(tsk2, tsk1);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_task_has_cookie(tsk2->pid_str);
+	make_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	reset_task_cookie(tsk1);
+	reset_task_cookie(tsk2);
+
+	/* case 4: */
+	dprint("case 4");
+	assert_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	make_tasks_share(tsk1, tsk1);
+	assert_task_has_cookie(tsk1->pid_str);
+	make_tasks_share(tsk2, tsk2);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_dont_share(tsk1, tsk2);
+	make_tasks_share(tsk1, tsk2);
+	assert_task_has_cookie(tsk1->pid_str);
+	assert_task_has_cookie(tsk2->pid_str);
+	assert_tasks_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	reset_task_cookie(tsk1);
+	reset_task_cookie(tsk2);
+
+	kill_task(tsk1);
+	kill_task(tsk2);
+	kill_task(tsk3);
+	del_group(p);
+	print_pass();
+}
+
+int main(int argc, char *argv[])
+{
+	char *root;
+
+	if (argc > 1)
+		root = argv[1];
+	else
+		root = make_group(NULL, NULL);
+
+	test_cgroup_parent_tag_child_inherit(root);
+	test_cgroup_parent_child_tag_inherit(root);
+	test_prctl_in_group(root);
+
+	if (argc <= 1)
+		del_root_group(root);
+	return 0;
+}
-- 
2.30.0.280.ga3ce27912f-goog

