Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA3A1ED29C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 16:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFCOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 10:51:53 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:57688 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFCOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:51:52 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgUkA-0006ZY-JD; Wed, 03 Jun 2020 08:51:50 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgUk9-0005aR-P2; Wed, 03 Jun 2020 08:51:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Wed, 03 Jun 2020 09:47:51 -0500
Message-ID: <875zc8kxyg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgUk9-0005aR-P2;;;mid=<875zc8kxyg.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+hMjF0oDHJ4xXsPRpWOhyuUU9Uw6OySHE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3170]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 434 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.0 (0.9%), b_tie_ro: 2.8 (0.7%), parse: 0.62
        (0.1%), extract_message_metadata: 3.1 (0.7%), get_uri_detail_list:
        1.61 (0.4%), tests_pri_-1000: 2.7 (0.6%), tests_pri_-950: 1.03 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 137 (31.6%), check_bayes:
        136 (31.3%), b_tokenize: 6 (1.5%), b_tok_get_all: 12 (2.8%),
        b_comp_prob: 1.79 (0.4%), b_tok_touch_all: 112 (25.7%), b_finish: 0.75
        (0.2%), tests_pri_0: 268 (61.8%), check_dkim_signature: 0.71 (0.2%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.72 (0.2%), tests_pri_10:
        2.9 (0.7%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] proc changes for v5.8-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the proc-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git proc-linus

   HEAD: 9d78edeaec759f997c303f286ecd39daee166f2a proc: proc_pid_ns takes super_block as an argument

This branch has 4 sets of changes:

      proc: modernize proc to support multiple private instances
      proc: Ensure we see the exit of each process tid exactly
      Removing has_group_leader_pid
      posix-cpu-timers: Use pids not tasks in lookup

Alexey updated proc so each mount of proc uses a new superblock.  This
allows people to actually use mount options with proc with no fear of
messing up another mount of proc.  Given the kernel's internal mounts of
proc for things like uml this was a real problem, and resulted in
Android's hidepid mount options being ignored and introducing security
issues.

The rest of the changes are small cleanups and fixes that came out of my
work to allow this change to proc.  In essence it is swapping the pids
in de_thread during exec which revoves a special case the code had to
handle.  Then updating the code to stop handling that special case.

Alexey Gladkov (9):
      proc: modernize proc to support multiple private instances
      proc: rename struct proc_fs_info to proc_fs_opts
      proc: allow to mount many instances of proc in one pid namespace
      proc: instantiate only pids that we can ptrace on 'hidepid=4' mount option
      proc: add option to mount only a pids subset
      docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior
      proc: use human-readable values for hidepid
      proc: use named enums for better readability
      Use proc_pid_ns() to get pid_namespace from the proc superblock
      proc: proc_pid_ns takes super_block as an argument

Eric W. Biederman (14):
      proc: Use PIDTYPE_TGID in next_tgid
      rculist: Add hlists_swap_heads_rcu
      proc: Ensure we see the exit of each process tid exactly once
      proc: Ensure we see the exit of each process tid exactly
      posix-cpu-timer: Tidy up group_leader logic in lookup_task
      posix-cpu-timer:  Unify the now redundant code in lookup_task
      exec: Remove BUG_ON(has_group_leader_pid)
      signal: Remove has_group_leader_pid
      posix-cpu-timers: Extend rcu_read_lock removing task_struct references
      posix-cpu-timers: Replace cpu_timer_pid_type with clock_pid_type
      posix-cpu-timers: Replace __get_task_for_clock with pid_for_clock
      Removing has_group_leader_pid
      posix-cpu-timers: Use pids not tasks in lookup

Oleg Nesterov (1):
      remove the no longer needed pid_alive() check in __task_pid_nr_ns()

 Documentation/filesystems/proc.rst                 |  92 ++++++++++++---
 fs/exec.c                                          |   6 +-
 fs/locks.c                                         |   4 +-
 fs/proc/array.c                                    |   2 +-
 fs/proc/base.c                                     |  74 ++++++------
 fs/proc/generic.c                                  |   9 ++
 fs/proc/inode.c                                    |  30 ++++-
 fs/proc/root.c                                     | 131 ++++++++++++++++-----
 fs/proc/self.c                                     |   8 +-
 fs/proc/thread_self.c                              |   8 +-
 fs/proc_namespace.c                                |  14 +--
 include/linux/pid.h                                |   1 +
 include/linux/pid_namespace.h                      |  12 --
 include/linux/proc_fs.h                            |  32 ++++-
 include/linux/rculist.h                            |  21 ++++
 include/linux/sched/signal.h                       |  11 --
 kernel/fork.c                                      |   2 +-
 kernel/pid.c                                       |  22 +++-
 kernel/time/posix-cpu-timers.c                     | 111 ++++++++---------
 net/ipv6/ip6_flowlabel.c                           |   2 +-
 security/tomoyo/realpath.c                         |   4 +-
 tools/testing/selftests/proc/.gitignore            |   2 +
 tools/testing/selftests/proc/Makefile              |   2 +
 .../testing/selftests/proc/proc-fsconfig-hidepid.c |  50 ++++++++
 .../testing/selftests/proc/proc-multiple-procfs.c  |  48 ++++++++
 25 files changed, 492 insertions(+), 206 deletions(-)

Eric
