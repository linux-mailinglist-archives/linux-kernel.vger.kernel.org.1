Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6170D2DB6A0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbgLOWpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:45:25 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:49082 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729791AbgLOWpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:45:08 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpJ3S-00CpT4-RA; Tue, 15 Dec 2020 15:44:26 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kpJ3S-0002Bn-4w; Tue, 15 Dec 2020 15:44:26 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Dec 2020 16:43:41 -0600
Message-ID: <87bleubsgy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kpJ3S-0002Bn-4w;;;mid=<87bleubsgy.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19HxtS8hHnLlEoclg7VYSAxKAkqnUV2i4U=
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
        *      [score: 0.4208]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (1.0%), b_tie_ro: 2.5 (0.7%), parse: 0.60
        (0.2%), extract_message_metadata: 2.8 (0.8%), get_uri_detail_list:
        1.42 (0.4%), tests_pri_-1000: 2.4 (0.7%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 89 (24.3%), check_bayes:
        87 (23.9%), b_tokenize: 6 (1.5%), b_tok_get_all: 6 (1.5%),
        b_comp_prob: 1.56 (0.4%), b_tok_touch_all: 72 (19.6%), b_finish: 0.64
        (0.2%), tests_pri_0: 252 (68.9%), check_dkim_signature: 0.37 (0.1%),
        check_dkim_adsp: 2.00 (0.5%), poll_dns_idle: 0.65 (0.2%),
        tests_pri_10: 1.78 (0.5%), tests_pri_500: 6 (1.7%), rewrite_mail: 0.00
        (0.0%)
Subject: [GIT PULL] signal enhancements for v5.11-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull the signal-for-v5.11 branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

   HEAD: bc54a5cda97917155b8da0d99afe1dc0ed0b30db signal/parisc: Remove parisc specific definition of __ARCH_UAPI_SA_FLAGS

This is the work from Peter Collingbourne to add an new signal action
flag SA_EXPOSE_TAGBITS on arm64.  There was a lot of discussion leading
up to this and ultimately we were able to channel the original proposal
into something that is much more maintainable than an arm64 specific
hack.

Most of this I believe has already come in through Catalin Marinas pull
request "arm64 updates for 5.11".  As I took the generic bits of the
cleanup and place it in a non-rebasing branch.  There is a compile fix
for parisc that was caught late that I don't believe Catalin picked up.

The generic changes are mostly about removing never used HP-UX
compatibility from parisc headers and consolidating the SA_* flags
definitions into a generic header as much as possible.  We only have 32
SA_* flag bits total, so we need to be careful.  But as this is the
first addition in a decade or so I think we are fine for the forseeable
future.

Eric W. Biederman (1):
      signal/parisc: Remove parisc specific definition of __ARCH_UAPI_SA_FLAGS

Helge Deller (1):
      parisc: Drop parisc special case for __sighandler_t

Peter Collingbourne (6):
      parisc: start using signal-defs.h
      arch: move SA_* definitions to generic headers
      signal: clear non-uapi flag bits when passing/returning sa_flags
      arch: provide better documentation for the arch-specific SA_* flags
      signal: define the SA_UNSUPPORTED bit in sa_flags
      signal: define the SA_EXPOSE_TAGBITS bit in sa_flags

 arch/alpha/include/uapi/asm/signal.h   | 14 --------
 arch/arm/include/asm/signal.h          |  2 ++
 arch/arm/include/uapi/asm/signal.h     | 27 ++-------------
 arch/h8300/include/uapi/asm/signal.h   | 24 -------------
 arch/ia64/include/uapi/asm/signal.h    | 24 -------------
 arch/m68k/include/uapi/asm/signal.h    | 24 -------------
 arch/mips/include/uapi/asm/signal.h    | 12 -------
 arch/parisc/include/uapi/asm/signal.h  | 34 +-----------------
 arch/powerpc/include/uapi/asm/signal.h | 24 -------------
 arch/s390/include/uapi/asm/signal.h    | 24 -------------
 arch/sparc/include/uapi/asm/signal.h   |  4 +--
 arch/x86/include/uapi/asm/signal.h     | 24 -------------
 arch/x86/kernel/signal_compat.c        |  7 ----
 arch/xtensa/include/uapi/asm/signal.h  | 24 -------------
 include/linux/signal.h                 | 14 ++++++++
 include/linux/signal_types.h           | 12 +++++++
 include/uapi/asm-generic/signal-defs.h | 63 ++++++++++++++++++++++++++++++++++
 include/uapi/asm-generic/signal.h      | 29 ----------------
 kernel/signal.c                        | 40 +++++++++++++++++++++
 19 files changed, 136 insertions(+), 290 deletions(-)

Eric
