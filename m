Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF1274920
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgIVT3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVT3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:29:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A961C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:29:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bfb005490ac4baf047eb3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:fb00:5490:ac4b:af04:7eb3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E092F1EC027B;
        Tue, 22 Sep 2020 21:29:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600802980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sDjTaVZjD8FQHQZVC8YDJ3mI9VAs4nKAd6yLsx8Kys8=;
        b=PAFHpidZh1yphKJvfNEppX9a3i+JVEaxj9Xt/2aL5OkxJiO7BfMpPyalb42reysHGYWqE/
        rT8F33OGplrqR6vbFD8qsT57qZ2dQc1WFvPiYcRhiSq/0eGk/+6lYfIc0gL3jkgSdOTiWo
        HjYp9csTslN9WvwSps4W1jGGZXxidjU=
Date:   Tue, 22 Sep 2020 21:29:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <20200922192934.GR22660@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic>
 <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:56:04AM -0700, Nick Desaulniers wrote:
> > Gnight and good luck.
> 
> Ah, that's a famous quote from journalist Edward R Murrow, who helped
> defeat Senator Joseph McCarthy (Murrow's show See It Now dedicated a
> segment to addressing McCarthy).

Good. Finally someone has recognized this - I use it from time to time
in mails but no one would pick up on it!

And how relevant it is again...

https://www.youtube.com/watch?v=vEvEmkMNYHY

> Sometimes I fund uncanny parallels between claims of what a compiler
> can do on LKML "without proper regard for evidence" and McCarthyism.
> Falsifiability is an interesting trait. That's why I try to advocate
> for sharing links from godbolt.org as much as possible.

LOL. Good one. :-)

I'll take a look at the rest of your reply tomorrow because brain is
fried for today.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
