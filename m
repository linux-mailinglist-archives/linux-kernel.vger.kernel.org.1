Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B242A0379
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgJ3K5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgJ3K5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:57:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D07C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:57:06 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x203so6205992oia.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x083AjvGF0zQfoi/Zp4lR99mcm5WG8qTkAtv8ezIp6w=;
        b=TfYtmrepxSGkTOhnz89oz6fSDep8VfjQbMpR6CczHyYU+W2W7jTUmEowCn4QD/hVvq
         dsWCZauyXVabXaqJnvVyWA0PwsX0aWqKTQ7ckuvxEREHo2CGKGVQcZRnxqxutoHya7za
         6QPSPDYJmVISC6QxiRn1TMZpWFIqSBWHAMQRqRPj+wTPNmDukvtu9Vp56kZSAIBKkGLo
         6Z5VieLX+zzEXrsM7nqfyZXoq6B6+/cUtEh46djyIf/4EhucCioVM3q8c00a0RdHT3AD
         RcDiuqZCdNgmt5y+jqSaBseAoLg3/PpF7r96838wOeOEM2oPoa0HChKzDMv6jrZVVaaS
         sfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x083AjvGF0zQfoi/Zp4lR99mcm5WG8qTkAtv8ezIp6w=;
        b=o5WoDIWHgZOhJoGcnuE7tO/NUX3dOTK5DgH5HjveO/ko5oStXyAWSd0Ftq5p2PIM2r
         B50sLTbSZ/hR2bkeTb+C9qENTnN/fcx4MQ9j9vjAS3Wd/WV+E30wnvXlh0UuZcEbWdZH
         g+vRKXLDDyKi2z7w7G8HNug1Z02IUXT1+yKrs4+krvyPj1L65POI+wF0ZhTNuFpzxzNR
         r9mfdsiITLEFxr7i8+bYk5ysMZWGPx9/9HM2xdx9M1m+9p405DZ8rTuKl8wAdQ18p+su
         xJwzB5LaHysyQxjUjj6eW+NWNNyiXpNJQ/Rim3EAM7RbyoUo/NttVGoPbjz4PbFETkhz
         9aVA==
X-Gm-Message-State: AOAM532TmXAsvaXcjVyJPYRfA2RL30UFI7wCq0Xt8Xduddn4Hw00rTPJ
        TqdzO7ddsRHs+vPNvdTdUpf3QTrYQHO3lCSZ1RmcZw==
X-Google-Smtp-Source: ABdhPJz3C4ZPru/opHgaUXloKSf0xyz52fj93A1p3T9rYcAFfZuZf7nAa+ojQJj0KzgJdsGQpQt03lRixeBInl+1H40=
X-Received: by 2002:aca:4f55:: with SMTP id d82mr1153951oib.172.1604055425438;
 Fri, 30 Oct 2020 03:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <20201029131649.182037-1-elver@google.com> <CAG48ez1xg0uRV6LqYOO-ibVqOO7jNRJGLVLrQfGW=s8TcbPGoQ@mail.gmail.com>
In-Reply-To: <CAG48ez1xg0uRV6LqYOO-ibVqOO7jNRJGLVLrQfGW=s8TcbPGoQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 30 Oct 2020 11:56:53 +0100
Message-ID: <CANpmjNOx=6ZRUC-Gkx=RqX4EPtuLe=AMshGSMcnd6a3=2iNtkQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/9] KFENCE: A low-overhead sampling-based memory
 safety error detector
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
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
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        =?UTF-8?Q?J=C3=B6rn_Engel?= <joern@purestorage.com>,
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
        kernel list <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 at 03:49, Jann Horn <jannh@google.com> wrote:
> On Thu, Oct 29, 2020 at 2:16 PM Marco Elver <elver@google.com> wrote:
> > This adds the Kernel Electric-Fence (KFENCE) infrastructure. KFENCE is a
> > low-overhead sampling-based memory safety error detector of heap
> > use-after-free, invalid-free, and out-of-bounds access errors.  This
> > series enables KFENCE for the x86 and arm64 architectures, and adds
> > KFENCE hooks to the SLAB and SLUB allocators.
>
> I think this is getting close to a good state, just a couple minor issues left.

Thanks for your comments. We'll address all of them for v7.

> Now that the magic "embed the memory pool in the BSS section" stuff is
> gone, this series looks fairly straightforward.

Good to hear. :-)

Thanks,
-- Marco
