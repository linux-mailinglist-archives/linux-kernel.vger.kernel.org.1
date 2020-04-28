Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77401BC4B5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 18:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgD1QK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 12:10:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30553 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728660AbgD1QK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588090255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BvGI5FUs0bqWu+Zx8FDc9MXrUmI/gSrh2ap0YyduCgU=;
        b=YNj7BqQf1xnONI0t94RJAJUZJfMnN0x8g1E1i7zOJ1axixf70zGgAYm0Hsb3k4q3/kx0Xt
        KzOnrfdDSTyjYVeES1fHqitaStpat37U5khc5yKaaWt3RRZszbRDL0c6WJjv80C7E2IdUC
        lRoqsVKlnW8v/AautRp6OlmT6M09OH0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-_h7PqQY5OyKK8Dk0b_f2VA-1; Tue, 28 Apr 2020 12:10:48 -0400
X-MC-Unique: _h7PqQY5OyKK8Dk0b_f2VA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60F1E835B42;
        Tue, 28 Apr 2020 16:10:47 +0000 (UTC)
Received: from treble (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC35F6111F;
        Tue, 28 Apr 2020 16:10:46 +0000 (UTC)
Date:   Tue, 28 Apr 2020 11:10:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200428161044.caamvx67t2z4t6vd@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:49:15PM +0200, Arnd Bergmann wrote:
> I noticed the number of objtool warnings in randconfig kernels have gone down
>  recently, maybe it's possible to eliminate the remaining ones?
> 
> Here are the ones I ran into recently, using gcc-9.3:
> 
> ==> build/x86/0x3D2B5D6D_defconfig/log <==
> arch/x86/kvm/vmx/vmx.o: warning: objtool: vmx_handle_exit_irqoff()+0x24: unreachable instruction

This is a legit warning caused by CONFIG_UBSAN_TRAP +
CONFIG_UBSAN_ALIGNMENT, I think Kees is going to do a fix.

> ==> build/x86/0xFD7B7323_defconfig/log <==
> arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x991: unreachable instruction

This warning looks correct, did you make a change to entry_64.S?

> ==> build/x86/0x7942F24A_defconfig/log <==
> samples/ftrace/ftrace-direct.o: warning: objtool: .text+0x0: unreachable instruction
> samples/ftrace/ftrace-direct-too.o: warning: objtool: .text+0x0: unreachable instruction
> samples/ftrace/ftrace-direct-modify.o: warning: objtool: .text+0x0: unreachable instruction

I posted a fix for these a few days ago:

https://lkml.kernel.org/r/86c1cbca67cb353da9f335643ef5fd19bd82988f.1587761369.git.jpoimboe@redhat.com

> ==> build/x86/0xE0F2ACFF_defconfig/log <==
> kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
>
> ==> build/x86/0x2EA4CE4F_defconfig/log <==
> kernel/kcov.o: warning: objtool: write_comp_data()+0x1b: call to check_kcov_mode() with UACCESS enabled
> kernel/kcov.o: warning: objtool: __sanitizer_cov_trace_pc()+0x15: call to check_kcov_mode() with UACCESS enabled
> 
> ==> build/x86/0x500B1B82_defconfig/log <==
> kernel/bpf/core.o: warning: objtool: ___bpf_prog_run()+0x1269: call
> without frame pointer save/setup

I'll look into these.

-- 
Josh

