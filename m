Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3564284385
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgJFAt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:49:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82362C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:49:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g4so11556990edk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSqKb3Tej8m7nFeWjbSYdo/k6NG+xT3qX97daJHfAaE=;
        b=deEOQpGoKw7XNYSPULzK/Fx+6FgNXN/khjYZmJenTlrPkh3dV8pR9GRMbNMshg3WBV
         mIhmaC0prowNnpBBfAOgciFl8Aodl0rSQD0jjxo98zbVcb/lVK/w4xzZ8RH7ut5R65D4
         8in1ydpN21OQa+pm2/egla8YAjlb0ivT9qFVlicuCHeu1OSW7e91KAVeVD8rfu51aRDF
         qMQv329ZsWOgNyP21r8aTq6vFJInOWaztNfk0KHDhN4hKlc+rb6zcKrDeoSYKitO8zvC
         oTJCmeqSuf2Nyq1UbdDB7JdyBRZqPMuxwo7izVmribdAB7jmHG8WWxh41wYQuF3rNl4g
         AM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSqKb3Tej8m7nFeWjbSYdo/k6NG+xT3qX97daJHfAaE=;
        b=fHDJUrx432oux2k2hEh4eo/rxtaO15UzEPO29TOuszoz90vrwySu9GMMkzaCUCpxtk
         z8fP0vTHLeSAYOAnVVZCvrlDBKqCwNGyfXX1xEKcSqBmyraCY9pLHSPBvNAo023kcu2e
         4PkioVOlaZATB8ySsdEIQcbeVDfLGviy9MwJmcqDWjyOs5wYGh1lbctoUXpUy7BvG518
         1dB1nFc3CnFOH+fXUB6p8Emq/TZZL5x6hDnpTrJHfrkbi3WOXDW0CN1u1ZS/1Zc/8hZd
         RcaSsPwY1NavwCl/ntbd3WK52EdEcMSp1Oz8Hl9Bk53DWpXJrrbfQyIMWkLD0vZ3Pyge
         /8sg==
X-Gm-Message-State: AOAM530wf49kUxsFH64xBR7ZAxICfal2p1K4x5go1X6LxW7B9Wpm+iUU
        2cODR6NfAlGoOO/eKh0QtgMxPChKsu9c0F3nqUWtsA==
X-Google-Smtp-Source: ABdhPJzX5TIoNNDa3K+sA4F6j+CIm71wUpd29DPTJfqfilZUUFmdG5N8+VeVzCx8F4tg0u5dyUACMyV8sE4qgDYzfPY=
X-Received: by 2002:a50:fe98:: with SMTP id d24mr2504183edt.223.1601945366080;
 Mon, 05 Oct 2020 17:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200929183513.380760-1-alex.popov@linux.com> <91d564a6-9000-b4c5-15fd-8774b06f5ab0@linux.com>
 <CAG48ez1tNU_7n8qtnxTYZ5qt-upJ81Fcb0P2rZe38ARK=iyBkA@mail.gmail.com> <20201006004414.GP20115@casper.infradead.org>
In-Reply-To: <20201006004414.GP20115@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 6 Oct 2020 02:48:59 +0200
Message-ID: <CAG48ez3VKw=B14r-BeAOxGtPExc-G4FYNymRPgFKUKUMsn5Osw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 0/6] Break heap spraying needed for exploiting use-after-free
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Will Deacon <will@kernel.org>,
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

On Tue, Oct 6, 2020 at 2:44 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Tue, Oct 06, 2020 at 12:56:33AM +0200, Jann Horn wrote:
> > It seems to me like, if you want to make UAF exploitation harder at
> > the heap allocator layer, you could do somewhat more effective things
> > with a probably much smaller performance budget. Things like
> > preventing the reallocation of virtual kernel addresses with different
> > types, such that an attacker can only replace a UAF object with
> > another object of the same type. (That is not an idea I like very much
> > either, but I would like it more than this proposal.) (E.g. some
> > browsers implement things along those lines, I believe.)
>
> The slab allocator already has that functionality.  We call it
> TYPESAFE_BY_RCU, but if forcing that on by default would enhance security
> by a measurable amount, it wouldn't be a terribly hard sell ...

TYPESAFE_BY_RCU just forces an RCU grace period before the
reallocation; I'm thinking of something more drastic, like completely
refusing to give back the memory, or using vmalloc for slabs where
that's safe (reusing physical but not virtual addresses across types).
And, to make it more effective, something like a compiler plugin to
isolate kmalloc(sizeof(<type>)) allocations by type beyond just size
classes.
