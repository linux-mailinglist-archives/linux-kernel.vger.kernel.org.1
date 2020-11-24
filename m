Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8572C2AFA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389441AbgKXPNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:13:01 -0500
Received: from mga18.intel.com ([134.134.136.126]:55436 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389459AbgKXPM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:12:59 -0500
IronPort-SDR: KyLj+aluDNuuIhDs5OhSxgr34fKdialdOaDvZn4jvHjr4MZqCrXcpYN955VcBY0869olTYAW3k
 EpuQqYv0gccQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="159726645"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="xz'?yaml'?scan'208";a="159726645"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:12:23 -0800
IronPort-SDR: rrb0N8ibAcnMXdUtJlWFkg7TQKKq+zPRc203a4+A961JdWhDsOE3WnZ160kPVi1m+2nxvovy0q
 mEYOYVjMVXaA==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="xz'?yaml'?scan'208";a="546864098"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.140])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 07:12:17 -0800
Date:   Tue, 24 Nov 2020 23:26:34 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com
Subject: [selftests/memfd]  1c49e3783f: kernel-selftests.memfd.make_fail
Message-ID: <20201124152634.GB15586@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Greeting,

FYI, we noticed the following commit (built with gcc-9):

commit: 1c49e3783f8899555190a49024ac86d3d76633cd ("selftests/memfd: Fix imp=
licit declaration warnings")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


in testcase: kernel-selftests
version: kernel-selftests-x86_64-b5a583fb-1_20201015
with following parameters:

	group: group-02
	ucode: 0xe2

test-description: The kernel contains a set of "self tests" under the tools=
/testing/selftests/ directory. These are intended to be small unit tests to=
 exercise individual code paths in the kernel.
test-url: https://www.kernel.org/doc/Documentation/kselftest.txt


on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 32G=
 memory

caused below changes (please refer to attached dmesg/kmsg for entire log/ba=
cktrace):




If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd
2019-02-14 10:12:11 ln -sf /usr/bin/clang
2019-02-14 10:12:11 ln -sf /usr/bin/llc
2019-02-14 10:12:11 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
LKP SKIP media_tests
2019-02-14 10:12:11 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/membarri=
er'
make: Warning: File '../lib.mk' has modification time 55786330 s in the fut=
ure
gcc -g -I../../../../usr/include/    membarrier_test_single_thread.c /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86=
d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/too=
ls/testing/selftests/kselftest.h -lpthread -o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/membarrier/membarrier_test_single_thread
gcc -g -I../../../../usr/include/    membarrier_test_multi_thread.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h -lpthread -o /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/membarrier/membarrier_test_multi_thread
TAP version 13
1..2
# selftests: membarrier: membarrier_test_single_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: membarrier: membarrier_test_single_thread
# selftests: membarrier: membarrier_test_multi_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: membarrier: membarrier_test_multi_thread
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/membarrie=
r'
2019-02-14 10:12:12 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd'
make: Warning: File '../lib.mk' has modification time 55786329 s in the fut=
ure
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest.h common.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd/mem=
fd_test
memfd_test.c: In function =E2=80=98test_seal_future_write=E2=80=99:
memfd_test.c:783:27: error: =E2=80=98F_SEAL_FUTURE_WRITE=E2=80=99 undeclare=
d (first use in this function); did you mean =E2=80=98F_SEAL_WRITE=E2=80=99?
  mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
                           ^~~~~~~~~~~~~~~~~~~
                           F_SEAL_WRITE
memfd_test.c:783:27: note: each undeclared identifier is reported only once=
 for each function it appears in
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd/me=
mfd_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd'
2019-02-14 10:12:12 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memory-h=
otplug'
make: Warning: File '../lib.mk' has modification time 55786328 s in the fut=
ure
TAP version 13
1..1
# selftests: memory-hotplug: mem-on-off-test.sh
# Test scope: 2% hotplug memory
# 	 online all hot-pluggable memory in offline state:
# 		 SKIPPED - no hot-pluggable memory in offline state
# 	 offline 2% hot-pluggable memory in online state
# 	 trying to offline 6 out of 256 memory block(s):
# online->offline memory0
# ./mem-on-off-test.sh: line 78: echo: write error: Invalid argument
# offline_memory_expect_success 0: unexpected fail
# online->offline memory1
# online->offline memory10
# online->offline memory100
# online->offline memory101
# online->offline memory102
# online->offline memory103
# 	 online all hot-pluggable memory in offline state:
# offline->online memory1
# offline->online memory10
# offline->online memory100
# offline->online memory101
# offline->online memory102
# offline->online memory103
# 	 Test with memory notifier error injection
#
not ok 1 selftests: memory-hotplug: mem-on-off-test.sh # TIMEOUT 300 seconds
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memory-ho=
tplug'
2019-02-14 10:17:13 make run_tests -C mincore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mincore'
make: Warning: File '../lib.mk' has modification time 55786028 s in the fut=
ure
gcc -Wall    mincore_selftest.c /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ks=
elftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3=
783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o =
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a490=
24ac86d3d76633cd/tools/testing/selftests/mincore/mincore_selftest
TAP version 13
1..1
# selftests: mincore: mincore_selftest
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           global.basic_interface ...
# #            OK  global.basic_interface
# ok 1 global.basic_interface
# #  RUN           global.check_anonymous_locked_pages ...
# #            OK  global.check_anonymous_locked_pages
# ok 2 global.check_anonymous_locked_pages
# #  RUN           global.check_huge_pages ...
# #      SKIP     No huge pages available.
# #            OK  global.check_huge_pages
# ok 3 # SKIP No huge pages available.
# #  RUN           global.check_file_mmap ...
# # mincore_selftest.c:211:check_file_mmap:Expected -1 (-1) !=3D fd (-1)
# # mincore_selftest.c:213:check_file_mmap:Can't create temporary file: Ope=
ration not supported
# # check_file_mmap: Test terminated by assertion
# #          FAIL  global.check_file_mmap
# not ok 4 global.check_file_mmap
# #  RUN           global.check_tmpfs_mmap ...
# #            OK  global.check_tmpfs_mmap
# ok 5 global.check_tmpfs_mmap
# # FAILED: 4 / 5 tests passed.
# # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:1 error:0
not ok 1 selftests: mincore: mincore_selftest # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mincore'
2019-02-14 10:17:13 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mount'
make: Warning: File '../lib.mk' has modification time 55786028 s in the fut=
ure
gcc -Wall -O2    unprivileged-remount-test.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/mount/unprivileged-re=
mount-test
gcc -Wall -O2    nosymfollow-test.c /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190=
a49024ac86d3d76633cd/tools/testing/selftests/mount/nosymfollow-test
TAP version 13
1..2
# selftests: mount: run_unprivileged_remount.sh
ok 1 selftests: mount: run_unprivileged_remount.sh
# selftests: mount: run_nosymfollow.sh
ok 2 selftests: mount: run_nosymfollow.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mount'
2019-02-14 10:17:14 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue'
make: Warning: File '../lib.mk' has modification time 55786027 s in the fut=
ure
gcc -O2    mq_open_tests.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselfte=
st_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -lrt -lpt=
hread -lpopt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e378=
3f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue/mq_open_tes=
ts
gcc -O2    mq_perf_tests.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselfte=
st_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -lrt -lpt=
hread -lpopt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e378=
3f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue/mq_perf_tes=
ts
TAP version 13
1..2
# selftests: mqueue: mq_open_tests
# Using Default queue path - /test1
#=20
# Initial system state:
# 	Using queue path:		/test1
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
#=20
# Test series 1, behavior when no attr struct passed to mq_open:
# Kernel supports setting defaults separately from maximums:		PASS
# Given sane values, mq_open without an attr struct succeeds:		PASS
# Kernel properly honors default setting knobs:				PASS
# Kernel properly limits default values to lesser of default/max:		PASS
# Kernel properly fails to create queue when defaults would
# exceed rlimit:								PASS
#=20
#=20
# Test series 2, behavior when attr struct is passed to mq_open:
# Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
# Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
# Queue open with total size > 2GB when euid =3D 0 failed:			PASS
# Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
# Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
# Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1 selftests: mqueue: mq_open_tests
# selftests: mqueue: mq_perf_tests
#=20
# Initial system state:
# 	Using queue path:			/mq_perf_tests
# 	RLIMIT_MSGQUEUE(soft):			819200
# 	RLIMIT_MSGQUEUE(hard):			819200
# 	Maximum Message Size:			8192
# 	Maximum Queue Size:			10
# 	Nice value:				0
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):			(unlimited)
# 	RLIMIT_MSGQUEUE(hard):			(unlimited)
# 	Maximum Message Size:			16777216
# 	Maximum Queue Size:			65530
# 	Nice value:				-20
# 	Continuous mode:			(disabled)
# 	CPUs to pin:				3
#=20
# 	Queue /mq_perf_tests created:
# 		mq_flags:			O_NONBLOCK
# 		mq_maxmsg:			65530
# 		mq_msgsize:			16
# 		mq_curmsgs:			0
#=20
# 	Started mqueue performance test thread on CPU 3
# 		Max priorities:			32768
# 		Clock resolution:		1 nsec
#=20
# 	Test #1: Time send/recv message, queue empty
# 		(10000000 iterations)
# 		Send msg:			58.698323494s total time
# 						5869 nsec/msg
# 		Recv msg:			57.170959823s total time
# 						5717 nsec/msg
#=20
# 	Test #2a: Time send/recv message, queue full, constant prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.241087222s
# 		Testing...done.
# 		Send msg:			0.588674308s total time
# 						5886 nsec/msg
# 		Recv msg:			0.532119363s total time
# 						5321 nsec/msg
# 		Draining queue...done.		0.189556062s
#=20
# 	Test #2b: Time send/recv message, queue full, increasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.245054013s
# 		Testing...done.
# 		Send msg:			0.596914314s total time
# 						5969 nsec/msg
# 		Recv msg:			0.557010190s total time
# 						5570 nsec/msg
# 		Draining queue...done.		0.193351889s
#=20
# 	Test #2c: Time send/recv message, queue full, decreasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.241666554s
# 		Testing...done.
# 		Send msg:			0.601334493s total time
# 						6013 nsec/msg
# 		Recv msg:			0.550965430s total time
# 						5509 nsec/msg
# 		Draining queue...done.		0.196532482s
#=20
# 	Test #2d: Time send/recv message, queue full, random prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.248801144s
# 		Testing...done.
# 		Send msg:			0.608562791s total time
# 						6085 nsec/msg
# 		Recv msg:			0.563787583s total time
# 						5637 nsec/msg
# 		Draining queue...done.		0.197478860s
ok 2 selftests: mqueue: mq_perf_tests
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue'
2019-02-14 10:19:42 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/nsfs'
make: Warning: File '../lib.mk' has modification time 55785879 s in the fut=
ure
gcc -Wall -Werror    owner.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kself=
test_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783=
f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kself=
test_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783=
f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/nsfs/pidns
TAP version 13
1..2
# selftests: nsfs: owner
ok 1 selftests: nsfs: owner
# selftests: nsfs: pidns
ok 2 selftests: nsfs: pidns
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/nsfs'
Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=08=08=08=
=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done                =
           =20
Creating filesystem with 102400 1k blocks and 25688 inodes
Filesystem UUID: d3361ae0-97e0-4f43-9047-55526734b28a
Superblock backups stored on blocks:=20
	8193, 24577, 40961, 57345, 73729

Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done      =
                     =20
Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done         =
                  =20
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information:  0/13=08=08=08=
=08=08     =08=08=08=08=08done

2019-02-14 10:19:46 ./openat2_test
TAP version 13
1..114
ok 1 openat2 with normal struct argument [misalign=3D0] succeeds
ok 2 openat2 with normal struct argument [misalign=3D1] succeeds
ok 3 openat2 with normal struct argument [misalign=3D2] succeeds
ok 4 openat2 with normal struct argument [misalign=3D3] succeeds
ok 5 openat2 with normal struct argument [misalign=3D4] succeeds
ok 6 openat2 with normal struct argument [misalign=3D5] succeeds
ok 7 openat2 with normal struct argument [misalign=3D6] succeeds
ok 8 openat2 with normal struct argument [misalign=3D7] succeeds
ok 9 openat2 with normal struct argument [misalign=3D8] succeeds
ok 10 openat2 with normal struct argument [misalign=3D9] succeeds
ok 11 openat2 with normal struct argument [misalign=3D11] succeeds
ok 12 openat2 with normal struct argument [misalign=3D17] succeeds
ok 13 openat2 with normal struct argument [misalign=3D87] succeeds
ok 14 openat2 with bigger struct (zeroed out) argument [misalign=3D0] succe=
eds
ok 15 openat2 with bigger struct (zeroed out) argument [misalign=3D1] succe=
eds
ok 16 openat2 with bigger struct (zeroed out) argument [misalign=3D2] succe=
eds
ok 17 openat2 with bigger struct (zeroed out) argument [misalign=3D3] succe=
eds
ok 18 openat2 with bigger struct (zeroed out) argument [misalign=3D4] succe=
eds
ok 19 openat2 with bigger struct (zeroed out) argument [misalign=3D5] succe=
eds
ok 20 openat2 with bigger struct (zeroed out) argument [misalign=3D6] succe=
eds
ok 21 openat2 with bigger struct (zeroed out) argument [misalign=3D7] succe=
eds
ok 22 openat2 with bigger struct (zeroed out) argument [misalign=3D8] succe=
eds
ok 23 openat2 with bigger struct (zeroed out) argument [misalign=3D9] succe=
eds
ok 24 openat2 with bigger struct (zeroed out) argument [misalign=3D11] succ=
eeds
ok 25 openat2 with bigger struct (zeroed out) argument [misalign=3D17] succ=
eeds
ok 26 openat2 with bigger struct (zeroed out) argument [misalign=3D87] succ=
eeds
ok 27 openat2 with zero-sized 'struct' argument [misalign=3D0] fails with -=
22 (Invalid argument)
ok 28 openat2 with zero-sized 'struct' argument [misalign=3D1] fails with -=
22 (Invalid argument)
ok 29 openat2 with zero-sized 'struct' argument [misalign=3D2] fails with -=
22 (Invalid argument)
ok 30 openat2 with zero-sized 'struct' argument [misalign=3D3] fails with -=
22 (Invalid argument)
ok 31 openat2 with zero-sized 'struct' argument [misalign=3D4] fails with -=
22 (Invalid argument)
ok 32 openat2 with zero-sized 'struct' argument [misalign=3D5] fails with -=
22 (Invalid argument)
ok 33 openat2 with zero-sized 'struct' argument [misalign=3D6] fails with -=
22 (Invalid argument)
ok 34 openat2 with zero-sized 'struct' argument [misalign=3D7] fails with -=
22 (Invalid argument)
ok 35 openat2 with zero-sized 'struct' argument [misalign=3D8] fails with -=
22 (Invalid argument)
ok 36 openat2 with zero-sized 'struct' argument [misalign=3D9] fails with -=
22 (Invalid argument)
ok 37 openat2 with zero-sized 'struct' argument [misalign=3D11] fails with =
-22 (Invalid argument)
ok 38 openat2 with zero-sized 'struct' argument [misalign=3D17] fails with =
-22 (Invalid argument)
ok 39 openat2 with zero-sized 'struct' argument [misalign=3D87] fails with =
-22 (Invalid argument)
ok 40 openat2 with smaller-than-v0 struct argument [misalign=3D0] fails wit=
h -22 (Invalid argument)
ok 41 openat2 with smaller-than-v0 struct argument [misalign=3D1] fails wit=
h -22 (Invalid argument)
ok 42 openat2 with smaller-than-v0 struct argument [misalign=3D2] fails wit=
h -22 (Invalid argument)
ok 43 openat2 with smaller-than-v0 struct argument [misalign=3D3] fails wit=
h -22 (Invalid argument)
ok 44 openat2 with smaller-than-v0 struct argument [misalign=3D4] fails wit=
h -22 (Invalid argument)
ok 45 openat2 with smaller-than-v0 struct argument [misalign=3D5] fails wit=
h -22 (Invalid argument)
ok 46 openat2 with smaller-than-v0 struct argument [misalign=3D6] fails wit=
h -22 (Invalid argument)
ok 47 openat2 with smaller-than-v0 struct argument [misalign=3D7] fails wit=
h -22 (Invalid argument)
ok 48 openat2 with smaller-than-v0 struct argument [misalign=3D8] fails wit=
h -22 (Invalid argument)
ok 49 openat2 with smaller-than-v0 struct argument [misalign=3D9] fails wit=
h -22 (Invalid argument)
ok 50 openat2 with smaller-than-v0 struct argument [misalign=3D11] fails wi=
th -22 (Invalid argument)
ok 51 openat2 with smaller-than-v0 struct argument [misalign=3D17] fails wi=
th -22 (Invalid argument)
ok 52 openat2 with smaller-than-v0 struct argument [misalign=3D87] fails wi=
th -22 (Invalid argument)
ok 53 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D0] fails with -7 (Argument list too long)
ok 54 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D1] fails with -7 (Argument list too long)
ok 55 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D2] fails with -7 (Argument list too long)
ok 56 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D3] fails with -7 (Argument list too long)
ok 57 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D4] fails with -7 (Argument list too long)
ok 58 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D5] fails with -7 (Argument list too long)
ok 59 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D6] fails with -7 (Argument list too long)
ok 60 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D7] fails with -7 (Argument list too long)
ok 61 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D8] fails with -7 (Argument list too long)
ok 62 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D9] fails with -7 (Argument list too long)
ok 63 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D11] fails with -7 (Argument list too long)
ok 64 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D17] fails with -7 (Argument list too long)
ok 65 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D87] fails with -7 (Argument list too long)
ok 66 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D0] fails with -7 (Argument list too long)
ok 67 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D1] fails with -7 (Argument list too long)
ok 68 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D2] fails with -7 (Argument list too long)
ok 69 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D3] fails with -7 (Argument list too long)
ok 70 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D4] fails with -7 (Argument list too long)
ok 71 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D5] fails with -7 (Argument list too long)
ok 72 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D6] fails with -7 (Argument list too long)
ok 73 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D7] fails with -7 (Argument list too long)
ok 74 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D8] fails with -7 (Argument list too long)
ok 75 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D9] fails with -7 (Argument list too long)
ok 76 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D11] fails with -7 (Argument list too long)
ok 77 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D17] fails with -7 (Argument list too long)
ok 78 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D87] fails with -7 (Argument list too long)
ok 79 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D0] fails with -7 (Argument list too long)
ok 80 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D1] fails with -7 (Argument list too long)
ok 81 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D2] fails with -7 (Argument list too long)
ok 82 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D3] fails with -7 (Argument list too long)
ok 83 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D4] fails with -7 (Argument list too long)
ok 84 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D5] fails with -7 (Argument list too long)
ok 85 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D6] fails with -7 (Argument list too long)
ok 86 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D7] fails with -7 (Argument list too long)
ok 87 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D8] fails with -7 (Argument list too long)
ok 88 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D9] fails with -7 (Argument list too long)
ok 89 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D11] fails with -7 (Argument list too long)
ok 90 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D17] fails with -7 (Argument list too long)
ok 91 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D87] fails with -7 (Argument list too long)
ok 92 openat2 with incompatible flags (O_TMPFILE | O_PATH) fails with -22 (=
Invalid argument)
ok 93 openat2 with incompatible flags (O_TMPFILE | O_CREAT) fails with -22 =
(Invalid argument)
ok 94 openat2 with compatible flags (O_PATH | O_CLOEXEC) succeeds
ok 95 openat2 with compatible flags (O_PATH | O_DIRECTORY) succeeds
ok 96 openat2 with compatible flags (O_PATH | O_NOFOLLOW) succeeds
ok 97 openat2 with incompatible flags (O_PATH | O_RDWR) fails with -22 (Inv=
alid argument)
ok 98 openat2 with incompatible flags (O_PATH | O_CREAT) fails with -22 (In=
valid argument)
ok 99 openat2 with incompatible flags (O_PATH | O_EXCL) fails with -22 (Inv=
alid argument)
ok 100 openat2 with incompatible flags (O_PATH | O_NOCTTY) fails with -22 (=
Invalid argument)
ok 101 openat2 with incompatible flags (O_PATH | O_DIRECT) fails with -22 (=
Invalid argument)
ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with -2=
2 (Invalid argument)
ok 103 openat2 with non-zero how.mode and O_RDONLY fails with -22 (Invalid =
argument)
ok 104 openat2 with non-zero how.mode and O_PATH fails with -22 (Invalid ar=
gument)
ok 105 openat2 with valid how.mode and O_CREAT succeeds
ok 106 openat2 with valid how.mode and O_TMPFILE succeeds
ok 107 openat2 with invalid how.mode and O_CREAT fails with -22 (Invalid ar=
gument)
ok 108 openat2 with invalid (very large) how.mode and O_CREAT fails with -2=
2 (Invalid argument)
ok 109 openat2 with invalid how.mode and O_TMPFILE fails with -22 (Invalid =
argument)
ok 110 openat2 with invalid (very large) how.mode and O_TMPFILE fails with =
-22 (Invalid argument)
ok 111 openat2 with invalid how.resolve and O_RDONLY fails with -22 (Invali=
d argument)
ok 112 openat2 with invalid how.resolve and O_CREAT fails with -22 (Invalid=
 argument)
ok 113 openat2 with invalid how.resolve and O_TMPFILE fails with -22 (Inval=
id argument)
ok 114 openat2 with invalid how.resolve and O_PATH fails with -22 (Invalid =
argument)
# Totals: pass:114 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: openat2: openat2_test
2019-02-14 10:19:46 make run_tests -C pid_namespace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pid_name=
space'
make: Warning: File '../lib.mk' has modification time 55785875 s in the fut=
ure
gcc -g -I../../../../usr/include/    regression_enomem.c /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/t=
ools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/s=
elftests/kselftest.h ../pidfd/pidfd.h  -o /usr/src/perf_selftests-x86_64-rh=
el-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/se=
lftests/pid_namespace/regression_enomem
TAP version 13
1..1
# selftests: pid_namespace: regression_enomem
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.regression_enomem ...
# #            OK  global.regression_enomem
# ok 1 global.regression_enomem
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: pid_namespace: regression_enomem
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pid_names=
pace'
2019-02-14 10:19:46 make run_tests -C pidfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd'
make: Warning: File '../lib.mk' has modification time 55785875 s in the fut=
ure
gcc -g -I../../../../usr/include/ -pthread    pidfd_test.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd/p=
idfd_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_fdinfo_test.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
pidfd/pidfd_fdinfo_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_open_test.c /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76=
633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/te=
sting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pi=
dfd/pidfd_open_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_poll_test.c /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76=
633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/te=
sting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pi=
dfd/pidfd_poll_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_wait.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd/p=
idfd_wait
gcc -g -I../../../../usr/include/ -pthread    pidfd_getfd_test.c /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/p=
idfd/pidfd_getfd_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_setns_test.c /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/p=
idfd/pidfd_setns_test
TAP version 13
1..7
# selftests: pidfd: pidfd_test
# TAP version 13
# 1..8
# # Parent: pid: 6410
# # Parent: Waiting for Child (6411) to complete.
# # Time waited for child: 3
# ok 1 pidfd_poll check for premature notification on child thread exec tes=
t: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6422) to complete.
# # Parent: Child process waited for.
# # Time waited for child: 3
# ok 2 pidfd_poll check for premature notification on child thread exec tes=
t: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6436) to complete.
# # Time since child exit: 3
# ok 3 pidfd_poll check for premature notification on non-emptygroup leader=
 exit test: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6448) to complete.
# # Parent: Child process waited for.
# # Time since child exit: 3
# ok 4 pidfd_poll check for premature notification on non-emptygroup leader=
 exit test: Passed
