Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AFC2851B2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 20:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgJFSiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgJFSiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:38:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DA5C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 11:38:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce10so19116311ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 11:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iiFZhuwHNBTR9+4Q7mOK5ZAfJhgSvj1um5FsudlQqFU=;
        b=PM0JMNHPiD6wmU2ArxvuwJ2NKPRtEQlVKHA276QyadNFqaMC+5g4jmPjNKlBwa83lk
         KMrg1mI1j/QkHGefhK1gI+ESdACDTe3iR9kYZQrCPSGlv2WcAAciQultmozXlq9o8P7n
         OzFWfxJPVfi73YPtx4jDIKUZYiqLExKGK45yBtr9Ed9U6rDQzCyxD37PVNCGIQ9p4mxt
         0VJfoDcon+b/gOPiEX06CZJpoZrT2164DEu2j2GLCEfF3t4IFdB9MPh3QP7o12hUq68R
         K1syuLf2mpvfTcraEsjAGe15fUQn+pdBuvT0W5IG9/qT2hQPTKLCLCFy//thqB8KRanz
         J6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iiFZhuwHNBTR9+4Q7mOK5ZAfJhgSvj1um5FsudlQqFU=;
        b=m/ikf5H8NsgKR4YASDUWxhXIbhac6DoAI5HAgj6JnhQC88+NfQYyrMqTw0DDtGfzje
         CQLCxZmoy6gNbkyd2Pdbm5Ibfkz/nQHU2bS/dqGMqJYlb7+u2BItdGQXW5rPiUXiq4bE
         u/Se+pkIiOzQYcgEzjU79dBg4w5VCB25NilN+V09Kb7Lpm/GaqjSCvwEihFFWk1WQgi3
         VuAipuOcJzdlqRahCqJV1IdRVaNj2Iyb9NlQjDr0bb7RPIs5HceYJg4I4GcQt3v4DGnf
         o3imGwJ9/bR/aLcPgAAveRp4C3rx/tn/vRRlIKAObwChrthQWKtE7Xh1GhskLPAI6DU/
         dbpw==
X-Gm-Message-State: AOAM530t4O66/k4zMUJSWp72Q+KIUDt8SdFEw8lLDpJHAGj3TbggD7Zy
        ju3bC2izu9mHtBFqSFY3OzHtbE7EsfZHe0cP1NFVbQ==
X-Google-Smtp-Source: ABdhPJwIor6UpBlGj2PuTDA18/0MI0H/2wNMCyrRIxHFGEdipoCiKU3u0FaVJ0EJpvaRPXT5N/b5LLBabc5Ly2lWG94=
X-Received: by 2002:a17:906:9156:: with SMTP id y22mr981885ejw.184.1602009482216;
 Tue, 06 Oct 2020 11:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200929183513.380760-1-alex.popov@linux.com> <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com> <1b5cf312-f7bb-87ce-6658-5ca741c2e790@linux.com>
In-Reply-To: <1b5cf312-f7bb-87ce-6658-5ca741c2e790@linux.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 6 Oct 2020 20:37:35 +0200
Message-ID: <CAG48ez17s4NyH6r_Xjsx+Of7hsu6Nwp3Kwi+NjgP=3CY4_DHTA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] Break heap spraying needed for exploiting use-after-free
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Machek <pavel@denx.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 7:56 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 06.10.2020 01:56, Jann Horn wrote:
> > On Thu, Oct 1, 2020 at 9:43 PM Alexander Popov <alex.popov@linux.com> wrote:
> >> On 29.09.2020 21:35, Alexander Popov wrote:
> >>> This is the second version of the heap quarantine prototype for the Linux
> >>> kernel. I performed a deeper evaluation of its security properties and
> >>> developed new features like quarantine randomization and integration with
> >>> init_on_free. That is fun! See below for more details.
> >>>
> >>>
> >>> Rationale
> >>> =========
> >>>
> >>> Use-after-free vulnerabilities in the Linux kernel are very popular for
> >>> exploitation. There are many examples, some of them:
> >>>  https://googleprojectzero.blogspot.com/2018/09/a-cache-invalidation-bug-in-linux.html
>
> Hello Jann, thanks for your reply.
>
> > I don't think your proposed mitigation would work with much
> > reliability against this bug; the attacker has full control over the
> > timing of the original use and the following use, so an attacker
> > should be able to trigger the kmem_cache_free(), then spam enough new
> > VMAs and delete them to flush out the quarantine, and then do heap
> > spraying as normal, or something like that.
>
> The randomized quarantine will release the vulnerable object at an unpredictable
> moment (patch 4/6).
>
> So I think the control over the time of the use-after-free access doesn't help
> attackers, if they don't have an "infinite spray" -- unlimited ability to store
> controlled data in the kernelspace objects of the needed size without freeing them.
>
> "Unlimited", because the quarantine size is 1/32 of whole memory.
> "Without freeing", because freed objects are erased by init_on_free before going
> to randomized heap quarantine (patch 3/6).
>
> Would you agree?

But you have a single quarantine (per CPU) for all objects, right? So
for a UAF on slab A, the attacker can just spam allocations and
deallocations on slab B to almost deterministically flush everything
in slab A back to the SLUB freelists?

> > Also, note that here, if the reallocation fails, the kernel still
> > wouldn't crash because the dangling object is not accessed further if
> > the address range stored in it doesn't match the fault address. So an
> > attacker could potentially try multiple times, and if the object
> > happens to be on the quarantine the first time, that wouldn't really
> > be a showstopper, you'd just try again.
>
> Freed objects are filled by zero before going to quarantine (patch 3/6).
> Would it cause a null pointer dereference on unsuccessful try?

Not as far as I can tell.

[...]
> >> N.B. There was NO performance optimization made for this version of the heap
> >> quarantine prototype. The main effort was put into researching its security
> >> properties (hope for your feedback). Performance optimization will be done in
> >> further steps, if we see that my work is worth doing.
> >
> > But you are pretty much inherently limited in terms of performance by
> > the effect the quarantine has on the data cache, right?
>
> Yes.
> However, the quarantine parameters can be adjusted.
>
> > It seems to me like, if you want to make UAF exploitation harder at
> > the heap allocator layer, you could do somewhat more effective things
> > with a probably much smaller performance budget. Things like
> > preventing the reallocation of virtual kernel addresses with different
> > types, such that an attacker can only replace a UAF object with
> > another object of the same type. (That is not an idea I like very much
> > either, but I would like it more than this proposal.) (E.g. some
> > browsers implement things along those lines, I believe.)
>
> That's interesting, thank you.

Just as some more context of how I think about this:

Preventing memory corruption, outside of stuff like core memory
management code, isn't really all *that* hard. There are schemes out
there for hardware that reliably protects the integrity of data
pointers, and such things. And if people can do that in hardware, we
can also emulate that, and we'll get the same protection in software.

The hard part is making it reasonably fast. And if you are willing to
accept the kind of performance impact that comes with gigantic
quarantine queues, there might be more effective things to spend that
performance on?
