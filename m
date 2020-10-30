Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFCB2A10C2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgJ3WV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ3WV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:21:26 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F241C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:21:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id k9so4681972pgt.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3fiZz3pnVGdkkoPbxTwU4oYDt9RpnGON9HEtgVqfA0=;
        b=OvlPonnqE6vczTx8qvc0J+Tma4BmnHGNEJrABcd1IvaYjrmyTSnSAp8XhF1SUr6lQs
         Hod4myAVUHHIqQSTW+St68VXdE1TNmC+YTgbMRMCWkhZLBEXPbBtPWqslBSBHBn/tafO
         ksS2Laaa2Pl6mtOmNPDgP3xac3t1TxQyn7fhI64p8lsMX2I5XQhPrmzK2jnNBEf9UlNV
         r7fP3ZxKRVb1+w72ka02e8ztbGEv9+QzOsjCBKj+1FgwH7+pR6zXN9f8kzc3p5tnBD77
         4pNcfDCIJvArzDIOhVbinbX6TgT0xyPonFQY7gT15PjCZFasIbBgZT9VqrU/hCLpMatc
         X5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3fiZz3pnVGdkkoPbxTwU4oYDt9RpnGON9HEtgVqfA0=;
        b=IWYO43mKPP9+13GmYv/ql0fVKyejY89rToFw14A2LC+LqSIfLhoV6Sk/8cMTOSc4hs
         epnYvtyrZJAbEd5mimsEldMsQPIDE97z3n2l96FJTqcRCqWI6373S5RJPyU2vOqHalg3
         n6sBvV88UzWwLDzEjG+W19I2NOL+YmY897HhZyz97I3nw/cgJeqkTaW8R1ekSxyluBR7
         scsG/byw89w0eBETEQzrbtviUxTDpStsz2tw91uP+scupaYDu4qiT/HZEAStnFhwSG0Y
         6iwTFPDhGCzEgO0VuZQSPELgTw7C0BPupLICGZQwmYQvea55r7yLXHwMehkA2gw116zt
         474Q==
X-Gm-Message-State: AOAM533CQoFytrF3IclknTha3BRSKDiISdB4sxcgVsx/y0kzqWE+dL7s
        qaZ2pa9NxYwmzltCGQSXAXI=
X-Google-Smtp-Source: ABdhPJxu9JZ1MYGpyEVzu0OPLG8naGtBPIaGTjWwcuHmdOyM4nse3mN7offTq79XpiTY9C9RD4D45g==
X-Received: by 2002:a63:d456:: with SMTP id i22mr3921577pgj.440.1604096483841;
        Fri, 30 Oct 2020 15:21:23 -0700 (PDT)
Received: from Monkey.fios-router.home ([47.144.162.13])
        by smtp.gmail.com with ESMTPSA id t11sm4343641pjs.8.2020.10.30.15.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 15:21:23 -0700 (PDT)
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     "' Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen ' <tim.c.chen@intel.com>
Cc:     "John B. Wyatt IV" <jbwyatt4@gmail.com>
Subject: [PATCH] sched: Change all 4 space tabs to actual tabs
Date:   Fri, 30 Oct 2020 15:20:28 -0700
Message-Id: <20201030222028.29587-1-jbwyatt4@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020014336.2076526-24-joel@joelfernandes.org>
References: <20201020014336.2076526-24-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch solves over a hundred style warnings caused by 4 space tabs from
patch 23 in the coresched-v8-posted-to-list patch set.

Please review. A script was written to convert all 4 spaces blocks to tabs and
some manual editing was used to fix the any remaining alignment issues caused
by the conversion to tabs.

Issues reported by checkpatch.

Signed-off-by: John B. Wyatt IV <jbwyatt4@gmail.com>
---
 .../testing/selftests/sched/test_coresched.c  | 998 +++++++++---------
 1 file changed, 499 insertions(+), 499 deletions(-)

diff --git a/tools/testing/selftests/sched/test_coresched.c b/tools/testing/selftests/sched/test_coresched.c
index 2fdefb843115..44a33ef88435 100644
--- a/tools/testing/selftests/sched/test_coresched.c
+++ b/tools/testing/selftests/sched/test_coresched.c
@@ -33,20 +33,20 @@
 
 void print_banner(char *s)
 {
-    printf("coresched: %s:  ", s);
+	printf("coresched: %s:  ", s);
 }
 
 void print_pass(void)
 {
-    printf("PASS\n");
+	printf("PASS\n");
 }
 
 void assert_cond(int cond, char *str)
 {
-    if (!cond) {
-	printf("Error: %s\n", str);
-	abort();
-    }
+	if (!cond) {
+		printf("Error: %s\n", str);
+		abort();
+	}
 }
 
 char *make_group_root(void)
