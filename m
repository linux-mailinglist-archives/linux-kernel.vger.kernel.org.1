Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F342E9845
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbhADPSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727357AbhADPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609773401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2NNGGIsCzmJcVG4Le5Juli3XgCVUNleJrw+22odZ79o=;
        b=h938dfzotoC6mRTIEgcB5SDEESpvIL+kdsG0ICj5q/4To09JxZQPtdoJJ9cb+msn0vNB9A
        UTAze7FZqpJKToD1lMxAM1EpI4fRT5VVyeCEG+lzcUBMfN/HwD6jRLICTit2FO9CeQvbao
        ZMRO2g+K2HMUHdsrDgBYlzscV40V1BM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-AVlI2Q0uMIqfVxh8hDZZLQ-1; Mon, 04 Jan 2021 10:16:38 -0500
X-MC-Unique: AVlI2Q0uMIqfVxh8hDZZLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EBC6190A7A0;
        Mon,  4 Jan 2021 15:16:37 +0000 (UTC)
Received: from treble (ovpn-113-48.rdu2.redhat.com [10.10.113.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A35C271B6;
        Mon,  4 Jan 2021 15:16:36 +0000 (UTC)
Date:   Mon, 4 Jan 2021 09:16:33 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 3/3] objtool: Support stack layout changes in alternatives
Message-ID: <20210104151633.ojv3wggzpxzn2alx@treble>
References: <cover.1608700338.git.jpoimboe@redhat.com>
 <9f78604e49b400eb3b2ca613591f8c357474ed4e.1608700338.git.jpoimboe@redhat.com>
 <20210104140952.GQ3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104140952.GQ3021@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 03:09:52PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 22, 2020 at 11:18:10PM -0600, Josh Poimboeuf wrote:
> 
> > For example, this scenario is allowed:
> > 
> >           Alt1                    Alt2                    Alt3
> > 
> >    0x00   CALL *pv_ops.save_fl    CALL xen_save_fl        PUSHF
> >    0x01                                                   POP %RAX
> >    0x02                                                   NOP
> >    ...
> >    0x05                           NOP
> >    ...
> >    0x07   <insn>
> > 
> 
> > This scenario is NOT allowed:
> > 
> >           Alt1                    Alt2
> > 
> >    0x00   CALL *pv_ops.save_fl    PUSHF
> >    0x01                           NOP6
> >    ...
> >    0x07   NOP                     POP %RAX
> > 
> 
> > The problem here is that offset-0x7, which is an instruction boundary in
> > both possible instruction patch streams, has two conflicting stack
> > layouts.
> 
> There's another fun scenario:
> 
>   0x00	CALL *pv_ops.save_fl		PUSHF
>   0x01					NOP2
>   ..
>   0x03					NOP5
>   ..
>   0x07	NOP2
>   0x08					POP %RAX
>   0x09	<insn>
> 
> No conflicting boundary at 0x07, but still buggered.
> 
> Let me go read the actual patch to see if this is handled.

That scenario looks good, see ORC below:

.diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index cad08703c4ad..4079a430ab3f 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1483,3 +1483,8 @@ SYM_CODE_START(rewind_stack_do_exit)
 	call	do_exit
 SYM_CODE_END(rewind_stack_do_exit)
 .popsection
+
+SYM_FUNC_START(peter)
+	ALTERNATIVE "call *pv_ops+288(%rip); .byte 0x66,0x90", "pushf; .byte 0x66,0x90; .byte 0x66,0x66,0x66,0x90; popq %rax", X86_FEATURE_ALWAYS
+	ret
+SYM_FUNC_END(peter)


00000000000014e0 <peter>:
    14e0:       ff 15 00 00 00 00       callq  *0x0(%rip)        # 14e6 <peter+0x6>
                        14e2: R_X86_64_PC32     pv_ops+0x11c
    14e6:       66 90                   xchg   %ax,%ax
    14e8:       c3                      retq

alt replacement:
  cf:   9c                      pushfq
  d0:   66 90                   xchg   %ax,%ax
  d2:   66 66 66 90             data16 data16 xchg %ax,%ax
  d6:   58                      pop    %rax



ORC:

.entry.text+14e0: sp:sp+8 bp:(und) type:call end:0
.entry.text+14e1: sp:sp+16 bp:(und) type:call end:0
.entry.text+14e6: sp:sp+8 bp:(und) type:call end:0
.entry.text+14e7: sp:sp+16 bp:(und) type:call end:0
.entry.text+14e8: sp:sp+8 bp:(und) type:call end:0
.entry.text+14e9: sp:(und) bp:(und) type:call end:0

-- 
Josh

