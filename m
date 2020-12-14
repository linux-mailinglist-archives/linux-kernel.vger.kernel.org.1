Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390752DA3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 23:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441238AbgLNWvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 17:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441216AbgLNWvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 17:51:50 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D5C061793
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 14:51:09 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kowgN-001Hjz-Ez; Mon, 14 Dec 2020 22:51:07 +0000
Date:   Mon, 14 Dec 2020 22:51:07 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] misc followups to regset work
Message-ID: <20201214225107.GD3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Dead code removal, mostly; the only exception is a bit of cleanups
on itanic (getting rid of redundant stack unwinds - each access_uarea()
call does it and we call that 7 times in a row in ptrace_[sg]etregs(), *after*
having done it ourselves in the caller; location where the user registers
have been spilled won't change under us, and we can bloody well just call
access_elf_reg() directly, giving it the unw_frame_info we'd calculated for
our own purposes).

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git regset.followup

for you to fetch changes up to d4948d19d47f08f926db55f0fb8cb324e43f1c19:

  c6x: kill ELF_CORE_COPY_FPREGS (2020-10-25 20:03:06 -0400)

----------------------------------------------------------------
Al Viro (5):
      arm: kill dump_task_regs()
      [ia64] missed cleanups from switch to regset coredumps
      [ia64] ptrace_[sg]etregs(): use access_elf_reg() instead of access_uarea()
      whack-a-mole: USE_ELF_CORE_DUMP
      c6x: kill ELF_CORE_COPY_FPREGS

 arch/arm/include/asm/elf.h     |  4 ----
 arch/arm/kernel/process.c      |  9 --------
 arch/c6x/include/asm/elf.h     |  3 ---
 arch/csky/include/asm/elf.h    |  1 -
 arch/hexagon/include/asm/elf.h |  1 -
 arch/ia64/kernel/process.c     |  2 +-
 arch/ia64/kernel/ptrace.c      | 51 ++++++++++++++++++++++--------------------
 arch/nds32/include/asm/elf.h   |  1 -
 8 files changed, 28 insertions(+), 44 deletions(-)
