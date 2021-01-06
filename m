Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B675D2EB6E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbhAFAbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbhAFAbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:31:04 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE2EC061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 16:30:24 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwwiO-007DEZ-VN; Wed, 06 Jan 2021 00:30:17 +0000
Date:   Wed, 6 Jan 2021 00:30:16 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
Subject: Re: in_compat_syscall() on x86
Message-ID: <20210106003016.GZ3579531@ZenIV.linux.org.uk>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
 <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
 <87mtxodxat.fsf@x220.int.ebiederm.org>
 <20210105005700.GR3579531@ZenIV.linux.org.uk>
 <878s97aq4c.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s97aq4c.fsf@x220.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 06:03:15PM -0600, Eric W. Biederman wrote:
> > Yes, the current mainline is bloody awful in that area (PRSTATUS_SIZE and
> > SET_PR_FPVALID are not for weak stomach), but that's really not hard to
> > get into sane shape - -next had that done in last cycle and I'm currently
> > testing (well, building the test kernel) of port of that to 5.11-rc1.
> 
> That does sound interesting.  Anytime we can clean up arch specific
> weirdness so that it simply becomes generic weirdness and it can be
> tested and maintained by more people is always nice.

vfs.git #work.elf-compat, and AFAICS it works.

 arch/Kconfig                               |   3 ++
 arch/arm64/Kconfig                         |   1 -
 arch/ia64/kernel/crash.c                   |   2 +-
 arch/mips/Kconfig                          |   8 ++----
 arch/mips/include/asm/elf.h                |  56 +++++++++++++-----------------------
 arch/mips/include/asm/elfcore-compat.h     |  29 +++++++++++++++++++
 arch/mips/kernel/Makefile                  |   4 +--
 arch/mips/kernel/binfmt_elfn32.c           | 106 --------------------------------------------------------------------
 arch/mips/kernel/binfmt_elfo32.c           | 109 ----------------------------------------------------------------------
 arch/mips/kernel/scall64-n64.S             |   2 +-
 arch/parisc/Kconfig                        |   1 -
 arch/powerpc/Kconfig                       |   1 -
 arch/powerpc/platforms/powernv/opal-core.c |   6 ++--
 arch/s390/Kconfig                          |   1 -
 arch/s390/kernel/crash_dump.c              |   2 +-
 arch/sparc/Kconfig                         |   1 -
 arch/x86/Kconfig                           |   2 +-
 arch/x86/include/asm/compat.h              |  11 -------
 arch/x86/include/asm/elf.h                 |   2 +-
 arch/x86/include/asm/elfcore-compat.h      |  31 ++++++++++++++++++++
 fs/Kconfig.binfmt                          |   2 +-
 fs/binfmt_elf.c                            |  19 ++++++-------
 fs/binfmt_elf_fdpic.c                      |  22 ++++----------
 fs/compat_binfmt_elf.c                     |   7 +----
 include/linux/elfcore-compat.h             |  15 ++++++++--
 include/linux/elfcore.h                    |   7 ++++-
 kernel/kexec_core.c                        |   2 +-
 28 files changed, 128 insertions(+), 324 deletions(-)
 create mode 100644 arch/mips/include/asm/elfcore-compat.h
 delete mode 100644 arch/mips/kernel/binfmt_elfn32.c
 delete mode 100644 arch/mips/kernel/binfmt_elfo32.c
 create mode 100644 arch/x86/include/asm/elfcore-compat.h

