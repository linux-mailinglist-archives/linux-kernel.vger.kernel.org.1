Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4209E2C2526
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbgKXMAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXMAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:00:43 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06D1C0613D6;
        Tue, 24 Nov 2020 04:00:41 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id u21so21617021iol.12;
        Tue, 24 Nov 2020 04:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pFQqpahw9l/rBq/5WPcCxd/Tz8vut/eGLY8uQxwZEKc=;
        b=PlrDiVIB/mj/X4OK1G1S1G02sy41oyRhiUn+fsH4CN6pmWvatSvSYpxYUQX1MC9N1c
         nhOV8k6/4+oQHNttb9dqLXVbA57fvjB+syUVsDtMaZgjcjKYWjy5j4anebLtyw7xZZc5
         EWwx3XIAaXFphf5fi9rVLmXR9S3Tu6tU7R3lNiIEZBY8IJ4lW7Hbwf5DTQfARhhztuKr
         FODb6T+t7JBq5/ERKrI2QVDYX4eQGseSohns6lfhKQy4G89v4q3ohKVi80+COvVuicVX
         SDQrYa45x/FyFwv00AfukXf8e3cuZuduTDqOuXJ0ZVEj82iRD14wAgUOwt1ftzP3OC5z
         LqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pFQqpahw9l/rBq/5WPcCxd/Tz8vut/eGLY8uQxwZEKc=;
        b=qpMetso5qwvb39nNNZP/vqWq6ACy1Z87dAfEsv5n5qXxFE3uIWmOkLupNgY7SUzXoa
         41M614f3WBw//tNpNRrGJ8roJY5G3t6/a4W+LlB/7QZ01hxNhXgGGUD+p3Uk4Nl2MTpY
         gBeTpEWQFpbRmNJFCs86PNhWGN8o1ExDJx/FtaTTCmBbNsCNuDh7mn3G+dEJVUXMiYVi
         eZTLyCPYatC5SntWCyLgnMlkalYGiBJvPEiWWquwueZT1XaGeI9DCW0Q2J+TGWsR3Rz8
         LpnubiqV7e0fFYEJ01abVT8rHBoHhAXA9rsf344ZubwEn3GDxwCuOBOi3+phWh552U4c
         Az9g==
X-Gm-Message-State: AOAM533MvPUbftUkn9hmQFJSZcdn4yWo5TV2m5jooSiP+2FyCmjH8Byj
        H1rJb1cJe3DIydenRjuauAPCQntYPIxBedGuvRA=
X-Google-Smtp-Source: ABdhPJxPepiMRuOiYdJgy6qTfsmXpz4u4CBALSh/3WHT0UFzgBDc/IiFLglOGujxF7OvvxbR95atYKgbEl5bZq9YA9U=
X-Received: by 2002:a05:6638:41a:: with SMTP id q26mr4087022jap.27.1606219241186;
 Tue, 24 Nov 2020 04:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20201124104030.903-1-lukas.bulwahn@gmail.com> <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
 <20201124115058.GA32060@infradead.org> <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
In-Reply-To: <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Nov 2020 13:00:30 +0100
Message-ID: <CAKXUXMxfPqn4hG-QCtQM1qrK7Vck2hHRycb5VZBYHf4-ezkiGA@mail.gmail.com>
Subject: Re: [PATCH] zlib: define get_unaligned16() only when used
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        kernel-janitors@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:56 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Nov 24, 2020 at 12:51 PM Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, Nov 24, 2020 at 12:08:40PM +0100, Jann Horn wrote:
> > > > Since commit acaab7335bd6 ("lib/zlib: remove outdated and incorrect
> > > > pre-increment optimization"), get_unaligned16() is only used when
> > > > !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> > > >
> > > > Hence, make CC=clang W=1 warns:
> > > >
> > > >   lib/zlib_inflate/inffast.c:20:1:
> > > >     warning: unused function 'get_unaligned16' [-Wunused-function]
> > > >
> > > > Define get_unaligned16() only when it is actually used.
> > > >
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > >
> > > AFAICS a nicer option would be to "#include <asm/unaligned.h>" and
> > > then use "get_unaligned", which should automatically do the right
> > > thing everywhere and remove the need for defining get_unaligned16()
> > > and checking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS entirely?
> >
> > Yes, that is the right thing to do.
>
> It's possible that this didn't work when the code was originally added:
> The decompressor functions are called from the compressed boot path,
> which is a bit limited regarding which headers it can include, at least
> on some architectures.
>
> I would recommend test-building this for all architectures that include
> ../../../../lib/decompress_inflate.c from their boot code.
>

Jann, Christoph, Arnd, thanks for the advice. I will start to look
into this immediately.

Lukas