# ok 5 pidfd_send_signal check for support test: pidfd_send_signal() syscal=
l is supported. Tests can be executed
# ok 6 pidfd_send_signal send SIGUSR1 test: Sent signal
# ok 7 pidfd_send_signal signal exited process test: Failed to send signal =
as expected
# ok 8 pidfd_send_signal signal recycled pid test: Failed to signal recycle=
d pid as expected
# # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: pidfd: pidfd_test
# selftests: pidfd: pidfd_fdinfo_test
# TAP version 13
# 1..2
# # New child: 7636, fd: 5
# # New child: 7637, fd: 6
# ok 1 pidfd check for NSpid in fdinfo test: Passed
# # New child: 7638, fd: 5
# ok 2 pidfd check fdinfo for dead process test: Passed
# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: pidfd: pidfd_fdinfo_test
# selftests: pidfd: pidfd_open_test
# 1..3
# ok 1 do not allow invalid pid test: passed
# ok 2 do not allow invalid flag test: passed
# ok 3 open a new pidfd test: passed
# # pidfd 5 refers to process with pid 7650
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: pidfd: pidfd_open_test
# selftests: pidfd: pidfd_poll_test
# # running pidfd poll test for 10000 iterations
# ok 1 pidfd poll test: pass
# # Planned tests !=3D run tests (0 !=3D 1)
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: pidfd: pidfd_poll_test
# selftests: pidfd: pidfd_wait
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.wait_simple ...
# #            OK  global.wait_simple
# ok 1 global.wait_simple
# #  RUN           global.wait_states ...
# #            OK  global.wait_states
# ok 2 global.wait_states
# #  RUN           global.wait_nonblock ...
# #            OK  global.wait_nonblock
# ok 3 global.wait_nonblock
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 5 selftests: pidfd: pidfd_wait
# selftests: pidfd: pidfd_getfd_test
# TAP version 13
# 1..4
# # Starting 4 tests from 2 test cases.
# #  RUN           global.flags_set ...
# #            OK  global.flags_set
# ok 1 global.flags_set
# #  RUN           child.disable_ptrace ...
# #            OK  child.disable_ptrace
# ok 2 child.disable_ptrace
# #  RUN           child.fetch_fd ...
# #            OK  child.fetch_fd
# ok 3 child.fetch_fd
# #  RUN           child.test_unknown_fd ...
# #            OK  child.test_unknown_fd
# ok 4 child.test_unknown_fd
# # PASSED: 4 / 4 tests passed.
# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 6 selftests: pidfd: pidfd_getfd_test
# selftests: pidfd: pidfd_setns_test
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           global.setns_einval ...
# #            OK  global.setns_einval
# ok 1 global.setns_einval
# #  RUN           current_nsset.invalid_flags ...
# # pidfd_setns_test.c:162:invalid_flags:Expected self->child_pid_exited (0=
) > 0 (0)
# #            OK  current_nsset.invalid_flags
# ok 2 current_nsset.invalid_flags
# #  RUN           current_nsset.pidfd_exited_child ...
# # pidfd_setns_test.c:162:pidfd_exited_child:Expected self->child_pid_exit=
ed (0) > 0 (0)
# #            OK  current_nsset.pidfd_exited_child
# ok 3 current_nsset.pidfd_exited_child
# #  RUN           current_nsset.pidfd_incremental_setns ...
# # pidfd_setns_test.c:162:pidfd_incremental_setns:Expected self->child_pid=
_exited (0) > 0 (0)
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to user namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to mnt namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to pid namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to uts namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to ipc namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to net namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to cgroup namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to pid_for_children namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to time namespace of 17740 via pidfd 20
# #            OK  current_nsset.pidfd_incremental_setns
# ok 4 current_nsset.pidfd_incremental_setns
# #  RUN           current_nsset.nsfd_incremental_setns ...
# # pidfd_setns_test.c:162:nsfd_incremental_setns:Expected self->child_pid_=
exited (0) > 0 (0)
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to user namespace of 17745 via nsfd 19
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to mnt namespace of 17745 via nsfd 24
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to pid namespace of 17745 via nsfd 27
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to uts namespace of 17745 via nsfd 30
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to ipc namespace of 17745 via nsfd 33
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to net namespace of 17745 via nsfd 36
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to cgroup namespace of 17745 via nsfd 39
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to pid_for_children namespace of 17745 via nsfd 42
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to time namespace of 17745 via nsfd 45
# #            OK  current_nsset.nsfd_incremental_setns
# ok 5 current_nsset.nsfd_incremental_setns
# #  RUN           current_nsset.pidfd_one_shot_setns ...
# # pidfd_setns_test.c:162:pidfd_one_shot_setns:Expected self->child_pid_ex=
ited (0) > 0 (0)
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding user namespace of 17=
749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding mnt namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding pid namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding uts namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding ipc namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding net namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding cgroup namespace of =
17749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding pid_for_children nam=
espace of 17749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding time namespace of 17=
749 to list of namespaces to attach to
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to user namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to mnt namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to pid namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to uts namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to ipc namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to net namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to cgroup namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to pid_for_children namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to time namespace of 17749
# #            OK  current_nsset.pidfd_one_shot_setns
# ok 6 current_nsset.pidfd_one_shot_setns
# #  RUN           current_nsset.no_foul_play ...
# # pidfd_setns_test.c:162:no_foul_play:Expected self->child_pid_exited (0)=
 > 0 (0)
# # pidfd_setns_test.c:508:no_foul_play:Adding user namespace of 17754 to l=
ist of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding mnt namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding pid namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding uts namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding ipc namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding net namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding cgroup namespace of 17754 to=
 list of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding time namespace of 17754 to l=
ist of namespaces to attach to
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to user namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to user namespace of 17755 via nsfd 22
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to mnt namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to mnt namespace of 17755 via nsfd 25
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to pid namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to pid namespace of 17755 via nsfd 28
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to uts namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to uts namespace of 17755 via nsfd 31
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to ipc namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to ipc namespace of 17755 via nsfd 34
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to net namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to net namespace of 17755 via nsfd 37
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to cgroup namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to cgroup namespace of 17755 via nsfd 40
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to time namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to time namespace of 17755 via nsfd 46
# #            OK  current_nsset.no_foul_play
# ok 7 current_nsset.no_foul_play
# # PASSED: 7 / 7 tests passed.
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 7 selftests: pidfd: pidfd_setns_test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd'
LKP SKIP powerpc
prctl test: not in Makefile
2019-02-14 10:20:32 make TARGETS=3Dprctl
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748967 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748966 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
66 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
66 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
966 s in the future
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574896=
6 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
64 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  UPD     include/generated/uapi/linux/version.h
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748961=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
941 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make[1]: Warning: File '../lib.mk' has modification time 55785802 s in the =
future
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:21:00 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make: Warning: File '../lib.mk' has modification time 55785801 s in the fut=
ure
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
TAP version 13
1..3
# selftests: prctl: disable-tsc-ctxt-sw-stress-test
# [No further output means we're allright]
ok 1 selftests: prctl: disable-tsc-ctxt-sw-stress-test
# selftests: prctl: disable-tsc-on-off-stress-test
# [No further output means we're allright]
ok 2 selftests: prctl: disable-tsc-on-off-stress-test
# selftests: prctl: disable-tsc-test
# rdtsc() =3D=3D 6559452189861
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
# rdtsc() =3D=3D 6559452521539
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 6559452533458
# prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
# rdtsc() =3D=3D [ SIG_SEGV ]
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 6559452596615
ok 3 selftests: prctl: disable-tsc-test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
2019-02-14 10:21:21 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc'
make: Warning: File '../lib.mk' has modification time 55785780 s in the fut=
ure
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86=
d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/too=
ls/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.=
6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftes=
ts/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c /usr=
/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac=
86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/t=
ools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-=
7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selft=
ests/proc/proc-loadavg-001
proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-pid-vm.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
proc/proc-pid-vm
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/=
tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-self-syscall
proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-uptime-002
proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc/re=
ad
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc/se=
lf
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    setns-dcache.c /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3=
d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftest=
s-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools=
/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests=
/proc/setns-dcache
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    setns-sysvipc.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/proc/setns-sysvipc
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
proc/thread-self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-multiple-procfs.c =
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a490=
24ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_=
selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633=
cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/s=
elftests/proc/proc-multiple-procfs
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-fsconfig-hidepid.c=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49=
024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/proc/proc-fsconfig-hidepid
TAP version 13
1..18
# selftests: proc: fd-001-lookup
ok 1 selftests: proc: fd-001-lookup
# selftests: proc: fd-002-posix-eq
ok 2 selftests: proc: fd-002-posix-eq
# selftests: proc: fd-003-kthread
ok 3 selftests: proc: fd-003-kthread
# selftests: proc: proc-loadavg-001
ok 4 selftests: proc: proc-loadavg-001
# selftests: proc: proc-pid-vm
ok 5 selftests: proc: proc-pid-vm
# selftests: proc: proc-self-map-files-001
ok 6 selftests: proc: proc-self-map-files-001
# selftests: proc: proc-self-map-files-002
ok 7 selftests: proc: proc-self-map-files-002
# selftests: proc: proc-self-syscall
ok 8 selftests: proc: proc-self-syscall
# selftests: proc: proc-self-wchan
ok 9 selftests: proc: proc-self-wchan
# selftests: proc: proc-uptime-001
ok 10 selftests: proc: proc-uptime-001
# selftests: proc: proc-uptime-002
ok 11 selftests: proc: proc-uptime-002
# selftests: proc: read
ok 12 selftests: proc: read
# selftests: proc: self
ok 13 selftests: proc: self
# selftests: proc: setns-dcache
ok 14 selftests: proc: setns-dcache
# selftests: proc: setns-sysvipc
ok 15 selftests: proc: setns-sysvipc
# selftests: proc: thread-self
ok 16 selftests: proc: thread-self
# selftests: proc: proc-multiple-procfs
ok 17 selftests: proc: proc-multiple-procfs
# selftests: proc: proc-fsconfig-hidepid
ok 18 selftests: proc: proc-fsconfig-hidepid
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc'
2019-02-14 10:21:29 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pstore'
make: Warning: File '../lib.mk' has modification time 55785772 s in the fut=
ure
TAP version 13
1..2
# selftests: pstore: pstore_tests
# =3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
# UUID=3Dd182fe0d-5afe-42bd-b40e-b550ccbe2770
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-2020112=
1-5143-23xpiy-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.6-kselftests bra=
nch=3Dlinux-next/master commit=3D1c49e3783f8899555190a49024ac86d3d76633cd B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f889955519=
0a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88 erst_disable m=
ax_uptime=3D3600 RESULT_ROOT=3D/result/kernel-selftests/group-02-ucode=3D0x=
e2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/g=
cc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3 LKP_SERVER=3Dinternal-lkp-s=
erver nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.=
rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 =
softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 pro=
mpt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_logleve=
l console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dno=
rmal rw
# Checking pstore console is registered ... ok
# Checking /dev/pmsg0 exists ... ok
# Writing unique string to /dev/pmsg0 ... ok
ok 1 selftests: pstore: pstore_tests
# selftests: pstore: pstore_post_reboot_tests
# =3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
# UUID=3Dfbfd8a85-805d-4dd2-965c-22b42e588707
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-2020112=
1-5143-23xpiy-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.6-kselftests bra=
nch=3Dlinux-next/master commit=3D1c49e3783f8899555190a49024ac86d3d76633cd B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f889955519=
0a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88 erst_disable m=
ax_uptime=3D3600 RESULT_ROOT=3D/result/kernel-selftests/group-02-ucode=3D0x=
e2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/g=
cc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3 LKP_SERVER=3Dinternal-lkp-s=
erver nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.=
rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 =
softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 pro=
mpt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_logleve=
l console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dno=
rmal rw
# pstore_crash_test has not been executed yet. we skip further tests.
ok 2 selftests: pstore: pstore_post_reboot_tests # SKIP
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pstore'
ptp test: not in Makefile
2019-02-14 10:21:29 make TARGETS=3Dptp
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748910 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748909 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
08 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
08 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
908 s in the future
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574890=
8 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
06 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748904=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
883 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make[1]: Warning: File '../lib.mk' has modification time 55785744 s in the =
future
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:21:57 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make: Warning: File '../lib.mk' has modification time 55785744 s in the fut=
ure
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
TAP version 13
1..1
# selftests: ptp: testptp
ok 1 selftests: ptp: testptp
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
2019-02-14 10:21:58 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptrace'
make: Warning: File '../lib.mk' has modification time 55785743 s in the fut=
ure
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    get_syscal=
l_info.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f88995=
55190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/ptrace/get_syscall_info
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    peeksiginf=
o.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190=
a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_=
64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testi=
ng/selftests/ptrace/peeksiginfo
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    vmaccess.c=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49=
024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/ptrace/vmaccess
TAP version 13
1..3
# selftests: ptrace: get_syscall_info
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.get_syscall_info ...
# #            OK  global.get_syscall_info
# ok 1 global.get_syscall_info
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info
# selftests: ptrace: peeksiginfo
# PASS
ok 2 selftests: ptrace: peeksiginfo
# selftests: ptrace: vmaccess
# TAP version 13
# 1..2
# # Starting 2 tests from 1 test cases.
# #  RUN           global.vmaccess ...
# #            OK  global.vmaccess
# ok 1 global.vmaccess
# #  RUN           global.attach ...
# # attach: Test terminated by timeout
# #          FAIL  global.attach
# not ok 2 global.attach
# # FAILED: 1 / 2 tests passed.
# # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 3 selftests: ptrace: vmaccess # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptrace'
2019-02-14 10:22:32 make run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc'
make: Warning: File '../lib.mk' has modification time 55785709 s in the fut=
ure
gcc -O3 -Wl,-no-as-needed -Wall    rtctest.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h -lrt -lpthread -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc=
/rtctest
gcc -O3 -Wl,-no-as-needed -Wall    setdate.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h -lrt -lpthread -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc=
/setdate
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:49:date_read:Current RTC date/time is 06/12/2017 20:30:07.
# #            OK  rtc.date_read
# ok 1 rtc.date_read
# #  RUN           rtc.uie_read ...
# #            OK  rtc.uie_read
# ok 2 rtc.uie_read
# #  RUN           rtc.uie_select ...
# #            OK  rtc.uie_select
# ok 3 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:137:alarm_alm_set:Alarm time now set to 20:30:16.
# # rtctest.c:156:alarm_alm_set:data: 1a0
# #            OK  rtc.alarm_alm_set
# ok 4 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:195:alarm_wkalm_set:Alarm time now set to 06/12/2017 20:30:19.
# #            OK  rtc.alarm_wkalm_set
# ok 5 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:239:alarm_alm_set_minute:Alarm time now set to 20:31:00.
# # rtctest.c:258:alarm_alm_set_minute:data: 1a0
# #            OK  rtc.alarm_alm_set_minute
# ok 6 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:297:alarm_wkalm_set_minute:Alarm time now set to 06/12/2017 2=
0:32:00.
#
not ok 1 selftests: rtc: rtctest # TIMEOUT 90 seconds
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc'
safesetid test: not in Makefile
2019-02-14 10:24:25 make TARGETS=3Dsafesetid
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748734 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748733 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
33 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
33 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
733 s in the future
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574873=
3 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
31 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748728=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
708 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safes=
etid'
make[1]: Warning: File '../lib.mk' has modification time 55785568 s in the =
future
gcc -Wall -O2    safesetid-test.c /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49=
e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/safesetid/safesetid-test
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safese=
tid'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:24:53 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safeseti=
d'
make: Warning: File '../lib.mk' has modification time 55785568 s in the fut=
ure
gcc -Wall -O2    safesetid-test.c /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49=
e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/safesetid/safesetid-test
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safesetid'
2019-02-14 10:24:53 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp'
make: Warning: File '../lib.mk' has modification time 55785568 s in the fut=
ure
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp/secc=
omp_bpf
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633c=
d/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccom=
p/seccomp_benchmark
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4026:user_notification_addfd:Expected fd (7) =3D=3D 5 (5)
# # seccomp_bpf.c:4033:user_notification_addfd:Expected fd (8) =3D=3D 6 (6)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 86 / 87 tests passed.
# # Totals: pass:86 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=3D1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable =3D 1
# net.core.bpf_jit_harden =3D 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17951400 syscalls...
# 15.027407091 - 1.003599836 =3D 14023807255 (14.0s)
# getpid native: 781 ns
# 30.046056566 - 15.027625635 =3D 15018430931 (15.0s)
# getpid RET_ALLOW 1 filter: 836 ns
# 45.677750291 - 30.046270984 =3D 15631479307 (15.6s)
# getpid RET_ALLOW 2 filters: 870 ns
# Estimated total seccomp overhead for 1 filter: 55 ns
# Estimated total seccomp overhead for 2 filters: 89 ns
# Estimated seccomp per-filter overhead: 34 ns
# Estimated seccomp entry overhead: 21 ns
ok 2 selftests: seccomp: seccomp_benchmark
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp'
2019-02-14 10:25:42 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sigaltst=
ack'
make: Warning: File '../lib.mk' has modification time 55785519 s in the fut=
ure
gcc -Wall    sas.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e=
3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harne=
ss.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/sigaltstack/sas
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sigaltsta=
ck'
2019-02-14 10:25:42 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size'
make: Warning: File '../lib.mk' has modification time 55785519 s in the fut=
ure
gcc -static -ffreestanding -nostartfiles -s    get_size.c /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/=
tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size/get=
_size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32350720
#  Free:   27979088
#  Buffer: 0
#  In use: 4371632
#  ...
# 1..1
ok 1 selftests: size: get_size
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size'
2019-02-14 10:25:43 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sparc64'
make: Warning: File 'Makefile' has modification time 55748657 s in the futu=
re
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sparc64'
2019-02-14 10:25:43 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/splice'
make: Warning: File '../lib.mk' has modification time 55785518 s in the fut=
ure
gcc     default_file_splice_read.c /usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests=
/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c4=
9e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  =
-o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a=
49024ac86d3d76633cd/tools/testing/selftests/splice/default_file_splice_read
gcc     splice_read.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_ha=
rness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955=
5190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/splice/splice_read
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/13419/limits 4096
# splice: Invalid argument
# FAIL: /proc/13419/limits 2
# splice: Invalid argument
# FAIL: /proc/13419/comm 4096
# splice: Invalid argument
# FAIL: /proc/13419/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# splice: Invalid argument
# FAIL: /sys/module/test_module/coresize 4096
# splice: Invalid argument
# FAIL: /sys/module/test_module/coresize 2
# splice: Invalid argument
# FAIL: /sys/module/test_module/sections/.init.text 4096
# splice: Invalid argument
# FAIL: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/splice'
2019-02-14 10:25:43 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/static_k=
eys'
make: Warning: File '../lib.mk' has modification time 55785518 s in the fut=
ure
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/static_ke=
ys'
LKP WARN miss config CONFIG_SYNC=3D of sync/config
2019-02-14 10:25:44 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync'
make: Warning: File '../lib.mk' has modification time 55785517 s in the fut=
ure
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_a=
lloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_f=
ence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_m=
erge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_wa=
it.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/sync/sync_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/s=
ync/sync_stress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync=
/sync_stress_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_te=
st.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e37=
83f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync.o -O2 -=
g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_test /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d766=
33cd/tools/testing/selftests/sync/sync_test.o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/sync/sync.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-=
1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_=
alloc.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955=
5190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_fence.o /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3=
d76633cd/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
sync/sync_stress_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/syn=
c/sync_stress_consumer.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync=
_stress_merge.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../us=
r/include/ -pthread
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync'
2019-02-14 10:25:47 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sysctl'
make: Warning: File '../lib.mk' has modification time 55785514 s in the fut=
ure
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0001 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
01 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0002 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string=
_0001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0003 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
02 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0004 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0=
001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Thu Feb 14 10:25:50 UTC 2019
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Thu Feb 14 10:25:51 UTC 2019
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Thu Feb 14 10:25:53 UTC 2019
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Thu Feb 14 10:25:54 UTC 2019
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Thu Feb 14 10:25:54 UTC 2019
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Thu Feb 14 10:25:55 UTC 2019
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Thu Feb 14 10:25:55 UTC 2019
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Thu Feb 14 10:25:56 UTC 2019
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Thu Feb 14 10:25:56 UTC 2019
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Thu Feb 14 10:25:57 UTC 2019
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Thu Feb 14 10:25:59 UTC 2019
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Thu Feb 14 10:25:59 UTC 2019
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Thu Feb 14 10:26:00 UTC 2019
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Thu Feb 14 10:26:02 UTC 2019
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Thu Feb 14 10:26:02 UTC 2019
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Thu Feb 14 10:26:03 UTC 2019
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Thu Feb 14 10:26:03 UTC 2019
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Thu Feb 14 10:26:04 UTC 2019
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Thu Feb 14 10:26:04 UTC 2019
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Thu Feb 14 10:26:05 UTC 2019
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Thu Feb 14 10:26:07 UTC 2019
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Thu Feb 14 10:26:07 UTC 2019
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Thu Feb 14 10:26:09 UTC 2019
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Thu Feb 14 10:26:09 UTC 2019
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Thu Feb 14 10:26:10 UTC 2019
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Thu Feb 14 10:26:12 UTC 2019
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Thu Feb 14 10:26:13 UTC 2019
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Thu Feb 14 10:26:15 UTC 2019
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...FAIL
# Checking if /proc/cmdline contains setting of the expected parameter ...
# Skipping test, expected kernel parameter missing.
# To perform this test, make sure kernel is booted with parameter: sysctl.d=
ebug.test_sysctl.boot_int=3D1
ok 1 selftests: sysctl: sysctl.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sysctl'



To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml



Thanks,
Oliver Sang


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.10.0-rc1-00011-g1c49e3783f88"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.10.0-rc1 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="gcc-9 (Debian 9.3.0-15) 9.3.0"
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90300
CONFIG_LD_VERSION=235000000
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
# CONFIG_WATCH_QUEUE is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_GENERIC_IRQ_INJECTION=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_IRQ_MSI_IOMMU=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_PREEMPTION=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_TASKS_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
# CONFIG_CGROUP_RDMA is not set
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_RD_ZSTD=y
# CONFIG_BOOT_CONFIG is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_HAVE_ARCH_USERFAULTFD_WP=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
# CONFIG_BPF_LSM is not set
CONFIG_BPF_SYSCALL=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
# CONFIG_BPF_PRELOAD is not set
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NUMA_EMU=y
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_UMIP=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_HIBERNATION_SNAPSHOT_DEV=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
# CONFIG_ACPI_APEI_ERST_DEBUG is not set
# CONFIG_ACPI_DPTF is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y
CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_KVM_XFER_TO_GUEST_WORK=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=y
# CONFIG_KVM_WERROR is not set
CONFIG_KVM_INTEL=y
# CONFIG_KVM_AMD is not set
CONFIG_KVM_MMU_AUDIT=y
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_GENERIC_ENTRY=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_CGROUP_RWSTAT=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
# CONFIG_BLK_DEV_ZONED is not set
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_NUMA_KEEP_MEMINFO=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_PAGE_REPORTING=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=y
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
# CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
CONFIG_ZSWAP_COMPRESSOR_DEFAULT="lzo"
CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=y
# CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
# CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
CONFIG_ZSWAP_ZPOOL_DEFAULT="zbud"
# CONFIG_ZSWAP_DEFAULT_ON is not set
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_ZSMALLOC_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
CONFIG_HMM_MIRROR=y
CONFIG_DEVICE_PRIVATE=y
CONFIG_VMAP_PFN=y
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
CONFIG_GUP_BENCHMARK=y
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
CONFIG_MAPPING_DIRTY_HELPERS=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_NET_REDIRECT=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
CONFIG_TLS=m
# CONFIG_TLS_DEVICE is not set
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_USER_COMPAT is not set
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_AH=m
CONFIG_XFRM_ESP=m
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
CONFIG_XDP_SOCKETS=y
# CONFIG_XDP_SOCKETS_DIAG is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE_DEMUX=y
CONFIG_NET_IP_TUNNEL=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=y
CONFIG_NET_FOU=y
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
# CONFIG_INET_ESPINTCP is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
# CONFIG_INET6_ESPINTCP is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=y
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=y
CONFIG_IPV6_GRE=y
CONFIG_IPV6_FOU=y
CONFIG_IPV6_FOU_TUNNEL=y
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
# CONFIG_IPV6_RPL_LWTUNNEL is not set
CONFIG_NETLABEL=y
CONFIG_MPTCP=y
CONFIG_INET_MPTCP_DIAG=m
CONFIG_MPTCP_IPV6=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
CONFIG_NF_TABLES_INET=y
CONFIG_NF_TABLES_NETDEV=y
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_FLOW_OFFLOAD=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
CONFIG_NFT_NAT=m
# CONFIG_NFT_TUNNEL is not set
CONFIG_NFT_OBJREF=m
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_REJECT_INET=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_DUP_NETDEV is not set
# CONFIG_NFT_DUP_NETDEV is not set
# CONFIG_NFT_FWD_NETDEV is not set
CONFIG_NF_FLOW_TABLE_INET=m
CONFIG_NF_FLOW_TABLE=m
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
CONFIG_NF_TABLES_IPV4=y
CONFIG_NFT_REJECT_IPV4=m
# CONFIG_NFT_DUP_IPV4 is not set
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_FLOW_TABLE_IPV4=m
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
CONFIG_NF_TABLES_IPV6=y
CONFIG_NFT_REJECT_IPV6=m
# CONFIG_NFT_DUP_IPV6 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_NF_FLOW_TABLE_IPV6=m
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=y
CONFIG_GARP=y
CONFIG_MRP=y
CONFIG_BRIDGE=y
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
# CONFIG_BRIDGE_MRP is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=y
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=y
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
CONFIG_NET_SCH_ETF=m
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=y
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=y
CONFIG_NET_SCH_PLUG=m
CONFIG_NET_SCH_ETS=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
CONFIG_NET_EMATCH_CANID=m
CONFIG_NET_EMATCH_IPSET=m
CONFIG_NET_EMATCH_IPT=m
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
CONFIG_NET_ACT_MPLS=m
CONFIG_NET_ACT_VLAN=m
CONFIG_NET_ACT_BPF=m
CONFIG_NET_ACT_CONNMARK=m
CONFIG_NET_ACT_CTINFO=m
CONFIG_NET_ACT_SKBMOD=m
CONFIG_NET_ACT_IFE=m
CONFIG_NET_ACT_TUNNEL_KEY=m
CONFIG_NET_ACT_CT=m
# CONFIG_NET_ACT_GATE is not set
CONFIG_NET_IFE_SKBMARK=m
CONFIG_NET_IFE_SKBPRIO=m
CONFIG_NET_IFE_SKBTCINDEX=m
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VSOCKETS_LOOPBACK=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=m
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set
# CONFIG_CAN_ISOTP is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# CONFIG_CAN_MCP251XFD is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_MSFTEXT is not set
CONFIG_BT_DEBUGFS=y
# CONFIG_BT_SELFTEST is not set

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
# CONFIG_MAC80211_MESH is not set
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=m
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
CONFIG_NET_IFE=m
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#
CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
CONFIG_FW_CACHE=y
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_SPI=m
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# CONFIG_MHI_BUS is not set
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# ECC engine support
#
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
CONFIG_ZRAM=m
# CONFIG_ZRAM_WRITEBACK is not set
# CONFIG_ZRAM_MEMORY_TRACKING is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=m
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
# CONFIG_NVME_MULTIPATH is not set
# CONFIG_NVME_HWMON is not set
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
# CONFIG_NVME_TARGET_PASSTHRU is not set
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_VIRTIO is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#
# CONFIG_INTEL_MIC_BUS is not set
# CONFIG_SCIF_BUS is not set
# CONFIG_VOP_BUS is not set
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# CONFIG_UACCE is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
CONFIG_SCSI_LPFC=m
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_SATA_HOST=y
CONFIG_PATA_TIMINGS=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_FORCE=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
# CONFIG_MD_MULTIPATH is not set
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
# CONFIG_DM_EBS is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=y
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=y
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=y
CONFIG_GENEVE=y
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=y
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
# CONFIG_AMD8111_ETH is not set
# CONFIG_PCNET32 is not set
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
# CONFIG_TIGON3 is not set
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_CHELSIO_INLINE_CRYPTO=y
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_PRESTERA is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_PHYLINK=m
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set
CONFIG_FIXED_PHY=y
# CONFIG_SFP is not set

