Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D3A279B34
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgIZRO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIZRO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:14:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BACC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:14:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c25001c55400185a26885.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:2500:1c55:4001:85a2:6885])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB5C31EC03EA;
        Sat, 26 Sep 2020 19:14:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601140493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FRmt1ZU323p3kg9TO7fbBge69StpQX8q8Foc3zlvE2s=;
        b=aIHN0152CmLZsWu2iozBNysrRKNTdF6YDMpRt6q0ui+4bF8LTMKwskGMQ7ViSwQmkMqAtv
        MVXcqTc89G6OUmKeRdTFIETBv5kXpcYhluoSww+A7/JzJlG2vvhygmTTYdZw8gRLgEXf34
        0bFMOAwS5Uob0+Nm6gwewS6r+A26kVg=
Date:   Sat, 26 Sep 2020 19:14:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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
Message-ID: <20200926171451.GB22089@zn.tnic>
References: <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic>
 <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic>
 <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic>
 <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
 <CACT4Y+bjyAfO-TRjBHT9wR194=prH2C284Oc9akVVHR1492WZA@mail.gmail.com>
 <CAKwvOdkYEP=oRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkYEP=oRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 05:32:14PM -0700, Nick Desaulniers wrote:
> Boris, one question I have. Doesn't the kernel mark pages backing
> executable code as read only at some point?

Yes, I added some debug output:

[  562.959995][    T1] Freeing unused kernel image (initmem) memory: 2548K
[  563.672645][    T1] Write protecting the kernel read-only data: 137216k [0xffffffff81000000:0xffffffff89600000]

and perf_misc_flags() is well within that range:

ffffffff810118e0 <perf_misc_flags>:

[  566.076923][    T1] unused kernel image (text/rodata gap): [0xffffffff88608000:0xffffffff88800000]
[  567.039076][    T1] unused kernel image (rodata/data gap): [0xffffffff8941d000:0xffffffff89600000]
[  568.205550][    T1] Freeing unused kernel image (text/rodata gap) memory: 2016K
[  569.277742][    T1] Freeing unused kernel image (rodata/data gap) memory: 1932K

We also have this debug option which I enabled:

[  570.598533][    T1] x86/mm: Checked W+X mappings: passed, no W+X pages found.

so that looks ok too.

> If that were the case, then I don't see how the instruction stream
> could be modified. I guess static key patching would have to undo that
> permission mapping before patching.

Yap, and I still have no clue about the mechanism which would lead to
this corruption.

> You're right about the length shorter than what I would have expected
> from static key patching.  That could very well be a write through
> dangling int pointer...

Right.

Lemme try to setup one of my test boxes to run syzkaller and see how far
I can get. But don't hold your breath...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
