Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D925ACF7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 16:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 10:25:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:33580 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgIBOQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:16:37 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 082EEWYN031070;
        Wed, 2 Sep 2020 09:14:32 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 082EEVOd031069;
        Wed, 2 Sep 2020 09:14:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 2 Sep 2020 09:14:31 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/2] powerpc/vdso32: link vdso64 with linker
Message-ID: <20200902141431.GV28786@gate.crashing.org>
References: <20200901222523.1941988-1-ndesaulniers@google.com> <20200901222523.1941988-3-ndesaulniers@google.com> <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2066ccd-2b81-6032-08e3-41105b400f75@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Sep 02, 2020 at 06:46:45AM +0000, Christophe Leroy wrote:
> ld crashes:
> 
>   LD      arch/powerpc/kernel/vdso32/vdso32.so.dbg
> /bin/sh: line 1: 23780 Segmentation fault      (core dumped) 
> ppc-linux-ld -EB -m elf32ppc -shared -soname linux-vdso32.so.1 
> --eh-frame-hdr --orphan-handling=warn -T 
> arch/powerpc/kernel/vdso32/vdso32.lds 
> arch/powerpc/kernel/vdso32/sigtramp.o 
> arch/powerpc/kernel/vdso32/gettimeofday.o 
> arch/powerpc/kernel/vdso32/datapage.o 
> arch/powerpc/kernel/vdso32/cacheflush.o 
> arch/powerpc/kernel/vdso32/note.o arch/powerpc/kernel/vdso32/getcpu.o -o 
> arch/powerpc/kernel/vdso32/vdso32.so.dbg
> make[4]: *** [arch/powerpc/kernel/vdso32/vdso32.so.dbg] Error 139
> 
> 
> [root@localhost linux-powerpc]# ppc-linux-ld --version
> GNU ld (GNU Binutils) 2.26.20160125

[ Don't build as root :-P ]

Try with a newer ld?  If it still happens with current versions, please
open a bug report?  https://sourceware.org/bugzilla


Segher
