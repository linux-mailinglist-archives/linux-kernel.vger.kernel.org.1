Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850EC2DB1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgLOQkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:40:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgLOQkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 11:40:02 -0500
X-Gm-Message-State: AOAM532MYCdpsvaXj6xz8GaeKabHyqi6QaGxf7Ot35fOSF2gVD3zwwz2
        t6ykJH/ZkgjSoPcCU5CeneVgT+h+eXrQ1bBCnPki7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608050361;
        bh=Rpvrhq1xN8ArrcBIuLot/raa13aSOrd6TedvRdYIdSg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JeAaiZotbdEwCWKbacduHYOzbclUnRdd3z2Dne7cvVRTFOEg9aj0Lu2RTwJsvZF9y
         hdSSmWbV4Pl/VbiKdbHutPZgib1yrxmaTdTZtGMXQP7jIAz4GsPK6gXDAhor07hu7P
         B5Z1Wlgmaez9K6j8XkFaan8YBYPjkXoXZDS5MxOa9kL96QCFOgzab58kyuVkoNkAy2
         /Z50ePo4uOoklvG24jRG8Btjhe953XihQUDMj3k+kmPd0OC45eR9lOEyeIu3xyYLbq
         veHiRZY+hsdJw8/wZ8TeHr3GlQUlqsRi6rD4guwvP9Mkb4eB4fF83KjRw/WK1krLjl
         bj+AkanLfFq8g==
X-Google-Smtp-Source: ABdhPJxGzJ5uANh25SZiAoS17gIhmCnzN82kxV4jhfhZfhhOiszaP48nEWqbPQRmbl9KeEIG6fDCET+FfjNqswOCphQ=
X-Received: by 2002:a5d:43c3:: with SMTP id v3mr10425647wrr.184.1608050359907;
 Tue, 15 Dec 2020 08:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20201215160314.18773-1-info@metux.net> <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
In-Reply-To: <41ef1cd1-017d-a0d4-91d3-a1183bd2ab01@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 15 Dec 2020 08:39:09 -0800
X-Gmail-Original-Message-ID: <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com>
Message-ID: <CALCETrXhZxyPUcrBaO=mzvANC72uXNBrivo7hGmdkV2bgdFxjw@mail.gmail.com>
Subject: Re: [PATCH] arch: x86: entry: vdso: fix type conversion on printf() call
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 8:32 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/15/20 8:03 AM, Enrico Weigelt, metux IT consult wrote:
> > Fixing the following compiler warning by explicit conversion to long:
> >
> > In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:162:0:
> > /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract64':
> > /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
> >   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> >                                                     ^
> >   CC      mm/filemap.o
> > In file included from /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.c:166:0:
> > /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h: In function 'extract32':
> > /home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/arch/x86/entry/vdso/vdso2c.h:38:52: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t {aka unsigned int}' [-Wformat=]
> >   fprintf(outfile, "static const unsigned char %s[%lu] = {", name, len);
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> > ---
> >  arch/x86/entry/vdso/vdso2c.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> Hi,
>
> size_t is normally printed with %zu.
> Is there some reason that isn't being used here?

No.  Want to send a patch?
