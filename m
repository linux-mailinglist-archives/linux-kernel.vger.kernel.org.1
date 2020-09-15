Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE9F26AF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 23:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgIOVEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 17:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgIOVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 17:02:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600203758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7QHIRSjUq0tJFcI92B4kapSPBKJs2g6zBRXj5O6BhSQ=;
        b=UnvU6HDeHzuShn9qzo6D5NNGnQ/Zyn1JkFUzHkxVOL+NHzWF27VtYea2jZXIJcVNzGHnuq
        Q4GlgGcW8ueYwRC7GSSIy1sBD77WaJ8+fr0AfF7YjwJn1F+G0hu/sxV9I8h4bonSJ0v+S0
        apXd/2YiMTaQxLqD3OyggAwKEhGdvT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-Jt6zVwijMvOsIG08nd4cyg-1; Tue, 15 Sep 2020 17:02:36 -0400
X-MC-Unique: Jt6zVwijMvOsIG08nd4cyg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5621B107465E;
        Tue, 15 Sep 2020 21:02:34 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36F647EB97;
        Tue, 15 Sep 2020 21:02:33 +0000 (UTC)
Date:   Tue, 15 Sep 2020 16:02:31 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>,
        "Li, Philip" <philip.li@intel.com>, x86-ml <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Marco Elver <elver@google.com>
Subject: Re: [tip:x86/seves] BUILD SUCCESS WITH WARNING
 e6eb15c9ba3165698488ae5c34920eea20eaa38e
Message-ID: <20200915210231.ysaibtkeibdm4zps@treble>
References: <5f60c4e0.Ru0MTgSE9A7mqhpG%lkp@intel.com>
 <20200915135519.GJ14436@zn.tnic>
 <20200915141816.GC28738@shao2-debian>
 <20200915160554.GN14436@zn.tnic>
 <20200915170248.gcv54pvyckteyhk3@treble>
 <CAKwvOdnc8au10g8q8miab89j3tT8UhwnZOMAJdRgkXVrnkhwqQ@mail.gmail.com>
 <20200915204912.GA14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915204912.GA14436@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 10:49:12PM +0200, Borislav Petkov wrote:
> On Tue, Sep 15, 2020 at 01:12:24PM -0700, Nick Desaulniers wrote:
> >       1 warning: objtool: ist_exc_vmm_communication()+0x12: unreachable instruction
> 
> That looks interesting. So your .o has:
> 
> 00000000000004c0 <ist_exc_vmm_communication>:
>  4c0:   55                      push   %rbp
>  4c1:   48 89 e5                mov    %rsp,%rbp
>  4c4:   48 c7 c7 00 00 00 00    mov    $0x0,%rdi
>  4cb:   31 c0                   xor    %eax,%eax
>  4cd:   e8 00 00 00 00          callq  4d2 <ist_exc_vmm_communication+0x12>
>  4d2:   0f 0b                   ud2    
>  4d4:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
>  4db:   00 00 00 00 
>  4df:   90                      nop

If you disassemble with "objdump -dr" it shows the relocations:

00000000000004c0 <ist_exc_vmm_communication>:
 4c0:	55                   	push   %rbp
 4c1:	48 89 e5             	mov    %rsp,%rbp
 4c4:	48 c7 c7 00 00 00 00 	mov    $0x0,%rdi
			4c7: R_X86_64_32S	.rodata.str1.1+0x1ef
 4cb:	31 c0                	xor    %eax,%eax
 4cd:	e8 00 00 00 00       	callq  4d2 <ist_exc_vmm_communication+0x12>
			4ce: R_X86_64_PLT32	panic-0x4
 4d2:	0f 0b                	ud2    
 4d4:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
 4db:	00 00 00 00 
 4df:	90                   	nop

panic() is noreturn, so the compiler is enforcing the fact that it
doesn't return, by trapping if it does return.

I seem to remember that's caused by CONFIG_UBSAN_TRAP.

-- 
Josh

