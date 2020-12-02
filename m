Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4590B2CCAC0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgLBXyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728637AbgLBXyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:54:14 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BFC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:53:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c79so83363pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nsQ5jLdSfQKhTpSL0ymLOmOqE37WINwXD7J/ZGWWptg=;
        b=qs68akwBxUNYen/TbMDZh6jcl2NwcHrIH2xzkxhdqFsg/hJ4YSnG8iLbR3lsnb6swr
         QctlrFJ6XpxeAkQuAZp88C7B33wUO1H1SEP2tWZWba/pkwL7i6oN6dxeLl/9KnSc741a
         ADMn5sF/tyRB1Rek4KBMXy8dPxWwfs5OqEU/A5IAq6OyikqbUvqcbgWbxfY1t2FOwRTZ
         L+bp4woIl+sWGir2meFERd5fv51DxzHOqs2jGnSW4tHsd/+yxxZWWqFY43AnQPLn8ffL
         LKYVDps4fbqyRpRSq+d7FCMszn7srSnzpa1M8vueYHsxR99nSdArZCbF/k1uLhAOlTrl
         a03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nsQ5jLdSfQKhTpSL0ymLOmOqE37WINwXD7J/ZGWWptg=;
        b=R/exiHQjg9cFysXmelQQ2aHkCQlj/B3FRi3hTa89Gkbw0SDw4GbybJVP+Cgkfx7e65
         hhUkZMhbCPpsYZGwlwSC0t0ecSnY1BlgeSsisAVzDk3umCk+H+HsN3MV6aEcmAFTLHja
         bC14ml3OGk1Lp0p7azPtuPcByn+ccZIntcDcFfU0mRpbbVxAVmf5HJaWJGB/2KQcSjKY
         j0JaCSMC8sZS9EorIIY1MZlcX3V26y8V/u7cwagJ2Zh6PRf2JiWe88oF35tySIdMyafk
         +3eK/3CLo1+4LQgZSx2mHcKZ2b5uSfNYmSkKsMqocvXHIMbwdga30WUlo7wijsHCSjXS
         1PAA==
X-Gm-Message-State: AOAM533CtqzOVLc3suFTOneRVDJUDo4tDysN0V+uW0etMLkTs34vQHf2
        +H1r/GqrzcmKJBgHqP+DKyYgCfiUvgABEoyQCViDgQ==
X-Google-Smtp-Source: ABdhPJw7Os4qn4J/J3GWLqnMymO8cHSVlhlFWWZdeLtouYkYU5JylntLXKfphckaST8Rr6PSSKOUCNp2HQeSyLZEF54=
X-Received: by 2002:a65:63d5:: with SMTP id n21mr637055pgv.346.1606953213234;
 Wed, 02 Dec 2020 15:53:33 -0800 (PST)
MIME-Version: 1.0
References: <20201202211542.1121189-1-axelrasmussen@google.com> <20201202230954.GB108496@xz-x1>
In-Reply-To: <20201202230954.GB108496@xz-x1>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Wed, 2 Dec 2020 15:52:56 -0800
Message-ID: <CAJHvVch2LJa57-Si2prKa-S3VUPpu3jYxW+3-+tcLMgSXkB69w@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: selftests: make __{s,u}64 format specifiers portable
To:     Peter Xu <peterx@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Alan Gilbert <dgilbert@redhat.com>,
        Greg Thelen <gthelen@google.com>,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Axel,
>
> Looks mostly good to me, but a few nitpickings below.
>
> On Wed, Dec 02, 2020 at 01:15:42PM -0800, Axel Rasmussen wrote:
>
> [...]
>
> > +static void uffd_error(const char *message, __s64 code)
> > +{
> > +     fprintf(stderr, "%s: %" PRId64 "\n", message, (int64_t)code);
> > +     exit(1);
> > +}
>
> IMHO a macro that can take arbitrary parameters would be nicer, but if it
> satisfy our need, definitely ok too.
>
> [...]
>
> > @@ -340,7 +348,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
> >       prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
> >
> >       if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
> > -             fprintf(stderr, "clear WP failed for address 0x%Lx\n", start);
> > +             fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
> > +                     (uint64_t)start);
> >               exit(1);
>
> Is it intended to not use uffd_error() here?

Yes, this is intentional. This particular case prints the value in
hexadecimal, rather than decimal.

(Agree that uffd_error() could be made more general to cover cases
like this. I opted for the simplest thing which covers all but two
cases - this one, and one where we "return 1;" instead of "exit(1);" -
but I don't feel strongly.)

>
> >       }
> >  }
>
> [...]
>
> > @@ -979,26 +981,20 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
> >       if (ret) {
> >               /* real retval in ufdio_zeropage.zeropage */
> >               if (has_zeropage) {
> > -                     if (uffdio_zeropage.zeropage == -EEXIST) {
> > -                             fprintf(stderr, "UFFDIO_ZEROPAGE -EEXIST\n");
> > -                             exit(1);
> > -                     } else {
> > -                             fprintf(stderr, "UFFDIO_ZEROPAGE error %Ld\n",
> > -                                     uffdio_zeropage.zeropage);
> > -                             exit(1);
> > -                     }
> > +                     uffd_error(uffdio_zeropage.zeropage == -EEXIST ?
> > +                                              "UFFDIO_ZEROPAGE -EEXIST" :
> > +                                              "UFFDIO_ZEROPAGE error",
>
> Nit: The indents here are a bit odd..

This is what clang-format yields. Are you thinking it would be better
to line everything up with the ( in uffd_error( ?

Or, perhaps this case is a good reason to make uffd_error() a variadic
macro so we can insert "-EEXIST" || "error" with a "%s".

>
> Thanks,
>
> --
> Peter Xu
>