#
# MII PHY device drivers
#
CONFIG_AMD_PHY=m
# CONFIG_ADIN_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_BROADCOM_PHY=m
# CONFIG_BCM54140_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM84881_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
CONFIG_ICPLUS_PHY=m
CONFIG_LXT_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_DP83869_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
CONFIG_MDIO_DEVRES=y
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MVUSB is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set

#
# MDIO Multiplexers
#

#
# PCS device drivers
#
# CONFIG_PCS_XPCS is not set
# end of PCS device drivers

# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
# CONFIG_USB_USBNET is not set
CONFIG_USB_HSO=m
# CONFIG_USB_IPHETH is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
# CONFIG_ATH11K is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
# CONFIG_MT7663U is not set
# CONFIG_MT7663S is not set
# CONFIG_MT7915E is not set
CONFIG_WLAN_VENDOR_MICROCHIP=y
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=y
CONFIG_CAPI_TRACE=y
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_IQS269A is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F3A is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_LDISC_AUTOLOAD=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
CONFIG_NOZOMI=m
# CONFIG_NULL_TTY is not set
# CONFIG_TRACE_SINK is not set
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=m
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
# CONFIG_HW_RANDOM_BA431 is not set
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
# CONFIG_HW_RANDOM_XIPHERA is not set
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set
CONFIG_NVRAM=y
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_DEVPORT=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_LANTIQ_SSC is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_AMD is not set

#
# SPI Multiplexer support
#
# CONFIG_SPI_MUX is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
CONFIG_SPI_DYNAMIC=y
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
# CONFIG_PTP_1588_CLOCK_INES is not set
CONFIG_PTP_1588_CLOCK_KVM=m
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
CONFIG_PINCTRL_INTEL=y
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
# CONFIG_PINCTRL_EMMITSBURG is not set
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
# CONFIG_PINCTRL_TIGERLAKE is not set

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
CONFIG_GPIO_CDEV_V1=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCA9570 is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

# CONFIG_GPIO_AGGREGATOR is not set
CONFIG_GPIO_MOCKUP=m
# CONFIG_W1 is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_CW2015 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ2515X is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_BQ25980 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_CHARGER_BD99954 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
# CONFIG_SENSORS_AMD_ENERGY is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
# CONFIG_SENSORS_CORSAIR_CPRO is not set
# CONFIG_SENSORS_DRIVETEMP is not set
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2947_I2C is not set
# CONFIG_SENSORS_LTC2947_SPI is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX31730 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_MR75203 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
# CONFIG_SENSORS_ADM1266 is not set
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_BEL_PFE is not set
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX16601 is not set
# CONFIG_SENSORS_MAX20730 is not set
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_MP2975 is not set
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
# CONFIG_SENSORS_XDPE122 is not set
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_MP2629 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_INTEL_PMC_BXT is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6360 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SL28CPLD is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# CONFIG_MFD_INTEL_M10_BMC is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
# CONFIG_IR_TOY is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_SUPPORT=m
# CONFIG_MEDIA_SUPPORT_FILTER is not set
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y

#
# Media device types
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
CONFIG_MEDIA_SDR_SUPPORT=y
CONFIG_MEDIA_PLATFORM_SUPPORT=y
CONFIG_MEDIA_TEST_SUPPORT=y
# end of Media device types

#
# Media core support
#
CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y
CONFIG_DVB_CORE=m
# end of Media core support

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
# end of Video4Linux options

#
# Media controller options
#
CONFIG_MEDIA_CONTROLLER_DVB=y
# end of Media controller options

#
# Digital TV options
#
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set
# end of Digital TV options

#
# Media drivers
#
CONFIG_TTPCI_EEPROM=m
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m

#
# Software defined radio USB devices
#
# CONFIG_USB_AIRSPY is not set
# CONFIG_USB_HACKRF is not set
# CONFIG_USB_MSI2500 is not set
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_VIDEO_IPU3_CIO2 is not set
# CONFIG_VIDEO_PCI_SKELETON is not set
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set
# CONFIG_SDR_PLATFORM_DRIVERS is not set

#
# MMC/SDIO DVB adapters
#
CONFIG_SMS_SDIO_DRV=m
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_TEST_DRIVERS is not set

#
# FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y

#
# IR I2C driver auto-selected by 'Autoselect ancillary drivers'
#
CONFIG_VIDEO_IR_I2C=m

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TDA1997X is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m
# end of RDS decoders

#
# Video decoders
#
# CONFIG_VIDEO_ADV7180 is not set
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_ADV7604 is not set
# CONFIG_VIDEO_ADV7842 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TC358743 is not set
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m
# end of Video decoders

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_ADV7511 is not set
# CONFIG_VIDEO_AD9389B is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m
# end of Video improvement chips

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# CONFIG_SDR_MAX2175 is not set
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# CONFIG_VIDEO_ST_MIPID02 is not set
# end of Miscellaneous helper chips

#
# Camera sensor devices
#
# CONFIG_VIDEO_HI556 is not set
# CONFIG_VIDEO_IMX214 is not set
# CONFIG_VIDEO_IMX219 is not set
# CONFIG_VIDEO_IMX258 is not set
# CONFIG_VIDEO_IMX274 is not set
# CONFIG_VIDEO_IMX290 is not set
# CONFIG_VIDEO_IMX319 is not set
# CONFIG_VIDEO_IMX355 is not set
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV2740 is not set
# CONFIG_VIDEO_OV5647 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5670 is not set
# CONFIG_VIDEO_OV5675 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV7251 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV8856 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_OV9650 is not set
# CONFIG_VIDEO_OV13858 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M001 is not set
# CONFIG_VIDEO_MT9M032 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9P031 is not set
# CONFIG_VIDEO_MT9T001 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V032 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_NOON010PC30 is not set
# CONFIG_VIDEO_M5MOLS is not set
# CONFIG_VIDEO_RDACM20 is not set
# CONFIG_VIDEO_RJ54N1 is not set
# CONFIG_VIDEO_S5K6AA is not set
# CONFIG_VIDEO_S5K6A3 is not set
# CONFIG_VIDEO_S5K4ECGX is not set
# CONFIG_VIDEO_S5K5BAF is not set
# CONFIG_VIDEO_SMIAPP is not set
# CONFIG_VIDEO_ET8EK8 is not set
# CONFIG_VIDEO_S5C73M3 is not set
# end of Camera sensor devices

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set
# CONFIG_VIDEO_AK7375 is not set
# CONFIG_VIDEO_DW9714 is not set
# CONFIG_VIDEO_DW9768 is not set
# CONFIG_VIDEO_DW9807_VCM is not set
# end of Lens drivers

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set
# end of Flash devices

#
# SPI helper chips
#
# CONFIG_VIDEO_GS1662 is not set
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_RTL2832_SDR=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set
# end of Customise DVB Frontends

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Media ancillary drivers

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
# CONFIG_DRM_DEBUG_MM is not set
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_TTM_DMA_PAGE_POOL=y
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_TTM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set
# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_FENCE_TIMEOUT=10000
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
CONFIG_DRM_I915_STOP_TIMEOUT=100
CONFIG_DRM_I915_TIMESLICE_DURATION=1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=y
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_CIRRUS_QEMU=m
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_ILI9486 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_EXPORT_FOR_TESTS=y
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_KTD253 is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_QCOM_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_GENERIC_LEDS=y
CONFIG_SND_HDA_INTEL=m
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=y
CONFIG_SND_INTEL_DSP_CONFIG=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
# CONFIG_SND_SOC_INTEL_CATPT is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_ADAU7118_HW is not set
# CONFIG_SND_SOC_ADAU7118_I2C is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4234 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373_I2C is not set
CONFIG_SND_SOC_MAX98390=m
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS2562 is not set
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TLV320ADCX140 is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZL38060 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_MT6660 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_VIVALDI is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# CONFIG_HID_MCP2221 is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_FEW_INIT_RETRIES is not set
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_PRODUCTLIST is not set
# CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PCI_RENESAS is not set
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
# CONFIG_APPLE_MFI_FASTCHARGE is not set
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set
# CONFIG_TYPEC_STUSB160X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_CLASS_MULTICOLOR is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
# CONFIG_LEDS_LP50XX is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV3032 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
# CONFIG_INTEL_IDXD is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_PLX_DMA is not set
# CONFIG_XILINX_ZYNQMP_DPDMA is not set
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y
# CONFIG_SF_PDMA is not set

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=y
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=m
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=m
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=m
CONFIG_VIRTIO_MEM=m
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set
CONFIG_VIRTIO_DMA_SHARED_BUFFER=m
# CONFIG_VDPA is not set
CONFIG_VHOST_IOTLB=m
CONFIG_VHOST=m
CONFIG_VHOST_MENU=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# CONFIG_XEN_UNPOPULATED_ALLOC is not set
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_FB_TFT is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set
CONFIG_QLGE=m
# CONFIG_WFX is not set
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
# CONFIG_ALIENWARE_WMI is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
CONFIG_INTEL_WMI_THUNDERBOLT=m
CONFIG_MXM_WMI=m
# CONFIG_PEAQ_WMI is not set
# CONFIG_XIAOMI_WMI is not set
CONFIG_ACERHDF=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACER_WMI=m
CONFIG_APPLE_GMUX=m
CONFIG_ASUS_LAPTOP=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_LAPTOP=m
CONFIG_EEEPC_WMI=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_DELL_SMO8800=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_AMILO_RFKILL=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_IBM_RTL is not set
CONFIG_IDEAPAD_LAPTOP=m
CONFIG_SENSORS_HDAPS=m
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
# CONFIG_INTEL_ATOMISP2_PM is not set
CONFIG_INTEL_HID_EVENT=m
# CONFIG_INTEL_INT0002_VGPIO is not set
# CONFIG_INTEL_MENLOW is not set
CONFIG_INTEL_OAKTRAIL=m
CONFIG_INTEL_VBTN=m
# CONFIG_SURFACE3_WMI is not set
# CONFIG_SURFACE_3_POWER_OPREGION is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
CONFIG_MSI_LAPTOP=m
CONFIG_MSI_WMI=m
# CONFIG_PCENGINES_APU2 is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_SAMSUNG_Q10=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
CONFIG_COMPAL_LAPTOP=m
# CONFIG_LG_LAPTOP is not set
CONFIG_PANASONIC_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
# CONFIG_SYSTEM76_ACPI is not set
CONFIG_TOPSTAR_LAPTOP=m
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_MLX_PLATFORM is not set
CONFIG_INTEL_IPS=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
CONFIG_INTEL_PMC_CORE=m
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_INTEL_SCU_PCI is not set
# CONFIG_INTEL_SCU_PLATFORM is not set
CONFIG_PMC_ATOM=y
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_HAVE_CLK=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOASID=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=y
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_DMA is not set
# CONFIG_IIO_BUFFER_DMAENGINE is not set
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set
# CONFIG_IIO_TRIGGERED_EVENT is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMA400 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7091R5 is not set
# CONFIG_AD7124 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7292 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_AD9467 is not set
# CONFIG_ADI_AXI_ADC is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2496 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1241 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# CONFIG_HMC425 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_ATLAS_EZO_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SCD30_CORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5770R is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS290 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HDC2010 is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16475 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_FXOS8700_I2C is not set
# CONFIG_FXOS8700_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_ICM42600_I2C is not set
# CONFIG_INV_ICM42600_SPI is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_ADUX1020 is not set
# CONFIG_AL3010 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_AS73211 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP002 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6030 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Linear and angular position sensors
#
# end of Linear and angular position sensors

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DLHL60D is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_ICP10100 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_PING is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9310 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VCNL3020 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_LTC2983 is not set
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# CONFIG_MST_IRQ is not set
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# CONFIG_PHY_INTEL_LGM_EMMC is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_TEE is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# CONFIG_MOST is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_SUPPORT_V4=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
# CONFIG_XFS_RT is not set
# CONFIG_XFS_ONLINE_SCRUB is not set
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
# CONFIG_OCFS2_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_PSTORE_BLK is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
# CONFIG_NFSD_V4_2_INTER_SSC is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=256
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
CONFIG_IMA_ARCH_POLICY=y
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set
# CONFIG_CRYPTO_SM2 is not set
# CONFIG_CRYPTO_CURVE25519 is not set
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=m
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=m
# CONFIG_CRYPTO_BLAKE2S is not set
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=m
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=y
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_ARC4=m
# CONFIG_CRYPTO_LIB_BLAKE2S is not set
# CONFIG_CRYPTO_LIB_CHACHA is not set
# CONFIG_CRYPTO_LIB_CURVE25519 is not set
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
# CONFIG_CRYPTO_LIB_POLY1305 is not set
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_DECOMPRESS_ZSTD=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_DMA_OPS=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_COHERENT_POOL=y
CONFIG_DMA_CMA=y
# CONFIG_DMA_PERNUMA_CMA is not set

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=0
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_SYMBOLIC_ERRNAME=y
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_COMPRESSED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_BTF=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_32B is not set
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
# CONFIG_DEBUG_VM is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
# CONFIG_KASAN is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
# CONFIG_LOCK_STAT is not set
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_WW_MUTEX_SELFTEST=m
# CONFIG_SCF_TORTURE_TEST is not set
# CONFIG_CSD_LOCK_WAIT_DEBUG is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PLIST=y
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_RCU_SCALE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
# CONFIG_RCU_REF_SCALE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_TRACE_PREEMPT_TOGGLE=y
CONFIG_IRQSOFF_TRACER=y
CONFIG_PREEMPT_TRACER=y
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
CONFIG_PREEMPTIRQ_DELAY_TEST=m
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_HIST_TRIGGERS_DEBUG is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_SAMPLES=y
# CONFIG_SAMPLE_AUXDISPLAY is not set
# CONFIG_SAMPLE_TRACE_EVENTS is not set
CONFIG_SAMPLE_TRACE_PRINTK=m
CONFIG_SAMPLE_FTRACE_DIRECT=m
# CONFIG_SAMPLE_TRACE_ARRAY is not set
# CONFIG_SAMPLE_KOBJECT is not set
# CONFIG_SAMPLE_KPROBES is not set
# CONFIG_SAMPLE_HW_BREAKPOINT is not set
# CONFIG_SAMPLE_KFIFO is not set
# CONFIG_SAMPLE_LIVEPATCH is not set
# CONFIG_SAMPLE_CONFIGFS is not set
# CONFIG_SAMPLE_VFIO_MDEV_MTTY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY is not set
# CONFIG_SAMPLE_VFIO_MDEV_MDPY_FB is not set
# CONFIG_SAMPLE_VFIO_MDEV_MBOCHS is not set
# CONFIG_SAMPLE_WATCHDOG is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
CONFIG_LKDTM=y
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_BITOPS=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=y
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
CONFIG_TEST_HMM=m
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='kernel-selftests'
	export testcase='kernel-selftests'
	export category='functional'
	export kconfig='x86_64-rhel-7.6-kselftests'
	export need_memory='3G'
	export need_cpu=2
	export kernel_cmdline='erst_disable'
	export job_origin='/lkp-src/allot/cyclic:p1:internal-devel:devel-hourly/lkp-skl-d05/kernel-selftests.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-skl-d05'
	export tbox_group='lkp-skl-d05'
	export submit_id='5fb8a1424e06af1417b51d23'
	export job_file='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-20201121-5143-23xpiy-3.yaml'
	export id='df5ec9e85a7eee968526b2e204cd8b2e7cf5fbb0'
	export queuer_version='/lkp-src'
	export model='Skylake'
	export nr_cpu=4
	export memory='32G'
	export nr_ssd_partitions=1
	export nr_hdd_partitions=4
	export hdd_partitions='/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
	export ssd_partitions='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
	export rootfs_partition='/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
	export brand='Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
	export commit='1c49e3783f8899555190a49024ac86d3d76633cd'
	export need_kconfig_hw='CONFIG_E1000E=y
CONFIG_SATA_AHCI'
	export ucode='0xe2'
	export need_kernel_headers=true
	export need_kernel_selftests=true
	export need_kconfig='CONFIG_ANDROID=y
CONFIG_FUSE_FS=m
CONFIG_IPV6_MULTIPLE_TABLES=y
CONFIG_MACSEC=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
CONFIG_MISC_FILESYSTEMS=y
CONFIG_MPTCP=y ~ ">= v5.6-rc1"
CONFIG_MPTCP_IPV6=y ~ ">= v5.6-rc1"
CONFIG_NET_FOU
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_NET_L3_MASTER_DEV=y
CONFIG_NET_SCH_NETEM
CONFIG_NET_VRF=y
CONFIG_NFT_OBJREF=m ~ ">= v4.10-rc1"
CONFIG_NF_FLOW_TABLE=m ~ ">= v4.16-rc1"
CONFIG_NF_FLOW_TABLE_INET=m ~ ">= v4.16-rc1"
CONFIG_NF_FLOW_TABLE_IPV4=m ~ ">= v4.16-rc1"
CONFIG_NF_FLOW_TABLE_IPV6=m ~ ">= v4.16-rc1"
CONFIG_NF_TABLES_NETDEV=y ~ ">= v4.17-rc1"
CONFIG_NOTIFIER_ERROR_INJECTION=y
CONFIG_PID_NS=y
CONFIG_PROC_FS=y
CONFIG_PSTORE=y
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
CONFIG_PSTORE_RAM=m
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_STAGING=y
CONFIG_SW_SYNC=y
CONFIG_SYNC=y ~ "<= v4.7"
CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
CONFIG_TEST_STATIC_KEYS
CONFIG_TEST_SYSCTL=y
CONFIG_USER_NS=y
CONFIG_UTS_NS=y
CONFIG_VETH
CONFIG_X86_CPU_RESCTRL=y ~ ">= v5.0-rc1"'
	export enqueue_time='2020-11-21 13:10:26 +0800'
	export _id='5fb8a1464e06af1417b51d25'
	export _rt='/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd'
	export user='lkp'
	export compiler='gcc-9'
	export head_commit='fa8b6e45d7ce2d6a58dee66ffe7458f1d155d723'
	export base_commit='09162bc32c880a791c6c0668ce0745cf7958f576'
	export branch='linux-next/master'
	export rootfs='debian-10.4-x86_64-20200603.cgz'
	export result_root='/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3'
	export scheduler_version='/lkp/lkp/.src-20201120-230606'
	export LKP_SERVER='internal-lkp-server'
	export arch='x86_64'
	export max_uptime=3600
	export initrd='/osimage/debian/debian-10.4-x86_64-20200603.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-20201121-5143-23xpiy-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6-kselftests
branch=linux-next/master
commit=1c49e3783f8899555190a49024ac86d3d76633cd
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88
erst_disable
max_uptime=3600
RESULT_ROOT=/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3
LKP_SERVER=internal-lkp-server
nokaslr
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/modules.cgz'
	export bm_initrd='/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b5a583fb-1_20201015.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
	export linux_headers_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/linux-headers.cgz'
	export linux_selftests_initrd='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/linux-selftests.cgz'
	export ucode_initrd='/osimage/ucode/intel-ucode-20201117.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.10.0-rc4-wt-ath-07774-g989cd8990fb5'
	export repeat_to=4
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88'
	export dequeue_time='2020-11-21 13:35:19 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-20201121-5143-23xpiy-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test group='group-02' $LKP_SRC/tests/wrapper kernel-selftests
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper kernel-selftests
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time kernel-selftests.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--pAwQNkOnpTn9IO2O
Content-Type: application/x-xz
Content-Disposition: attachment; filename="kmsg.xz"
Content-Transfer-Encoding: base64

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
oTnyJbHEZ/sCAAAAAARZWg==

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename=kernel-selftests
Content-Transfer-Encoding: quoted-printable

KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd
2019-02-14 10:12:11 ln -sf /usr/bin/clang
2019-02-14 10:12:11 ln -sf /usr/bin/llc
2019-02-14 10:12:11 sed -i s/default_timeout=3D45/default_timeout=3D300/ ks=
elftest/runner.sh
LKP SKIP media_tests
2019-02-14 10:12:11 make run_tests -C membarrier
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/membarri=
er'
make: Warning: File '../lib.mk' has modification time 55786330 s in the fut=
ure
gcc -g -I../../../../usr/include/    membarrier_test_single_thread.c /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86=
d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/too=
ls/testing/selftests/kselftest.h -lpthread -o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/membarrier/membarrier_test_single_thread
gcc -g -I../../../../usr/include/    membarrier_test_multi_thread.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h -lpthread -o /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/membarrier/membarrier_test_multi_thread
TAP version 13
1..2
# selftests: membarrier: membarrier_test_single_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: membarrier: membarrier_test_single_thread
# selftests: membarrier: membarrier_test_multi_thread
# TAP version 13
# 1..13
# ok 1 sys_membarrier available
# ok 2 sys membarrier invalid command test: command =3D -1, flags =3D 0, er=
rno =3D 22. Failed as expected
# ok 3 sys membarrier MEMBARRIER_CMD_QUERY invalid flags test: flags =3D 1,=
 errno =3D 22. Failed as expected
# ok 4 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED not registered failu=
re test: flags =3D 0, errno =3D 1
# ok 5 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE not regist=
ered failure test: flags =3D 0, errno =3D 1
# ok 6 sys membarrier MEMBARRIER_CMD_GLOBAL test: flags =3D 0
# ok 7 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED test: flags=
 =3D 0
# ok 8 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED test: flags =3D 0
# ok 9 sys membarrier MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE t=
est: flags =3D 0
# ok 10 sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE test: fla=
gs =3D 0
# ok 11 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# ok 12 sys membarrier MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED test: flags=
 =3D 0
# ok 13 sys membarrier MEMBARRIER_CMD_GLOBAL_EXPEDITED test: flags =3D 0
# # Totals: pass:13 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: membarrier: membarrier_test_multi_thread
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/membarrie=
r'
2019-02-14 10:12:12 make run_tests -C memfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd'
make: Warning: File '../lib.mk' has modification time 55786329 s in the fut=
ure
gcc -D_FILE_OFFSET_BITS=3D64 -I../../../../include/uapi/ -I../../../../incl=
ude/ -I../../../../usr/include/    memfd_test.c /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest.h common.c  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd/mem=
fd_test
memfd_test.c: In function =E2=80=98test_seal_future_write=E2=80=99:
memfd_test.c:783:27: error: =E2=80=98F_SEAL_FUTURE_WRITE=E2=80=99 undeclare=
d (first use in this function); did you mean =E2=80=98F_SEAL_WRITE=E2=80=99?
  mfd_assert_add_seals(fd, F_SEAL_FUTURE_WRITE);
                           ^~~~~~~~~~~~~~~~~~~
                           F_SEAL_WRITE
memfd_test.c:783:27: note: each undeclared identifier is reported only once=
 for each function it appears in
make: *** [../lib.mk:139: /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd/me=
mfd_test] Error 1
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memfd'
2019-02-14 10:12:12 make run_tests -C memory-hotplug
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memory-h=
otplug'
make: Warning: File '../lib.mk' has modification time 55786328 s in the fut=
ure
TAP version 13
1..1
# selftests: memory-hotplug: mem-on-off-test.sh
# Test scope: 2% hotplug memory
# 	 online all hot-pluggable memory in offline state:
# 		 SKIPPED - no hot-pluggable memory in offline state
# 	 offline 2% hot-pluggable memory in online state
# 	 trying to offline 6 out of 256 memory block(s):
# online->offline memory0
# ./mem-on-off-test.sh: line 78: echo: write error: Invalid argument
# offline_memory_expect_success 0: unexpected fail
# online->offline memory1
# online->offline memory10
# online->offline memory100
# online->offline memory101
# online->offline memory102
# online->offline memory103
# 	 online all hot-pluggable memory in offline state:
# offline->online memory1
# offline->online memory10
# offline->online memory100
# offline->online memory101
# offline->online memory102
# offline->online memory103
# 	 Test with memory notifier error injection
#
not ok 1 selftests: memory-hotplug: mem-on-off-test.sh # TIMEOUT 300 seconds
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/memory-ho=
tplug'
2019-02-14 10:17:13 make run_tests -C mincore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mincore'
make: Warning: File '../lib.mk' has modification time 55786028 s in the fut=
ure
gcc -Wall    mincore_selftest.c /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ks=
elftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3=
783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o =
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a490=
24ac86d3d76633cd/tools/testing/selftests/mincore/mincore_selftest
TAP version 13
1..1
# selftests: mincore: mincore_selftest
# TAP version 13
# 1..5
# # Starting 5 tests from 1 test cases.
# #  RUN           global.basic_interface ...
# #            OK  global.basic_interface
# ok 1 global.basic_interface
# #  RUN           global.check_anonymous_locked_pages ...
# #            OK  global.check_anonymous_locked_pages
# ok 2 global.check_anonymous_locked_pages
# #  RUN           global.check_huge_pages ...
# #      SKIP     No huge pages available.
# #            OK  global.check_huge_pages
# ok 3 # SKIP No huge pages available.
# #  RUN           global.check_file_mmap ...
# # mincore_selftest.c:211:check_file_mmap:Expected -1 (-1) !=3D fd (-1)
# # mincore_selftest.c:213:check_file_mmap:Can't create temporary file: Ope=
ration not supported
# # check_file_mmap: Test terminated by assertion
# #          FAIL  global.check_file_mmap
# not ok 4 global.check_file_mmap
# #  RUN           global.check_tmpfs_mmap ...
# #            OK  global.check_tmpfs_mmap
# ok 5 global.check_tmpfs_mmap
# # FAILED: 4 / 5 tests passed.
# # Totals: pass:3 fail:1 xfail:0 xpass:0 skip:1 error:0
not ok 1 selftests: mincore: mincore_selftest # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mincore'
2019-02-14 10:17:13 make run_tests -C mount
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mount'
make: Warning: File '../lib.mk' has modification time 55786028 s in the fut=
ure
gcc -Wall -O2    unprivileged-remount-test.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/mount/unprivileged-re=
mount-test
gcc -Wall -O2    nosymfollow-test.c /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h =
 -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190=
