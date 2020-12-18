Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934692DDF54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732898AbgLRIAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:00:24 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54378 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725897AbgLRIAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:00:24 -0500
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxX8teYdxf_t8BAA--.5208S5;
        Fri, 18 Dec 2020 15:59:30 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
Subject: [PATCH 3/4] perf tools: Update powerpc's syscall.tbl
Date:   Fri, 18 Dec 2020 15:59:23 +0800
Message-Id: <1608278364-6733-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
References: <1608278364-6733-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf9DxX8teYdxf_t8BAA--.5208S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF43Kw4xKw43CF4UGrW8Xrb_yoW5ZFWxpF
        n7C34UJF1rGF10va42k3W8Wa4xGwn5uF1jgw4DKa9xZrnxt3sIk3yIqa98try7Xrs7CrWj
        9F48XrWUKr1FqaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
        8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
        jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4xMxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjpVbDUUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This silences the following tools/perf/ build warning:
Warning: Kernel ABI header at 'tools/perf/arch/powerpc/entry/syscalls/syscall.tbl' differs from latest version at 'arch/powerpc/kernel/syscalls/syscall.tbl'

Just make them same:
cp arch/powerpc/kernel/syscalls/syscall.tbl tools/perf/arch/powerpc/entry/syscalls/syscall.tbl

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl | 25 ++++++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index b168364..1275dae 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -9,7 +9,9 @@
 #
 0	nospu	restart_syscall			sys_restart_syscall
 1	nospu	exit				sys_exit
-2	nospu	fork				ppc_fork
+2	32	fork				ppc_fork			sys_fork
+2	64	fork				sys_fork
+2	spu	fork				sys_ni_syscall
 3	common	read				sys_read
 4	common	write				sys_write
 5	common	open				sys_open			compat_sys_open
@@ -158,7 +160,9 @@
 119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
 119	64	sigreturn			sys_ni_syscall
 119	spu	sigreturn			sys_ni_syscall
-120	nospu	clone				ppc_clone
+120	32	clone				ppc_clone			sys_clone
+120	64	clone				sys_clone
+120	spu	clone				sys_ni_syscall
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	modify_ldt			sys_ni_syscall
@@ -240,7 +244,9 @@
 186	spu	sendfile			sys_sendfile64
 187	common	getpmsg				sys_ni_syscall
 188	common 	putpmsg				sys_ni_syscall
-189	nospu	vfork				ppc_vfork
+189	32	vfork				ppc_vfork			sys_vfork
+189	64	vfork				sys_vfork
+189	spu	vfork				sys_ni_syscall
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	common	readahead			sys_readahead			compat_sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
@@ -316,8 +322,8 @@
 248	32	clock_nanosleep			sys_clock_nanosleep_time32
 248	64	clock_nanosleep			sys_clock_nanosleep
 248	spu	clock_nanosleep			sys_clock_nanosleep
-249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
-249	64	swapcontext			ppc64_swapcontext
+249	32	swapcontext			ppc_swapcontext			compat_sys_swapcontext
+249	64	swapcontext			sys_swapcontext
 249	spu	swapcontext			sys_ni_syscall
 250	common	tgkill				sys_tgkill
 251	32	utimes				sys_utimes_time32
@@ -456,7 +462,7 @@
 361	common	bpf				sys_bpf
 362	nospu	execveat			sys_execveat			compat_sys_execveat
 363	32	switch_endian			sys_ni_syscall
-363	64	switch_endian			ppc_switch_endian
+363	64	switch_endian			sys_switch_endian
 363	spu	switch_endian			sys_ni_syscall
 364	common	userfaultfd			sys_userfaultfd
 365	common	membarrier			sys_membarrier
@@ -516,6 +522,11 @@
 432	common	fsmount				sys_fsmount
 433	common	fspick				sys_fspick
 434	common	pidfd_open			sys_pidfd_open
-435	nospu	clone3				ppc_clone3
+435	32	clone3				ppc_clone3			sys_clone3
+435	64	clone3				sys_clone3
+435	spu	clone3				sys_ni_syscall
+436	common	close_range			sys_close_range
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
-- 
2.1.0

