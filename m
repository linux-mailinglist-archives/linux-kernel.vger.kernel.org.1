Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5522E2002
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgLWRnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgLWRnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:21 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 426F31EC03FA;
        Wed, 23 Dec 2020 18:42:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=FD61H8rIxHmCvemqh8Q/kVuULBJ2A4rjtyxggNQV5ok=;
        b=A8Oyjb2lc4zMcAgmi2GMqaT0ekPcZf3CDKcLb+GqU3JsgBt2aWhW3PQbf90D2kmTMqtQGQ
        oYf78DDwRZaRtULwfjsXeUt5TW+EbLvUKWtqP8ru7Ewq8GL4fFz5SVzMm23n8ZdqW6i/kp
        XuBBltiAahVn3NboYOQZ/acQABoJHwE=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 00/19] x86/insn: Add an insn_decode() API
Date:   Wed, 23 Dec 2020 18:42:14 +0100
Message-Id: <20201223174233.28638-1-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

here's v1 with the requested change to return -ENODATA on short input to
the decoder. The rest is as in the previous submission.

Only lightly tested.

Thx.

changelog:
==========

v0:
---

https://lkml.kernel.org/r/20201124101952.7909-1-bp@alien8.de

here's what I had in mind, finally split into proper patches. The final
goal is for all users of the decoder to simply call insn_decode() and
look at its retval. Simple.

As to amluto's question about detecting partial insns, see the diff
below.

Running that gives:

insn buffer:
0x48 0xcf 0x48 0x83 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 0x90 
supplied buf size: 15, ret 0
supplied buf size: 2, ret 0
supplied buf size: 3, ret 0
supplied buf size: 4, ret 0

and the return value is always success.

Which means that that buf_len that gets supplied to the decoder
functions doesn't really work and I need to look into it.

That is, provided this is how we want to control what the instruction
decoder decodes - by supplying the length of the buffer it should look
at.

We could also say that probably there should be a way to say "decode
only the first insn in the buffer and ignore the rest". That is all up
to the use cases so I'm looking for suggestions here.

In any case, at least the case where I give it

0x48 0xcf 0x48 0x83

and say that buf size is 4, should return an error because the second
insn is incomplete. So I need to go look at that now.

Thx.

Borislav Petkov (19):
  x86/insn: Rename insn_decode() to insn_decode_regs()
  x86/insn: Add @buf_len param to insn_init() kernel-doc comment
  x86/insn: Add an insn_decode() API
  x86/insn-eval: Handle return values from the decoder
  x86/boot/compressed/sev-es: Convert to insn_decode()
  perf/x86/intel/ds: Check insn_get_length() retval
  perf/x86/intel/ds: Check return values of insn decoder functions
  x86/alternative: Use insn_decode()
  x86/mce: Convert to insn_decode()
  x86/kprobes: Convert to insn_decode()
  x86/sev-es: Convert to insn_decode()
  x86/traps: Convert to insn_decode()
  x86/uprobes: Convert to insn_decode()
  x86/tools/insn_decoder_test: Convert to insn_decode()
  tools/objtool: Convert to insn_decode()
  x86/tools/insn_sanity: Convert to insn_decode()
  tools/perf: Convert to insn_decode()
  x86/insn: Remove kernel_insn_init()
  x86/insn: Make insn_complete() static

 arch/x86/boot/compressed/sev-es.c             |  11 +-
 arch/x86/events/intel/ds.c                    |   4 +-
 arch/x86/events/intel/lbr.c                   |  10 +-
 arch/x86/include/asm/insn-eval.h              |   4 +-
 arch/x86/include/asm/insn.h                   |  42 ++-
 arch/x86/kernel/alternative.c                 |   6 +-
 arch/x86/kernel/cpu/mce/severity.c            |  12 +-
 arch/x86/kernel/kprobes/core.c                |  17 +-
 arch/x86/kernel/kprobes/opt.c                 |   9 +-
 arch/x86/kernel/sev-es.c                      |  15 +-
 arch/x86/kernel/traps.c                       |   7 +-
 arch/x86/kernel/umip.c                        |   2 +-
 arch/x86/kernel/uprobes.c                     |   8 +-
 arch/x86/lib/insn-eval.c                      |  25 +-
 arch/x86/lib/insn.c                           | 247 ++++++++++++++----
 arch/x86/tools/insn_decoder_test.c            |  10 +-
 arch/x86/tools/insn_sanity.c                  |   8 +-
 tools/arch/x86/include/asm/insn.h             |  42 ++-
 tools/arch/x86/lib/insn.c                     | 247 ++++++++++++++----
 tools/include/linux/kconfig.h                 |  73 ++++++
 tools/objtool/arch/x86/decode.c               |   9 +-
 tools/perf/arch/x86/tests/insn-x86.c          |   9 +-
 tools/perf/arch/x86/util/archinsn.c           |   9 +-
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  17 +-
 24 files changed, 595 insertions(+), 248 deletions(-)
 create mode 100644 tools/include/linux/kconfig.h

-- 
2.29.2