a49024ac86d3d76633cd/tools/testing/selftests/mount/nosymfollow-test
TAP version 13
1..2
# selftests: mount: run_unprivileged_remount.sh
ok 1 selftests: mount: run_unprivileged_remount.sh
# selftests: mount: run_nosymfollow.sh
ok 2 selftests: mount: run_nosymfollow.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mount'
2019-02-14 10:17:14 make run_tests -C mqueue
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue'
make: Warning: File '../lib.mk' has modification time 55786027 s in the fut=
ure
gcc -O2    mq_open_tests.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselfte=
st_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -lrt -lpt=
hread -lpopt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e378=
3f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue/mq_open_tes=
ts
gcc -O2    mq_perf_tests.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselfte=
st_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8=
899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -lrt -lpt=
hread -lpopt -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e378=
3f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue/mq_perf_tes=
ts
TAP version 13
1..2
# selftests: mqueue: mq_open_tests
# Using Default queue path - /test1
#=20
# Initial system state:
# 	Using queue path:		/test1
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):		819200
# 	RLIMIT_MSGQUEUE(hard):		819200
# 	Maximum Message Size:		8192
# 	Maximum Queue Size:		10
# 	Default Message Size:		8192
# 	Default Queue Size:		10
#=20
#=20
# Test series 1, behavior when no attr struct passed to mq_open:
# Kernel supports setting defaults separately from maximums:		PASS
# Given sane values, mq_open without an attr struct succeeds:		PASS
# Kernel properly honors default setting knobs:				PASS
# Kernel properly limits default values to lesser of default/max:		PASS
# Kernel properly fails to create queue when defaults would
# exceed rlimit:								PASS
#=20
#=20
# Test series 2, behavior when attr struct is passed to mq_open:
# Queue open in excess of rlimit max when euid =3D 0 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 0 succeeded:		PASS
# Queue open with mq_msgsize > limit when euid =3D 0 succeeded:		PASS
# Queue open with total size > 2GB when euid =3D 0 failed:			PASS
# Queue open in excess of rlimit max when euid =3D 99 failed:		PASS
# Queue open with mq_maxmsg > limit when euid =3D 99 failed:		PASS
# Queue open with mq_msgsize > limit when euid =3D 99 failed:		PASS
# Queue open with total size > 2GB when euid =3D 99 failed:			PASS
ok 1 selftests: mqueue: mq_open_tests
# selftests: mqueue: mq_perf_tests
#=20
# Initial system state:
# 	Using queue path:			/mq_perf_tests
# 	RLIMIT_MSGQUEUE(soft):			819200
# 	RLIMIT_MSGQUEUE(hard):			819200
# 	Maximum Message Size:			8192
# 	Maximum Queue Size:			10
# 	Nice value:				0
#=20
# Adjusted system state for testing:
# 	RLIMIT_MSGQUEUE(soft):			(unlimited)
# 	RLIMIT_MSGQUEUE(hard):			(unlimited)
# 	Maximum Message Size:			16777216
# 	Maximum Queue Size:			65530
# 	Nice value:				-20
# 	Continuous mode:			(disabled)
# 	CPUs to pin:				3
#=20
# 	Queue /mq_perf_tests created:
# 		mq_flags:			O_NONBLOCK
# 		mq_maxmsg:			65530
# 		mq_msgsize:			16
# 		mq_curmsgs:			0
#=20
# 	Started mqueue performance test thread on CPU 3
# 		Max priorities:			32768
# 		Clock resolution:		1 nsec
#=20
# 	Test #1: Time send/recv message, queue empty
# 		(10000000 iterations)
# 		Send msg:			58.698323494s total time
# 						5869 nsec/msg
# 		Recv msg:			57.170959823s total time
# 						5717 nsec/msg
#=20
# 	Test #2a: Time send/recv message, queue full, constant prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.241087222s
# 		Testing...done.
# 		Send msg:			0.588674308s total time
# 						5886 nsec/msg
# 		Recv msg:			0.532119363s total time
# 						5321 nsec/msg
# 		Draining queue...done.		0.189556062s
#=20
# 	Test #2b: Time send/recv message, queue full, increasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.245054013s
# 		Testing...done.
# 		Send msg:			0.596914314s total time
# 						5969 nsec/msg
# 		Recv msg:			0.557010190s total time
# 						5570 nsec/msg
# 		Draining queue...done.		0.193351889s
#=20
# 	Test #2c: Time send/recv message, queue full, decreasing prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.241666554s
# 		Testing...done.
# 		Send msg:			0.601334493s total time
# 						6013 nsec/msg
# 		Recv msg:			0.550965430s total time
# 						5509 nsec/msg
# 		Draining queue...done.		0.196532482s
#=20
# 	Test #2d: Time send/recv message, queue full, random prio
# :
# 		(100000 iterations)
# 		Filling queue...done.		0.248801144s
# 		Testing...done.
# 		Send msg:			0.608562791s total time
# 						6085 nsec/msg
# 		Recv msg:			0.563787583s total time
# 						5637 nsec/msg
# 		Draining queue...done.		0.197478860s
ok 2 selftests: mqueue: mq_perf_tests
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/mqueue'
2019-02-14 10:19:42 make run_tests -C nsfs
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/nsfs'
make: Warning: File '../lib.mk' has modification time 55785879 s in the fut=
ure
gcc -Wall -Werror    owner.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kself=
test_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783=
f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/nsfs/owner
gcc -Wall -Werror    pidns.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kself=
test_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783=
f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/nsfs/pidns
TAP version 13
1..2
# selftests: nsfs: owner
ok 1 selftests: nsfs: owner
# selftests: nsfs: pidns
ok 2 selftests: nsfs: pidns
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/nsfs'
Discarding device blocks:   1024/102400=08=08=08=08=08=08=08=08=08=08=08=08=
=08             =08=08=08=08=08=08=08=08=08=08=08=08=08done                =
           =20
Creating filesystem with 102400 1k blocks and 25688 inodes
Filesystem UUID: d3361ae0-97e0-4f43-9047-55526734b28a
Superblock backups stored on blocks:=20
	8193, 24577, 40961, 57345, 73729

Allocating group tables:  0/13=08=08=08=08=08     =08=08=08=08=08done      =
                     =20
Writing inode tables:  0/13=08=08=08=08=08     =08=08=08=08=08done         =
                  =20
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information:  0/13=08=08=08=
=08=08     =08=08=08=08=08done

2019-02-14 10:19:46 ./openat2_test
TAP version 13
1..114
ok 1 openat2 with normal struct argument [misalign=3D0] succeeds
ok 2 openat2 with normal struct argument [misalign=3D1] succeeds
ok 3 openat2 with normal struct argument [misalign=3D2] succeeds
ok 4 openat2 with normal struct argument [misalign=3D3] succeeds
ok 5 openat2 with normal struct argument [misalign=3D4] succeeds
ok 6 openat2 with normal struct argument [misalign=3D5] succeeds
ok 7 openat2 with normal struct argument [misalign=3D6] succeeds
ok 8 openat2 with normal struct argument [misalign=3D7] succeeds
ok 9 openat2 with normal struct argument [misalign=3D8] succeeds
ok 10 openat2 with normal struct argument [misalign=3D9] succeeds
ok 11 openat2 with normal struct argument [misalign=3D11] succeeds
ok 12 openat2 with normal struct argument [misalign=3D17] succeeds
ok 13 openat2 with normal struct argument [misalign=3D87] succeeds
ok 14 openat2 with bigger struct (zeroed out) argument [misalign=3D0] succe=
eds
ok 15 openat2 with bigger struct (zeroed out) argument [misalign=3D1] succe=
eds
ok 16 openat2 with bigger struct (zeroed out) argument [misalign=3D2] succe=
eds
ok 17 openat2 with bigger struct (zeroed out) argument [misalign=3D3] succe=
eds
ok 18 openat2 with bigger struct (zeroed out) argument [misalign=3D4] succe=
eds
ok 19 openat2 with bigger struct (zeroed out) argument [misalign=3D5] succe=
eds
ok 20 openat2 with bigger struct (zeroed out) argument [misalign=3D6] succe=
eds
ok 21 openat2 with bigger struct (zeroed out) argument [misalign=3D7] succe=
eds
ok 22 openat2 with bigger struct (zeroed out) argument [misalign=3D8] succe=
eds
ok 23 openat2 with bigger struct (zeroed out) argument [misalign=3D9] succe=
eds
ok 24 openat2 with bigger struct (zeroed out) argument [misalign=3D11] succ=
eeds
ok 25 openat2 with bigger struct (zeroed out) argument [misalign=3D17] succ=
eeds
ok 26 openat2 with bigger struct (zeroed out) argument [misalign=3D87] succ=
eeds
ok 27 openat2 with zero-sized 'struct' argument [misalign=3D0] fails with -=
22 (Invalid argument)
ok 28 openat2 with zero-sized 'struct' argument [misalign=3D1] fails with -=
22 (Invalid argument)
ok 29 openat2 with zero-sized 'struct' argument [misalign=3D2] fails with -=
22 (Invalid argument)
ok 30 openat2 with zero-sized 'struct' argument [misalign=3D3] fails with -=
22 (Invalid argument)
ok 31 openat2 with zero-sized 'struct' argument [misalign=3D4] fails with -=
22 (Invalid argument)
ok 32 openat2 with zero-sized 'struct' argument [misalign=3D5] fails with -=
22 (Invalid argument)
ok 33 openat2 with zero-sized 'struct' argument [misalign=3D6] fails with -=
22 (Invalid argument)
ok 34 openat2 with zero-sized 'struct' argument [misalign=3D7] fails with -=
22 (Invalid argument)
ok 35 openat2 with zero-sized 'struct' argument [misalign=3D8] fails with -=
22 (Invalid argument)
ok 36 openat2 with zero-sized 'struct' argument [misalign=3D9] fails with -=
22 (Invalid argument)
ok 37 openat2 with zero-sized 'struct' argument [misalign=3D11] fails with =
-22 (Invalid argument)
ok 38 openat2 with zero-sized 'struct' argument [misalign=3D17] fails with =
-22 (Invalid argument)
ok 39 openat2 with zero-sized 'struct' argument [misalign=3D87] fails with =
-22 (Invalid argument)
ok 40 openat2 with smaller-than-v0 struct argument [misalign=3D0] fails wit=
h -22 (Invalid argument)
ok 41 openat2 with smaller-than-v0 struct argument [misalign=3D1] fails wit=
h -22 (Invalid argument)
ok 42 openat2 with smaller-than-v0 struct argument [misalign=3D2] fails wit=
h -22 (Invalid argument)
ok 43 openat2 with smaller-than-v0 struct argument [misalign=3D3] fails wit=
h -22 (Invalid argument)
ok 44 openat2 with smaller-than-v0 struct argument [misalign=3D4] fails wit=
h -22 (Invalid argument)
ok 45 openat2 with smaller-than-v0 struct argument [misalign=3D5] fails wit=
h -22 (Invalid argument)
ok 46 openat2 with smaller-than-v0 struct argument [misalign=3D6] fails wit=
h -22 (Invalid argument)
ok 47 openat2 with smaller-than-v0 struct argument [misalign=3D7] fails wit=
h -22 (Invalid argument)
ok 48 openat2 with smaller-than-v0 struct argument [misalign=3D8] fails wit=
h -22 (Invalid argument)
ok 49 openat2 with smaller-than-v0 struct argument [misalign=3D9] fails wit=
h -22 (Invalid argument)
ok 50 openat2 with smaller-than-v0 struct argument [misalign=3D11] fails wi=
th -22 (Invalid argument)
ok 51 openat2 with smaller-than-v0 struct argument [misalign=3D17] fails wi=
th -22 (Invalid argument)
ok 52 openat2 with smaller-than-v0 struct argument [misalign=3D87] fails wi=
th -22 (Invalid argument)
ok 53 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D0] fails with -7 (Argument list too long)
ok 54 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D1] fails with -7 (Argument list too long)
ok 55 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D2] fails with -7 (Argument list too long)
ok 56 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D3] fails with -7 (Argument list too long)
ok 57 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D4] fails with -7 (Argument list too long)
ok 58 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D5] fails with -7 (Argument list too long)
ok 59 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D6] fails with -7 (Argument list too long)
ok 60 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D7] fails with -7 (Argument list too long)
ok 61 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D8] fails with -7 (Argument list too long)
ok 62 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D9] fails with -7 (Argument list too long)
ok 63 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D11] fails with -7 (Argument list too long)
ok 64 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D17] fails with -7 (Argument list too long)
ok 65 openat2 with bigger struct (non-zero data in first 'future field') ar=
gument [misalign=3D87] fails with -7 (Argument list too long)
ok 66 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D0] fails with -7 (Argument list too long)
ok 67 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D1] fails with -7 (Argument list too long)
ok 68 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D2] fails with -7 (Argument list too long)
ok 69 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D3] fails with -7 (Argument list too long)
ok 70 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D4] fails with -7 (Argument list too long)
ok 71 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D5] fails with -7 (Argument list too long)
ok 72 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D6] fails with -7 (Argument list too long)
ok 73 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D7] fails with -7 (Argument list too long)
ok 74 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D8] fails with -7 (Argument list too long)
ok 75 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D9] fails with -7 (Argument list too long)
ok 76 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D11] fails with -7 (Argument list too long)
ok 77 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D17] fails with -7 (Argument list too long)
ok 78 openat2 with bigger struct (non-zero data in middle of 'future fields=
') argument [misalign=3D87] fails with -7 (Argument list too long)
ok 79 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D0] fails with -7 (Argument list too long)
ok 80 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D1] fails with -7 (Argument list too long)
ok 81 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D2] fails with -7 (Argument list too long)
ok 82 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D3] fails with -7 (Argument list too long)
ok 83 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D4] fails with -7 (Argument list too long)
ok 84 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D5] fails with -7 (Argument list too long)
ok 85 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D6] fails with -7 (Argument list too long)
ok 86 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D7] fails with -7 (Argument list too long)
ok 87 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D8] fails with -7 (Argument list too long)
ok 88 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D9] fails with -7 (Argument list too long)
ok 89 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D11] fails with -7 (Argument list too long)
ok 90 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D17] fails with -7 (Argument list too long)
ok 91 openat2 with bigger struct (non-zero data at end of 'future fields') =
argument [misalign=3D87] fails with -7 (Argument list too long)
ok 92 openat2 with incompatible flags (O_TMPFILE | O_PATH) fails with -22 (=
Invalid argument)
ok 93 openat2 with incompatible flags (O_TMPFILE | O_CREAT) fails with -22 =
(Invalid argument)
ok 94 openat2 with compatible flags (O_PATH | O_CLOEXEC) succeeds
ok 95 openat2 with compatible flags (O_PATH | O_DIRECTORY) succeeds
ok 96 openat2 with compatible flags (O_PATH | O_NOFOLLOW) succeeds
ok 97 openat2 with incompatible flags (O_PATH | O_RDWR) fails with -22 (Inv=
alid argument)
ok 98 openat2 with incompatible flags (O_PATH | O_CREAT) fails with -22 (In=
valid argument)
ok 99 openat2 with incompatible flags (O_PATH | O_EXCL) fails with -22 (Inv=
alid argument)
ok 100 openat2 with incompatible flags (O_PATH | O_NOCTTY) fails with -22 (=
Invalid argument)
ok 101 openat2 with incompatible flags (O_PATH | O_DIRECT) fails with -22 (=
Invalid argument)
ok 102 openat2 with incompatible flags (O_PATH | O_LARGEFILE) fails with -2=
2 (Invalid argument)
ok 103 openat2 with non-zero how.mode and O_RDONLY fails with -22 (Invalid =
argument)
ok 104 openat2 with non-zero how.mode and O_PATH fails with -22 (Invalid ar=
gument)
ok 105 openat2 with valid how.mode and O_CREAT succeeds
ok 106 openat2 with valid how.mode and O_TMPFILE succeeds
ok 107 openat2 with invalid how.mode and O_CREAT fails with -22 (Invalid ar=
gument)
ok 108 openat2 with invalid (very large) how.mode and O_CREAT fails with -2=
2 (Invalid argument)
ok 109 openat2 with invalid how.mode and O_TMPFILE fails with -22 (Invalid =
argument)
ok 110 openat2 with invalid (very large) how.mode and O_TMPFILE fails with =
-22 (Invalid argument)
ok 111 openat2 with invalid how.resolve and O_RDONLY fails with -22 (Invali=
d argument)
ok 112 openat2 with invalid how.resolve and O_CREAT fails with -22 (Invalid=
 argument)
ok 113 openat2 with invalid how.resolve and O_TMPFILE fails with -22 (Inval=
id argument)
ok 114 openat2 with invalid how.resolve and O_PATH fails with -22 (Invalid =
argument)
# Totals: pass:114 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: openat2: openat2_test
2019-02-14 10:19:46 make run_tests -C pid_namespace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pid_name=
space'
make: Warning: File '../lib.mk' has modification time 55785875 s in the fut=
ure
gcc -g -I../../../../usr/include/    regression_enomem.c /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/t=
ools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/s=
elftests/kselftest.h ../pidfd/pidfd.h  -o /usr/src/perf_selftests-x86_64-rh=
el-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/se=
lftests/pid_namespace/regression_enomem
TAP version 13
1..1
# selftests: pid_namespace: regression_enomem
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.regression_enomem ...
# #            OK  global.regression_enomem
# ok 1 global.regression_enomem
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: pid_namespace: regression_enomem
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pid_names=
pace'
2019-02-14 10:19:46 make run_tests -C pidfd
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd'
make: Warning: File '../lib.mk' has modification time 55785875 s in the fut=
ure
gcc -g -I../../../../usr/include/ -pthread    pidfd_test.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd/p=
idfd_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_fdinfo_test.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
pidfd/pidfd_fdinfo_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_open_test.c /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76=
633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/te=
sting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pi=
dfd/pidfd_open_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_poll_test.c /usr/src/pe=
rf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76=
633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x=
86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/te=
sting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kse=
lftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pi=
dfd/pidfd_poll_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_wait.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd/p=
idfd_wait
gcc -g -I../../../../usr/include/ -pthread    pidfd_getfd_test.c /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/p=
idfd/pidfd_getfd_test
gcc -g -I../../../../usr/include/ -pthread    pidfd_setns_test.c /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/p=
idfd/pidfd_setns_test
TAP version 13
1..7
# selftests: pidfd: pidfd_test
# TAP version 13
# 1..8
# # Parent: pid: 6410
# # Parent: Waiting for Child (6411) to complete.
# # Time waited for child: 3
# ok 1 pidfd_poll check for premature notification on child thread exec tes=
t: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6422) to complete.
# # Parent: Child process waited for.
# # Time waited for child: 3
# ok 2 pidfd_poll check for premature notification on child thread exec tes=
t: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6436) to complete.
# # Time since child exit: 3
# ok 3 pidfd_poll check for premature notification on non-emptygroup leader=
 exit test: Passed
# # Parent: pid: 6410
# # Parent: Waiting for Child (6448) to complete.
# # Parent: Child process waited for.
# # Time since child exit: 3
# ok 4 pidfd_poll check for premature notification on non-emptygroup leader=
 exit test: Passed
# ok 5 pidfd_send_signal check for support test: pidfd_send_signal() syscal=
l is supported. Tests can be executed
# ok 6 pidfd_send_signal send SIGUSR1 test: Sent signal
# ok 7 pidfd_send_signal signal exited process test: Failed to send signal =
as expected
# ok 8 pidfd_send_signal signal recycled pid test: Failed to signal recycle=
d pid as expected
# # Totals: pass:8 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: pidfd: pidfd_test
# selftests: pidfd: pidfd_fdinfo_test
# TAP version 13
# 1..2
# # New child: 7636, fd: 5
# # New child: 7637, fd: 6
# ok 1 pidfd check for NSpid in fdinfo test: Passed
# # New child: 7638, fd: 5
# ok 2 pidfd check fdinfo for dead process test: Passed
# # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 2 selftests: pidfd: pidfd_fdinfo_test
# selftests: pidfd: pidfd_open_test
# 1..3
# ok 1 do not allow invalid pid test: passed
# ok 2 do not allow invalid flag test: passed
# ok 3 open a new pidfd test: passed
# # pidfd 5 refers to process with pid 7650
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 3 selftests: pidfd: pidfd_open_test
# selftests: pidfd: pidfd_poll_test
# # running pidfd poll test for 10000 iterations
# ok 1 pidfd poll test: pass
# # Planned tests !=3D run tests (0 !=3D 1)
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 4 selftests: pidfd: pidfd_poll_test
# selftests: pidfd: pidfd_wait
# TAP version 13
# 1..3
# # Starting 3 tests from 1 test cases.
# #  RUN           global.wait_simple ...
# #            OK  global.wait_simple
# ok 1 global.wait_simple
# #  RUN           global.wait_states ...
# #            OK  global.wait_states
# ok 2 global.wait_states
# #  RUN           global.wait_nonblock ...
# #            OK  global.wait_nonblock
# ok 3 global.wait_nonblock
# # PASSED: 3 / 3 tests passed.
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 5 selftests: pidfd: pidfd_wait
# selftests: pidfd: pidfd_getfd_test
# TAP version 13
# 1..4
# # Starting 4 tests from 2 test cases.
# #  RUN           global.flags_set ...
# #            OK  global.flags_set
# ok 1 global.flags_set
# #  RUN           child.disable_ptrace ...
# #            OK  child.disable_ptrace
# ok 2 child.disable_ptrace
# #  RUN           child.fetch_fd ...
# #            OK  child.fetch_fd
# ok 3 child.fetch_fd
# #  RUN           child.test_unknown_fd ...
# #            OK  child.test_unknown_fd
# ok 4 child.test_unknown_fd
# # PASSED: 4 / 4 tests passed.
# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 6 selftests: pidfd: pidfd_getfd_test
# selftests: pidfd: pidfd_setns_test
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           global.setns_einval ...
# #            OK  global.setns_einval
# ok 1 global.setns_einval
# #  RUN           current_nsset.invalid_flags ...
# # pidfd_setns_test.c:162:invalid_flags:Expected self->child_pid_exited (0=
) > 0 (0)
# #            OK  current_nsset.invalid_flags
# ok 2 current_nsset.invalid_flags
# #  RUN           current_nsset.pidfd_exited_child ...
# # pidfd_setns_test.c:162:pidfd_exited_child:Expected self->child_pid_exit=
ed (0) > 0 (0)
# #            OK  current_nsset.pidfd_exited_child
# ok 3 current_nsset.pidfd_exited_child
# #  RUN           current_nsset.pidfd_incremental_setns ...
# # pidfd_setns_test.c:162:pidfd_incremental_setns:Expected self->child_pid=
_exited (0) > 0 (0)
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to user namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to mnt namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to pid namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to uts namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to ipc namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to net namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to cgroup namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to pid_for_children namespace of 17740 via pidfd 20
# # pidfd_setns_test.c:410:pidfd_incremental_setns:Managed to correctly set=
ns to time namespace of 17740 via pidfd 20
# #            OK  current_nsset.pidfd_incremental_setns
# ok 4 current_nsset.pidfd_incremental_setns
# #  RUN           current_nsset.nsfd_incremental_setns ...
# # pidfd_setns_test.c:162:nsfd_incremental_setns:Expected self->child_pid_=
exited (0) > 0 (0)
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to user namespace of 17745 via nsfd 19
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to mnt namespace of 17745 via nsfd 24
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to pid namespace of 17745 via nsfd 27
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to uts namespace of 17745 via nsfd 30
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to ipc namespace of 17745 via nsfd 33
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to net namespace of 17745 via nsfd 36
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to cgroup namespace of 17745 via nsfd 39
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to pid_for_children namespace of 17745 via nsfd 42
# # pidfd_setns_test.c:446:nsfd_incremental_setns:Managed to correctly setn=
s to time namespace of 17745 via nsfd 45
# #            OK  current_nsset.nsfd_incremental_setns
# ok 5 current_nsset.nsfd_incremental_setns
# #  RUN           current_nsset.pidfd_one_shot_setns ...
# # pidfd_setns_test.c:162:pidfd_one_shot_setns:Expected self->child_pid_ex=
ited (0) > 0 (0)
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding user namespace of 17=
749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding mnt namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding pid namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding uts namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding ipc namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding net namespace of 177=
49 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding cgroup namespace of =
17749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding pid_for_children nam=
espace of 17749 to list of namespaces to attach to
# # pidfd_setns_test.c:464:pidfd_one_shot_setns:Adding time namespace of 17=
749 to list of namespaces to attach to
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to user namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to mnt namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to pid namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to uts namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to ipc namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to net namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to cgroup namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to pid_for_children namespace of 17749
# # pidfd_setns_test.c:490:pidfd_one_shot_setns:Managed to correctly setns =
to time namespace of 17749
# #            OK  current_nsset.pidfd_one_shot_setns
# ok 6 current_nsset.pidfd_one_shot_setns
# #  RUN           current_nsset.no_foul_play ...
# # pidfd_setns_test.c:162:no_foul_play:Expected self->child_pid_exited (0)=
 > 0 (0)
# # pidfd_setns_test.c:508:no_foul_play:Adding user namespace of 17754 to l=
ist of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding mnt namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding pid namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding uts namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding ipc namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding net namespace of 17754 to li=
st of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding cgroup namespace of 17754 to=
 list of namespaces to attach to
# # pidfd_setns_test.c:508:no_foul_play:Adding time namespace of 17754 to l=
ist of namespaces to attach to
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to user namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to user namespace of 17755 via nsfd 22
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to mnt namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to mnt namespace of 17755 via nsfd 25
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to pid namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to pid namespace of 17755 via nsfd 28
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to uts namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to uts namespace of 17755 via nsfd 31
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to ipc namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to ipc namespace of 17755 via nsfd 34
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to net namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to net namespace of 17755 via nsfd 37
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to cgroup namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to cgroup namespace of 17755 via nsfd 40
# # pidfd_setns_test.c:535:no_foul_play:Operation not permitted - Correctly=
 failed to setns to time namespace of 17755 via pidfd 21
# # pidfd_setns_test.c:544:no_foul_play:Operation not permitted - Correctly=
 failed to setns to time namespace of 17755 via nsfd 46
