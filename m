Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD072F6B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbhANTo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:44:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22140 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729205AbhANTo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610653381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=utbSIuyoQOkLB93xAGsbds2nLdvkpqUcRNTv/wbR8kg=;
        b=IRlZiiYt187DVd+Cgg+pvxpmfmA//8bk/5umjHolXoLcuZyCH0S9yDdEl328kvAzZWG6Qt
        tD6UeASYW+B3k5XXBArHYl+tKsbYjjs0rx3/Ldcra+fImdVySpFkEf5qAkQRY6cgCE0AqR
        04O1fQGP9EUn1II6TPx59PBmxYNnliA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-OJ937Q2pNXCbNls68d4EZw-1; Thu, 14 Jan 2021 14:40:24 -0500
X-MC-Unique: OJ937Q2pNXCbNls68d4EZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98E39806663;
        Thu, 14 Jan 2021 19:40:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC09101E663;
        Thu, 14 Jan 2021 19:40:21 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 00/21] objtool: vmlinux.o and CLANG LTO support
Date:   Thu, 14 Jan 2021 13:39:56 -0600
Message-Id: <cover.1610652862.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for proper vmlinux.o validation, which will be needed for
Sami's upcoming x86 LTO set.  (And vmlinux validation is the future for
objtool anyway, for other reasons.)

This isn't 100% done -- most notably, crypto still needs to be supported
-- but I think this gets us most of the way there.

This can also be found at

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-vmlinux

And for more testing it can be combined with Sami's x86 LTO patches:

  https://github.com/samitolvanen/linux clang-lto



Josh Poimboeuf (21):
  objtool: Fix seg fault in BT_FUNC() with fake jump
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
  x86/xen/pvh: Convert indirect jump to retpoline
  x86/ftrace: Support objtool vmlinux.o validation in ftrace_64.S
  x86/acpi: Convert indirect jump to retpoline
  x86/acpi: Support objtool validation in wakeup_64.S
  x86/power: Convert indirect jumps to retpolines
  x86/power: Move restore_registers() to top of the file
  x86/power: Support objtool validation in hibernate_asm_64.S

 arch/x86/include/asm/unwind_hints.h |  13 +---
 arch/x86/kernel/acpi/Makefile       |   1 -
 arch/x86/kernel/acpi/wakeup_64.S    |   5 +-
 arch/x86/kernel/ftrace_64.S         |   8 +--
 arch/x86/lib/retpoline.S            |   2 +-
 arch/x86/platform/pvh/head.S        |   3 +-
 arch/x86/power/Makefile             |   1 -
 arch/x86/power/hibernate_asm_64.S   | 105 ++++++++++++++--------------
 arch/x86/xen/Makefile               |   1 -
 arch/x86/xen/xen-asm.S              |  29 +++++---
 arch/x86/xen/xen-head.S             |   5 +-
 include/linux/objtool.h             |  13 +++-
 tools/include/linux/objtool.h       |  13 +++-
 tools/objtool/arch/x86/decode.c     |   4 +-
 tools/objtool/arch/x86/special.c    |   2 +-
 tools/objtool/check.c               |  91 +++++++++++++-----------
 tools/objtool/check.h               |  12 +++-
 tools/objtool/elf.c                 |  87 +++++++++++++++++------
 tools/objtool/elf.h                 |   2 +-
 19 files changed, 241 insertions(+), 156 deletions(-)

-- 
2.29.2

