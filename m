Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 863872DC780
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 21:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLPUDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 15:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726877AbgLPUDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 15:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608148926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ho9PPYv+1UwQ5JBc1uUgDPq/AaB5ido8rQiNgCpjGCU=;
        b=XeCNQitnGV2mDjzVIJ00YIp9Gc0VPLcoH3h8MhbScU1w1vc4cIVnXzPo+jTVRiAUgRiEde
        DC4ji0FaGSyi+8aHHsALqhiDA7+dWY3vB+jdt5AvprTtA7KorT3TfqcfbsehzZe/RbzaZ3
        ddytzNjhfuA4sh6B0jnbl23gS8AAs4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-4eBTrRGZMgKkNSx8aLLC-A-1; Wed, 16 Dec 2020 15:02:03 -0500
X-MC-Unique: 4eBTrRGZMgKkNSx8aLLC-A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0213F8015F4;
        Wed, 16 Dec 2020 20:02:02 +0000 (UTC)
Received: from treble (ovpn-112-170.rdu2.redhat.com [10.10.112.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D3EE60BF3;
        Wed, 16 Dec 2020 20:02:01 +0000 (UTC)
Date:   Wed, 16 Dec 2020 14:01:58 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: New objtool warning..
Message-ID: <20201216200158.akf356yrw44o2rlb@treble>
References: <CAHk-=wiXtdHJBXw+=0so3ZV8mvG0xEykxUta2sUWPB=hUWHmtQ@mail.gmail.com>
 <20201216044918.jdmi32dz75uboybv@treble>
 <CAHk-=wjMoZesNgi1yWzY3nikyR11PUxHgov561UNom5mL1R4rA@mail.gmail.com>
 <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whpp_eo-5d0ZLpx=0X91J0ZNReZ_9riNf96z2dy24z=hw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:32:29PM -0800, Linus Torvalds wrote:
> > The asm code looks like this:
> >
> >         cmpb    $4, %al #, _30
> >         jne     .L176   #,
> > ...
> >         cmpb    $12, %al        #, _30
> >         jne     .L176   #,
> > ...
> > .L176:
> > # drivers/gpu/drm/drm_edid.c:3118:                      unreachable();
> > #APP
> > # 3118 "drivers/gpu/drm/drm_edid.c" 1
> >         320:    #
> >         .pushsection .discard.unreachable
> >         .long 320b - .  #
> >         .popsection
> > # 0 "" 2
> > #NO_APP
> >    .. this falls through..
> >
> > So you *should* find that label that then falls through in that
> > ".discard.unreachable" section, and so it should be possible to teach
> > objdump about that (insane) unreachable code that way. No?

So this is kind of tricky, because the unreachable() annotation usually
means "the previous instruction is a dead end".  Most of the time, the
next instruction -- the one actually pointed to by the annotation -- is
actually reachable from another path.


For example, here's a typical usage of unreachable():

	je not_a_bug
	ud2

	.pushsection .discard.unreachable
	.long not_a_bug - .
	.popsection

not_a_bug:
	... normal non-buggy code ...

The 'not_a_bug' label is pointed to by the unreachable annotation, but
it's actually reachable.


In your .o, .discard.unreachable points to 0xbb3, so objtool marks the
previous instruction (0xbae) as a dead end:

     bae:       e9 30 ff ff ff          jmpq   ae3 <do_cvt_mode+0xd3>
     bb3:       66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
     bba:       00 00 00 00
     bbe:       66 90                   xchg   %ax,%ax

And there's another path to 0xbb3 from the switch statement, so objtool
assumes it's reachable.

So maybe we need to make objtool's unreachable logic a little more
nuanced: If the previous instruction is an unconditional jump, then
consider *the annotated instruction itself* to be a dead end.

I'm not quite able to convince myself this wouldn't produce false
positives.  It did immediately produce one false positive in
no_context(), but that should be easily fixable (see patch).

I can run it through more testing, if you don't see any obvious problems
with it.


diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index f1f1b5a0956a..c888821bb40c 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -699,7 +699,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 */
 		asm volatile ("movq %[stack], %%rsp\n\t"
 			      "call handle_stack_overflow\n\t"
-			      "1: jmp 1b"
 			      : ASM_CALL_CONSTRAINT
 			      : "D" ("kernel stack overflow (page fault)"),
 				"S" (regs), "d" (address),
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c6ab44543c92..267e8b88ca3a 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -370,9 +370,12 @@ static int add_dead_ends(struct objtool_file *file)
 			return -1;
 		}
 		insn = find_insn(file, reloc->sym->sec, reloc->addend);
-		if (insn)
-			insn = list_prev_entry(insn, list);
-		else if (reloc->addend == reloc->sym->sec->len) {
+		if (insn) {
+			struct instruction *prev = list_prev_entry(insn, list);
+			if (prev->type != INSN_JUMP_UNCONDITIONAL)
+				insn = prev;
+
+		} else if (reloc->addend == reloc->sym->sec->len) {
 			insn = find_last_insn(file, reloc->sym->sec);
 			if (!insn) {
 				WARN("can't find unreachable insn at %s+0x%x",