@@ -56,8 +56,8 @@ char *make_group_root(void)
 
 	mntpath = malloc(50);
 	if (!mntpath) {
-	    perror("Failed to allocate mntpath\n");
-	    abort();
+		perror("Failed to allocate mntpath\n");
+		abort();
 	}
 
 	sprintf(mntpath, "/tmp/coresched-test-XXXXXX");
@@ -78,82 +78,82 @@ char *make_group_root(void)
 
 char *read_group_cookie(char *cgroup_path)
 {
-    char path[50] = {}, *val;
-    int fd;
+	char path[50] = {}, *val;
+	int fd;
 
-    sprintf(path, "%s/cpu.core_group_cookie", cgroup_path);
-    fd = open(path, O_RDONLY, 0666);
-    if (fd == -1) {
-	perror("Open of cgroup tag path failed: ");
-	abort();
-    }
+	sprintf(path, "%s/cpu.core_group_cookie", cgroup_path);
+	fd = open(path, O_RDONLY, 0666);
+	if (fd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
 
-    val = calloc(1, 50);
-    if (read(fd, val, 50) == -1) {
-	perror("Failed to read group cookie: ");
-	abort();
-    }
+	val = calloc(1, 50);
+	if (read(fd, val, 50) == -1) {
+		perror("Failed to read group cookie: ");
+		abort();
+	}
 
-    val[strcspn(val, "\r\n")] = 0;
+	val[strcspn(val, "\r\n")] = 0;
 
-    close(fd);
-    return val;
+	close(fd);
+	return val;
 }
 
 void assert_group_tag(char *cgroup_path, char *tag)
 {
-    char tag_path[50] = {}, rdbuf[8] = {};
-    int tfd;
+	char tag_path[50] = {}, rdbuf[8] = {};
+	int tfd;
 
-    sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
-    tfd = open(tag_path, O_RDONLY, 0666);
-    if (tfd == -1) {
-	perror("Open of cgroup tag path failed: ");
-	abort();
-    }
+	sprintf(tag_path, "%s/cpu.core_tag", cgroup_path);
+	tfd = open(tag_path, O_RDONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
 
-    if (read(tfd, rdbuf, 1) != 1) {
-	perror("Failed to enable coresched on cgroup: ");
-	abort();
-    }
+	if (read(tfd, rdbuf, 1) != 1) {
+		perror("Failed to enable coresched on cgroup: ");
+		abort();
+	}
 
-    if (strcmp(rdbuf, tag)) {
-	printf("Group tag does not match (exp: %s, act: %s)\n", tag, rdbuf);
-	abort();
-    }
+	if (strcmp(rdbuf, tag)) {
+		printf("Group tag does not match (exp: %s, act: %s)\n", tag, rdbuf);
+		abort();
+	}
 
-    if (close(tfd) == -1) {
-	perror("Failed to close tag fd: ");
-	abort();
-    }
+	if (close(tfd) == -1) {
+		perror("Failed to close tag fd: ");
+		abort();
+	}
 }
 
 void assert_group_color(char *cgroup_path, const char *color)
 {
-    char tag_path[50] = {}, rdbuf[8] = {};
-    int tfd;
+	char tag_path[50] = {}, rdbuf[8] = {};
+	int tfd;
 
-    sprintf(tag_path, "%s/cpu.core_tag_color", cgroup_path);
-    tfd = open(tag_path, O_RDONLY, 0666);
-    if (tfd == -1) {
-	perror("Open of cgroup tag path failed: ");
-	abort();
-    }
+	sprintf(tag_path, "%s/cpu.core_tag_color", cgroup_path);
+	tfd = open(tag_path, O_RDONLY, 0666);
+	if (tfd == -1) {
+		perror("Open of cgroup tag path failed: ");
+		abort();
+	}
 
-    if (read(tfd, rdbuf, 8) == -1) {
-	perror("Failed to read group color\n");
-	abort();
-    }
+	if (read(tfd, rdbuf, 8) == -1) {
+		perror("Failed to read group color\n");
+		abort();
+	}
 
-    if (strncmp(color, rdbuf, strlen(color))) {
-	printf("Group color does not match (exp: %s, act: %s)\n", color, rdbuf);
-	abort();
-    }
+	if (strncmp(color, rdbuf, strlen(color))) {
+		printf("Group color does not match (exp: %s, act: %s)\n", color, rdbuf);
+		abort();
+	}
 
-    if (close(tfd) == -1) {
-	perror("Failed to close color fd: ");
-	abort();
-    }
+	if (close(tfd) == -1) {
+		perror("Failed to close color fd: ");
+		abort();
+	}
 }
 
 void color_group(char *cgroup_path, const char *color_str)
@@ -172,11 +172,11 @@ void color_group(char *cgroup_path, const char *color_str)
 
 	ret = write(tfd, color_str, strlen(color_str));
 	assert_cond(color < 256 || ret == -1,
-		    "Writing invalid range color should have failed!");
+			"Writing invalid range color should have failed!");
 
 	if (color < 1 || color > 255) {
-	    close(tfd);
-	    return;
+		close(tfd);
+		return;
 	}
 
 	if (ret == -1) {
@@ -248,12 +248,12 @@ char *make_group(char *parent, char *name)
 	int ret;
 
 	if (!parent && !name)
-	    return make_group_root();
+		return make_group_root();
 
 	cgroup_path = malloc(50);
 	if (!cgroup_path) {
-	    perror("Failed to allocate cgroup_path\n");
-	    abort();
+		perror("Failed to allocate cgroup_path\n");
+		abort();
 	}
 
 	/* Make the cgroup node for this group */
@@ -269,278 +269,278 @@ char *make_group(char *parent, char *name)
 
 static void del_group(char *path)
 {
-    if (rmdir(path) != 0) {
-	printf("Removal of group failed\n");
-	abort();
-    }
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
 
-    free(path);
+	free(path);
 }
 
 static void del_root_group(char *path)
 {
-    if (umount(path) != 0) {
-	perror("umount of cgroup failed\n");
-	abort();
-    }
+	if (umount(path) != 0) {
+		perror("umount of cgroup failed\n");
+		abort();
+	}
 
-    if (rmdir(path) != 0) {
-	printf("Removal of group failed\n");
-	abort();
-    }
+	if (rmdir(path) != 0) {
+		printf("Removal of group failed\n");
+		abort();
+	}
 
-    free(path);
+	free(path);
 }
 
 void assert_group_cookie_equal(char *c1, char *c2)
 {
-    char *v1, *v2;
+	char *v1, *v2;
 
-    v1 = read_group_cookie(c1);
-    v2 = read_group_cookie(c2);
-    if (strcmp(v1, v2)) {
-	printf("Group cookies not equal\n");
-	abort();
-    }
+	v1 = read_group_cookie(c1);
+	v2 = read_group_cookie(c2);
+	if (strcmp(v1, v2)) {
+		printf("Group cookies not equal\n");
+		abort();
+	}
 
-    free(v1);
-    free(v2);
+	free(v1);
+	free(v2);
 }
 
 void assert_group_cookie_not_equal(char *c1, char *c2)
 {
-    char *v1, *v2;
+	char *v1, *v2;
 
-    v1 = read_group_cookie(c1);
-    v2 = read_group_cookie(c2);
-    if (!strcmp(v1, v2)) {
-	printf("Group cookies not equal\n");
-	abort();
-    }
+	v1 = read_group_cookie(c1);
+	v2 = read_group_cookie(c2);
+	if (!strcmp(v1, v2)) {
+		printf("Group cookies not equal\n");
+		abort();
+	}
 
-    free(v1);
-    free(v2);
+	free(v1);
+	free(v2);
 }
 
 void assert_group_cookie_not_zero(char *c1)
 {
-    char *v1 = read_group_cookie(c1);
+	char *v1 = read_group_cookie(c1);
 
-    v1[1] = 0;
-    if (!strcmp(v1, "0")) {
-	printf("Group cookie zero\n");
-	abort();
-    }
-    free(v1);
+	v1[1] = 0;
+	if (!strcmp(v1, "0")) {
+		printf("Group cookie zero\n");
+		abort();
+	}
+	free(v1);
 }
 
 void assert_group_cookie_zero(char *c1)
 {
-    char *v1 = read_group_cookie(c1);
+	char *v1 = read_group_cookie(c1);
 
-    v1[1] = 0;
-    if (strcmp(v1, "0")) {
-	printf("Group cookie not zero");
-	abort();
-    }
-    free(v1);
+	v1[1] = 0;
+	if (strcmp(v1, "0")) {
+		printf("Group cookie not zero");
+		abort();
+	}
+	free(v1);
 }
 
 struct task_state {
-    int pid_share;
-    char pid_str[50];
-    pthread_mutex_t m;
-    pthread_cond_t cond;
-    pthread_cond_t cond_par;
+	int pid_share;
+	char pid_str[50];
+	pthread_mutex_t m;
+	pthread_cond_t cond;
+	pthread_cond_t cond_par;
 };
 
 struct task_state *add_task(char *p)
 {
-    struct task_state *mem;
-    pthread_mutexattr_t am;
-    pthread_condattr_t a;
-    char tasks_path[50];
-    int tfd, pid, ret;
-
-    sprintf(tasks_path, "%s/tasks", p);
-    tfd = open(tasks_path, O_WRONLY, 0666);
-    if (tfd == -1) {
-	perror("Open of cgroup tasks path failed: ");
-	abort();
-    }
-
-    mem = mmap(NULL, sizeof *mem, PROT_READ | PROT_WRITE,
-	    MAP_SHARED | MAP_ANONYMOUS, -1, 0);
-    memset(mem, 0, sizeof(*mem));
-
-    pthread_condattr_init(&a);
-    pthread_condattr_setpshared(&a, PTHREAD_PROCESS_SHARED);
-    pthread_mutexattr_init(&am);
-    pthread_mutexattr_setpshared(&am, PTHREAD_PROCESS_SHARED);
-
-    pthread_cond_init(&mem->cond, &a);
-    pthread_cond_init(&mem->cond_par, &a);
-    pthread_mutex_init(&mem->m, &am);
-
-    pid = fork();
-    if (pid == 0) {
-	while(1) {
-	    pthread_mutex_lock(&mem->m);
-	    while(!mem->pid_share)
-		pthread_cond_wait(&mem->cond, &mem->m);
-
-	    pid = mem->pid_share;
-	    mem->pid_share = 0;
-	    if (pid == -1)
-		pid = 0;
-	    prctl(PR_SCHED_CORE_SHARE, pid);
-	    pthread_mutex_unlock(&mem->m);
-	    pthread_cond_signal(&mem->cond_par);
-	}
-    }
-
-    sprintf(mem->pid_str, "%d", pid);
-    dprint("add task %d to group %s", pid, p);
-
-    ret = write(tfd, mem->pid_str, strlen(mem->pid_str));
-    assert_cond(ret != -1,
-	    "Failed to write pid into tasks");
-
-    close(tfd);
-    return mem;
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
+	mem = mmap(NULL, sizeof *mem, PROT_READ | PROT_WRITE,
+		MAP_SHARED | MAP_ANONYMOUS, -1, 0);
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
+		while(1) {
+			pthread_mutex_lock(&mem->m);
+			while(!mem->pid_share)
+				pthread_cond_wait(&mem->cond, &mem->m);
+
+			pid = mem->pid_share;
+			mem->pid_share = 0;
+			if (pid == -1)
+				pid = 0;
+			prctl(PR_SCHED_CORE_SHARE, pid);
+			pthread_mutex_unlock(&mem->m);
+			pthread_cond_signal(&mem->cond_par);
+		}
+	}
+
+	sprintf(mem->pid_str, "%d", pid);
+	dprint("add task %d to group %s", pid, p);
+
+	ret = write(tfd, mem->pid_str, strlen(mem->pid_str));
+	assert_cond(ret != -1,
+		"Failed to write pid into tasks");
+
+	close(tfd);
+	return mem;
 }
 
 /* Make t1 share with t2 */
 void make_tasks_share(struct task_state *t1, struct task_state *t2)
 {
-    int p2 = atoi(t2->pid_str);
-    dprint("task %s %s", t1->pid_str, t2->pid_str);
+	int p2 = atoi(t2->pid_str);
+	dprint("task %s %s", t1->pid_str, t2->pid_str);
 
-    pthread_mutex_lock(&t1->m);
-    t1->pid_share = p2;
-    pthread_mutex_unlock(&t1->m);
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = p2;
+	pthread_mutex_unlock(&t1->m);
 
-    pthread_cond_signal(&t1->cond);
+	pthread_cond_signal(&t1->cond);
 
-    pthread_mutex_lock(&t1->m);
-    while (t1->pid_share)
-	pthread_cond_wait(&t1->cond_par, &t1->m);
-    pthread_mutex_unlock(&t1->m);
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
 }
 
 /* Make t1 share with t2 */
 void reset_task_cookie(struct task_state *t1)
 {
-    dprint("task %s", t1->pid_str);
+	dprint("task %s", t1->pid_str);
 
-    pthread_mutex_lock(&t1->m);
-    t1->pid_share = -1;
-    pthread_mutex_unlock(&t1->m);
+	pthread_mutex_lock(&t1->m);
+	t1->pid_share = -1;
+	pthread_mutex_unlock(&t1->m);
 
-    pthread_cond_signal(&t1->cond);
+	pthread_cond_signal(&t1->cond);
 
-    pthread_mutex_lock(&t1->m);
-    while (t1->pid_share)
-	pthread_cond_wait(&t1->cond_par, &t1->m);
-    pthread_mutex_unlock(&t1->m);
+	pthread_mutex_lock(&t1->m);
+	while (t1->pid_share)
+		pthread_cond_wait(&t1->cond_par, &t1->m);
+	pthread_mutex_unlock(&t1->m);
 }
 
 char *get_task_core_cookie(char *pid)
 {
-    char proc_path[50];
-    int found = 0;
-    char *line;
-    int i, j;
-    FILE *fp;
-
-    line = malloc(1024);
-    assert_cond(!!line, "Failed to alloc memory");
-
-    sprintf(proc_path, "/proc/%s/sched", pid);
-
-    fp = fopen(proc_path, "r");
-    while ((fgets(line, 1024, fp)) != NULL)
-    {
-        if(!strstr(line, "core_cookie"))
-            continue;
-
-        for (j = 0, i = 0; i < 1024 && line[i] != '\0'; i++)
-            if (line[i] >= '0' && line[i] <= '9')
-                line[j++] = line[i];
-        line[j] = '\0';
-        found = 1;
-        break;
-    }
-
-    fclose(fp);
-
-    if (found) {
-        return line;
-    } else {
-        free(line);
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
+	while ((fgets(line, 1024, fp)) != NULL)
+	{
+		if(!strstr(line, "core_cookie"))
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
+	if (found) {
+		return line;
+	} else {
+		free(line);
 	printf("core_cookie not found. Enable SCHED_DEBUG?\n");
 	abort();
-        return NULL;
-    }
+		return NULL;
+	}
 }
 
 void assert_tasks_share(struct task_state *t1, struct task_state *t2)
 {
-    char *c1, *c2;
-
-    c1 = get_task_core_cookie(t1->pid_str);
-    c2 = get_task_core_cookie(t2->pid_str);
-    dprint("check task (%s) cookie (%s) == task (%s) cookie (%s)",
-	    t1->pid_str, c1, t2->pid_str, c2);
-    assert_cond(!strcmp(c1, c2), "Tasks don't share cookie");
-    free(c1); free(c2);
+	char *c1, *c2;
+
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("check task (%s) cookie (%s) == task (%s) cookie (%s)",
+		t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(!strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1); free(c2);
 }
 
 void assert_tasks_dont_share(struct task_state *t1,  struct task_state *t2)
 {
-    char *c1, *c2;
-    c1 = get_task_core_cookie(t1->pid_str);
-    c2 = get_task_core_cookie(t2->pid_str);
-    dprint("check task (%s) cookie (%s) != task (%s) cookie (%s)",
-	    t1->pid_str, c1, t2->pid_str, c2);
-    assert_cond(strcmp(c1, c2), "Tasks don't share cookie");
-    free(c1); free(c2);
+	char *c1, *c2;
+	c1 = get_task_core_cookie(t1->pid_str);
+	c2 = get_task_core_cookie(t2->pid_str);
+	dprint("check task (%s) cookie (%s) != task (%s) cookie (%s)",
+		t1->pid_str, c1, t2->pid_str, c2);
+	assert_cond(strcmp(c1, c2), "Tasks don't share cookie");
+	free(c1); free(c2);
 }
 
 void assert_group_cookie_equals_task_cookie(char *g, char *pid)
 {
-    char *gk;
-    char *tk;
+	char *gk;
+	char *tk;
 
-    gk = read_group_cookie(g);
-    tk = get_task_core_cookie(pid);
+	gk = read_group_cookie(g);
+	tk = get_task_core_cookie(pid);
 
-    assert_cond(!strcmp(gk, tk), "Group cookie not equal to tasks'");
+	assert_cond(!strcmp(gk, tk), "Group cookie not equal to tasks'");
 
-    free(gk);
-    free(tk);
+	free(gk);
+	free(tk);
 }
 
 void assert_group_cookie_not_equals_task_cookie(char *g, char *pid)
 {
-    char *gk;
-    char *tk;
+	char *gk;
+	char *tk;
 
-    gk = read_group_cookie(g);
-    tk = get_task_core_cookie(pid);
+	gk = read_group_cookie(g);
+	tk = get_task_core_cookie(pid);
 
-    assert_cond(strcmp(gk, tk), "Group cookie not equal to tasks'");
+	assert_cond(strcmp(gk, tk), "Group cookie not equal to tasks'");
 
-    free(gk);
-    free(tk);
+	free(gk);
+	free(tk);
 }
 
 void kill_task(struct task_state *t)
 {
-    int pid = atoi(t->pid_str);
+	int pid = atoi(t->pid_str);
 
-    kill(pid, SIGKILL);
-    waitpid(pid, NULL, 0);
+	kill(pid, SIGKILL);
+	waitpid(pid, NULL, 0);
 }
 
 /*
@@ -556,51 +556,51 @@ void kill_task(struct task_state *t)
  */
 static void test_cgroup_coloring(char *root)
 {
-    char *y1, *y2, *y22, *r1, *r11, *b3, *r4;
+	char *y1, *y2, *y22, *r1, *r11, *b3, *r4;
 
-    print_banner("TEST-CGROUP-COLORING");
+	print_banner("TEST-CGROUP-COLORING");
 
-    y1 = make_group(root, "y1");
-    tag_group(y1);
+	y1 = make_group(root, "y1");
+	tag_group(y1);
 
-    y2 = make_group(y1, "y2");
-    y22 = make_group(y2, "y22");
+	y2 = make_group(y1, "y2");
+	y22 = make_group(y2, "y22");
 
-    r1 = make_group(y1, "y1");
-    r11 = make_group(r1, "r11");
+	r1 = make_group(y1, "y1");
+	r11 = make_group(r1, "r11");
 
-    color_group(r1, "256"); /* Wouldn't succeed. */
-    color_group(r1, "0");   /* Wouldn't succeed. */
-    color_group(r1, "254");
+	color_group(r1, "256"); /* Wouldn't succeed. */
+	color_group(r1, "0");   /* Wouldn't succeed. */
+	color_group(r1, "254");
 
-    b3 = make_group(y1, "b3");
-    color_group(b3, "8");
+	b3 = make_group(y1, "b3");
+	color_group(b3, "8");
 
-    r4 = make_group(y1, "r4");
-    color_group(r4, "254");
+	r4 = make_group(y1, "r4");
+	color_group(r4, "254");
 
-    /* Check that all yellows share the same cookie. */
-    assert_group_cookie_not_zero(y1);
-    assert_group_cookie_equal(y1, y2);
-    assert_group_cookie_equal(y1, y22);
+	/* Check that all yellows share the same cookie. */
+	assert_group_cookie_not_zero(y1);
+	assert_group_cookie_equal(y1, y2);
+	assert_group_cookie_equal(y1, y22);
 
-    /* Check that all reds share the same cookie. */
-    assert_group_cookie_not_zero(r1);
-    assert_group_cookie_equal(r1, r11);
-    assert_group_cookie_equal(r11, r4);
+	/* Check that all reds share the same cookie. */
+	assert_group_cookie_not_zero(r1);
+	assert_group_cookie_equal(r1, r11);
+	assert_group_cookie_equal(r11, r4);
 
-    /* Check that blue, red and yellow are different cookie. */
-    assert_group_cookie_not_equal(r1, b3);
-    assert_group_cookie_not_equal(b3, y1);
+	/* Check that blue, red and yellow are different cookie. */
+	assert_group_cookie_not_equal(r1, b3);
+	assert_group_cookie_not_equal(b3, y1);
 
-    del_group(r11);
-    del_group(r1);
-    del_group(y22);
-    del_group(y2);
-    del_group(b3);
-    del_group(r4);
-    del_group(y1);
-    print_pass();
+	del_group(r11);
+	del_group(r1);
+	del_group(y22);
+	del_group(y2);
+	del_group(b3);
+	del_group(r4);
+	del_group(y1);
+	print_pass();
 }
 
 /*
@@ -608,68 +608,68 @@ static void test_cgroup_coloring(char *root)
  * from their parent group _after_ the parent was tagged.
  *
  *   p ----- c1 - c11
- *     \ c2 - c22
+ *	 \ c2 - c22
  */
 static void test_cgroup_parent_child_tag_inherit(char *root)
 {
-    char *p, *c1, *c11, *c2, *c22;
-
-    print_banner("TEST-CGROUP-PARENT-CHILD-TAG");
-
-    p = make_group(root, "p");
-    assert_group_cookie_zero(p);
-
-    c1 = make_group(p, "c1");
-    assert_group_tag(c1, "0"); /* Child tag is "0" but inherits cookie from parent. */
-    assert_group_cookie_zero(c1);
-    assert_group_cookie_equal(c1, p);
-
-    c11 = make_group(c1, "c11");
-    assert_group_tag(c11, "0");
-    assert_group_cookie_zero(c11);
-    assert_group_cookie_equal(c11, p);
-
-    c2 = make_group(p, "c2");
-    assert_group_tag(c2, "0");
-    assert_group_cookie_zero(c2);
-    assert_group_cookie_equal(c2, p);
-
-    tag_group(p);
-
-    /* Verify c1 got the cookie */
-    assert_group_tag(c1, "0");
-    assert_group_cookie_not_zero(c1);
-    assert_group_cookie_equal(c1, p);
-
-    /* Verify c2 got the cookie */
-    assert_group_tag(c2, "0");
-    assert_group_cookie_not_zero(c2);
-    assert_group_cookie_equal(c2, p);
-
-    /* Verify c11 got the cookie */
-    assert_group_tag(c11, "0");
-    assert_group_cookie_not_zero(c11);
-    assert_group_cookie_equal(c11, p);
-
-    /*
-     * Verify c22 which is a nested group created
-     * _after_ tagging got the cookie.
-     */
-    c22 = make_group(c2, "c22");
-
-    assert_group_tag(c22, "0");
-    assert_group_cookie_not_zero(c22);
-    assert_group_cookie_equal(c22, c1);
-    assert_group_cookie_equal(c22, c11);
-    assert_group_cookie_equal(c22, c2);
-    assert_group_cookie_equal(c22, p);
-
-    del_group(c22);
-    del_group(c11);
-    del_group(c1);
-    del_group(c2);
-    del_group(p);
-    print_pass();
+	char *p, *c1, *c11, *c2, *c22;
+
+	print_banner("TEST-CGROUP-PARENT-CHILD-TAG");
+
+	p = make_group(root, "p");
+	assert_group_cookie_zero(p);
+
+	c1 = make_group(p, "c1");
+	assert_group_tag(c1, "0"); /* Child tag is "0" but inherits cookie from parent. */
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
 }
 
 /*
@@ -678,163 +678,163 @@ static void test_cgroup_parent_child_tag_inherit(char *root)
  */
 static void test_cgroup_parent_tag_child_inherit(char *root)
 {
-    char *p, *c1, *c2, *c3;
-
-    print_banner("TEST-CGROUP-PARENT-TAG-CHILD-INHERIT");
-
-    p = make_group(root, "p");
-    assert_group_cookie_zero(p);
-    tag_group(p);
-    assert_group_cookie_not_zero(p);
-
-    c1 = make_group(p, "c1");
-    assert_group_cookie_not_zero(c1);
-    /* Child tag is "0" but it inherits cookie from parent. */
-    assert_group_tag(c1, "0");
-    assert_group_cookie_equal(c1, p);
-
-    c2 = make_group(p, "c2");
-    assert_group_tag(c2, "0");
-    assert_group_cookie_equal(c2, p);
-    assert_group_cookie_equal(c1, c2);
-
-    c3 = make_group(c1, "c3");
-    assert_group_tag(c3, "0");
-    assert_group_cookie_equal(c3, p);
-    assert_group_cookie_equal(c1, c3);
-
-    del_group(c3);
-    del_group(c1);
-    del_group(c2);
-    del_group(p);
-    print_pass();
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
 }
 
 static void test_prctl_in_group(char *root)
 {
-    char *p;
-    struct task_state *tsk1, *tsk2, *tsk3;
-
-    print_banner("TEST-PRCTL-IN-GROUP");
-
-    p = make_group(root, "p");
-    assert_group_cookie_zero(p);
-    tag_group(p);
-    assert_group_cookie_not_zero(p);
-
-    tsk1 = add_task(p);
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-
-    tsk2 = add_task(p);
-    assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
-
-    tsk3 = add_task(p);
-    assert_group_cookie_equals_task_cookie(p, tsk3->pid_str);
-
-    /* tsk2 share with tsk3 -- both get disconnected from CGroup. */
-    make_tasks_share(tsk2, tsk3);
-    assert_tasks_share(tsk2, tsk3);
-    assert_tasks_dont_share(tsk1, tsk2);
-    assert_tasks_dont_share(tsk1, tsk3);
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-    assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
-    assert_group_cookie_not_equals_task_cookie(p, tsk3->pid_str);
-
-    /* now reset tsk3 -- get connected back to CGroup. */
-    reset_task_cookie(tsk3);
-    assert_tasks_dont_share(tsk2, tsk3);
-    assert_tasks_share(tsk1, tsk3);      // tsk3 is back.
-    assert_tasks_dont_share(tsk1, tsk2); // but tsk2 is still zombie
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-    assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
-    assert_group_cookie_equals_task_cookie(p, tsk3->pid_str); // tsk3 is back.
-
-    /* now reset tsk2 as well to get it connected back to CGroup. */
-    reset_task_cookie(tsk2);
-    assert_tasks_share(tsk2, tsk3);
-    assert_tasks_share(tsk1, tsk3);
-    assert_tasks_share(tsk1, tsk2);
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-    assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
-    assert_group_cookie_equals_task_cookie(p, tsk3->pid_str);
-
-    /* Test the rest of the cases (2 to 4)
-     *
-     *		t1		joining		t2
-     * CASE 1:
-     * before	0				0
-     * after	new cookie			new cookie
-     *
-     * CASE 2:
-     * before	X (non-zero)			0
-     * after	0				0
-     *
-     * CASE 3:
-     * before	0				X (non-zero)
-     * after	X				X
-     *
-     * CASE 4:
-     * before	Y (non-zero)			X (non-zero)
-     * after	X				X
-     */
-
-    /* case 2: */
-    dprint("case 2");
-    make_tasks_share(tsk1, tsk1);
-    assert_tasks_dont_share(tsk1, tsk2);
-    assert_tasks_dont_share(tsk1, tsk3);
-    assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
-    make_tasks_share(tsk1, tsk2); /* Will reset the task cookie. */
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-
-    /* case 3: */
-    dprint("case 3");
-    assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
-    make_tasks_share(tsk2, tsk2);
-    assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
-    assert_tasks_dont_share(tsk2, tsk1);
-    assert_tasks_dont_share(tsk2, tsk3);
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-    make_tasks_share(tsk1, tsk2);
-    assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
-    assert_tasks_share(tsk1, tsk2);
-    assert_tasks_dont_share(tsk1, tsk3);
-    reset_task_cookie(tsk1);
-    reset_task_cookie(tsk2);
-
-    /* case 4: */
-    dprint("case 4");
-    assert_tasks_share(tsk1, tsk2);
-    assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
-    make_tasks_share(tsk1, tsk1);
-    assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
-    assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
-    make_tasks_share(tsk2, tsk2);
-    assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
-    assert_tasks_dont_share(tsk1, tsk2);
-    make_tasks_share(tsk1, tsk2);
-    assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
-    assert_tasks_share(tsk1, tsk2);
-    assert_tasks_dont_share(tsk1, tsk3);
-    reset_task_cookie(tsk1);
-    reset_task_cookie(tsk2);
-
-    kill_task(tsk1);
-    kill_task(tsk2);
-    kill_task(tsk3);
-    del_group(p);
-    print_pass();
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
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+
+	tsk2 = add_task(p);
+	assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
+
+	tsk3 = add_task(p);
+	assert_group_cookie_equals_task_cookie(p, tsk3->pid_str);
+
+	/* tsk2 share with tsk3 -- both get disconnected from CGroup. */
+	make_tasks_share(tsk2, tsk3);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+	assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
+	assert_group_cookie_not_equals_task_cookie(p, tsk3->pid_str);
+
+	/* now reset tsk3 -- get connected back to CGroup. */
+	reset_task_cookie(tsk3);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);	  // tsk3 is back.
+	assert_tasks_dont_share(tsk1, tsk2); // but tsk2 is still zombie
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+	assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
+	assert_group_cookie_equals_task_cookie(p, tsk3->pid_str); // tsk3 is back.
+
+	/* now reset tsk2 as well to get it connected back to CGroup. */
+	reset_task_cookie(tsk2);
+	assert_tasks_share(tsk2, tsk3);
+	assert_tasks_share(tsk1, tsk3);
+	assert_tasks_share(tsk1, tsk2);
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+	assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
+	assert_group_cookie_equals_task_cookie(p, tsk3->pid_str);
+
+	/* Test the rest of the cases (2 to 4)
+	 *
+	 *		t1		joining		t2
+	 * CASE 1:
+	 * before	0				0
+	 * after	new cookie			new cookie
+	 *
+	 * CASE 2:
+	 * before	X (non-zero)			0
+	 * after	0				0
+	 *
+	 * CASE 3:
+	 * before	0				X (non-zero)
+	 * after	X				X
+	 *
+	 * CASE 4:
+	 * before	Y (non-zero)			X (non-zero)
+	 * after	X				X
+	 */
+
+	/* case 2: */
+	dprint("case 2");
+	make_tasks_share(tsk1, tsk1);
+	assert_tasks_dont_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
+	make_tasks_share(tsk1, tsk2); /* Will reset the task cookie. */
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+
+	/* case 3: */
+	dprint("case 3");
+	assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
+	make_tasks_share(tsk2, tsk2);
+	assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
+	assert_tasks_dont_share(tsk2, tsk1);
+	assert_tasks_dont_share(tsk2, tsk3);
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+	make_tasks_share(tsk1, tsk2);
+	assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
+	assert_tasks_share(tsk1, tsk2);
+	assert_tasks_dont_share(tsk1, tsk3);
+	reset_task_cookie(tsk1);
+	reset_task_cookie(tsk2);
+
+	/* case 4: */
+	dprint("case 4");
+	assert_tasks_share(tsk1, tsk2);
+	assert_group_cookie_equals_task_cookie(p, tsk1->pid_str);
+	make_tasks_share(tsk1, tsk1);
+	assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
+	assert_group_cookie_equals_task_cookie(p, tsk2->pid_str);
+	make_tasks_share(tsk2, tsk2);
+	assert_group_cookie_not_equals_task_cookie(p, tsk2->pid_str);
+	assert_tasks_dont_share(tsk1, tsk2);
+	make_tasks_share(tsk1, tsk2);
+	assert_group_cookie_not_equals_task_cookie(p, tsk1->pid_str);
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
 }
 
 int main() {
-    char *root = make_group(NULL, NULL);
+	char *root = make_group(NULL, NULL);
 
-    test_cgroup_parent_tag_child_inherit(root);
-    test_cgroup_parent_child_tag_inherit(root);
-    test_cgroup_coloring(root);
-    test_prctl_in_group(root);
+	test_cgroup_parent_tag_child_inherit(root);
+	test_cgroup_parent_child_tag_inherit(root);
+	test_cgroup_coloring(root);
+	test_prctl_in_group(root);
 
-    del_root_group(root);
-    return 0;
+	del_root_group(root);
+	return 0;
 }
 
-- 
2.28.0

