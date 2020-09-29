Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130EF27CFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgI2Nth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730283AbgI2Nth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:49:37 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE5AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:49:36 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id t76so5494774oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf55h5Im87Thv0CvH7P0y872ufq4n52JjgwdZSbMlsE=;
        b=YWvZewRv9EPKGFMnrlX58gFAN4LNRwvpGbFM90qagfwzOhq0xOTQNlNS+0+/UZRUXl
         Q7O5w9O42x2fVh6uUAi4MXMRUBrKtvPQ47jSBSlQYgk1VuwO5B/SEVy9ORLiy61AlAHw
         +UzixFrJbSnGdRS8QXuZuySULzOKUs/8R3kIgIbvZ7ebPA5UfZeQv1RFr0FfPnXMg0bL
         bHxh0w1kGfiqwbe9bqgEIcuhrl3d1BBCkFUWfqeddsGe8Bze8qiCFcdUboFW+w1ha7Ek
         Y7rSAQOzrp/Pjaj+giqaZMqJIQ8LErSJVTTUhTPFN5cmDq27q8qtmhYOLdO+wydX+nS0
         zYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf55h5Im87Thv0CvH7P0y872ufq4n52JjgwdZSbMlsE=;
        b=DPyDAVg3lwM/4Wbf320a/fnKf5m9pRJYEstCAA65rN2yD6g9fNC5Rony8jXaRMSqRb
         thjr4bIXEPvlGgquQij5znLA0baNdLjigBEAPy9IdZUo5rwu2spG1JVxBV7yQvvmtB6W
         b6FJxwS6hOKOk2XkR1U0QdPeV7daKrNFlXGZ1opN3VIoI4dggsVJaXIsk9MKQEeo02YL
         MDAhUs909Qf87lp/X5WA5KvoEvUrwX4v14Bt5uuxjZKbdqLysnW1xjETEpmtXkPayhMH
         Y4geFetTZLK8G2R08cwY/0rmlBj2iGR098iQPSxkQ4yImpJO0dBqTBCUVLvuJzfgdLxu
         EM5w==
X-Gm-Message-State: AOAM531zPTw+WYKvatWxxjlwWXDmPjfcnGiLzh53wS4szsK3RpmLwR3f
        lL/EEjFaltUIUV5QVU/r4mrlHe2BEfWv9dyh5zO9yg==
X-Google-Smtp-Source: ABdhPJxiJi8hWBBZVcllFLyB/VLfKmBGpjW01B6eYyc4+D70if0keiWc+WE0jU5wtu+kUc8X4oTDsf54W+9c0iy9kFM=
X-Received: by 2002:aca:5158:: with SMTP id f85mr2718140oib.121.1601387375957;
 Tue, 29 Sep 2020 06:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200921132611.1700350-1-elver@google.com> <20200921132611.1700350-2-elver@google.com>
 <CAAeHK+zYP6xhAEcv75zdSt03V2wAOTed6vNBYReV_U7EsRmUBw@mail.gmail.com>
 <20200929131135.GA2822082@elver.google.com> <CAAeHK+y0aPAZ8zheD5vWFDR-9YCTR251i0F1pZ9QfXuiaW0r8w@mail.gmail.com>
In-Reply-To: <CAAeHK+y0aPAZ8zheD5vWFDR-9YCTR251i0F1pZ9QfXuiaW0r8w@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Sep 2020 15:49:24 +0200
Message-ID: <CANpmjNOFpFkrSMFezcBFJODwBK5vRi8sSEzS3AvyFu3Y0ZqgVA@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        SeongJae Park <sjpark@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 at 15:48, Andrey Konovalov <andreyknvl@google.com> wrote:
> On Tue, Sep 29, 2020 at 3:11 PM Marco Elver <elver@google.com> wrote:
> >
> > On Tue, Sep 29, 2020 at 02:42PM +0200, Andrey Konovalov wrote:
> > [...]
> > > > +        */
> > > > +       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> > >
> > > Why do we subtract 1 here? We do have the metadata entry reserved for something?
> >
> > Above the declaration of __kfence_pool it says:
> >
> >         * We allocate an even number of pages, as it simplifies calculations to map
> >         * address to metadata indices; effectively, the very first page serves as an
> >         * extended guard page, but otherwise has no special purpose.
> >
> > Hopefully that clarifies the `- 1` here.
>
> So there are two guard pages at the beginning and only then a page
> that holds an object?

Yes, correct.
