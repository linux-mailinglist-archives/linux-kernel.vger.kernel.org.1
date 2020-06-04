Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF41EEB9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgFDUNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 16:13:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:60070 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgFDUNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:13:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwEm-00039a-Kq; Thu, 04 Jun 2020 14:13:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jgwEl-0008Pb-PQ; Thu, 04 Jun 2020 14:13:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     <linux-kernel@vger.kernel.org>
Date:   Thu, 04 Jun 2020 15:09:16 -0500
Message-ID: <87k10mioer.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jgwEl-0008Pb-PQ;;;mid=<87k10mioer.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ZkL+F89jjfIpI3mg8ccyT4X1fIe58w40=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4895]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 11 (2.4%), parse: 0.85
        (0.2%), extract_message_metadata: 4.3 (0.9%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 3.5 (0.8%), tests_pri_-950: 1.16 (0.3%),
        tests_pri_-900: 0.92 (0.2%), tests_pri_-90: 165 (35.9%), check_bayes:
        163 (35.5%), b_tokenize: 9 (1.9%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 139 (30.4%), b_finish: 0.95
        (0.2%), tests_pri_0: 248 (54.1%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.38 (0.1%), tests_pri_10:
        3.9 (0.9%), tests_pri_500: 12 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] exec cleanups for v5.8-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the proc-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git exec-linus

   HEAD: 3977e285ee89a94699255dbbf6eeea13889a1083 exec: Remove the recomputation of bprm->cred

Last cycle for the Nth time I ran into bugs and quality of
implementation issues related to exec that could not be easily be fixed
because of the way exec is implemented.  So I have been digging into
exec and cleanup up what I can.

I don't think I have exec sorted out enough to fix the issues I started
with but I have made some headway this cycle with 4 sets of changes.

      exec: Promised cleanups after introducing exec_update_mutex
      exec: Trivial cleanups for exec
      exec: Control flow simplifications
      exec: Remove the recomputation of bprm->cred

The net result is code that is a bit easier to understand and work with
and a decrease in the number of lines of code (if you don't count the
added tests).

There is a trivial conflict with the transformation of
copy_strings_kernel into copy_string_kernel by Christoph Hellwig.  These
changes touch adjacent lines.

Arnd Bergmann (1):
      binfmt_elf_fdpic: fix execfd build regression

Eric W. Biederman (30):
      binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
      exec: Make unlocking exec_update_mutex explict
      exec: Rename the flag called_exec_mmap point_of_no_return
      exec: Merge install_exec_creds into setup_new_exec
      exec: In setup_new_exec cache current in the local variable me
      exec: Move most of setup_new_exec into flush_old_exec
      exec: Rename flush_old_exec begin_new_exec
      exec: Promised cleanups after introducing exec_update_mutex
      exec: Move the comment from above de_thread to above unshare_sighand
      exec: Fix spelling of search_binary_handler in a comment
      exec: Run sync_mm_rss before taking exec_update_mutex
      exec: Move handling of the point of no return to the top level
      exec: Set the point of no return sooner
      exec: Trivial cleanups for exec
      exec: Move would_dump into flush_old_exec
      Merge f87d1c955916 ("exec: Move would_dump into flush_old_exec")
      exec: Teach prepare_exec_creds how exec treats uids & gids
      exec: Factor security_bprm_creds_for_exec out of security_bprm_set_creds
      exec: Convert security_bprm_set_creds into security_bprm_repopulate_creds
      exec: Allow load_misc_binary to call prepare_binprm unconditionally
      exec: Move the call of prepare_binprm into search_binary_handler
      exec/binfmt_script: Don't modify bprm->buf and then return -ENOEXEC
      exec: Generic execfd support
      exec: Remove recursion from search_binary_handler
      exec: Control flow simplifications
      exec: Always set cap_ambient in cap_bprm_set_creds
      Merge commit a4ae32c71fe9 ("exec: Always set cap_ambient in cap_bprm_set_creds")
      exec: Add a per bprm->file version of per_clear
      exec: Compute file based creds only once
      exec: Remove the recomputation of bprm->cred

Kees Cook (1):
      selftests/exec: Add binfmt_script regression test

 Documentation/trace/ftrace.rst             |   2 +-
 arch/alpha/kernel/binfmt_loader.c          |  11 +-
 arch/x86/ia32/ia32_aout.c                  |   4 +-
 fs/binfmt_aout.c                           |   3 +-
 fs/binfmt_elf.c                            |   7 +-
 fs/binfmt_elf_fdpic.c                      |   9 +-
 fs/binfmt_em86.c                           |  13 +-
 fs/binfmt_flat.c                           |   4 +-
 fs/binfmt_misc.c                           |  69 +------
 fs/binfmt_script.c                         |  82 ++++----
 fs/exec.c                                  | 320 ++++++++++++++++-------------
 include/linux/binfmts.h                    |  45 ++--
 include/linux/lsm_hook_defs.h              |   3 +-
 include/linux/lsm_hooks.h                  |  56 ++---
 include/linux/security.h                   |  15 +-
 kernel/cred.c                              |   3 +
 kernel/events/core.c                       |   2 +-
 security/apparmor/domain.c                 |   7 +-
 security/apparmor/include/domain.h         |   2 +-
 security/apparmor/lsm.c                    |   2 +-
 security/commoncap.c                       |  22 +-
 security/security.c                        |   9 +-
 security/selinux/hooks.c                   |   8 +-
 security/smack/smack_lsm.c                 |   9 +-
 security/tomoyo/tomoyo.c                   |  12 +-
 tools/testing/selftests/exec/Makefile      |   1 +
 tools/testing/selftests/exec/binfmt_script | 171 +++++++++++++++
 27 files changed, 503 insertions(+), 388 deletions(-)


Eric
