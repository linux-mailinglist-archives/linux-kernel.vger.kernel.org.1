Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA202C22AE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgKXKUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50246 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731129AbgKXKUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:01 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D75E41EC0531;
        Tue, 24 Nov 2020 11:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=OvO1ckz+5Qb8CZPEpfo9zKfFqJKO2pQXxzTmhAvh87g=;
        b=Jdt+wcewhT9wRH8f0hKt0Vt8lifydlrwLYXGgb1HO88bwiHPXdGM1f9ErGnAm4BkiEgCwJ
        oR5WtcRM875MVcaNZbDuvcXLxy7Ea64bflInTqZ6YKedaHvLS5XeCw0kPdM/YnxVYEwtb+
        nDGZwcU1RY/NHw49Z6v+71umQzKF378=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Date:   Tue, 24 Nov 2020 11:19:33 +0100
Message-Id: <20201124101952.7909-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Hi,

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

---

diff --git a/arch/x86/tools/insn_sanity.c b/arch/x86/tools/insn_sanity.c
index 51309df285b4..41e1ae0cd833 100644
--- a/arch/x86/tools/insn_sanity.c
+++ b/arch/x86/tools/insn_sanity.c
@@ -220,6 +220,45 @@ static void parse_args(int argc, char **argv)
 	}
 }
 
+static void run_insn_limits_test(void)
+{
+	unsigned char b[MAX_INSN_SIZE];
+	struct insn insn;
+	int ret, i, size;
+
+	memset(b, INSN_NOP, MAX_INSN_SIZE);
+
+	/* IRETQ */
+	b[0] = 0x48;
+	b[1] = 0xcf;
+
+	/* partial add $0x8, %rsp */
+	b[2] = 0x48;
+	b[3] = 0x83;
+
+	printf("insn buffer:\n");
+
+	for (i = 0; i < MAX_INSN_SIZE; i++)
+		printf("0x%hhx ", b[i]);
+	printf("\n");
+
+	size = MAX_INSN_SIZE;
+	ret = insn_decode(&insn, b, size, INSN_MODE_64);
+	printf("supplied buf size: %d, ret %d\n", size, ret);
+
+	size = 2;
+	ret = insn_decode(&insn, b, size, INSN_MODE_64);
+	printf("supplied buf size: %d, ret %d\n", size, ret);
+
+	size = 3;
+	ret = insn_decode(&insn, b, size, INSN_MODE_64);
+	printf("supplied buf size: %d, ret %d\n", size, ret);
+
+	size = 4;
+	ret = insn_decode(&insn, b, size, INSN_MODE_64);
+	printf("supplied buf size: %d, ret %d\n", size, ret);
+}
+
 int main(int argc, char **argv)
 {
 	int insns = 0, ret;
@@ -265,5 +304,7 @@ int main(int argc, char **argv)
 		errors,
 		seed);
 
+	run_insn_limits_test();
+
 	return errors ? 1 : 0;
 }

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
 arch/x86/include/asm/insn.h                   |  42 ++--
 arch/x86/kernel/alternative.c                 |   6 +-
 arch/x86/kernel/cpu/mce/severity.c            |  12 +-
 arch/x86/kernel/kprobes/core.c                |  17 +-
 arch/x86/kernel/kprobes/opt.c                 |   9 +-
 arch/x86/kernel/sev-es.c                      |  15 +-
 arch/x86/kernel/traps.c                       |   7 +-
 arch/x86/kernel/umip.c                        |   2 +-
 arch/x86/kernel/uprobes.c                     |   8 +-
 arch/x86/lib/insn-eval.c                      |  20 +-
 arch/x86/lib/insn.c                           | 190 ++++++++++++++----
 arch/x86/tools/insn_decoder_test.c            |  10 +-
 arch/x86/tools/insn_sanity.c                  |   8 +-
 tools/arch/x86/include/asm/insn.h             |  42 ++--
 tools/arch/x86/lib/insn.c                     | 190 ++++++++++++++----
 tools/include/linux/kconfig.h                 |  73 +++++++
 tools/objtool/arch/x86/decode.c               |   9 +-
 tools/perf/arch/x86/tests/insn-x86.c          |   9 +-
 tools/perf/arch/x86/util/archinsn.c           |   9 +-
 .../intel-pt-decoder/intel-pt-insn-decoder.c  |  17 +-
 24 files changed, 507 insertions(+), 217 deletions(-)
 create mode 100644 tools/include/linux/kconfig.h

-- 
2.21.0