# #            OK  current_nsset.no_foul_play
# ok 7 current_nsset.no_foul_play
# # PASSED: 7 / 7 tests passed.
# # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 7 selftests: pidfd: pidfd_setns_test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pidfd'
LKP SKIP powerpc
prctl test: not in Makefile
2019-02-14 10:20:32 make TARGETS=3Dprctl
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748967 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748966 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
66 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
66 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
966 s in the future
  WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  WRAP    arch/x86/include/generated/uapi/asm/errno.h
  WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  WRAP    arch/x86/include/generated/uapi/asm/param.h
  WRAP    arch/x86/include/generated/uapi/asm/poll.h
  WRAP    arch/x86/include/generated/uapi/asm/resource.h
  WRAP    arch/x86/include/generated/uapi/asm/socket.h
  WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  WRAP    arch/x86/include/generated/uapi/asm/termios.h
  WRAP    arch/x86/include/generated/uapi/asm/types.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574896=
6 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
64 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  UPD     include/generated/uapi/linux/version.h
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748961=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
941 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make[1]: Warning: File '../lib.mk' has modification time 55785802 s in the =
future
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:21:00 make run_tests -C prctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
Makefile:14: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make: Warning: File '../lib.mk' has modification time 55785801 s in the fut=
ure
gcc     disable-tsc-ctxt-sw-stress-test.c   -o disable-tsc-ctxt-sw-stress-t=
est
gcc     disable-tsc-on-off-stress-test.c   -o disable-tsc-on-off-stress-test
gcc     disable-tsc-test.c   -o disable-tsc-test
TAP version 13
1..3
# selftests: prctl: disable-tsc-ctxt-sw-stress-test
# [No further output means we're allright]
ok 1 selftests: prctl: disable-tsc-ctxt-sw-stress-test
# selftests: prctl: disable-tsc-on-off-stress-test
# [No further output means we're allright]
ok 2 selftests: prctl: disable-tsc-on-off-stress-test
# selftests: prctl: disable-tsc-test
# rdtsc() =3D=3D 6559452189861
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_ENABLE
# rdtsc() =3D=3D 6559452521539
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 6559452533458
# prctl(PR_SET_TSC, PR_TSC_SIGSEGV)
# rdtsc() =3D=3D [ SIG_SEGV ]
# prctl(PR_GET_TSC, &tsc_val); tsc_val =3D=3D PR_TSC_SIGSEGV
# prctl(PR_SET_TSC, PR_TSC_ENABLE)
# rdtsc() =3D=3D 6559452596615
ok 3 selftests: prctl: disable-tsc-test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/prctl'
2019-02-14 10:21:21 make run_tests -C proc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc'
make: Warning: File '../lib.mk' has modification time 55785780 s in the fut=
ure
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-001-lookup.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/proc/fd-001-lookup
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-002-posix-eq.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/fd-002-posix-eq
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    fd-003-kthread.c /usr/s=
rc/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86=
d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selfte=
sts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/too=
ls/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.=
6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftes=
ts/proc/fd-003-kthread
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-loadavg-001.c /usr=
/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac=
86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_self=
tests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/t=
ools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-=
7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selft=
ests/proc/proc-loadavg-001
proc-loadavg-001.c:17: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-pid-vm.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
proc/proc-pid-vm
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-001=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/proc/proc-self-map-files-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-map-files-002=
=2Ec /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86=
_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/test=
ing/selftests/proc/proc-self-map-files-002
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-syscall.c /us=
r/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024a=
c86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/=
tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-self-syscall
proc-self-syscall.c:16: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-self-wchan.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-self-wchan
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-001.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-uptime-001
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-uptime-002.c /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selft=
ests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/to=
ols/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7=
=2E6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/proc/proc-uptime-002
proc-uptime-002.c:18: warning: "_GNU_SOURCE" redefined
 #define _GNU_SOURCE
=20
<command-line>: note: this is the location of the previous definition
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    read.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc/re=
ad
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    self.c /usr/src/perf_se=
lftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd=
/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftes=
ts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc/se=
lf
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    setns-dcache.c /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3=
d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftest=
s-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools=
/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests=
/proc/setns-dcache
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    setns-sysvipc.c /usr/sr=
c/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d=
3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/proc/setns-sysvipc
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    thread-self.c /usr/src/=
perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d=
76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
proc/thread-self
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-multiple-procfs.c =
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a490=
24ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf_=
selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633=
cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-r=
hel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/s=
elftests/proc/proc-multiple-procfs
gcc -Wall -O2 -Wno-unused-function -D_GNU_SOURCE    proc-fsconfig-hidepid.c=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49=
024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/proc/proc-fsconfig-hidepid
TAP version 13
1..18
# selftests: proc: fd-001-lookup
ok 1 selftests: proc: fd-001-lookup
# selftests: proc: fd-002-posix-eq
ok 2 selftests: proc: fd-002-posix-eq
# selftests: proc: fd-003-kthread
ok 3 selftests: proc: fd-003-kthread
# selftests: proc: proc-loadavg-001
ok 4 selftests: proc: proc-loadavg-001
# selftests: proc: proc-pid-vm
ok 5 selftests: proc: proc-pid-vm
# selftests: proc: proc-self-map-files-001
ok 6 selftests: proc: proc-self-map-files-001
# selftests: proc: proc-self-map-files-002
ok 7 selftests: proc: proc-self-map-files-002
# selftests: proc: proc-self-syscall
ok 8 selftests: proc: proc-self-syscall
# selftests: proc: proc-self-wchan
ok 9 selftests: proc: proc-self-wchan
# selftests: proc: proc-uptime-001
ok 10 selftests: proc: proc-uptime-001
# selftests: proc: proc-uptime-002
ok 11 selftests: proc: proc-uptime-002
# selftests: proc: read
ok 12 selftests: proc: read
# selftests: proc: self
ok 13 selftests: proc: self
# selftests: proc: setns-dcache
ok 14 selftests: proc: setns-dcache
# selftests: proc: setns-sysvipc
ok 15 selftests: proc: setns-sysvipc
# selftests: proc: thread-self
ok 16 selftests: proc: thread-self
# selftests: proc: proc-multiple-procfs
ok 17 selftests: proc: proc-multiple-procfs
# selftests: proc: proc-fsconfig-hidepid
ok 18 selftests: proc: proc-fsconfig-hidepid
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/proc'
2019-02-14 10:21:29 make run_tests -C pstore
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pstore'
make: Warning: File '../lib.mk' has modification time 55785772 s in the fut=
ure
TAP version 13
1..2
# selftests: pstore: pstore_tests
# =3D=3D=3D Pstore unit tests (pstore_tests) =3D=3D=3D
# UUID=3Dd182fe0d-5afe-42bd-b40e-b550ccbe2770
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-2020112=
1-5143-23xpiy-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.6-kselftests bra=
nch=3Dlinux-next/master commit=3D1c49e3783f8899555190a49024ac86d3d76633cd B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f889955519=
0a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88 erst_disable m=
ax_uptime=3D3600 RESULT_ROOT=3D/result/kernel-selftests/group-02-ucode=3D0x=
e2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/g=
cc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3 LKP_SERVER=3Dinternal-lkp-s=
erver nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.=
rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 =
softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 pro=
mpt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_logleve=
l console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dno=
rmal rw
# Checking pstore console is registered ... ok
# Checking /dev/pmsg0 exists ... ok
# Writing unique string to /dev/pmsg0 ... ok
ok 1 selftests: pstore: pstore_tests
# selftests: pstore: pstore_post_reboot_tests
# =3D=3D=3D Pstore unit tests (pstore_post_reboot_tests) =3D=3D=3D
# UUID=3Dfbfd8a85-805d-4dd2-965c-22b42e588707
# Checking pstore backend is registered ... ok
# 	backend=3Dramoops
# 	cmdline=3Dip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 user=3Dlkp job=3D/=
lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=3D0xe2-debia=
n-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-2020112=
1-5143-23xpiy-3.yaml ARCH=3Dx86_64 kconfig=3Dx86_64-rhel-7.6-kselftests bra=
nch=3Dlinux-next/master commit=3D1c49e3783f8899555190a49024ac86d3d76633cd B=
OOT_IMAGE=3D/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f889955519=
0a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88 erst_disable m=
ax_uptime=3D3600 RESULT_ROOT=3D/result/kernel-selftests/group-02-ucode=3D0x=
e2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/g=
cc-9/1c49e3783f8899555190a49024ac86d3d76633cd/3 LKP_SERVER=3Dinternal-lkp-s=
erver nokaslr selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.=
rcu_cpu_stall_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 =
softlockup_panic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 pro=
mpt_ramdisk=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore_logleve=
l console=3Dtty0 earlyprintk=3DttyS0,115200 console=3DttyS0,115200 vga=3Dno=
rmal rw
# pstore_crash_test has not been executed yet. we skip further tests.
ok 2 selftests: pstore: pstore_post_reboot_tests # SKIP
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/pstore'
ptp test: not in Makefile
2019-02-14 10:21:29 make TARGETS=3Dptp
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748910 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748909 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
08 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
08 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
908 s in the future
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574890=
8 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557489=
06 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748904=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
883 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make[1]: Warning: File '../lib.mk' has modification time 55785744 s in the =
future
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:21:57 make run_tests -C ptp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
Makefile:10: warning: overriding recipe for target 'clean'
=2E./lib.mk:123: warning: ignoring old recipe for target 'clean'
make: Warning: File '../lib.mk' has modification time 55785744 s in the fut=
ure
gcc -I../../../../usr/include/    testptp.c  -lrt -o testptp
TAP version 13
1..1
# selftests: ptp: testptp
ok 1 selftests: ptp: testptp
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptp'
2019-02-14 10:21:58 make run_tests -C ptrace
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptrace'
make: Warning: File '../lib.mk' has modification time 55785743 s in the fut=
ure
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    get_syscal=
l_info.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f88995=
55190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/=
src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac8=
6d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests=
-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/=
testing/selftests/ptrace/get_syscall_info
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    peeksiginf=
o.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190=
a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_=
64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testi=
ng/selftests/ptrace/peeksiginfo
gcc -std=3Dc99 -pthread -iquote../../../../include/uapi -Wall    vmaccess.c=
 /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49=
024ac86d3d76633cd/tools/testing/selftests/kselftest_harness.h /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/ptrace/vmaccess
TAP version 13
1..3
# selftests: ptrace: get_syscall_info
# TAP version 13
# 1..1
# # Starting 1 tests from 1 test cases.
# #  RUN           global.get_syscall_info ...
# #            OK  global.get_syscall_info
# ok 1 global.get_syscall_info
# # PASSED: 1 / 1 tests passed.
# # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: ptrace: get_syscall_info
# selftests: ptrace: peeksiginfo
# PASS
ok 2 selftests: ptrace: peeksiginfo
# selftests: ptrace: vmaccess
# TAP version 13
# 1..2
# # Starting 2 tests from 1 test cases.
# #  RUN           global.vmaccess ...
# #            OK  global.vmaccess
# ok 1 global.vmaccess
# #  RUN           global.attach ...
# # attach: Test terminated by timeout
# #          FAIL  global.attach
# not ok 2 global.attach
# # FAILED: 1 / 2 tests passed.
# # Totals: pass:1 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 3 selftests: ptrace: vmaccess # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/ptrace'
2019-02-14 10:22:32 make run_tests -C rtc
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc'
make: Warning: File '../lib.mk' has modification time 55785709 s in the fut=
ure
gcc -O3 -Wl,-no-as-needed -Wall    rtctest.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h -lrt -lpthread -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc=
/rtctest
gcc -O3 -Wl,-no-as-needed -Wall    setdate.c /usr/src/perf_selftests-x86_64=
-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing=
/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kse=
lftest.h -lrt -lpthread -lm -o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc=
/setdate
TAP version 13
1..1
# selftests: rtc: rtctest
# TAP version 13
# 1..7
# # Starting 7 tests from 2 test cases.
# #  RUN           rtc.date_read ...
# # rtctest.c:49:date_read:Current RTC date/time is 06/12/2017 20:30:07.
# #            OK  rtc.date_read
# ok 1 rtc.date_read
# #  RUN           rtc.uie_read ...
# #            OK  rtc.uie_read
# ok 2 rtc.uie_read
# #  RUN           rtc.uie_select ...
# #            OK  rtc.uie_select
# ok 3 rtc.uie_select
# #  RUN           rtc.alarm_alm_set ...
# # rtctest.c:137:alarm_alm_set:Alarm time now set to 20:30:16.
# # rtctest.c:156:alarm_alm_set:data: 1a0
# #            OK  rtc.alarm_alm_set
# ok 4 rtc.alarm_alm_set
# #  RUN           rtc.alarm_wkalm_set ...
# # rtctest.c:195:alarm_wkalm_set:Alarm time now set to 06/12/2017 20:30:19.
# #            OK  rtc.alarm_wkalm_set
# ok 5 rtc.alarm_wkalm_set
# #  RUN           rtc.alarm_alm_set_minute ...
# # rtctest.c:239:alarm_alm_set_minute:Alarm time now set to 20:31:00.
# # rtctest.c:258:alarm_alm_set_minute:data: 1a0
# #            OK  rtc.alarm_alm_set_minute
# ok 6 rtc.alarm_alm_set_minute
# #  RUN           rtc.alarm_wkalm_set_minute ...
# # rtctest.c:297:alarm_wkalm_set_minute:Alarm time now set to 06/12/2017 2=
0:32:00.
#
not ok 1 selftests: rtc: rtctest # TIMEOUT 90 seconds
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/rtc'
safesetid test: not in Makefile
2019-02-14 10:24:25 make TARGETS=3Dsafesetid
make: Warning: File '../../../scripts/subarch.include' has modification tim=
e 55748734 s in the future
make --no-builtin-rules ARCH=3Dx86 -C ../../.. headers_install
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Warning: File 'scripts/Makefile.extrawarn' has modification time 5=
5748733 s in the future
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
33 s in the future
  HOSTCC  scripts/basic/fixdep
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
33 s in the future
  HOSTCC  scripts/unifdef
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
733 s in the future
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.lib' has modification time 5574873=
3 s in the future
  SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
  SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Makefile.host' has modification time 557487=
