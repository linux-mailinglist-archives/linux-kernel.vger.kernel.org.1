Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580A8273584
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 00:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgIUWNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 18:13:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57050 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgIUWNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 18:13:49 -0400
Received: from zn.tnic (p200300ec2f07e300e2ed6c50343c7f1c.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:e300:e2ed:6c50:343c:7f1c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71B581EC03CE;
        Tue, 22 Sep 2020 00:13:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600726428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=u/ai9rsZw+bNAm914PoiDjMDRau8nkOxqRVQQam3P/4=;
        b=hhIFa+HwsHiJYClqiBVdi1Zs+j17VmkRx6ejhUnKosSKTVoLLpf0rw0S4uyBCMjAhRbnj9
        e5K6QyaYlpxrn8s35hw1AOs/SQinkNiLfRLilJPLjoyC2LkNhxbZIEZqV3N1ykF272FFwL
        zFn5B1wFdrMMQG3o7PBLxpKP7aUVt7c=
Date:   Tue, 22 Sep 2020 00:13:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: general protection fault in perf_misc_flags
Message-ID: <20200921221336.GN5901@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 01:59:43PM -0700, Nick Desaulniers wrote:
> Right, the two sequences above look almost the same, except those 4
> bytes of zeros (the disassembler gets confused about the rest, but
> it's the same byte sequence otherwise).  Are the two disassemblies a
> comparison of the code at runtime vs. compile-time? 

Yes.

> If so, how did you disassemble the runtime code?

./scripts/decodecode < /tmp/splat

where /tmp/splat contains the line starting with "Code:". Make sure you
have only one "Code:"-line, otherwise you'll see the code of the *last*
Code: line only.

> If runtime and compile time differ, I suspect some kind of runtime
> patching.

If it is, it ain't patching at the right place. :)

But no, that function is pretty simple and looking at its asm, there's
no asm goto() or alternatives in there. But that .config might add them.
It adds a lot of calls to *ASAN helpers and whatnot.

> I wonder if we calculated the address of a static_key wrong
> (asm goto). What function am I looking at the disassembly of?
> perf_misc_flags() in arch/x86/events/core.c?

Yes.

> With this config?
> https://syzkaller.appspot.com/x/.config?x=cd992d74d6c7e62 (though I
> don't see _any_ asm goto in the IR for this file built with this
> config).

Right, there should be none.

> If this is deterministically reproducible, I suppose we
> could set a watchpoint on the address being overwritten?

Sounds like worth a try. I'll go sleep instead, tho. :)

Gnight and good luck.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
