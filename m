Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBEF2C2511
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgKXL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:56:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbgKXL4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:56:48 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4659A2076B;
        Tue, 24 Nov 2020 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606219007;
        bh=y7hNCHDhOzCdJOZUojv/G3eF5vHntYRU1MQ8NUR/VkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ubr93BgqQ9elnxKRaC9Uy7kW6GwLt9O4FCZNYRLejie3j/brR5HVW5ioNG+KN2IuL
         sUw9acNqGq7fbsqGEMgVwe2KVq/Y8+eGyRkBRIdjrTxo806Wp+dVMLh5vXOB4uozLC
         y6nIIF4TUE5N+aZA/krt5hTNXOMM4uegvBpiYbw4=
Received: by mail-ot1-f49.google.com with SMTP id z24so5058288oto.6;
        Tue, 24 Nov 2020 03:56:47 -0800 (PST)
X-Gm-Message-State: AOAM530rHvvpBrg2sSerYl252eTJ1Su4xRcEBrPPunAUxQhqm3TCQpES
        NiGo5dxS3V0RzDT+EmIcb/c07j1frO7CGbcYhrs=
X-Google-Smtp-Source: ABdhPJyIlbxK8kUI/Gd+t4sq0176BR9e9qJAqPwFGr3P2q+YWGeihJdMWgrJLWFUEZQLFdVjeb1/n3JnWGVkwsHznUo=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr2756972otk.251.1606219006415;
 Tue, 24 Nov 2020 03:56:46 -0800 (PST)
MIME-Version: 1.0
References: <20201124104030.903-1-lukas.bulwahn@gmail.com> <CAG48ez1FqJYay1F=LUt84DVHd+k0=gXohwhTnwv=t1sv=hTSjw@mail.gmail.com>
 <20201124115058.GA32060@infradead.org>
In-Reply-To: <20201124115058.GA32060@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 24 Nov 2020 12:56:30 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
Message-ID: <CAK8P3a2rVKQ5UHzcycu=0QpjtSQ3Nne4Xre-7+V27vmCe9yfKg@mail.gmail.com>
Subject: Re: [PATCH] zlib: define get_unaligned16() only when used
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
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

On Tue, Nov 24, 2020 at 12:51 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 24, 2020 at 12:08:40PM +0100, Jann Horn wrote:
> > > Since commit acaab7335bd6 ("lib/zlib: remove outdated and incorrect
> > > pre-increment optimization"), get_unaligned16() is only used when
> > > !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
> > >
> > > Hence, make CC=clang W=1 warns:
> > >
> > >   lib/zlib_inflate/inffast.c:20:1:
> > >     warning: unused function 'get_unaligned16' [-Wunused-function]
> > >
> > > Define get_unaligned16() only when it is actually used.
> > >
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > AFAICS a nicer option would be to "#include <asm/unaligned.h>" and
> > then use "get_unaligned", which should automatically do the right
> > thing everywhere and remove the need for defining get_unaligned16()
> > and checking CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS entirely?
>
> Yes, that is the right thing to do.

It's possible that this didn't work when the code was originally added:
The decompressor functions are called from the compressed boot path,
which is a bit limited regarding which headers it can include, at least
on some architectures.

I would recommend test-building this for all architectures that include
../../../../lib/decompress_inflate.c from their boot code.

     Arnd