31 s in the future
  HOSTCC  arch/x86/tools/relocs_32.o
  HOSTCC  arch/x86/tools/relocs_64.o
  HOSTCC  arch/x86/tools/relocs_common.o
  HOSTLD  arch/x86/tools/relocs
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'include/uapi/Kbuild' has modification time 55748728=
 s in the future
  HDRINST usr/include/video/edid.h
  HDRINST usr/include/video/sisfb.h
  HDRINST usr/include/video/uvesafb.h
  HDRINST usr/include/drm/v3d_drm.h
  HDRINST usr/include/drm/radeon_drm.h
  HDRINST usr/include/drm/panfrost_drm.h
  HDRINST usr/include/drm/vgem_drm.h
  HDRINST usr/include/drm/vmwgfx_drm.h
  HDRINST usr/include/drm/drm_fourcc.h
  HDRINST usr/include/drm/i915_drm.h
  HDRINST usr/include/drm/virtgpu_drm.h
  HDRINST usr/include/drm/r128_drm.h
  HDRINST usr/include/drm/amdgpu_drm.h
  HDRINST usr/include/drm/drm_mode.h
  HDRINST usr/include/drm/etnaviv_drm.h
  HDRINST usr/include/drm/mga_drm.h
  HDRINST usr/include/drm/exynos_drm.h
  HDRINST usr/include/drm/nouveau_drm.h
  HDRINST usr/include/drm/vc4_drm.h
  HDRINST usr/include/drm/sis_drm.h
  HDRINST usr/include/drm/drm_sarea.h
  HDRINST usr/include/drm/qxl_drm.h
  HDRINST usr/include/drm/omap_drm.h
  HDRINST usr/include/drm/i810_drm.h
  HDRINST usr/include/drm/savage_drm.h
  HDRINST usr/include/drm/drm.h
  HDRINST usr/include/drm/armada_drm.h
  HDRINST usr/include/drm/msm_drm.h
  HDRINST usr/include/drm/tegra_drm.h
  HDRINST usr/include/drm/lima_drm.h
  HDRINST usr/include/drm/via_drm.h
  HDRINST usr/include/mtd/mtd-user.h
  HDRINST usr/include/mtd/inftl-user.h
  HDRINST usr/include/mtd/ubi-user.h
  HDRINST usr/include/mtd/mtd-abi.h
  HDRINST usr/include/mtd/nftl-user.h
  HDRINST usr/include/xen/gntalloc.h
  HDRINST usr/include/xen/privcmd.h
  HDRINST usr/include/xen/gntdev.h
  HDRINST usr/include/xen/evtchn.h
  HDRINST usr/include/asm-generic/param.h
  HDRINST usr/include/asm-generic/int-l64.h
  HDRINST usr/include/asm-generic/auxvec.h
  HDRINST usr/include/asm-generic/ucontext.h
  HDRINST usr/include/asm-generic/swab.h
  HDRINST usr/include/asm-generic/posix_types.h
  HDRINST usr/include/asm-generic/unistd.h
  HDRINST usr/include/asm-generic/msgbuf.h
  HDRINST usr/include/asm-generic/statfs.h
  HDRINST usr/include/asm-generic/shmbuf.h
  HDRINST usr/include/asm-generic/signal.h
  HDRINST usr/include/asm-generic/ipcbuf.h
  HDRINST usr/include/asm-generic/bpf_perf_event.h
  HDRINST usr/include/asm-generic/ioctl.h
  HDRINST usr/include/asm-generic/sembuf.h
  HDRINST usr/include/asm-generic/resource.h
  HDRINST usr/include/asm-generic/signal-defs.h
  HDRINST usr/include/asm-generic/sockios.h
  HDRINST usr/include/asm-generic/hugetlb_encode.h
  HDRINST usr/include/asm-generic/kvm_para.h
  HDRINST usr/include/asm-generic/termios.h
  HDRINST usr/include/asm-generic/int-ll64.h
  HDRINST usr/include/asm-generic/errno-base.h
  HDRINST usr/include/asm-generic/socket.h
  HDRINST usr/include/asm-generic/termbits.h
  HDRINST usr/include/asm-generic/ioctls.h
  HDRINST usr/include/asm-generic/poll.h
  HDRINST usr/include/asm-generic/fcntl.h
  HDRINST usr/include/asm-generic/mman-common.h
  HDRINST usr/include/asm-generic/mman.h
  HDRINST usr/include/asm-generic/errno.h
  HDRINST usr/include/asm-generic/setup.h
  HDRINST usr/include/asm-generic/siginfo.h
  HDRINST usr/include/asm-generic/stat.h
  HDRINST usr/include/asm-generic/bitsperlong.h
  HDRINST usr/include/asm-generic/types.h
  HDRINST usr/include/rdma/rdma_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mthca-abi.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_cmds.h
  HDRINST usr/include/rdma/mlx5-abi.h
  HDRINST usr/include/rdma/rvt-abi.h
  HDRINST usr/include/rdma/rdma_netlink.h
  HDRINST usr/include/rdma/ib_user_mad.h
  HDRINST usr/include/rdma/rdma_user_ioctl.h
  HDRINST usr/include/rdma/ib_user_verbs.h
  HDRINST usr/include/rdma/rdma_user_rxe.h
  HDRINST usr/include/rdma/ib_user_sa.h
  HDRINST usr/include/rdma/bnxt_re-abi.h
  HDRINST usr/include/rdma/vmw_pvrdma-abi.h
  HDRINST usr/include/rdma/ocrdma-abi.h
  HDRINST usr/include/rdma/qedr-abi.h
  HDRINST usr/include/rdma/i40iw-abi.h
  HDRINST usr/include/rdma/hns-abi.h
  HDRINST usr/include/rdma/rdma_user_cm.h
  HDRINST usr/include/rdma/ib_user_ioctl_verbs.h
  HDRINST usr/include/rdma/ib_user_ioctl_cmds.h
  HDRINST usr/include/rdma/efa-abi.h
  HDRINST usr/include/rdma/cxgb4-abi.h
  HDRINST usr/include/rdma/siw-abi.h
  HDRINST usr/include/rdma/mlx4-abi.h
  HDRINST usr/include/rdma/hfi/hfi1_user.h
  HDRINST usr/include/rdma/hfi/hfi1_ioctl.h
  HDRINST usr/include/rdma/mlx5_user_ioctl_verbs.h
  HDRINST usr/include/misc/xilinx_sdfec.h
  HDRINST usr/include/misc/fastrpc.h
  HDRINST usr/include/misc/habanalabs.h
  HDRINST usr/include/misc/ocxl.h
  HDRINST usr/include/misc/cxl.h
  HDRINST usr/include/misc/pvpanic.h
  HDRINST usr/include/misc/uacce/hisi_qm.h
  HDRINST usr/include/misc/uacce/uacce.h
  HDRINST usr/include/linux/if_tun.h
  HDRINST usr/include/linux/msg.h
  HDRINST usr/include/linux/mrp_bridge.h
  HDRINST usr/include/linux/synclink.h
  HDRINST usr/include/linux/close_range.h
  HDRINST usr/include/linux/v4l2-controls.h
  HDRINST usr/include/linux/dlm_netlink.h
  HDRINST usr/include/linux/isdn/capicmd.h
  HDRINST usr/include/linux/virtio_pmem.h
  HDRINST usr/include/linux/param.h
  HDRINST usr/include/linux/raid/md_u.h
  HDRINST usr/include/linux/raid/md_p.h
  HDRINST usr/include/linux/virtio_types.h
  HDRINST usr/include/linux/bcm933xx_hcs.h
  HDRINST usr/include/linux/zorro.h
  HDRINST usr/include/linux/btf.h
  HDRINST usr/include/linux/memfd.h
  HDRINST usr/include/linux/genwqe/genwqe_card.h
  HDRINST usr/include/linux/elf.h
  HDRINST usr/include/linux/virtio_vsock.h
  HDRINST usr/include/linux/wmi.h
  HDRINST usr/include/linux/irqnr.h
  HDRINST usr/include/linux/phantom.h
  HDRINST usr/include/linux/netfilter_decnet.h
  HDRINST usr/include/linux/map_to_7segment.h
  HDRINST usr/include/linux/gen_stats.h
  HDRINST usr/include/linux/aio_abi.h
  HDRINST usr/include/linux/netfilter_arp.h
  HDRINST usr/include/linux/pidfd.h
  HDRINST usr/include/linux/blkpg.h
  HDRINST usr/include/linux/kdev_t.h
  HDRINST usr/include/linux/if_bridge.h
  HDRINST usr/include/linux/ip6_tunnel.h
  HDRINST usr/include/linux/adb.h
  HDRINST usr/include/linux/virtio_input.h
  HDRINST usr/include/linux/bcache.h
  HDRINST usr/include/linux/if_infiniband.h
  HDRINST usr/include/linux/agpgart.h
  HDRINST usr/include/linux/target_core_user.h
  HDRINST usr/include/linux/atm_nicstar.h
  HDRINST usr/include/linux/tc_ematch/tc_em_cmp.h
  HDRINST usr/include/linux/tc_ematch/tc_em_meta.h
  HDRINST usr/include/linux/tc_ematch/tc_em_ipt.h
  HDRINST usr/include/linux/tc_ematch/tc_em_nbyte.h
  HDRINST usr/include/linux/tc_ematch/tc_em_text.h
  HDRINST usr/include/linux/smc.h
  HDRINST usr/include/linux/uleds.h
  HDRINST usr/include/linux/binfmts.h
  HDRINST usr/include/linux/virtio_pci.h
  HDRINST usr/include/linux/tcp_metrics.h
  HDRINST usr/include/linux/virtio_blk.h
  HDRINST usr/include/linux/rfkill.h
  HDRINST usr/include/linux/psample.h
  HDRINST usr/include/linux/falloc.h
  HDRINST usr/include/linux/raw.h
  HDRINST usr/include/linux/mroute.h
  HDRINST usr/include/linux/ppp-ioctl.h
  HDRINST usr/include/linux/sed-opal.h
  HDRINST usr/include/linux/ipsec.h
  HDRINST usr/include/linux/net_dropmon.h
  HDRINST usr/include/linux/ipc.h
  HDRINST usr/include/linux/virtio_gpu.h
  HDRINST usr/include/linux/joystick.h
  HDRINST usr/include/linux/if_fddi.h
  HDRINST usr/include/linux/if_alg.h
  HDRINST usr/include/linux/vsockmon.h
  HDRINST usr/include/linux/watch_queue.h
  HDRINST usr/include/linux/arm_sdei.h
  HDRINST usr/include/linux/cycx_cfm.h
  HDRINST usr/include/linux/tty_flags.h
  HDRINST usr/include/linux/ip.h
  HDRINST usr/include/linux/fdreg.h
  HDRINST usr/include/linux/qrtr.h
  HDRINST usr/include/linux/quota.h
  HDRINST usr/include/linux/rtc.h
  HDRINST usr/include/linux/hiddev.h
  HDRINST usr/include/linux/dlm.h
  HDRINST usr/include/linux/pr.h
  HDRINST usr/include/linux/psp-sev.h
  HDRINST usr/include/linux/wireless.h
  HDRINST usr/include/linux/nfs_fs.h
  HDRINST usr/include/linux/openat2.h
  HDRINST usr/include/linux/qnx4_fs.h
  HDRINST usr/include/linux/android/binderfs.h
  HDRINST usr/include/linux/android/binder.h
  HDRINST usr/include/linux/inotify.h
  HDRINST usr/include/linux/soundcard.h
  HDRINST usr/include/linux/auxvec.h
  HDRINST usr/include/linux/am437x-vpfe.h
  HDRINST usr/include/linux/fadvise.h
  HDRINST usr/include/linux/radeonfb.h
  HDRINST usr/include/linux/gtp.h
  HDRINST usr/include/linux/ipmi.h
  HDRINST usr/include/linux/uuid.h
  HDRINST usr/include/linux/usbip.h
  HDRINST usr/include/linux/if_ether.h
  HDRINST usr/include/linux/i2c-dev.h
  HDRINST usr/include/linux/cm4000_cs.h
  HDRINST usr/include/linux/xilinx-v4l2-controls.h
  HDRINST usr/include/linux/serio.h
  HDRINST usr/include/linux/tipc_config.h
  HDRINST usr/include/linux/if_xdp.h
  HDRINST usr/include/linux/kfd_ioctl.h
  HDRINST usr/include/linux/dns_resolver.h
  HDRINST usr/include/linux/ethtool.h
  HDRINST usr/include/linux/if_packet.h
  HDRINST usr/include/linux/if_addrlabel.h
  HDRINST usr/include/linux/sysctl.h
  HDRINST usr/include/linux/ptp_clock.h
  HDRINST usr/include/linux/cgroupstats.h
  HDRINST usr/include/linux/tcp.h
  HDRINST usr/include/linux/swab.h
  HDRINST usr/include/linux/atmapi.h
  HDRINST usr/include/linux/if_link.h
  HDRINST usr/include/linux/atmppp.h
  HDRINST usr/include/linux/vbox_err.h
  HDRINST usr/include/linux/posix_types.h
  HDRINST usr/include/linux/adfs_fs.h
  HDRINST usr/include/linux/aspeed-lpc-ctrl.h
  HDRINST usr/include/linux/mpls_iptunnel.h
  HDRINST usr/include/linux/netdevice.h
  HDRINST usr/include/linux/unistd.h
  HDRINST usr/include/linux/mptcp.h
  HDRINST usr/include/linux/gpio.h
  HDRINST usr/include/linux/scif_ioctl.h
  HDRINST usr/include/linux/hidraw.h
  HDRINST usr/include/linux/atm.h
  HDRINST usr/include/linux/media-bus-format.h
  HDRINST usr/include/linux/fsl_hypervisor.h
  HDRINST usr/include/linux/ptrace.h
  HDRINST usr/include/linux/rpmsg.h
  HDRINST usr/include/linux/time.h
  HDRINST usr/include/linux/rtnetlink.h
  HDRINST usr/include/linux/i2o-dev.h
  HDRINST usr/include/linux/serial_reg.h
  HDRINST usr/include/linux/nfs4_mount.h
  HDRINST usr/include/linux/caif/if_caif.h
  HDRINST usr/include/linux/caif/caif_socket.h
  HDRINST usr/include/linux/in6.h
  HDRINST usr/include/linux/atmioc.h
  HDRINST usr/include/linux/membarrier.h
  HDRINST usr/include/linux/magic.h
  HDRINST usr/include/linux/dqblk_xfs.h
  HDRINST usr/include/linux/times.h
  HDRINST usr/include/linux/personality.h
  HDRINST usr/include/linux/snmp.h
  HDRINST usr/include/linux/vhost.h
  HDRINST usr/include/linux/keyboard.h
  HDRINST usr/include/linux/futex.h
  HDRINST usr/include/linux/if_ppp.h
  HDRINST usr/include/linux/dma-buf.h
  HDRINST usr/include/linux/nilfs2_ondisk.h
  HDRINST usr/include/linux/dm-log-userspace.h
  HDRINST usr/include/linux/dlm_plock.h
  HDRINST usr/include/linux/sysinfo.h
  HDRINST usr/include/linux/uhid.h
  HDRINST usr/include/linux/icmpv6.h
  HDRINST usr/include/linux/utsname.h
  HDRINST usr/include/linux/if.h
  HDRINST usr/include/linux/const.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ECN.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ah.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_CLUSTERIP.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_LOG.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_TTL.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv4/ip_tables.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ecn.h
  HDRINST usr/include/linux/netfilter_ipv4/ipt_ttl.h
  HDRINST usr/include/linux/capi.h
  HDRINST usr/include/linux/virtio_ids.h
  HDRINST usr/include/linux/openvswitch.h
  HDRINST usr/include/linux/virtio_iommu.h
  HDRINST usr/include/linux/cramfs_fs.h
  HDRINST usr/include/linux/signal.h
  HDRINST usr/include/linux/apm_bios.h
  HDRINST usr/include/linux/limits.h
  HDRINST usr/include/linux/oom.h
  HDRINST usr/include/linux/ivtvfb.h
  HDRINST usr/include/linux/rio_mport_cdev.h
  HDRINST usr/include/linux/batadv_packet.h
  HDRINST usr/include/linux/nvme_ioctl.h
  HDRINST usr/include/linux/sched/types.h
  HDRINST usr/include/linux/neighbour.h
  HDRINST usr/include/linux/hdlcdrv.h
  HDRINST usr/include/linux/vtpm_proxy.h
  HDRINST usr/include/linux/cciss_defs.h
  HDRINST usr/include/linux/seccomp.h
  HDRINST usr/include/linux/kernelcapi.h
  HDRINST usr/include/linux/sound.h
  HDRINST usr/include/linux/nfs.h
  HDRINST usr/include/linux/wireguard.h
  HDRINST usr/include/linux/seg6_iptunnel.h
  HDRINST usr/include/linux/firewire-cdev.h
  HDRINST usr/include/linux/vm_sockets_diag.h
  HDRINST usr/include/linux/un.h
  HDRINST usr/include/linux/romfs_fs.h
  HDRINST usr/include/linux/hdlc/ioctl.h
  HDRINST usr/include/linux/cuda.h
  HDRINST usr/include/linux/mmc/ioctl.h
  HDRINST usr/include/linux/bfs_fs.h
  HDRINST usr/include/linux/seg6_genl.h
  HDRINST usr/include/linux/ipx.h
  HDRINST usr/include/linux/serial.h
  HDRINST usr/include/linux/if_eql.h
  HDRINST usr/include/linux/btrfs_tree.h
  HDRINST usr/include/linux/ppp-comp.h
  HDRINST usr/include/linux/nbd.h
  HDRINST usr/include/linux/mic_ioctl.h
  HDRINST usr/include/linux/hyperv.h
  HDRINST usr/include/linux/auto_dev-ioctl.h
  HDRINST usr/include/linux/if_arp.h
  HDRINST usr/include/linux/uio.h
  HDRINST usr/include/linux/xfrm.h
  HDRINST usr/include/linux/bpf_perf_event.h
  HDRINST usr/include/linux/nfs_mount.h
  HDRINST usr/include/linux/cifs/cifs_mount.h
  HDRINST usr/include/linux/um_timetravel.h
  HDRINST usr/include/linux/keyctl.h
  HDRINST usr/include/linux/virtio_balloon.h
  HDRINST usr/include/linux/netfilter_ipv4.h
  HDRINST usr/include/linux/pmu.h
  HDRINST usr/include/linux/xattr.h
  HDRINST usr/include/linux/fuse.h
  HDRINST usr/include/linux/mempolicy.h
  HDRINST usr/include/linux/cryptouser.h
  HDRINST usr/include/linux/hsr_netlink.h
  HDRINST usr/include/linux/ioctl.h
  HDRINST usr/include/linux/mei.h
  HDRINST usr/include/linux/string.h
  HDRINST usr/include/linux/pg.h
  HDRINST usr/include/linux/unix_diag.h
  HDRINST usr/include/linux/byteorder/little_endian.h
  HDRINST usr/include/linux/byteorder/big_endian.h
  HDRINST usr/include/linux/meye.h
  HDRINST usr/include/linux/kernel.h
  HDRINST usr/include/linux/gsmmux.h
  HDRINST usr/include/linux/lirc.h
  HDRINST usr/include/linux/iio/events.h
  HDRINST usr/include/linux/iio/types.h
  HDRINST usr/include/linux/coff.h
  HDRINST usr/include/linux/if_phonet.h
  HDRINST usr/include/linux/v4l2-mediabus.h
  HDRINST usr/include/linux/sock_diag.h
  HDRINST usr/include/linux/ppp_defs.h
  HDRINST usr/include/linux/nfs_idmap.h
  HDRINST usr/include/linux/vm_sockets.h
  HDRINST usr/include/linux/llc.h
  HDRINST usr/include/linux/dvb/version.h
  HDRINST usr/include/linux/dvb/video.h
  HDRINST usr/include/linux/dvb/osd.h
  HDRINST usr/include/linux/dvb/audio.h
  HDRINST usr/include/linux/dvb/net.h
  HDRINST usr/include/linux/dvb/dmx.h
  HDRINST usr/include/linux/dvb/frontend.h
  HDRINST usr/include/linux/dvb/ca.h
  HDRINST usr/include/linux/timerfd.h
  HDRINST usr/include/linux/utime.h
  HDRINST usr/include/linux/hsi/hsi_char.h
  HDRINST usr/include/linux/hsi/cs-protocol.h
  HDRINST usr/include/linux/nfs4.h
  HDRINST usr/include/linux/posix_acl_xattr.h
  HDRINST usr/include/linux/mtio.h
  HDRINST usr/include/linux/io_uring.h
  HDRINST usr/include/linux/bsg.h
  HDRINST usr/include/linux/sctp.h
  HDRINST usr/include/linux/ipmi_msgdefs.h
  HDRINST usr/include/linux/cyclades.h
  HDRINST usr/include/linux/v4l2-common.h
  HDRINST usr/include/linux/if_addr.h
  HDRINST usr/include/linux/sched.h
  HDRINST usr/include/linux/reiserfs_fs.h
  HDRINST usr/include/linux/sonet.h
  HDRINST usr/include/linux/max2175.h
  HDRINST usr/include/linux/scc.h
  HDRINST usr/include/linux/seg6_local.h
  HDRINST usr/include/linux/nexthop.h
  HDRINST usr/include/linux/mdio.h
  HDRINST usr/include/linux/userfaultfd.h
  HDRINST usr/include/linux/seg6_hmac.h
  HDRINST usr/include/linux/edd.h
  HDRINST usr/include/linux/dn.h
  HDRINST usr/include/linux/netfilter.h
  HDRINST usr/include/linux/ax25.h
  HDRINST usr/include/linux/mroute6.h
  HDRINST usr/include/linux/posix_acl.h
  HDRINST usr/include/linux/selinux_netlink.h
  HDRINST usr/include/linux/vhost_types.h
  HDRINST usr/include/linux/netfilter_ipv6.h
  HDRINST usr/include/linux/nfs2.h
  HDRINST usr/include/linux/pkt_cls.h
  HDRINST usr/include/linux/if_slip.h
  HDRINST usr/include/linux/if_macsec.h
  HDRINST usr/include/linux/fiemap.h
  HDRINST usr/include/linux/fpga-dfl.h
  HDRINST usr/include/linux/input-event-codes.h
  HDRINST usr/include/linux/fb.h
  HDRINST usr/include/linux/kcmp.h
  HDRINST usr/include/linux/sem.h
  HDRINST usr/include/linux/kcov.h
  HDRINST usr/include/linux/hdlc.h
  HDRINST usr/include/linux/bpfilter.h
  HDRINST usr/include/linux/if_arcnet.h
  HDRINST usr/include/linux/seg6.h
  HDRINST usr/include/linux/tipc.h
  HDRINST usr/include/linux/cec-funcs.h
  HDRINST usr/include/linux/resource.h
  HDRINST usr/include/linux/ife.h
  HDRINST usr/include/linux/virtio_crypto.h
  HDRINST usr/include/linux/matroxfb.h
  HDRINST usr/include/linux/if_plip.h
  HDRINST usr/include/linux/ethtool_netlink.h
  HDRINST usr/include/linux/omapfb.h
  HDRINST usr/include/linux/v4l2-subdev.h
  HDRINST usr/include/linux/fs.h
  HDRINST usr/include/linux/uinput.h
  HDRINST usr/include/linux/smc_diag.h
  HDRINST usr/include/linux/if_team.h
  HDRINST usr/include/linux/coda.h
  HDRINST usr/include/linux/hid.h
  HDRINST usr/include/linux/sockios.h
  HDRINST usr/include/linux/shm.h
  HDRINST usr/include/linux/tee.h
  HDRINST usr/include/linux/netfilter/xt_LOG.h
  HDRINST usr/include/linux/netfilter/nfnetlink_compat.h
  HDRINST usr/include/linux/netfilter/xt_CT.h
  HDRINST usr/include/linux/netfilter/xt_cpu.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_ftp.h
  HDRINST usr/include/linux/netfilter/xt_ecn.h
  HDRINST usr/include/linux/netfilter/xt_connlabel.h
  HDRINST usr/include/linux/netfilter/xt_SECMARK.h
  HDRINST usr/include/linux/netfilter/xt_TEE.h
  HDRINST usr/include/linux/netfilter/xt_esp.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tuple_common.h
  HDRINST usr/include/linux/netfilter/nfnetlink_queue.h
  HDRINST usr/include/linux/netfilter/x_tables.h
  HDRINST usr/include/linux/netfilter/nfnetlink_acct.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_sctp.h
  HDRINST usr/include/linux/netfilter/xt_LED.h
  HDRINST usr/include/linux/netfilter/xt_statistic.h
  HDRINST usr/include/linux/netfilter/xt_TCPMSS.h
  HDRINST usr/include/linux/netfilter/xt_addrtype.h
  HDRINST usr/include/linux/netfilter/xt_SYNPROXY.h
  HDRINST usr/include/linux/netfilter/xt_realm.h
  HDRINST usr/include/linux/netfilter/xt_mac.h
  HDRINST usr/include/linux/netfilter/xt_socket.h
  HDRINST usr/include/linux/netfilter/xt_u32.h
  HDRINST usr/include/linux/netfilter/xt_set.h
  HDRINST usr/include/linux/netfilter/nf_nat.h
  HDRINST usr/include/linux/netfilter/xt_time.h
  HDRINST usr/include/linux/netfilter/nfnetlink_log.h
  HDRINST usr/include/linux/netfilter/xt_RATEEST.h
  HDRINST usr/include/linux/netfilter/nfnetlink.h
  HDRINST usr/include/linux/netfilter/xt_multiport.h
  HDRINST usr/include/linux/netfilter/xt_helper.h
  HDRINST usr/include/linux/netfilter/xt_cgroup.h
  HDRINST usr/include/linux/netfilter/xt_MARK.h
  HDRINST usr/include/linux/netfilter/xt_connmark.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_bitmap.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_hash.h
  HDRINST usr/include/linux/netfilter/ipset/ip_set_list.h
  HDRINST usr/include/linux/netfilter/xt_l2tp.h
  HDRINST usr/include/linux/netfilter/xt_comment.h
  HDRINST usr/include/linux/netfilter/nf_log.h
  HDRINST usr/include/linux/netfilter/xt_ipcomp.h
  HDRINST usr/include/linux/netfilter/xt_state.h
  HDRINST usr/include/linux/netfilter/xt_DSCP.h
  HDRINST usr/include/linux/netfilter/xt_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_nfacct.h
  HDRINST usr/include/linux/netfilter/xt_TCPOPTSTRIP.h
  HDRINST usr/include/linux/netfilter/xt_length.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_tcp.h
  HDRINST usr/include/linux/netfilter/xt_pkttype.h
  HDRINST usr/include/linux/netfilter/xt_NFQUEUE.h
  HDRINST usr/include/linux/netfilter/xt_osf.h
  HDRINST usr/include/linux/netfilter/xt_recent.h
  HDRINST usr/include/linux/netfilter/nf_conntrack_common.h
  HDRINST usr/include/linux/netfilter/xt_dccp.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cttimeout.h
  HDRINST usr/include/linux/netfilter/xt_mark.h
  HDRINST usr/include/linux/netfilter/nfnetlink_cthelper.h
  HDRINST usr/include/linux/netfilter/xt_bpf.h
  HDRINST usr/include/linux/netfilter/xt_quota.h
  HDRINST usr/include/linux/netfilter/nf_tables_compat.h
  HDRINST usr/include/linux/netfilter/xt_policy.h
  HDRINST usr/include/linux/netfilter/xt_tcpudp.h
  HDRINST usr/include/linux/netfilter/xt_NFLOG.h
  HDRINST usr/include/linux/netfilter/xt_TPROXY.h
  HDRINST usr/include/linux/netfilter/xt_rateest.h
  HDRINST usr/include/linux/netfilter/xt_hashlimit.h
  HDRINST usr/include/linux/netfilter/xt_CONNMARK.h
  HDRINST usr/include/linux/netfilter/xt_CONNSECMARK.h
  HDRINST usr/include/linux/netfilter/xt_connbytes.h
  HDRINST usr/include/linux/netfilter/nfnetlink_conntrack.h
  HDRINST usr/include/linux/netfilter/xt_HMARK.h
  HDRINST usr/include/linux/netfilter/nf_synproxy.h
  HDRINST usr/include/linux/netfilter/xt_sctp.h
  HDRINST usr/include/linux/netfilter/xt_devgroup.h
  HDRINST usr/include/linux/netfilter/xt_cluster.h
  HDRINST usr/include/linux/netfilter/xt_owner.h
  HDRINST usr/include/linux/netfilter/nf_tables.h
  HDRINST usr/include/linux/netfilter/xt_rpfilter.h
  HDRINST usr/include/linux/netfilter/xt_string.h
  HDRINST usr/include/linux/netfilter/xt_IDLETIMER.h
  HDRINST usr/include/linux/netfilter/xt_physdev.h
  HDRINST usr/include/linux/netfilter/xt_CHECKSUM.h
  HDRINST usr/include/linux/netfilter/xt_dscp.h
  HDRINST usr/include/linux/netfilter/xt_tcpmss.h
  HDRINST usr/include/linux/netfilter/xt_iprange.h
  HDRINST usr/include/linux/netfilter/nfnetlink_osf.h
  HDRINST usr/include/linux/netfilter/xt_ipvs.h
  HDRINST usr/include/linux/netfilter/xt_connlimit.h
  HDRINST usr/include/linux/netfilter/xt_limit.h
  HDRINST usr/include/linux/netfilter/xt_AUDIT.h
  HDRINST usr/include/linux/netfilter/xt_CLASSIFY.h
  HDRINST usr/include/linux/virtio_mem.h
  HDRINST usr/include/linux/dlm_device.h
  HDRINST usr/include/linux/dlmconstants.h
  HDRINST usr/include/linux/suspend_ioctls.h
  HDRINST usr/include/linux/errqueue.h
  HDRINST usr/include/linux/fsmap.h
  HDRINST usr/include/linux/kvm_para.h
  HDRINST usr/include/linux/rseq.h
  HDRINST usr/include/linux/cdrom.h
  HDRINST usr/include/linux/fd.h
  HDRINST usr/include/linux/pktcdvd.h
  HDRINST usr/include/linux/ivtv.h
  HDRINST usr/include/linux/udf_fs_i.h
  HDRINST usr/include/linux/lightnvm.h
  HDRINST usr/include/linux/blkzoned.h
  HDRINST usr/include/linux/netlink_diag.h
  HDRINST usr/include/linux/sunrpc/debug.h
  HDRINST usr/include/linux/tipc_netlink.h
  HDRINST usr/include/linux/aspeed-p2a-ctrl.h
  HDRINST usr/include/linux/atm_he.h
  HDRINST usr/include/linux/auto_fs4.h
  HDRINST usr/include/linux/can.h
  HDRINST usr/include/linux/atm_eni.h
  HDRINST usr/include/linux/sonypi.h
  HDRINST usr/include/linux/efs_fs_sb.h
  HDRINST usr/include/linux/bpf_common.h
  HDRINST usr/include/linux/libc-compat.h
  HDRINST usr/include/linux/uvcvideo.h
  HDRINST usr/include/linux/genetlink.h
  HDRINST usr/include/linux/if_x25.h
  HDRINST usr/include/linux/n_r3964.h
  HDRINST usr/include/linux/net.h
  HDRINST usr/include/linux/atmsap.h
  HDRINST usr/include/linux/virtio_mmio.h
  HDRINST usr/include/linux/if_cablemodem.h
  HDRINST usr/include/linux/toshiba.h
  HDRINST usr/include/linux/nubus.h
  HDRINST usr/include/linux/virtio_net.h
  HDRINST usr/include/linux/rxrpc.h
  HDRINST usr/include/linux/batman_adv.h
  HDRINST usr/include/linux/tty.h
  HDRINST usr/include/linux/rose.h
  HDRINST usr/include/linux/stm.h
  HDRINST usr/include/linux/gfs2_ondisk.h
  HDRINST usr/include/linux/if_bonding.h
  HDRINST usr/include/linux/tc_act/tc_ife.h
  HDRINST usr/include/linux/tc_act/tc_skbedit.h
  HDRINST usr/include/linux/tc_act/tc_defact.h
  HDRINST usr/include/linux/tc_act/tc_bpf.h
  HDRINST usr/include/linux/tc_act/tc_tunnel_key.h
  HDRINST usr/include/linux/tc_act/tc_gact.h
  HDRINST usr/include/linux/tc_act/tc_ct.h
  HDRINST usr/include/linux/tc_act/tc_ctinfo.h
  HDRINST usr/include/linux/tc_act/tc_sample.h
  HDRINST usr/include/linux/tc_act/tc_mirred.h
  HDRINST usr/include/linux/tc_act/tc_gate.h
  HDRINST usr/include/linux/tc_act/tc_nat.h
  HDRINST usr/include/linux/tc_act/tc_connmark.h
  HDRINST usr/include/linux/tc_act/tc_mpls.h
  HDRINST usr/include/linux/tc_act/tc_csum.h
  HDRINST usr/include/linux/tc_act/tc_pedit.h
  HDRINST usr/include/linux/tc_act/tc_vlan.h
  HDRINST usr/include/linux/tc_act/tc_ipt.h
  HDRINST usr/include/linux/tc_act/tc_skbmod.h
  HDRINST usr/include/linux/mqueue.h
  HDRINST usr/include/linux/kd.h
  HDRINST usr/include/linux/vfio_zdev.h
  HDRINST usr/include/linux/ip_vs.h
  HDRINST usr/include/linux/atm_idt77105.h
  HDRINST usr/include/linux/atmdev.h
  HDRINST usr/include/linux/atalk.h
  HDRINST usr/include/linux/isst_if.h
  HDRINST usr/include/linux/nilfs2_api.h
  HDRINST usr/include/linux/ppdev.h
  HDRINST usr/include/linux/if_tunnel.h
  HDRINST usr/include/linux/termios.h
  HDRINST usr/include/linux/reiserfs_xattr.h
  HDRINST usr/include/linux/affs_hardblocks.h
  HDRINST usr/include/linux/timex.h
  HDRINST usr/include/linux/elf-em.h
  HDRINST usr/include/linux/phonet.h
  HDRINST usr/include/linux/erspan.h
  HDRINST usr/include/linux/i8k.h
  HDRINST usr/include/linux/netrom.h
  HDRINST usr/include/linux/iommu.h
  HDRINST usr/include/linux/blktrace_api.h
  HDRINST usr/include/linux/dma-heap.h
  HDRINST usr/include/linux/random.h
  HDRINST usr/include/linux/bpqether.h
  HDRINST usr/include/linux/if_ltalk.h
  HDRINST usr/include/linux/virtio_config.h
  HDRINST usr/include/linux/switchtec_ioctl.h
  HDRINST usr/include/linux/nfs3.h
  HDRINST usr/include/linux/mount.h
  HDRINST usr/include/linux/atmmpc.h
  HDRINST usr/include/linux/netfilter_bridge.h
  HDRINST usr/include/linux/omap3isp.h
  HDRINST usr/include/linux/udp.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_HL.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_NPT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_rt.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ipv6header.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_LOG.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_srh.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_REJECT.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6_tables.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_opts.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_frag.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_hl.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_ah.h
  HDRINST usr/include/linux/netfilter_ipv6/ip6t_mh.h
  HDRINST usr/include/linux/fib_rules.h
  HDRINST usr/include/linux/zorro_ids.h
  HDRINST usr/include/linux/inet_diag.h
  HDRINST usr/include/linux/i2c.h
  HDRINST usr/include/linux/vboxguest.h
  HDRINST usr/include/linux/elf-fdpic.h
  HDRINST usr/include/linux/loop.h
  HDRINST usr/include/linux/bt-bmc.h
  HDRINST usr/include/linux/atmarp.h
  HDRINST usr/include/linux/reboot.h
  HDRINST usr/include/linux/minix_fs.h
  HDRINST usr/include/linux/vt.h
  HDRINST usr/include/linux/videodev2.h
  HDRINST usr/include/linux/socket.h
  HDRINST usr/include/linux/icmp.h
  HDRINST usr/include/linux/ila.h
  HDRINST usr/include/linux/if_fc.h
  HDRINST usr/include/linux/lp.h
  HDRINST usr/include/linux/jffs2.h
  HDRINST usr/include/linux/fsi.h
  HDRINST usr/include/linux/in_route.h
  HDRINST usr/include/linux/ipv6_route.h
  HDRINST usr/include/linux/l2tp.h
  HDRINST usr/include/linux/tls.h
  HDRINST usr/include/linux/dccp.h
  HDRINST usr/include/linux/pci.h
  HDRINST usr/include/linux/chio.h
  HDRINST usr/include/linux/coresight-stm.h
  HDRINST usr/include/linux/tipc_sockets_diag.h
  HDRINST usr/include/linux/ncsi.h
  HDRINST usr/include/linux/atmbr2684.h
  HDRINST usr/include/linux/spi/spidev.h
  HDRINST usr/include/linux/veth.h
  HDRINST usr/include/linux/dcbnl.h
  HDRINST usr/include/linux/xdp_diag.h
  HDRINST usr/include/linux/parport.h
  HDRINST usr/include/linux/smiapp.h
  HDRINST usr/include/linux/nfsacl.h
  HDRINST usr/include/linux/packet_diag.h
  HDRINST usr/include/linux/baycom.h
  HDRINST usr/include/linux/tiocl.h
  HDRINST usr/include/linux/kvm.h
  HDRINST usr/include/linux/if_hippi.h
  HDRINST usr/include/linux/firewire-constants.h
  HDRINST usr/include/linux/netfilter_arp/arpt_mangle.h
  HDRINST usr/include/linux/netfilter_arp/arp_tables.h
  HDRINST usr/include/linux/can/gw.h
  HDRINST usr/include/linux/can/raw.h
  HDRINST usr/include/linux/can/isotp.h
  HDRINST usr/include/linux/can/bcm.h
  HDRINST usr/include/linux/can/error.h
  HDRINST usr/include/linux/can/j1939.h
  HDRINST usr/include/linux/can/netlink.h
  HDRINST usr/include/linux/can/vxcan.h
  HDRINST usr/include/linux/signalfd.h
  HDRINST usr/include/linux/arcfb.h
  HDRINST usr/include/linux/sync_file.h
  HDRINST usr/include/linux/pps.h
  HDRINST usr/include/linux/taskstats.h
  HDRINST usr/include/linux/rpl_iptunnel.h
  HDRINST usr/include/linux/nbd-netlink.h
  HDRINST usr/include/linux/auto_fs.h
  HDRINST usr/include/linux/perf_event.h
  HDRINST usr/include/linux/devlink.h
  HDRINST usr/include/linux/net_namespace.h
  HDRINST usr/include/linux/atmclip.h
  HDRINST usr/include/linux/prctl.h
  HDRINST usr/include/linux/acct.h
  HDRINST usr/include/linux/cn_proc.h
  HDRINST usr/include/linux/if_vlan.h
  HDRINST usr/include/linux/nfc.h
  HDRINST usr/include/linux/poll.h
  HDRINST usr/include/linux/ipmi_bmc.h
  HDRINST usr/include/linux/usbdevice_fs.h
  HDRINST usr/include/linux/kernel-page-flags.h
  HDRINST usr/include/linux/atm_zatm.h
  HDRINST usr/include/linux/patchkey.h
  HDRINST usr/include/linux/virtio_scsi.h
  HDRINST usr/include/linux/nfsd/cld.h
  HDRINST usr/include/linux/nfsd/nfsfh.h
  HDRINST usr/include/linux/nfsd/debug.h
  HDRINST usr/include/linux/nfsd/export.h
  HDRINST usr/include/linux/nfsd/stats.h
  HDRINST usr/include/linux/gameport.h
  HDRINST usr/include/linux/stddef.h
  HDRINST usr/include/linux/a.out.h
  HDRINST usr/include/linux/qnxtypes.h
  HDRINST usr/include/linux/vfio.h
  HDRINST usr/include/linux/idxd.h
  HDRINST usr/include/linux/pci_regs.h
  HDRINST usr/include/linux/eventpoll.h
  HDRINST usr/include/linux/pkt_sched.h
  HDRINST usr/include/linux/fcntl.h
  HDRINST usr/include/linux/nl80211.h
  HDRINST usr/include/linux/btrfs.h
  HDRINST usr/include/linux/igmp.h
  HDRINST usr/include/linux/netfilter_bridge/ebtables.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_stp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_redirect.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_log.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_pkttype.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nat.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arp.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_802_3.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_among.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_limit.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_arpreply.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip6.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_t.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_vlan.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_ip.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_nflog.h
  HDRINST usr/include/linux/netfilter_bridge/ebt_mark_m.h
  HDRINST usr/include/linux/net_tstamp.h
  HDRINST usr/include/linux/connector.h
  HDRINST usr/include/linux/screen_info.h
  HDRINST usr/include/linux/if_pppol2tp.h
  HDRINST usr/include/linux/kcm.h
  HDRINST usr/include/linux/sdla.h
  HDRINST usr/include/linux/mic_common.h
  HDRINST usr/include/linux/atmsvc.h
  HDRINST usr/include/linux/time_types.h
  HDRINST usr/include/linux/netlink.h
  HDRINST usr/include/linux/hdreg.h
  HDRINST usr/include/linux/serial_core.h
  HDRINST usr/include/linux/v4l2-dv-timings.h
  HDRINST usr/include/linux/input.h
  HDRINST usr/include/linux/media.h
  HDRINST usr/include/linux/atmlec.h
  HDRINST usr/include/linux/hpet.h
  HDRINST usr/include/linux/atm_tcp.h
  HDRINST usr/include/linux/remoteproc_cdev.h
  HDRINST usr/include/linux/securebits.h
  HDRINST usr/include/linux/virtio_9p.h
  HDRINST usr/include/linux/mman.h
  HDRINST usr/include/linux/wimax.h
  HDRINST usr/include/linux/kexec.h
  HDRINST usr/include/linux/x25.h
  HDRINST usr/include/linux/msdos_fs.h
  HDRINST usr/include/linux/netconf.h
  HDRINST usr/include/linux/mmtimer.h
  HDRINST usr/include/linux/errno.h
  HDRINST usr/include/linux/cec.h
  HDRINST usr/include/linux/usb/tmc.h
  HDRINST usr/include/linux/usb/video.h
  HDRINST usr/include/linux/usb/g_uvc.h
  HDRINST usr/include/linux/usb/midi.h
  HDRINST usr/include/linux/usb/audio.h
  HDRINST usr/include/linux/usb/ch11.h
  HDRINST usr/include/linux/usb/functionfs.h
  HDRINST usr/include/linux/usb/ch9.h
  HDRINST usr/include/linux/usb/charger.h
  HDRINST usr/include/linux/usb/cdc-wdm.h
  HDRINST usr/include/linux/usb/gadgetfs.h
  HDRINST usr/include/linux/usb/raw_gadget.h
  HDRINST usr/include/linux/usb/cdc.h
  HDRINST usr/include/linux/usb/g_printer.h
  HDRINST usr/include/linux/hw_breakpoint.h
  HDRINST usr/include/linux/mii.h
  HDRINST usr/include/linux/cciss_ioctl.h
  HDRINST usr/include/linux/fou.h
  HDRINST usr/include/linux/module.h
  HDRINST usr/include/linux/fanotify.h
  HDRINST usr/include/linux/if_frad.h
  HDRINST usr/include/linux/udmabuf.h
  HDRINST usr/include/linux/bpf.h
  HDRINST usr/include/linux/audit.h
  HDRINST usr/include/linux/psci.h
  HDRINST usr/include/linux/nsfs.h
  HDRINST usr/include/linux/lwtunnel.h
  HDRINST usr/include/linux/filter.h
  HDRINST usr/include/linux/watchdog.h
  HDRINST usr/include/linux/fscrypt.h
  HDRINST usr/include/linux/virtio_console.h
  HDRINST usr/include/linux/qemu_fw_cfg.h
  HDRINST usr/include/linux/ultrasound.h
  HDRINST usr/include/linux/fsverity.h
  HDRINST usr/include/linux/stat.h
  HDRINST usr/include/linux/rpl.h
  HDRINST usr/include/linux/userio.h
  HDRINST usr/include/linux/pfkeyv2.h
  HDRINST usr/include/linux/thermal.h
  HDRINST usr/include/linux/dm-ioctl.h
  HDRINST usr/include/linux/rio_cm_cdev.h
  HDRINST usr/include/linux/vfio_ccw.h
  HDRINST usr/include/linux/virtio_fs.h
  HDRINST usr/include/linux/hash_info.h
  HDRINST usr/include/linux/virtio_ring.h
  HDRINST usr/include/linux/if_pppox.h
  HDRINST usr/include/linux/major.h
  HDRINST usr/include/linux/in.h
  HDRINST usr/include/linux/iso_fs.h
  HDRINST usr/include/linux/ndctl.h
  HDRINST usr/include/linux/vmcore.h
  HDRINST usr/include/linux/virtio_rng.h
  HDRINST usr/include/linux/mpls.h
  HDRINST usr/include/linux/wait.h
  HDRINST usr/include/linux/pcitest.h
  HDRINST usr/include/linux/ipv6.h
  HDRINST usr/include/linux/capability.h
  HDRINST usr/include/linux/rds.h
  HDRINST usr/include/linux/nitro_enclaves.h
  HDRINST usr/include/linux/wimax/i2400m.h
  HDRINST usr/include/linux/vbox_vmmdev_types.h
  HDRINST usr/include/linux/nvram.h
  HDRINST usr/include/linux/types.h
  HDRINST usr/include/linux/route.h
  HDRINST usr/include/sound/hdspm.h
  HDRINST usr/include/sound/compress_offload.h
  HDRINST usr/include/sound/snd_sst_tokens.h
  HDRINST usr/include/sound/sfnt_info.h
  HDRINST usr/include/sound/firewire.h
  HDRINST usr/include/sound/compress_params.h
  HDRINST usr/include/sound/asound_fm.h
  HDRINST usr/include/sound/asequencer.h
  HDRINST usr/include/sound/sb16_csp.h
  HDRINST usr/include/sound/usb_stream.h
  HDRINST usr/include/sound/skl-tplg-interface.h
  HDRINST usr/include/sound/tlv.h
  HDRINST usr/include/sound/emu10k1.h
  HDRINST usr/include/sound/hdsp.h
  HDRINST usr/include/sound/asound.h
  HDRINST usr/include/sound/asoc.h
  HDRINST usr/include/sound/sof/fw.h
  HDRINST usr/include/sound/sof/abi.h
  HDRINST usr/include/sound/sof/tokens.h
  HDRINST usr/include/sound/sof/header.h
  HDRINST usr/include/scsi/scsi_netlink.h
  HDRINST usr/include/scsi/fc/fc_els.h
  HDRINST usr/include/scsi/fc/fc_fs.h
  HDRINST usr/include/scsi/fc/fc_ns.h
  HDRINST usr/include/scsi/fc/fc_gs.h
  HDRINST usr/include/scsi/scsi_netlink_fc.h
  HDRINST usr/include/scsi/cxlflash_ioctl.h
  HDRINST usr/include/scsi/scsi_bsg_ufs.h
  HDRINST usr/include/scsi/scsi_bsg_fc.h
  HDRINST usr/include/linux/version.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
