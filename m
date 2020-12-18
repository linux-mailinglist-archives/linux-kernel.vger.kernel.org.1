Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194BA2DEB38
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgLRVmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:42:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:58876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgLRVmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:42:02 -0500
X-Gm-Message-State: AOAM533cbtRYSc9tr/Q2+keUAXv6QyKZevqfE+CGiGKSqbZW1ZFQX9oN
        5c+Md0z6a5o0qr3qyC1JLT0oJXJyv0O+R/WSp84=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608327681;
        bh=Hq8wR/llExnD1xPaqlnM06iMoNktQtCOZk26zXnX3+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qDF4cKk7wAbFNvm4+TSMONgFASickPJueZgggl7iZ2nQbnCupprRs1SHIBfNWKapi
         OjW5EPjI/h9yi/kUT4MVb4TA0U0qSVrBVJsaXJS4sP98NdS9A7lNPB/DaJNTBaRc2K
         cqNnemlmSS/9/v3orqJJfS405hnsYINd5YbpSRoUrq3AxwvMu5sOyvAMbCRgF5aUUo
         sp/AQqxsw3uFmm2Y/6NQCI27xYzpMW+TcnlT1MrSVSHhsLex4y3h6R0reZ83RNPNBc
         KpIS5cHaeIlurM6YUtxprbqDeZJYRrL+Med9JQabksQv7bae+dSQlA1EsJncj68cCS
         e+kT1izSUkCqQ==
X-Google-Smtp-Source: ABdhPJyM4Mr7qNYdEaUSe9FUl1ZQdkgzfgjFVq0sQxkCK8X7Lgj1RPioMzsX7zUP7J8GfN0LeWZY/JFUbd+8375/cL4=
X-Received: by 2002:aca:44d:: with SMTP id 74mr4248055oie.4.1608327680658;
 Fri, 18 Dec 2020 13:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 18 Dec 2020 22:41:04 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2L-AGHwszuoLKAnzY2ag_8L-iewCZ_aWxk_770w1SMqQ@mail.gmail.com>
Message-ID: <CAK8P3a2L-AGHwszuoLKAnzY2ag_8L-iewCZ_aWxk_770w1SMqQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/13] sparc32: sunset sun4m and sun4d
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David S Miller <davem@davemloft.net>,
        sparclinux <sparclinux@vger.kernel.org>,
        Andreas Larsson <andreas@gaisler.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Denis Efremov <efremov@linux.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        debian-sparc@lists.debian.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 7:43 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> The sun4m and sun4d based SPARC machines was very popular in the
> 90'ties and was then replaced by the more powerful sparc64
> class of machines.
> Today there is only Gentoo that to my best knowledge supports
> sparc32 and people have moved on to more capable HW.
>
> Cobham Gaisler have variants of the LEON processer that
> runs sparc32 - and they are in production today.
>
> With this patchset I propose to sunset sun4m and sun4d and move
> focus to a more streamlined support for LEON.
>
> One downside is that qemu supports sun4m - and we may loose
> some testing possibilities when sun4m is dropped. qemu supports
> LEON to some degree - I have not yet tried it out.
>
> Andreas from Gaisler have indicated that they may be more active
> upstream on sparc32 - and this will only be easier with a kernel
> where the legacy stuff is dropped.
>
> I decided to divide up the patches to make it possible to review
> the set as some of the patches touches assembler and these parts
> could use some extra eyes if we move forward with this.
>
> For now it builds with the configurations I have tried.

Thank you for doing this, it looks like a very nice cleanup.

> Looking forward for feedback if sunsetting is a good idea or not.

I have no insight on whether there are any users left that would miss
it, but I'm fairly sure that there are lots of people that would rather
see it gone.

> Note: I dunno why git does not see floppy_64.h=>floppy.h as a rename??

It doesn't do that if the old name existed already.

        Arnd
