Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653581FC1F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 00:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgFPW5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 18:57:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgFPW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:57:21 -0400
Received: from ip-109-41-2-15.web.vodafone.de ([109.41.2.15] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jlKW6-0007cP-FA; Tue, 16 Jun 2020 22:57:18 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jan Stancek <jstancek@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
        kernel test robot <rong.a.chen@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>, lkp@lists.01.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>, ltp@lists.linux.it,
        Serge Hallyn <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/2] tests: test for setns() EINVAL regression
Date:   Wed, 17 Jun 2020 00:56:12 +0200
Message-Id: <20200616225612.4068799-2-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616225612.4068799-1-christian.brauner@ubuntu.com>
References: <https://lore.kernel.org/lkml/20200615213843.2ojgm3ob7kp3qq6a@wittgenstein>
 <20200616225612.4068799-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Verify that setns() reports EINVAL when an fd is passed that refers to an
open file but the file is not a file descriptor useable to interact with
namespaces.

Cc: Jan Stancek <jstancek@redhat.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Link: https://lore.kernel.org/lkml/20200615085836.GR12456@shao2-debian
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 tools/testing/selftests/pidfd/pidfd.h            |  5 +++++
 tools/testing/selftests/pidfd/pidfd_getfd_test.c |  5 -----
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 12 ++++++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index c1921a53dbed..8d728eda783d 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -95,4 +95,9 @@ static inline int sys_pidfd_getfd(int pidfd, int fd, int flags)
 	return syscall(__NR_pidfd_getfd, pidfd, fd, flags);
 }
 
+static inline int sys_memfd_create(const char *name, unsigned int flags)
+{
+	return syscall(__NR_memfd_create, name, flags);
+}
+
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
index 401a7c1d0312..84b65ecccb04 100644
--- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
@@ -34,11 +34,6 @@ static int sys_kcmp(pid_t pid1, pid_t pid2, int type, unsigned long idx1,
 	return syscall(__NR_kcmp, pid1, pid2, type, idx1, idx2);
 }
 
-static int sys_memfd_create(const char *name, unsigned int flags)
-{
-	return syscall(__NR_memfd_create, name, flags);
-}
-
 static int __child(int sk, int memfd)
 {
 	int ret;
diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 133ec5b6cda8..9418108eae13 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -470,4 +470,16 @@ TEST_F(current_nsset, no_foul_play)
 	}
 }
 
+TEST(setns_einval)
+{
+	int fd;
+
+	fd = sys_memfd_create("rostock", 0);
+	EXPECT_GT(fd, 0);
+
+	ASSERT_NE(setns(fd, 0), 0);
+	EXPECT_EQ(errno, EINVAL);
+	close(fd);
+}
+
 TEST_HARNESS_MAIN
-- 
2.27.0