make[2]: Warning: File 'scripts/Kbuild.include' has modification time 55748=
708 s in the future
  HDRINST usr/include/asm/posix_types_x32.h
  HDRINST usr/include/asm/mtrr.h
  HDRINST usr/include/asm/mce.h
  HDRINST usr/include/asm/kvm_perf.h
  HDRINST usr/include/asm/auxvec.h
  HDRINST usr/include/asm/msr.h
  HDRINST usr/include/asm/bootparam.h
  HDRINST usr/include/asm/ucontext.h
  HDRINST usr/include/asm/swab.h
  HDRINST usr/include/asm/posix_types.h
  HDRINST usr/include/asm/perf_regs.h
  HDRINST usr/include/asm/unistd.h
  HDRINST usr/include/asm/ptrace.h
  HDRINST usr/include/asm/vm86.h
  HDRINST usr/include/asm/msgbuf.h
  HDRINST usr/include/asm/statfs.h
  HDRINST usr/include/asm/posix_types_32.h
  HDRINST usr/include/asm/shmbuf.h
  HDRINST usr/include/asm/signal.h
  HDRINST usr/include/asm/ptrace-abi.h
  HDRINST usr/include/asm/debugreg.h
  HDRINST usr/include/asm/sembuf.h
  HDRINST usr/include/asm/sigcontext32.h
  HDRINST usr/include/asm/ist.h
  HDRINST usr/include/asm/sigcontext.h
  HDRINST usr/include/asm/byteorder.h
  HDRINST usr/include/asm/kvm_para.h
  HDRINST usr/include/asm/svm.h
  HDRINST usr/include/asm/e820.h
  HDRINST usr/include/asm/posix_types_64.h
  HDRINST usr/include/asm/processor-flags.h
  HDRINST usr/include/asm/vmx.h
  HDRINST usr/include/asm/hwcap2.h
  HDRINST usr/include/asm/kvm.h
  HDRINST usr/include/asm/prctl.h
  HDRINST usr/include/asm/vsyscall.h
  HDRINST usr/include/asm/a.out.h
  HDRINST usr/include/asm/mman.h
  HDRINST usr/include/asm/ldt.h
  HDRINST usr/include/asm/hw_breakpoint.h
  HDRINST usr/include/asm/setup.h
  HDRINST usr/include/asm/boot.h
  HDRINST usr/include/asm/siginfo.h
  HDRINST usr/include/asm/stat.h
  HDRINST usr/include/asm/bitsperlong.h
  HDRINST usr/include/asm/unistd_x32.h
  HDRINST usr/include/asm/unistd_64.h
  HDRINST usr/include/asm/unistd_32.h
  HDRINST usr/include/asm/types.h
  HDRINST usr/include/asm/termios.h
  HDRINST usr/include/asm/termbits.h
  HDRINST usr/include/asm/sockios.h
  HDRINST usr/include/asm/socket.h
  HDRINST usr/include/asm/resource.h
  HDRINST usr/include/asm/poll.h
  HDRINST usr/include/asm/param.h
  HDRINST usr/include/asm/ipcbuf.h
  HDRINST usr/include/asm/ioctls.h
  HDRINST usr/include/asm/ioctl.h
  HDRINST usr/include/asm/fcntl.h
  HDRINST usr/include/asm/errno.h
  HDRINST usr/include/asm/bpf_perf_event.h
