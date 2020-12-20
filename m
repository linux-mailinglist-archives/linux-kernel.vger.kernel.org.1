Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E912DF4F4
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 10:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgLTJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 04:59:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11222 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727109AbgLTJ7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 04:59:37 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BK9X2R7167077;
        Sun, 20 Dec 2020 04:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=jw/91xp8hHyOptgK34c31yu4XbTBXyVskWj4TFEXipU=;
 b=Ea82lCdBA7TqO4PiZWKF0dd2y6/RYsoxBEtmQCKHwdPqHJiN7lSZWZnOzxwMyh99OI/9
 NpYDU0qvS6dqkaXj+7eb4Bq5quFTJ7++d+36OLv++SlZWH4G/dgQ9ApeKNj/VJhZNATi
 mDq/Kpe84NmpDqXTw+7YbFB9tbL0BTDjcXOP1fHcbYy/bCfi71TZGJXX969k9tH7gptL
 zNiHESe0tC4wMvNwYmsDlHxa3eBb+qmQd/F/nsWNpbjzgFy9BmyfaFUfmi910Vh0s7sl
 dW9aiZcpJC7RUzhpwO4R57omX6kc4nVRStckn4ScT/sNPmW3guCYtOvx6GWBfScauCzg GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35j419ga8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Dec 2020 04:58:37 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BK9Xl1S168258;
        Sun, 20 Dec 2020 04:58:37 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35j419ga8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Dec 2020 04:58:37 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BK9r0cM031716;
        Sun, 20 Dec 2020 09:58:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 35hdgure96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 20 Dec 2020 09:58:35 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BK9wVnL19792182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Dec 2020 09:58:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5686EAE04D;
        Sun, 20 Dec 2020 09:58:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D58A4AE045;
        Sun, 20 Dec 2020 09:58:31 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Dec 2020 09:58:31 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Willem de Bruijn <willemb@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] epoll: fix compat syscall wire up of epoll_pwait2
Date:   Sun, 20 Dec 2020 10:58:30 +0100
Message-Id: <20201220095830.17843-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-20_02:2020-12-19,2020-12-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=661
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012200071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2") wired up
the 64 bit syscall instead of the compat variant in a couple of places.

Cc: Willem de Bruijn <willemb@google.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Fixes: b0a0c2615f6f ("epoll: wire up syscall epoll_pwait2")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/arm64/include/asm/unistd32.h         | 2 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl | 2 +-
 arch/s390/kernel/syscalls/syscall.tbl     | 2 +-
 arch/sparc/kernel/syscalls/syscall.tbl    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index f4bca2b90218..cccfbbefbf95 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -890,7 +890,7 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
 #define __NR_process_madvise 440
 __SYSCALL(__NR_process_madvise, sys_process_madvise)
 #define __NR_epoll_pwait2 441
-__SYSCALL(__NR_epoll_pwait2, sys_epoll_pwait2)
+__SYSCALL(__NR_epoll_pwait2, compat_sys_epoll_pwait2)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index ad9c3dd0ab1f..0f03ad223f33 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -379,4 +379,4 @@
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	faccessat2			sys_faccessat2
 440	n32	process_madvise			sys_process_madvise
-441	n32	epoll_pwait2			sys_epoll_pwait2
+441	n32	epoll_pwait2			compat_sys_epoll_pwait2
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 14f6525886a8..d443423495e5 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -443,4 +443,4 @@
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	faccessat2		sys_faccessat2			sys_faccessat2
 440  common	process_madvise		sys_process_madvise		sys_process_madvise
-441  common	epoll_pwait2		sys_epoll_pwait2		sys_epoll_pwait2
+441  common	epoll_pwait2		sys_epoll_pwait2		compat_sys_epoll_pwait2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index c7da4c3271e6..40d8c7cd8298 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -486,4 +486,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	faccessat2			sys_faccessat2
 440	common	process_madvise			sys_process_madvise
-441	common	epoll_pwait2			sys_epoll_pwait2
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
-- 
2.17.1

