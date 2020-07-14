Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8809721F7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGNRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 13:17:18 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:33888 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgGNRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:17:17 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvOYM-0008Cy-TV; Tue, 14 Jul 2020 11:17:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvOYL-0007NN-ND; Tue, 14 Jul 2020 11:17:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Nicolas Pitre <nico@fluxnic.net>
References: <20200630043641.GD2786714@ZenIV.linux.org.uk>
Date:   Tue, 14 Jul 2020 12:14:25 -0500
In-Reply-To: <20200630043641.GD2786714@ZenIV.linux.org.uk> (Al Viro's message
        of "Tue, 30 Jun 2020 05:36:41 +0100")
Message-ID: <875zaq589a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvOYL-0007NN-ND;;;mid=<875zaq589a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DLwPEzJB8iPoGZ+F8SvH9+Vy8PldIabY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_00 obfuscated drug references
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 869 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 12 (1.3%), b_tie_ro: 10 (1.1%), parse: 1.17
        (0.1%), extract_message_metadata: 18 (2.1%), get_uri_detail_list: 3.6
        (0.4%), tests_pri_-1000: 18 (2.0%), tests_pri_-950: 1.44 (0.2%),
        tests_pri_-900: 1.10 (0.1%), tests_pri_-90: 377 (43.4%), check_bayes:
        375 (43.2%), b_tokenize: 11 (1.3%), b_tok_get_all: 12 (1.4%),
        b_comp_prob: 4.3 (0.5%), b_tok_touch_all: 343 (39.4%), b_finish: 1.04
        (0.1%), tests_pri_0: 429 (49.4%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 2.6 (0.3%), poll_dns_idle: 0.82 (0.1%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 6 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCHES] converting FDPIC coredumps to regsets
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> 	Conversion of ELF coredumps to regsets has not touched
> ELF_FDPIC.  Right now all architectures that support FDPIC have
> regsets sufficient for switching it to regset-based coredumps.  A bit
> of backstory: original ELF (and ELF_FDPIC) coredumps reused the old
> helpers used by a.out coredumps.  These days a.out coredumps are gone;
> we could remove the dead code, if not for several obstacles.  And one
> of those obstacles is ELF_FDPIC.
>
> 	This series more or less reproduces the conversion done
> by Roland for ELF coredumps.  The branch is in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.fdpic
> and it's based on top of #regset.base there (just the introduction of
> regset_get() wrapper for ->get(); nothing else from the regset series
> is needed).  Killing the old aout helpers is _not_ in this branch;
> followup cleanups live separately.
>
> 	First we need to sort out the mess with struct elf_prstatus,
> though.  It's used both for ELF and ELF_FDPIC coredumps, and it
> contains a couple of fields under ifdef on CONFIG_BINFMT_ELF_FDPIC.
> ELF is MMU-dependent and most, but not all configs that allow ELF_FDPIC
> are non-MMU.  ARM is an exception - there ELF_FDPIC is allowed both for
> MMU and non-MMU configs.  That's a problem - struct elf_prstatus is a
> part of coredump layout, so ELF coredumps produced by arm kernels that
> have ELF_FDPIC enabled are incompatible with those that have it disabled.
>
> 	The obvious solution is to introduce struct elf_prstatus_fdpic
> and use that in binfmt_elf_fdpic.c, taking these fields out of the
> normal struct elf_prstatus.  Unfortunately, the damn thing is defined in
> include/uapi/linux/elfcore.h, so nominally it's a part of userland ABI.
> However, not a single userland program actually includes linux/elfcore.h.
> The reason is that the definition in there uses elf_gregset_t as a member,
> and _that_ is not defined anywhere in the exported headers.  It is defined
> in (libc) sys/procfs.h, but the same file defines struct elf_prstatus
> as well.  So if you try to include linux/elfcore.h without having already
> pulled sys/procfs.h, it'll break on incomplete type of a member.  And if
> you have pulled sys/procfs.h, it'll break on redefining a structure.
> IOW, it's not usable and it never had been; as the matter of fact,
> that's the reason sys/procfs.h had been introduced back in 1996.
>
> 1/7) unexport linux/elfcore.h
> 	Takes it out of include/uapi/linux and moves the stuff that used
> to live there into include/linux/elfcore.h
>
> 2/7) take fdpic-related parts of elf_prstatus out
> 	Now we can take that ifdef out of the definition of elf_prstatus
> (as well as compat_elf_prstatus) and put the variant with those extra
> fields into binfmt_elf_fdpic.c, calling it elf_prstatus_fdpic there.
>
> 3/7) kill elf_fpxregs_t
> 	All code dealing with it (both in elf_fdpic and non-regset side
> of elf) is conditional upon ELF_CORE_COPY_XFPREGS.  And no architectures
> define that anymore.  Take the dead code out.
>
> 4/7) [elf-fdpic] coredump: don't bother with cyclic list for per-thread
> objects
> 5/7) [elf-fdpic] move allocation of elf_thread_status into
> elf_dump_thread_status()
> 6/7) [elf-fdpic] use elf_dump_thread_status() for the dumper thread as well
> 	Massaging fdpic coredump logics towards the regset side of
> elf coredump.
>
> 7/7) [elf-fdpic] switch coredump to regsets
> 	... and now we can switch from elf_core_copy_task_{,fp}regs()
> to regset_get().

I just did a quick read through.

The KABI bits look sane, or rather pulling definitions out of the KABI
headers because they are not usable seems like a reasonable response to
a messed up situation.  In the long run it would be good if we could get
some proper KABI headers for the format of coredumps.

I am a bit confused about what is happening in the cleanups, and frankly
the fault really lies with the binfmt_elf.c.  As binfmt_elf.c in Linus's
tree still has a regset and a non-regset version of core dumping.

What I see happening is that you are transforming what started off
as a copy of the non-regset version of elf coredumping and transforming
it into something close to the regset version of coredumping.  Which is
sensible.  The fact that the elf_fdpic code continues to use the
non-regset names for the functions it calls, and does not synchronize
it's structure with the ordinary elf core dumping code may be sensible
but it is extremely confusing to follow.

As a follow up it would probably good to sort out synchronize the
elf and elf_fdpic coredumping code as much as possible, just to simplify
future maintenance.

So for as much as I could understand and verify.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
