Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AC52E7C55
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 21:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgL3Uuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 15:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgL3Uuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 15:50:46 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFBC061573
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 12:50:05 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so40289101lfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 12:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYyBNOChZHFpWKfBYLYVXjNCnPPzTBTHh9Nhg4dLnRo=;
        b=brOF6w0wbtsTPxir9UuZGXoSVO0cCL53QzEAXPMxRQBcco3tQEs5K6gQHHDnpDmhW9
         SQWanN3dMykzD9eP3Vu4Sa9T1D5nyCCcty8mOg4yE1HgMplwdOilYrX6MIP2Km98/fKd
         FkRNXc/8UFgyJWY7zFCbG0PrZHDI/bdMOhXnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYyBNOChZHFpWKfBYLYVXjNCnPPzTBTHh9Nhg4dLnRo=;
        b=kV0+YSNKpA42HgNI0k6YtwN+5YnfdghtNe7iJCQJExG56+4nY4xaOV5pfNAfjBuLZ4
         NE8xWYHcHIcsjL4IUxUUEf0eomf+5EPOmxrnLnsH1VXrBOHLXBziEVwmY8NtMvLzrRsF
         5spRoaBTomBl9dFyoCTO+HYNe1YlPYJmEPY9z4I/YKyCLtYVY79mzQupT9XDKSs7x6ZK
         Id8c/kRhDNsWmF8dSk0z2VXa9ocGXBPy0PIufQIs+SnI70rEqIYK8/eV4k+ylbE5tWOV
         OeL7TDlDPlZPqRbab2/sOojRXaYD5E1Wp6dc95iJZDB3tto8tv2d0gCWDTZiF91Juga6
         0YuQ==
X-Gm-Message-State: AOAM532wZLbb6fH1gNJD2S23VVUEnwxAMfsZszzNfOgpEzGjGsixo1Jm
        nXXZ2eau4Qmy5kym1PkW0cf0RCm8B1eZ/g==
X-Google-Smtp-Source: ABdhPJz+dTW3o5nKLTRXHnFRASjhIqXWoNglUQ5mlBoB0B0A5ZXGCPtSNvOdCWCO0eNQQHZ7Yi6HwQ==
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr25565556ljj.438.1609361403578;
        Wed, 30 Dec 2020 12:50:03 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id h1sm5574745lfc.121.2020.12.30.12.50.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 12:50:02 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 23so40151048lfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 12:50:01 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr22220738lfr.487.1609361401650;
 Wed, 30 Dec 2020 12:50:01 -0800 (PST)
MIME-Version: 1.0
References: <20201230031436.GB22185@xsang-OptiPlex-9020>
In-Reply-To: <20201230031436.GB22185@xsang-OptiPlex-9020>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Dec 2020 12:49:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGVoa0jzo5CmtHHmAD44qX+aaa6GOEATiABPKh3Lh5Xg@mail.gmail.com>
Message-ID: <CAHk-=wgGVoa0jzo5CmtHHmAD44qX+aaa6GOEATiABPKh3Lh5Xg@mail.gmail.com>
Subject: Re: [kasan] 97593cad00: RIP:kasan_record_aux_stack
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 6:59 PM kernel test robot <oliver.sang@intel.com> wrote:
>
> [  235.553325] BUG: sleeping function called from invalid context at arch/x86/mm/fault.c:1351
> [  235.554684] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 7515, name: trinity-c1
> [  235.555890] 2 locks held by trinity-c1/7515:
> [  235.556506]  #0: ffffffff8323dd38 (&ids->rwsem){....}-{3:3}, at: semctl_down+0x6d/0x686
> [  235.557684]  #1: ffff888128ccc868 (&mm->mmap_lock#2){....}-{3:3}, at: do_user_addr_fault+0x196/0x59e
> [  235.559020] CPU: 1 PID: 7515 Comm: trinity-c1 Not tainted 5.10.0-g97593cad003c #2
> [  235.560317] Call Trace:
> [  235.560767]  dump_stack+0x7d/0xa3
> [  235.561371]  ___might_sleep+0x2c4/0x2df
> [  235.562063]  ? do_user_addr_fault+0x196/0x59e
> [  235.562834]  do_user_addr_fault+0x234/0x59e
> [  235.563519]  exc_page_fault+0x70/0x8b
> [  235.564112]  asm_exc_page_fault+0x1b/0x20

Btw, I wonder if the kernel test robot dumps could be please run through the

 scripts/decode_stacktrace.sh

script to give line numbers and inlining information?

That does require CONFIG_DEBUG_INFO to work, but it would help things
like this when you don't have to try to guess where the exact access
happens.

Now, in this case, it seems to be a recursive issue with the original
fault happening in:

> [  235.564754] RIP: 0010:kasan_record_aux_stack+0x64/0x74

And yeah, that explains why it then bisects to 97593cad003c ("kasan:
sanitize objects when metadata doesn't fit")

The faulting instruction sequence decodes to

  10:   48 39 f3                cmp    %rsi,%rbx
  13:   48 0f 46 f3             cmovbe %rbx,%rsi
  17:   e8 6f e5 ff ff          callq  .. something ..
  1c:   bf 00 08 00 00          mov    $0x800,%edi
  21:   48 89 c3                mov    %rax,%rbx
  24:*  8b 40 08                mov    0x8(%rax),%eax           <--
trapping instruction
  27:   89 43 0c                mov    %eax,0xc(%rbx)

and I *think* that "call something" is the call to
kasan_get_alloc_meta. And there is no check for a NULL return.

So I think this was already fixed by commit 13384f6125ad ("kasan: fix
null pointer dereference in kasan_record_aux_stack").

But see about that "decode_stacktrace,sh" script request. I thought I
had already asked for this, but I now realize that I think that was
just for syzbot.

Can we do that for these kernel test robot reports too? Please?

             Linus
