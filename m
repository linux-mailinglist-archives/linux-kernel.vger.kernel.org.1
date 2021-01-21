Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0C782FF752
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAUVbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 16:31:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726413AbhAUVbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:31:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611264589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3DozC8dW0Uhol+BqgLOqbQLSP2NyYp20B/rQ0y/gMvk=;
        b=a6M3PFkOwXy8rH1BcA+n5uwF+o2Sd06bfHykbs8hHgy0sD3EP0vvXp2FzhmVPUAuoD6oGP
        EILJTBDVEX1q5OQ/TyRJkP811CMQY4knSXLYN49j+MOvlfwHQe+IVai2/ZjWtWVurmu2xA
        k8wGGeViKkCgZmtkSGGdJeiR1Mxo0Lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-GT9ystTpPTW1Hn3-hgxKOg-1; Thu, 21 Jan 2021 16:29:44 -0500
X-MC-Unique: GT9ystTpPTW1Hn3-hgxKOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C301800D41;
        Thu, 21 Jan 2021 21:29:43 +0000 (UTC)
Received: from treble.redhat.com (ovpn-116-102.rdu2.redhat.com [10.10.116.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3488119C59;
        Thu, 21 Jan 2021 21:29:42 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 00/20] objtool: vmlinux.o and CLANG LTO support
Date:   Thu, 21 Jan 2021 15:29:16 -0600
Message-Id: <cover.1611263461.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- fix commit description for why xen hypervisor page contents don't
  matter [Juergen]
- annotate indirect jumps as safe instead of converting them to
  retpolines [Andrew, Juergen]
- drop patch 1 - fake jumps no longer exist
- add acks

Based on tip/objtool/core.


Add support for proper vmlinux.o validation, which will be needed for
Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
objtool anyway, for other reasons.)

This isn't 100% done -- most notably, crypto still needs to be supported
-- but I think this gets us most of the way there.

This can also be found at

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux

And for more testing it can be combined with Sami's x86 LTO patches:

  https://github.com/samitolvanen/linux clang-lto


Josh Poimboeuf (20):
  objtool: Fix error handling for STD/CLD warnings
  objtool: Fix retpoline detection in asm code
  objtool: Fix ".cold" section suffix check for newer versions of GCC
  objtool: Support retpoline jump detection for vmlinux.o
  x86/ftrace: Add UNWIND_HINT_FUNC annotation for ftrace_stub
  objtool: Assume only ELF functions do sibling calls
  objtool: Add asm version of STACK_FRAME_NON_STANDARD
  objtool: Combine UNWIND_HINT_RET_OFFSET and UNWIND_HINT_FUNC
  objtool: Add xen_start_kernel() to noreturn list
  objtool: Move unsuffixed symbol conversion to a helper function
  objtool: Add CONFIG_CFI_CLANG support
  x86/xen: Support objtool validation in xen-asm.S
  x86/xen: Support objtool vmlinux.o validation in xen-head.S
  x86/xen/pvh: Annotate indirect branch as safe
  x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
  x86/acpi: Annotate indirect branch as safe
  x86/acpi: Support objtool validation in wakeup_64.S
  x86/power: Annotate indirect branches as safe
  x86/power: Move restore_registers() to top of the file
  x86/power: Support objtool validation in hibernate_asm_64.S

 arch/x86/include/asm/unwind_hints.h   |  13 +---
 arch/x86/kernel/acpi/Makefile         |   1 -
 arch/x86/kernel/acpi/wakeup_64.S      |   4 +
 arch/x86/kernel/ftrace_64.S           |   8 +-
 arch/x86/lib/retpoline.S              |   2 +-
 arch/x86/platform/pvh/head.S          |   2 +
 arch/x86/power/Makefile               |   1 -
 arch/x86/power/hibernate_asm_64.S     | 103 +++++++++++++-------------
 arch/x86/xen/Makefile                 |   1 -
 arch/x86/xen/xen-asm.S                |  29 +++++---
 arch/x86/xen/xen-head.S               |   5 +-
 include/linux/objtool.h               |  13 +++-
 tools/include/linux/objtool.h         |  13 +++-
 tools/objtool/arch/x86/decode.c       |   4 +-
 tools/objtool/arch/x86/special.c      |   2 +-
 tools/objtool/check.c                 |  89 ++++++++++++----------
 tools/objtool/elf.c                   |  88 ++++++++++++++++------
 tools/objtool/include/objtool/check.h |  12 ++-
 tools/objtool/include/objtool/elf.h   |   2 +-
 19 files changed, 240 insertions(+), 152 deletions(-)

-- 
2.29.2

