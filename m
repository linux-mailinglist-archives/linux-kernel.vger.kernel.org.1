Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE6723AE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgHCUXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 16:23:23 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42854 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:23:23 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2gzR-009G4h-Hx; Mon, 03 Aug 2020 14:23:21 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2gzQ-0000R5-O6; Mon, 03 Aug 2020 14:23:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Aug 2020 15:20:07 -0500
Message-ID: <87k0yfscqw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2gzQ-0000R5-O6;;;mid=<87k0yfscqw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/LdGJgW4IvzqUFH+hlQB3/SA4A6A27UI8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4740]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 416 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (0.9%), b_tie_ro: 2.7 (0.6%), parse: 0.64
        (0.2%), extract_message_metadata: 3.2 (0.8%), get_uri_detail_list:
        1.70 (0.4%), tests_pri_-1000: 2.7 (0.7%), tests_pri_-950: 0.95 (0.2%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 117 (28.1%), check_bayes:
        116 (27.8%), b_tokenize: 7 (1.6%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 1.96 (0.5%), b_tok_touch_all: 95 (22.9%), b_finish: 0.80
        (0.2%), tests_pri_0: 273 (65.6%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.5 (0.6%), poll_dns_idle: 1.09 (0.3%), tests_pri_10:
        1.76 (0.4%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] exec cleanups for v5.9-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the exec-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

   HEAD: 7fce69dff8db30cb93aace0bbebda09972027af7 Implement kernel_execve

During the development of v5.7 I ran into bugs and quality of
implementation issues related to exec that could not be easily
fixed because of the way exec is implemented.  So I have been
diggin into exec and cleaning up what I can.

This cycle I have been looking at different ideas and different
implementations to see what is possible to improve exec, and cleaning
the way exec interfaces with in kernel users.  Only cleaning up the
interfaces of exec with rest of the kernel has managed to stabalize
and make it through review in time for v5.9-rc1 resulting in 2
sets of changes this cycle.

      Implement kernel_execve
      Make the user mode driver code a better citizen

With kernel_execve the code size got a little larger as the copying of
parameters from userspace and copying of parameters from userspace is
now separate.  The good news is kernel threads no longer need to play
games with set_fs to use exec.  Which when combined with the rest of
Christophs set_fs changes should security bugs with set_fs much more
difficult.

The first changeset "Make the user mode driver code a better citizen"
should be both in this tree and in the bpf tree.

This inches the exec code closer to sorting out the long standing issues
I am aware of.

After 5.9-rc1 is released I am hoping to quickly rebase and get a lot of
changes posted, reviewed and merged.  I have a lot of additional fixes
and cleanups that just need a little more attention before they are
ready to merge.

Eric W. Biederman (25):
      umh: Capture the pid in umh_pipe_setup
      umh: Move setting PF_UMH into umh_pipe_setup
      umh: Rename the user mode driver helpers for clarity
      umh: Remove call_usermodehelper_setup_file.
      umh: Separate the user mode driver and the user mode helper support
      umd: For clarity rename umh_info umd_info
      umd: Rename umd_info.cmdline umd_info.driver_name
      umd: Transform fork_usermode_blob into fork_usermode_driver
      umh: Stop calling do_execve_file
      exec: Remove do_execve_file
      bpfilter: Move bpfilter_umh back into init data
      umd: Track user space drivers with struct pid
      exit: Factor thread_group_exited out of pidfd_poll
      bpfilter: Take advantage of the facilities of struct pid
      umd: Remove exit_umh
      umd: Stop using split_argv
      Make the user mode driver code a better citizen
      exec: Remove unnecessary spaces from binfmts.h
      exec: Factor out alloc_bprm
      exec: Move initialization of bprm->filename into alloc_bprm
      exec: Move bprm_mm_init into alloc_bprm
      exec: Factor bprm_execve out of do_execve_common
      exec: Factor bprm_stack_limits out of prepare_arg_pages
      exec: Implement kernel_execve
      Implement kernel_execve

 arch/x86/entry/entry_32.S        |   2 +-
 arch/x86/entry/entry_64.S        |   2 +-
 arch/x86/kernel/unwind_frame.c   |   2 +-
 fs/exec.c                        | 307 +++++++++++++++++++++++++--------------
 include/linux/binfmts.h          |  21 +--
 include/linux/bpfilter.h         |   7 +-
 include/linux/sched.h            |   9 --
 include/linux/sched/signal.h     |   2 +
 include/linux/umh.h              |  15 --
 include/linux/usermode_driver.h  |  18 +++
 init/main.c                      |   4 +-
 kernel/Makefile                  |   1 +
 kernel/exit.c                    |  25 +++-
 kernel/fork.c                    |   6 +-
 kernel/umh.c                     | 171 +---------------------
 kernel/usermode_driver.c         | 182 +++++++++++++++++++++++
 net/bpfilter/bpfilter_kern.c     |  38 ++---
 net/bpfilter/bpfilter_umh_blob.S |   2 +-
 net/ipv4/bpfilter/sockopt.c      |  20 +--
 security/tomoyo/common.h         |   2 +-
 security/tomoyo/domain.c         |   4 +-
 security/tomoyo/tomoyo.c         |   4 +-
 22 files changed, 480 insertions(+), 364 deletions(-)

Eric