make[2]: warning:  Clock skew detected.  Your build may be incomplete.
  INSTALL ./usr/include
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd'
make[1]: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselft=
ests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safes=
etid'
make[1]: Warning: File '../lib.mk' has modification time 55785568 s in the =
future
gcc -Wall -O2    safesetid-test.c /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49=
e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/safesetid/safesetid-test
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
make[1]: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safese=
tid'
make: warning:  Clock skew detected.  Your build may be incomplete.
2019-02-14 10:24:53 make run_tests -C safesetid
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safeseti=
d'
make: Warning: File '../lib.mk' has modification time 55785568 s in the fut=
ure
gcc -Wall -O2    safesetid-test.c /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49=
e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h -l=
cap -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/safesetid/safesetid-test
TAP version 13
1..1
# selftests: safesetid: safesetid-test.sh
# mounting securityfs failed
# safesetid-test.sh: done
ok 1 selftests: safesetid: safesetid-test.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/safesetid'
2019-02-14 10:24:53 make run_tests -C seccomp
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp'
make: Warning: File '../lib.mk' has modification time 55785568 s in the fut=
ure
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c /usr/src/perf_selftes=
ts-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tool=
s/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel=
-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/self=
tests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp/secc=
omp_bpf
gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c /usr/src/perf_s=
elftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633c=
d/tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselfte=
sts-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccom=
p/seccomp_benchmark
TAP version 13
1..2
# selftests: seccomp: seccomp_bpf
# TAP version 13
# 1..87
# # Starting 87 tests from 7 test cases.
# #  RUN           global.kcmp ...
# #            OK  global.kcmp
# ok 1 global.kcmp
# #  RUN           global.mode_strict_support ...
# #            OK  global.mode_strict_support
# ok 2 global.mode_strict_support
# #  RUN           global.mode_strict_cannot_call_prctl ...
# #            OK  global.mode_strict_cannot_call_prctl
# ok 3 global.mode_strict_cannot_call_prctl
# #  RUN           global.no_new_privs_support ...
# #            OK  global.no_new_privs_support
# ok 4 global.no_new_privs_support
# #  RUN           global.mode_filter_support ...
# #            OK  global.mode_filter_support
# ok 5 global.mode_filter_support
# #  RUN           global.mode_filter_without_nnp ...
# #            OK  global.mode_filter_without_nnp
# ok 6 global.mode_filter_without_nnp
# #  RUN           global.filter_size_limits ...
# #            OK  global.filter_size_limits
# ok 7 global.filter_size_limits
# #  RUN           global.filter_chain_limits ...
# #            OK  global.filter_chain_limits
# ok 8 global.filter_chain_limits
# #  RUN           global.mode_filter_cannot_move_to_strict ...
# #            OK  global.mode_filter_cannot_move_to_strict
# ok 9 global.mode_filter_cannot_move_to_strict
# #  RUN           global.mode_filter_get_seccomp ...
# #            OK  global.mode_filter_get_seccomp
# ok 10 global.mode_filter_get_seccomp
# #  RUN           global.ALLOW_all ...
# #            OK  global.ALLOW_all
# ok 11 global.ALLOW_all
# #  RUN           global.empty_prog ...
# #            OK  global.empty_prog
# ok 12 global.empty_prog
# #  RUN           global.log_all ...
# #            OK  global.log_all
# ok 13 global.log_all
# #  RUN           global.unknown_ret_is_kill_inside ...
# #            OK  global.unknown_ret_is_kill_inside
# ok 14 global.unknown_ret_is_kill_inside
# #  RUN           global.unknown_ret_is_kill_above_allow ...
# #            OK  global.unknown_ret_is_kill_above_allow
# ok 15 global.unknown_ret_is_kill_above_allow
# #  RUN           global.KILL_all ...
# #            OK  global.KILL_all
# ok 16 global.KILL_all
# #  RUN           global.KILL_one ...
# #            OK  global.KILL_one
# ok 17 global.KILL_one
# #  RUN           global.KILL_one_arg_one ...
# #            OK  global.KILL_one_arg_one
# ok 18 global.KILL_one_arg_one
# #  RUN           global.KILL_one_arg_six ...
# #            OK  global.KILL_one_arg_six
# ok 19 global.KILL_one_arg_six
# #  RUN           global.KILL_thread ...
# #            OK  global.KILL_thread
# ok 20 global.KILL_thread
# #  RUN           global.KILL_process ...
# #            OK  global.KILL_process
# ok 21 global.KILL_process
# #  RUN           global.KILL_unknown ...
# #            OK  global.KILL_unknown
# ok 22 global.KILL_unknown
# #  RUN           global.arg_out_of_range ...
# #            OK  global.arg_out_of_range
# ok 23 global.arg_out_of_range
# #  RUN           global.ERRNO_valid ...
# #            OK  global.ERRNO_valid
# ok 24 global.ERRNO_valid
# #  RUN           global.ERRNO_zero ...
# #            OK  global.ERRNO_zero
# ok 25 global.ERRNO_zero
# #  RUN           global.ERRNO_capped ...
# #            OK  global.ERRNO_capped
# ok 26 global.ERRNO_capped
# #  RUN           global.ERRNO_order ...
# #            OK  global.ERRNO_order
# ok 27 global.ERRNO_order
# #  RUN           global.negative_ENOSYS ...
# #            OK  global.negative_ENOSYS
# ok 28 global.negative_ENOSYS
# #  RUN           global.seccomp_syscall ...
# #            OK  global.seccomp_syscall
# ok 29 global.seccomp_syscall
# #  RUN           global.seccomp_syscall_mode_lock ...
# #            OK  global.seccomp_syscall_mode_lock
# ok 30 global.seccomp_syscall_mode_lock
# #  RUN           global.detect_seccomp_filter_flags ...
# #            OK  global.detect_seccomp_filter_flags
# ok 31 global.detect_seccomp_filter_flags
# #  RUN           global.TSYNC_first ...
# #            OK  global.TSYNC_first
# ok 32 global.TSYNC_first
# #  RUN           global.syscall_restart ...
# #            OK  global.syscall_restart
# ok 33 global.syscall_restart
# #  RUN           global.filter_flag_log ...
# #            OK  global.filter_flag_log
# ok 34 global.filter_flag_log
# #  RUN           global.get_action_avail ...
# #            OK  global.get_action_avail
# ok 35 global.get_action_avail
# #  RUN           global.get_metadata ...
# #            OK  global.get_metadata
# ok 36 global.get_metadata
# #  RUN           global.user_notification_basic ...
# #            OK  global.user_notification_basic
# ok 37 global.user_notification_basic
# #  RUN           global.user_notification_with_tsync ...
# #            OK  global.user_notification_with_tsync
# ok 38 global.user_notification_with_tsync
# #  RUN           global.user_notification_kill_in_middle ...
# #            OK  global.user_notification_kill_in_middle
# ok 39 global.user_notification_kill_in_middle
# #  RUN           global.user_notification_signal ...
# #            OK  global.user_notification_signal
# ok 40 global.user_notification_signal
# #  RUN           global.user_notification_closed_listener ...
# #            OK  global.user_notification_closed_listener
# ok 41 global.user_notification_closed_listener
# #  RUN           global.user_notification_child_pid_ns ...
# #            OK  global.user_notification_child_pid_ns
# ok 42 global.user_notification_child_pid_ns
# #  RUN           global.user_notification_sibling_pid_ns ...
# #            OK  global.user_notification_sibling_pid_ns
# ok 43 global.user_notification_sibling_pid_ns
# #  RUN           global.user_notification_fault_recv ...
# #            OK  global.user_notification_fault_recv
# ok 44 global.user_notification_fault_recv
# #  RUN           global.seccomp_get_notif_sizes ...
# #            OK  global.seccomp_get_notif_sizes
# ok 45 global.seccomp_get_notif_sizes
# #  RUN           global.user_notification_continue ...
# #            OK  global.user_notification_continue
# ok 46 global.user_notification_continue
# #  RUN           global.user_notification_filter_empty ...
# #            OK  global.user_notification_filter_empty
# ok 47 global.user_notification_filter_empty
# #  RUN           global.user_notification_filter_empty_threaded ...
# #            OK  global.user_notification_filter_empty_threaded
# ok 48 global.user_notification_filter_empty_threaded
# #  RUN           global.user_notification_addfd ...
# # seccomp_bpf.c:4026:user_notification_addfd:Expected fd (7) =3D=3D 5 (5)
# # seccomp_bpf.c:4033:user_notification_addfd:Expected fd (8) =3D=3D 6 (6)
# # user_notification_addfd: Test failed at step #5
# #          FAIL  global.user_notification_addfd
# not ok 49 global.user_notification_addfd
# #  RUN           global.user_notification_addfd_rlimit ...
# #            OK  global.user_notification_addfd_rlimit
# ok 50 global.user_notification_addfd_rlimit
# #  RUN           TRAP.dfl ...
# #            OK  TRAP.dfl
# ok 51 TRAP.dfl
# #  RUN           TRAP.ign ...
# #            OK  TRAP.ign
# ok 52 TRAP.ign
# #  RUN           TRAP.handler ...
# #            OK  TRAP.handler
# ok 53 TRAP.handler
# #  RUN           precedence.allow_ok ...
# #            OK  precedence.allow_ok
# ok 54 precedence.allow_ok
# #  RUN           precedence.kill_is_highest ...
# #            OK  precedence.kill_is_highest
# ok 55 precedence.kill_is_highest
# #  RUN           precedence.kill_is_highest_in_any_order ...
# #            OK  precedence.kill_is_highest_in_any_order
# ok 56 precedence.kill_is_highest_in_any_order
# #  RUN           precedence.trap_is_second ...
# #            OK  precedence.trap_is_second
# ok 57 precedence.trap_is_second
# #  RUN           precedence.trap_is_second_in_any_order ...
# #            OK  precedence.trap_is_second_in_any_order
# ok 58 precedence.trap_is_second_in_any_order
# #  RUN           precedence.errno_is_third ...
# #            OK  precedence.errno_is_third
# ok 59 precedence.errno_is_third
# #  RUN           precedence.errno_is_third_in_any_order ...
# #            OK  precedence.errno_is_third_in_any_order
# ok 60 precedence.errno_is_third_in_any_order
# #  RUN           precedence.trace_is_fourth ...
# #            OK  precedence.trace_is_fourth
# ok 61 precedence.trace_is_fourth
# #  RUN           precedence.trace_is_fourth_in_any_order ...
# #            OK  precedence.trace_is_fourth_in_any_order
# ok 62 precedence.trace_is_fourth_in_any_order
# #  RUN           precedence.log_is_fifth ...
# #            OK  precedence.log_is_fifth
# ok 63 precedence.log_is_fifth
# #  RUN           precedence.log_is_fifth_in_any_order ...
# #            OK  precedence.log_is_fifth_in_any_order
# ok 64 precedence.log_is_fifth_in_any_order
# #  RUN           TRACE_poke.read_has_side_effects ...
# #            OK  TRACE_poke.read_has_side_effects
# ok 65 TRACE_poke.read_has_side_effects
# #  RUN           TRACE_poke.getpid_runs_normally ...
# #            OK  TRACE_poke.getpid_runs_normally
# ok 66 TRACE_poke.getpid_runs_normally
# #  RUN           TRACE_syscall.ptrace.negative_ENOSYS ...
# #            OK  TRACE_syscall.ptrace.negative_ENOSYS
# ok 67 TRACE_syscall.ptrace.negative_ENOSYS
# #  RUN           TRACE_syscall.ptrace.syscall_allowed ...
# #            OK  TRACE_syscall.ptrace.syscall_allowed
# ok 68 TRACE_syscall.ptrace.syscall_allowed
# #  RUN           TRACE_syscall.ptrace.syscall_redirected ...
# #            OK  TRACE_syscall.ptrace.syscall_redirected
# ok 69 TRACE_syscall.ptrace.syscall_redirected
# #  RUN           TRACE_syscall.ptrace.syscall_errno ...
# #            OK  TRACE_syscall.ptrace.syscall_errno
# ok 70 TRACE_syscall.ptrace.syscall_errno
# #  RUN           TRACE_syscall.ptrace.syscall_faked ...
# #            OK  TRACE_syscall.ptrace.syscall_faked
# ok 71 TRACE_syscall.ptrace.syscall_faked
# #  RUN           TRACE_syscall.ptrace.skip_after ...
# #            OK  TRACE_syscall.ptrace.skip_after
# ok 72 TRACE_syscall.ptrace.skip_after
# #  RUN           TRACE_syscall.ptrace.kill_after ...
# #            OK  TRACE_syscall.ptrace.kill_after
# ok 73 TRACE_syscall.ptrace.kill_after
# #  RUN           TRACE_syscall.seccomp.negative_ENOSYS ...
# #            OK  TRACE_syscall.seccomp.negative_ENOSYS
# ok 74 TRACE_syscall.seccomp.negative_ENOSYS
# #  RUN           TRACE_syscall.seccomp.syscall_allowed ...
# #            OK  TRACE_syscall.seccomp.syscall_allowed
# ok 75 TRACE_syscall.seccomp.syscall_allowed
# #  RUN           TRACE_syscall.seccomp.syscall_redirected ...
# #            OK  TRACE_syscall.seccomp.syscall_redirected
# ok 76 TRACE_syscall.seccomp.syscall_redirected
# #  RUN           TRACE_syscall.seccomp.syscall_errno ...
# #            OK  TRACE_syscall.seccomp.syscall_errno
# ok 77 TRACE_syscall.seccomp.syscall_errno
# #  RUN           TRACE_syscall.seccomp.syscall_faked ...
# #            OK  TRACE_syscall.seccomp.syscall_faked
# ok 78 TRACE_syscall.seccomp.syscall_faked
# #  RUN           TRACE_syscall.seccomp.skip_after ...
# #            OK  TRACE_syscall.seccomp.skip_after
# ok 79 TRACE_syscall.seccomp.skip_after
# #  RUN           TRACE_syscall.seccomp.kill_after ...
# #            OK  TRACE_syscall.seccomp.kill_after
# ok 80 TRACE_syscall.seccomp.kill_after
# #  RUN           TSYNC.siblings_fail_prctl ...
# #            OK  TSYNC.siblings_fail_prctl
# ok 81 TSYNC.siblings_fail_prctl
# #  RUN           TSYNC.two_siblings_with_ancestor ...
# #            OK  TSYNC.two_siblings_with_ancestor
# ok 82 TSYNC.two_siblings_with_ancestor
# #  RUN           TSYNC.two_sibling_want_nnp ...
# #            OK  TSYNC.two_sibling_want_nnp
# ok 83 TSYNC.two_sibling_want_nnp
# #  RUN           TSYNC.two_siblings_with_no_filter ...
# #            OK  TSYNC.two_siblings_with_no_filter
# ok 84 TSYNC.two_siblings_with_no_filter
# #  RUN           TSYNC.two_siblings_with_one_divergence ...
# #            OK  TSYNC.two_siblings_with_one_divergence
# ok 85 TSYNC.two_siblings_with_one_divergence
# #  RUN           TSYNC.two_siblings_with_one_divergence_no_tid_in_err ...
# #            OK  TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# ok 86 TSYNC.two_siblings_with_one_divergence_no_tid_in_err
# #  RUN           TSYNC.two_siblings_not_under_filter ...
# #            OK  TSYNC.two_siblings_not_under_filter
# ok 87 TSYNC.two_siblings_not_under_filter
# # FAILED: 86 / 87 tests passed.
# # Totals: pass:86 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 1 selftests: seccomp: seccomp_bpf # exit=3D1
# selftests: seccomp: seccomp_benchmark
# net.core.bpf_jit_enable =3D 1
# net.core.bpf_jit_harden =3D 0
# Current BPF sysctl settings:
# Calibrating sample size for 15 seconds worth of syscalls ...
# Benchmarking 17951400 syscalls...
# 15.027407091 - 1.003599836 =3D 14023807255 (14.0s)
# getpid native: 781 ns
# 30.046056566 - 15.027625635 =3D 15018430931 (15.0s)
# getpid RET_ALLOW 1 filter: 836 ns
# 45.677750291 - 30.046270984 =3D 15631479307 (15.6s)
# getpid RET_ALLOW 2 filters: 870 ns
# Estimated total seccomp overhead for 1 filter: 55 ns
# Estimated total seccomp overhead for 2 filters: 89 ns
# Estimated seccomp per-filter overhead: 34 ns
# Estimated seccomp entry overhead: 21 ns
ok 2 selftests: seccomp: seccomp_benchmark
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/seccomp'
2019-02-14 10:25:42 make run_tests -C sigaltstack
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sigaltst=
ack'
make: Warning: File '../lib.mk' has modification time 55785519 s in the fut=
ure
gcc -Wall    sas.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e=
3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_harne=
ss.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955519=
0a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/perf=
_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7663=
3cd/tools/testing/selftests/sigaltstack/sas
TAP version 13
1..1
# selftests: sigaltstack: sas
# TAP version 13
# 1..3
# ok 1 Initial sigaltstack state was SS_DISABLE
# # [RUN]	signal USR1
# ok 2 sigaltstack is disabled in sighandler
# # [RUN]	switched to user ctx
# # [RUN]	signal USR2
# # [OK]	Stack preserved
# ok 3 sigaltstack is still SS_AUTODISARM after signal
# # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sigaltstack: sas
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sigaltsta=
ck'
2019-02-14 10:25:42 make run_tests -C size
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size'
make: Warning: File '../lib.mk' has modification time 55785519 s in the fut=
ure
gcc -static -ffreestanding -nostartfiles -s    get_size.c /usr/src/perf_sel=
ftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/=
tools/testing/selftests/kselftest_harness.h /usr/src/perf_selftests-x86_64-=
rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/=
selftests/kselftest.h  -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size/get=
_size
TAP version 13
1..1
# selftests: size: get_size
# TAP version 13
# # Testing system size.
# ok 1 get runtime memory use
# # System runtime memory report (units in Kilobytes):
#  ---
#  Total:  32350720
#  Free:   27979088
#  Buffer: 0
#  In use: 4371632
#  ...
# 1..1
ok 1 selftests: size: get_size
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/size'
2019-02-14 10:25:43 make run_tests -C sparc64
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sparc64'
make: Warning: File 'Makefile' has modification time 55748657 s in the futu=
re
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sparc64'
2019-02-14 10:25:43 make run_tests -C splice
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/splice'
make: Warning: File '../lib.mk' has modification time 55785518 s in the fut=
ure
gcc     default_file_splice_read.c /usr/src/perf_selftests-x86_64-rhel-7.6-=
kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests=
/kselftest_harness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c4=
9e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  =
-o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a=
49024ac86d3d76633cd/tools/testing/selftests/splice/default_file_splice_read
gcc     splice_read.c /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/kselftest_ha=
rness.h /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955=
5190a49024ac86d3d76633cd/tools/testing/selftests/kselftest.h  -o /usr/src/p=
erf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d7=
6633cd/tools/testing/selftests/splice/splice_read
TAP version 13
1..2
# selftests: splice: default_file_splice_read.sh
ok 1 selftests: splice: default_file_splice_read.sh
# selftests: splice: short_splice_read.sh
# splice: Invalid argument
# FAIL: /proc/13419/limits 4096
# splice: Invalid argument
# FAIL: /proc/13419/limits 2
# splice: Invalid argument
# FAIL: /proc/13419/comm 4096
# splice: Invalid argument
# FAIL: /proc/13419/comm 2
# ok: /proc/sys/fs/nr_open 4096
# ok: /proc/sys/fs/nr_open 2
# ok: /proc/sys/kernel/modprobe 4096
# ok: /proc/sys/kernel/modprobe 2
# ok: /proc/sys/kernel/version 4096
# ok: /proc/sys/kernel/version 2
# splice: Invalid argument
# FAIL: /sys/module/test_module/coresize 4096
# splice: Invalid argument
# FAIL: /sys/module/test_module/coresize 2
# splice: Invalid argument
# FAIL: /sys/module/test_module/sections/.init.text 4096
# splice: Invalid argument
# FAIL: /sys/module/test_module/sections/.init.text 2
not ok 2 selftests: splice: short_splice_read.sh # exit=3D1
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/splice'
2019-02-14 10:25:43 make run_tests -C static_keys
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/static_k=
eys'
make: Warning: File '../lib.mk' has modification time 55785518 s in the fut=
ure
TAP version 13
1..1
# selftests: static_keys: test_static_keys.sh
# static_key: ok
ok 1 selftests: static_keys: test_static_keys.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/static_ke=
ys'
LKP WARN miss config CONFIG_SYNC=3D of sync/config
2019-02-14 10:25:44 make run_tests -C sync
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync'
make: Warning: File '../lib.mk' has modification time 55785517 s in the fut=
ure
gcc -c sync_alloc.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_a=
lloc.o
gcc -c sync_fence.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_f=
ence.o
gcc -c sync_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1=
c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_m=
erge.o
gcc -c sync_wait.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_wa=
it.o
gcc -c sync_stress_parallelism.c -o /usr/src/perf_selftests-x86_64-rhel-7.6=
-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftest=
s/sync/sync_stress_parallelism.o
gcc -c sync_stress_consumer.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-ks=
elftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/s=
ync/sync_stress_consumer.o
gcc -c sync_stress_merge.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kself=
tests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync=
/sync_stress_merge.o
gcc -c sync_test.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c=
49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_te=
st.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -c sync.c -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e37=
83f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync.o -O2 -=
g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../usr/include/
gcc -o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555=
190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_test /usr/src/per=
f_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d766=
33cd/tools/testing/selftests/sync/sync_test.o /usr/src/perf_selftests-x86_6=
4-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testin=
g/selftests/sync/sync.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-=
1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_=
alloc.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f889955=
5190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync_fence.o /usr/src=
/perf_selftests-x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3=
d76633cd/tools/testing/selftests/sync/sync_merge.o /usr/src/perf_selftests-=
x86_64-rhel-7.6-kselftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/t=
esting/selftests/sync/sync_wait.o /usr/src/perf_selftests-x86_64-rhel-7.6-k=
selftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/=
sync/sync_stress_parallelism.o /usr/src/perf_selftests-x86_64-rhel-7.6-ksel=
ftests-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/syn=
c/sync_stress_consumer.o /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync/sync=
_stress_merge.o -O2 -g -std=3Dgnu89 -pthread -Wall -Wextra -I../../../../us=
r/include/ -pthread
TAP version 13
1..1
# selftests: sync: sync_test
# TAP version 13
# 1..10
# # [RUN]	Testing sync framework
# ok 1 [RUN]	test_alloc_timeline
# ok 2 [RUN]	test_alloc_fence
# ok 3 [RUN]	test_alloc_fence_negative
# ok 4 [RUN]	test_fence_one_timeline_wait
# ok 5 [RUN]	test_fence_one_timeline_merge
# ok 6 [RUN]	test_fence_merge_same_fence
# ok 7 [RUN]	test_fence_multi_timeline_wait
# ok 8 [RUN]	test_stress_two_threads_shared_timeline
# ok 9 [RUN]	test_consumer_stress_multi_producer_single_consumer
# ok 10 [RUN]	test_merge_stress_random_merge
# # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
ok 1 selftests: sync: sync_test
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sync'
2019-02-14 10:25:47 make run_tests -C sysctl
make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftest=
s-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sysctl'
make: Warning: File '../lib.mk' has modification time 55785514 s in the fut=
ure
TAP version 13
1..1
# selftests: sysctl: sysctl.sh
# Checking production write strict setting ... ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0001 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
01 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0002 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/string=
_0001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Writing entire sysctl in short writes ... ok
# Writing middle of sysctl after unsynchronized seek ... ok
# Checking sysctl maxlen is at least 65 ... ok
# Checking sysctl keeps original string on overflow append ... ok
# Checking sysctl stays NULL terminated on write ... ok
# Checking sysctl stays NULL terminated on overwrite ... ok
# Thu Feb 14 10:25:48 UTC 2019
# Running test: sysctl_test_0003 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/int_00=
02 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing INT_MAX works ...ok
# Testing INT_MAX + 1 will fail as expected...ok
# Testing negative values will work as expected...ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0004 - run #0
# =3D=3D Testing sysctl behavior against /proc/sys/debug/test_sysctl/uint_0=
001 =3D=3D
# Writing test file ... ok
# Checking sysctl is not set to test value ... ok
# Writing sysctl from shell ... ok
# Resetting sysctl to original value ... ok
# Writing entire sysctl in single write ... ok
# Writing middle of sysctl after synchronized seek ... ok
# Writing beyond end of sysctl ... ok
# Writing sysctl with multiple long writes ... ok
# Testing that 0x0000000100000000 fails as expected...ok
# Testing that 0x0000000100000001 fails as expected...ok
# Testing that 0x00000001ffffffff fails as expected...ok
# Testing that 0x0000000180000000 fails as expected...ok
# Testing that 0x000000017fffffff fails as expected...ok
# Testing that 0xffffffff00000000 fails as expected...ok
# Testing that 0xffffffff00000001 fails as expected...ok
# Testing that 0xffffffffffffffff fails as expected...ok
# Testing that 0xffffffff80000000 fails as expected...ok
# Testing that 0xffffffff7fffffff fails as expected...ok
# Testing that -0x0000000100000000 fails as expected...ok
# Testing that -0x0000000100000001 fails as expected...ok
# Testing that -0x00000001ffffffff fails as expected...ok
# Testing that -0x0000000180000000 fails as expected...ok
# Testing that -0x000000017fffffff fails as expected...ok
# Testing that -0xffffffff00000000 fails as expected...ok
# Testing that -0xffffffff00000001 fails as expected...ok
# Testing that -0xffffffffffffffff fails as expected...ok
# Testing that -0xffffffff80000000 fails as expected...ok
# Testing that -0xffffffff7fffffff fails as expected...ok
# Checking ignoring spaces up to PAGE_SIZE works on write ...ok
# Checking passing PAGE_SIZE of spaces fails on write ...ok
# Testing UINT_MAX works ...ok
# Testing UINT_MAX + 1 will fail as expected...ok
# Testing negative values will not work as expected ...ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #0
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #1
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0005 - run #2
# Testing array works as expected ... ok
# Testing skipping trailing array elements works ... ok
# Testing PAGE_SIZE limit on array works ... ok
# Testing exceeding PAGE_SIZE limit fails as expected ... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0006 - run #0
# Checking bitmap handler... ok
# Thu Feb 14 10:25:49 UTC 2019
# Running test: sysctl_test_0006 - run #1
# Checking bitmap handler... ok
# Thu Feb 14 10:25:50 UTC 2019
# Running test: sysctl_test_0006 - run #2
# Checking bitmap handler... ok
# Thu Feb 14 10:25:51 UTC 2019
# Running test: sysctl_test_0006 - run #3
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #4
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #5
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #6
# Checking bitmap handler... ok
# Thu Feb 14 10:25:52 UTC 2019
# Running test: sysctl_test_0006 - run #7
# Checking bitmap handler... ok
# Thu Feb 14 10:25:53 UTC 2019
# Running test: sysctl_test_0006 - run #8
# Checking bitmap handler... ok
# Thu Feb 14 10:25:54 UTC 2019
# Running test: sysctl_test_0006 - run #9
# Checking bitmap handler... ok
# Thu Feb 14 10:25:54 UTC 2019
# Running test: sysctl_test_0006 - run #10
# Checking bitmap handler... ok
# Thu Feb 14 10:25:55 UTC 2019
# Running test: sysctl_test_0006 - run #11
# Checking bitmap handler... ok
# Thu Feb 14 10:25:55 UTC 2019
# Running test: sysctl_test_0006 - run #12
# Checking bitmap handler... ok
# Thu Feb 14 10:25:56 UTC 2019
# Running test: sysctl_test_0006 - run #13
# Checking bitmap handler... ok
# Thu Feb 14 10:25:56 UTC 2019
# Running test: sysctl_test_0006 - run #14
# Checking bitmap handler... ok
# Thu Feb 14 10:25:57 UTC 2019
# Running test: sysctl_test_0006 - run #15
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #16
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #17
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #18
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #19
# Checking bitmap handler... ok
# Thu Feb 14 10:25:58 UTC 2019
# Running test: sysctl_test_0006 - run #20
# Checking bitmap handler... ok
# Thu Feb 14 10:25:59 UTC 2019
# Running test: sysctl_test_0006 - run #21
# Checking bitmap handler... ok
# Thu Feb 14 10:25:59 UTC 2019
# Running test: sysctl_test_0006 - run #22
# Checking bitmap handler... ok
# Thu Feb 14 10:26:00 UTC 2019
# Running test: sysctl_test_0006 - run #23
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #24
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #25
# Checking bitmap handler... ok
# Thu Feb 14 10:26:01 UTC 2019
# Running test: sysctl_test_0006 - run #26
# Checking bitmap handler... ok
# Thu Feb 14 10:26:02 UTC 2019
# Running test: sysctl_test_0006 - run #27
# Checking bitmap handler... ok
# Thu Feb 14 10:26:02 UTC 2019
# Running test: sysctl_test_0006 - run #28
# Checking bitmap handler... ok
# Thu Feb 14 10:26:03 UTC 2019
# Running test: sysctl_test_0006 - run #29
# Checking bitmap handler... ok
# Thu Feb 14 10:26:03 UTC 2019
# Running test: sysctl_test_0006 - run #30
# Checking bitmap handler... ok
# Thu Feb 14 10:26:04 UTC 2019
# Running test: sysctl_test_0006 - run #31
# Checking bitmap handler... ok
# Thu Feb 14 10:26:04 UTC 2019
# Running test: sysctl_test_0006 - run #32
# Checking bitmap handler... ok
# Thu Feb 14 10:26:05 UTC 2019
# Running test: sysctl_test_0006 - run #33
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #34
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #35
# Checking bitmap handler... ok
# Thu Feb 14 10:26:06 UTC 2019
# Running test: sysctl_test_0006 - run #36
# Checking bitmap handler... ok
# Thu Feb 14 10:26:07 UTC 2019
# Running test: sysctl_test_0006 - run #37
# Checking bitmap handler... ok
# Thu Feb 14 10:26:07 UTC 2019
# Running test: sysctl_test_0006 - run #38
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #39
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #40
# Checking bitmap handler... ok
# Thu Feb 14 10:26:08 UTC 2019
# Running test: sysctl_test_0006 - run #41
# Checking bitmap handler... ok
# Thu Feb 14 10:26:09 UTC 2019
# Running test: sysctl_test_0006 - run #42
# Checking bitmap handler... ok
# Thu Feb 14 10:26:09 UTC 2019
# Running test: sysctl_test_0006 - run #43
# Checking bitmap handler... ok
# Thu Feb 14 10:26:10 UTC 2019
# Running test: sysctl_test_0006 - run #44
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #45
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #46
# Checking bitmap handler... ok
# Thu Feb 14 10:26:11 UTC 2019
# Running test: sysctl_test_0006 - run #47
# Checking bitmap handler... ok
# Thu Feb 14 10:26:12 UTC 2019
# Running test: sysctl_test_0006 - run #48
# Checking bitmap handler... ok
# Thu Feb 14 10:26:13 UTC 2019
# Running test: sysctl_test_0006 - run #49
# Checking bitmap handler... ok
# Thu Feb 14 10:26:15 UTC 2019
# Running test: sysctl_test_0007 - run #0
# Testing if /proc/sys/debug/test_sysctl/boot_int is set to 1 ...FAIL
# Checking if /proc/cmdline contains setting of the expected parameter ...
# Skipping test, expected kernel parameter missing.
# To perform this test, make sure kernel is booted with parameter: sysctl.d=
ebug.test_sysctl.boot_int=3D1
ok 1 selftests: sysctl: sysctl.sh
make: warning:  Clock skew detected.  Your build may be incomplete.
make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests=
-1c49e3783f8899555190a49024ac86d3d76633cd/tools/testing/selftests/sysctl'

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---

#! jobs/kernel-selftests.yaml
suite: kernel-selftests
testcase: kernel-selftests
category: functional
kconfig: x86_64-rhel-7.6-kselftests
need_memory: 3G
need_cpu: 2
kernel-selftests:
  group: group-02
kernel_cmdline: erst_disable
job_origin: "/lkp-src/allot/cyclic:p1:internal-devel:devel-hourly/lkp-skl-d05/kernel-selftests.yaml"

#! queue options
queue_cmdline_keys:
- branch
- commit
queue: bisect
testbox: lkp-skl-d05
tbox_group: lkp-skl-d05
submit_id: 5fb87a2b4e06af10ea0af858
job_file: "/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-20201121-4330-1gftbdk-0.yaml"
id: 3ec8da5a46e4e04590016507b1e94929450a0e9d
queuer_version: "/lkp-src"

#! hosts/lkp-skl-d05
model: Skylake
nr_cpu: 4
memory: 32G
nr_ssd_partitions: 1
nr_hdd_partitions: 4
hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz

#! include/category/functional
kmsg: 
heartbeat: 
meminfo: 

#! include/queue/cyclic
commit: 1c49e3783f8899555190a49024ac86d3d76633cd

#! include/testbox/lkp-skl-d05
need_kconfig_hw:
- CONFIG_E1000E=y
- CONFIG_SATA_AHCI
ucode: '0xe2'

#! include/kernel-selftests
need_kernel_headers: true
need_kernel_selftests: true
need_kconfig:
- CONFIG_ANDROID=y
- CONFIG_FUSE_FS=m
- CONFIG_IPV6_MULTIPLE_TABLES=y
- CONFIG_MACSEC=y
- CONFIG_MEMORY_HOTPLUG=y
- CONFIG_MEMORY_HOTPLUG_SPARSE=y
- CONFIG_MEMORY_HOTREMOVE=y
- CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
- CONFIG_MISC_FILESYSTEMS=y
- CONFIG_MPTCP=y ~ ">= v5.6-rc1"
- CONFIG_MPTCP_IPV6=y ~ ">= v5.6-rc1"
- CONFIG_NET_FOU
- CONFIG_NET_FOU_IP_TUNNELS=y
- CONFIG_NET_L3_MASTER_DEV=y
- CONFIG_NET_SCH_NETEM
- CONFIG_NET_VRF=y
- CONFIG_NFT_OBJREF=m ~ ">= v4.10-rc1"
- CONFIG_NF_FLOW_TABLE=m ~ ">= v4.16-rc1"
- CONFIG_NF_FLOW_TABLE_INET=m ~ ">= v4.16-rc1"
- CONFIG_NF_FLOW_TABLE_IPV4=m ~ ">= v4.16-rc1"
- CONFIG_NF_FLOW_TABLE_IPV6=m ~ ">= v4.16-rc1"
- CONFIG_NF_TABLES_NETDEV=y ~ ">= v4.17-rc1"
- CONFIG_NOTIFIER_ERROR_INJECTION=y
- CONFIG_PID_NS=y
- CONFIG_PROC_FS=y
- CONFIG_PSTORE=y
- CONFIG_PSTORE_CONSOLE=y
- CONFIG_PSTORE_PMSG=y
- CONFIG_PSTORE_RAM=m
- CONFIG_SECCOMP=y
- CONFIG_SECCOMP_FILTER=y
- CONFIG_SECURITY=y
- CONFIG_SECURITYFS=y
- CONFIG_STAGING=y
- CONFIG_SW_SYNC=y
- CONFIG_SYNC=y ~ "<= v4.7"
- CONFIG_TEST_BLACKHOLE_DEV=m ~ ">= v5.3-rc1"
- CONFIG_TEST_STATIC_KEYS
- CONFIG_TEST_SYSCTL=y
- CONFIG_USER_NS=y
- CONFIG_UTS_NS=y
- CONFIG_VETH
- CONFIG_X86_CPU_RESCTRL=y ~ ">= v5.0-rc1"
enqueue_time: 2020-11-21 10:23:39.975672467 +08:00
_id: 5fb87a2b4e06af10ea0af858
_rt: "/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd"

#! schedule options
user: lkp
compiler: gcc-9
head_commit: fa8b6e45d7ce2d6a58dee66ffe7458f1d155d723
base_commit: '09162bc32c880a791c6c0668ce0745cf7958f576'
branch: internal-devel/devel-hourly-2020112013
rootfs: debian-10.4-x86_64-20200603.cgz
result_root: "/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/0"
scheduler_version: "/lkp/lkp/.src-20201120-230606"
LKP_SERVER: internal-lkp-server
arch: x86_64
max_uptime: 3600
initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-skl-d05/kernel-selftests-group-02-ucode=0xe2-debian-10.4-x86_64-20200603.cgz-1c49e3783f8899555190a49024ac86d3d76633cd-20201121-4330-1gftbdk-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6-kselftests
- branch=internal-devel/devel-hourly-2020112013
- commit=1c49e3783f8899555190a49024ac86d3d76633cd
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88
- erst_disable
- max_uptime=3600
- RESULT_ROOT=/result/kernel-selftests/group-02-ucode=0xe2/lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/0
- LKP_SERVER=internal-lkp-server
- nokaslr
- selinux=0
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/modules.cgz"
bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20200709.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/kernel-selftests_20201007.cgz,/osimage/pkg/debian-10.4-x86_64-20200603.cgz/kernel-selftests-x86_64-b5a583fb-1_20201015.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
linux_headers_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/linux-headers.cgz"
linux_selftests_initrd: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/linux-selftests.cgz"
ucode_initrd: "/osimage/ucode/intel-ucode-20201117.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn

#! /lkp/lkp/.src-20201120-103248/include/site/inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 

#! runtime status
last_kernel: 5.10.0-rc4-intel-next-02889-g79b54952c8d3
schedule_notify_address: 

#! user overrides
kernel: "/pkg/linux/x86_64-rhel-7.6-kselftests/gcc-9/1c49e3783f8899555190a49024ac86d3d76633cd/vmlinuz-5.10.0-rc1-00011-g1c49e3783f88"
dequeue_time: 2020-11-21 11:25:23.692440340 +08:00

#! /lkp/lkp/.src-20201120-230606/include/site/inn
job_state: finished
loadavg: 1.31 3.20 2.07 1/126 15715
start_time: '1550139129'
end_time: '1550139713'
version: "/lkp/lkp/.src-20201120-230655:3a1f47e8:44c9c7c85"

--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce

 "ln" "-sf" "/usr/bin/clang"
 "ln" "-sf" "/usr/bin/llc"
 "sed" "-i" "s/default_timeout=45/default_timeout=300/" "kselftest/runner.sh"
 "make" "run_tests" "-C" "membarrier"
 "make" "run_tests" "-C" "memfd"
 "make" "run_tests" "-C" "memory-hotplug"
 "make" "run_tests" "-C" "mincore"
 "make" "run_tests" "-C" "mount"
 "make" "run_tests" "-C" "mqueue"
 "make" "run_tests" "-C" "nsfs"
 "./openat2_test"
 "make" "run_tests" "-C" "pid_namespace"
 "make" "run_tests" "-C" "pidfd"
 "make" "TARGETS=prctl"
 "make" "run_tests" "-C" "prctl"
 "make" "run_tests" "-C" "proc"
 "make" "run_tests" "-C" "pstore"
 "make" "TARGETS=ptp"
 "make" "run_tests" "-C" "ptp"
 "make" "run_tests" "-C" "ptrace"
 "make" "run_tests" "-C" "rtc"
 "make" "TARGETS=safesetid"
 "make" "run_tests" "-C" "safesetid"
 "make" "run_tests" "-C" "seccomp"
 "make" "run_tests" "-C" "sigaltstack"
 "make" "run_tests" "-C" "size"
 "make" "run_tests" "-C" "sparc64"
 "make" "run_tests" "-C" "splice"
 "make" "run_tests" "-C" "static_keys"
 "make" "run_tests" "-C" "sync"
 "make" "run_tests" "-C" "sysctl"

--pAwQNkOnpTn9IO2O--
