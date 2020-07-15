Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3F32205C2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgGOHDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 03:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgGOHDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:03:41 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2CC1206D5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594796620;
        bh=UV+mfmRMd26ihN4f6dfSbARDNHCQ/VULlcsE3EswSis=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Bp9puQ99xjQsIFW2RGiZArn9zcGqk0Qn2UcT8PY+p/J4gx5zGYtZ5AVYRPctgATP7
         +mnpkBycW4tyfm0sz4G3iE3EyKBScQZU0wdU1oIgtwrSTfW/yhxyOHDqqqP/2pqtV0
         i3k3705ABUay05mNS1Pzok/Gs//E8y3iARcgCV3I=
Received: by mail-oo1-f46.google.com with SMTP id z23so262984ood.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:03:40 -0700 (PDT)
X-Gm-Message-State: AOAM533Ck6Gj/6oX9fvra2gzTkIR/yTspW5byoFBxcoIZ9YgT1ZMxt/p
        vxMKujp5mZ6OeBGZnWzmOdCYzJgi06X7HZZv5UE=
X-Google-Smtp-Source: ABdhPJzsk7y5jNKbbqb9/qIyssy3ypE5WzXrK288d/NhirZLciBaPNTqE55KH+YOg1RriUSg091UjMQXHFeQrwV9H0E=
X-Received: by 2002:a4a:b34b:: with SMTP id n11mr8087596ooo.41.1594796619297;
 Wed, 15 Jul 2020 00:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200711035544.2832154-1-palmer@dabbelt.com> <20200711035544.2832154-2-palmer@dabbelt.com>
 <20200713130632.GA29945@infradead.org>
In-Reply-To: <20200713130632.GA29945@infradead.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 15 Jul 2020 10:03:27 +0300
X-Gmail-Original-Message-ID: <CAMj1kXEH2_=tx7jNNZO7T3JHuq2+AdoNuWUmUZBvGN4CUHm+6Q@mail.gmail.com>
Message-ID: <CAMj1kXEH2_=tx7jNNZO7T3JHuq2+AdoNuWUmUZBvGN4CUHm+6Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] lib: Add a generic copy_oldmem_page()
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, mick@ics.forth.gr,
        Mark Rutland <mark.rutland@arm.com>, gregory.0xf0@gmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        takahiro.akashi@linaro.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <linux@armlinux.org.uk>, willy@infradead.org,
        Mike Rapoport <rppt@linux.ibm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        Petr Mladek <pmladek@suse.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Gow <davidgow@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 at 16:06, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Jul 10, 2020 at 08:55:42PM -0700, Palmer Dabbelt wrote:
> > +ssize_t copy_oldmem_page(unsigned long pfn, char *buf,
> > +                      size_t csize, unsigned long offset,
> > +                      int userbuf)
> > +{
> > +     void *vaddr;
> > +
> > +     if (!csize)
> > +             return 0;
> > +
> > +     vaddr = memremap(__pfn_to_phys(pfn), PAGE_SIZE, MEMREMAP_WB);
> > +     if (!vaddr)
> > +             return -ENOMEM;
>
> Doing a memremap for every page is very inefficient.

memremap(MEMREMAP_WB) will reuse the existing linear address if the PA
is covered by the linear mapping.

> Also I don't see
> why you'd want to even do that.  All memory is in the direct mapping
> for RISC-V.  For other architecture that support highmem kmap_atomic_pfn
> would do the job, which is what I'd use in a generic version.
