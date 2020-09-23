Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B02275670
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgIWKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:34:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59630 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726332AbgIWKef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:34:35 -0400
Received: from zn.tnic (p200300ec2f0d1300e5068c8a3292d31d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:1300:e506:8c8a:3292:d31d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B67AE1EC0409;
        Wed, 23 Sep 2020 12:34:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600857273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FZsrac/HmInXoXIXxRGxQJzsoj2KcH5XhZgh7SJHhMg=;
        b=FC1HJZM5zluJYAblwWMILTtAWbJarN/DVYpUvGXnhxCpMkNmE+o84Df1/dAjtgzJJILLfQ
        QVm6ycc1b3BM9WAQc9n6/xGnwiIM9efk6Y2W2XvyarhYw25/ti6xrYaX32Ok25RVy/0daL
        csbcbDCyozkIPUz0gzZXr+euC2nY3vw=
Date:   Wed, 23 Sep 2020 12:34:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
Message-ID: <20200923103431.GF28545@zn.tnic>
References: <00000000000052569205afa67426@google.com>
 <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic>
 <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic>
 <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:24:48AM +0200, Dmitry Vyukov wrote:
> 3. Run syzkaller locally with custom patches.

Let's say I wanna build the kernel with clang-10 using your .config and
run it in a vm locally. What are the steps in order to reproduce the
same workload syzkaller runs in the guest on the GCE so that I can at
least try get as close as possible to reproducing locally?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
