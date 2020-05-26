Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5147E1BEC72
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 01:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD2XLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 19:11:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726775AbgD2XLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588201880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1paFFo2Yqg1zYoVKIMCaB6BJEuowfAoRJebJ26CU3Yo=;
        b=FUd2Q44PVoIHyDPaKFVAuFh+hq72ZxWAr1ISyCIQ/gtF1P+UHLEH3uVZ9hFQfU5noOiGUu
        LEtOqDaE1/8WiXfx1WYgnNrisCTfCQhYylvYHJq2krhWPh9FbqydWzrPhextNXGTUGX/K7
        f7y9Qup2imu85OPJIaCDDUh4aK0uF+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-vfauNQyHNUWPHpY4HZ_Dtg-1; Wed, 29 Apr 2020 19:11:19 -0400
X-MC-Unique: vfauNQyHNUWPHpY4HZ_Dtg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8AE835B40;
        Wed, 29 Apr 2020 23:11:17 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 214A960C18;
        Wed, 29 Apr 2020 23:11:17 +0000 (UTC)
Date:   Wed, 29 Apr 2020 18:11:15 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
Message-ID: <20200429231115.z2mo5bsmrmj4oark@treble>
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
 <20200428161044.caamvx67t2z4t6vd@treble>
 <20200429185536.5xshpcwtn4be4llh@treble>
 <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0M9qh2-_5VKx89ZsTfy5S1zhfWwnO7rN4xYhDwBBvPjw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:46:57AM +0200, Arnd Bergmann wrote:
> On Wed, Apr 29, 2020 at 8:55 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Apr 28, 2020 at 11:10:44AM -0500, Josh Poimboeuf wrote:
> > > > ==> build/x86/0xE0F2ACFF_defconfig/log <==
> > > > kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
> >
> > This one is fixed with the following cleanup:
> >
> > From: Josh Poimboeuf <jpoimboe@redhat.com>
> > Subject: [PATCH] linkage: Convert syscall alias macros to C
> >
> > There's no need to use inline asm to create ELF alias symbols.
> > Annotated C function declarations can be used instead.
> >
> > This also makes the ordering of the ELF symbol table more logical, with
> > the real function now always coming before the aliases.  This makes it
> > easier for objtool, objdump and other tools to differentiate them.
> >
> > This fixes the following warning:
> >
> >   kernel/time/posix-stubs.o: warning: objtool: __x64_sys_timer_create()+0x23: sibling call from callable instruction with modified stack frame
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  include/linux/linkage.h | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> Unfortunately, this patch leads to new warnings when
> CONFIG_POSIX_TIMERS is disabled:
> 
> In file included from /git/arm-soc/kernel/time/posix-stubs.c:9:
> /git/arm-soc/kernel/time/posix-stubs.c:35:37: error: conflicting types
> for 'sys_timer_create'
>    35 | #define SYS_NI(name)  SYSCALL_ALIAS(sys_##name, sys_ni_posix_timers)
>       |                                     ^~~~
> /git/arm-soc/include/linux/linkage.h:26:63: note: in definition of
> macro 'SYSCALL_ALIAS'
>    26 | #define SYSCALL_ALIAS(alias, name) __alias(name) typeof(name) alias
>       |                                                               ^~~~~
> /git/arm-soc/kernel/time/posix-stubs.c:42:1: note: in expansion of
> macro 'SYS_NI'
>    42 | SYS_NI(timer_create);
>       | ^~~~~~
> In file included from /git/arm-soc/kernel/time/posix-stubs.c:13:
> /git/arm-soc/include/linux/syscalls.h:616:17: note: previous
> declaration of 'sys_timer_create' was here
>   616 | asmlinkage long sys_timer_create(clockid_t which_clock,
>       |                 ^~~~~~~~~~~~~~~~
> 
> We can probably move those SYS_NI() instances to kernel/sys_ni.c,
> which does not include the header, but it's still a bit ugly. I'll try
> that tomorrow
> unless you come up with a better suggestion first.

Oh I guess arm32 doesn't have SYS_NI defined.  All this syscall aliasing
stuff is a total mystery to me.

-- 
Josh

