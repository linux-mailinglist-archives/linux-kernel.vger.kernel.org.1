Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC9C2A5B12
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 01:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbgKDAie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 19:38:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgKDAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 19:38:33 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B65B3223EA;
        Wed,  4 Nov 2020 00:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604450312;
        bh=41puZOfiNTyKXVbiwPgaOTnfgsAP47mio60AN0YzIQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0x8yN6odwdvCC3llx5ahpRohlV6CiDGy1E7DQ/G8FgQcp2lO6GzSmT/U4s5/AgrNv
         ysr8sIEOKE7aHcksV9K9z2tgg6a+h2f+GET3unC+tyOsIHL8tnZx1CdKJH9B3ijfCB
         3epp+tVaF4b/S9I8tT+vHCXnx1tHoTk78k9dfjOc=
Date:   Wed, 4 Nov 2020 02:38:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/7] compiler-clang: add build check for clang 10.0.1
Message-ID: <20201104003826.GB19460@kernel.org>
References: <20200902225911.209899-1-ndesaulniers@google.com>
 <20200902225911.209899-2-ndesaulniers@google.com>
 <20201103045521.GA58906@kernel.org>
 <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdk-bMx3Jt6=oN=PHqRv_tx5cF=9cVmumazb4vMNHdj5Ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 10:48:27AM -0800, Nick Desaulniers wrote:
> On Mon, Nov 2, 2020 at 8:55 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Sep 02, 2020 at 03:59:05PM -0700, Nick Desaulniers wrote:
> > > +#define CLANG_VERSION (__clang_major__ * 10000       \
> > > +                  + __clang_minor__ * 100    \
> > > +                  + __clang_patchlevel__)
> > > +
> > > +#if CLANG_VERSION < 100001
> > > +# error Sorry, your version of Clang is too old - please use 10.0.1 or newer.
> > > +#endif
> >
> >
> > I'm trying to compile a BPF enabled test kernel for a live system and I
> > get this error even though I have much newer clang:
> >
> > ➜  ~ (master) ✔ clang --version
> > Ubuntu clang version 11.0.0-2
> > Target: x86_64-pc-linux-gnu
> > Thread model: posix
> > InstalledDir: /usr/bin
> >
> > Tried to Google for troubleshooter tips but this patch is basically the
> > only hit I get :-)
> 
> To check the values of the above preprocessor defines, please run:
> $ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p
> 
> If you have multiple versions of clang installed, you might not be
> running the version you think you are.  Particularly, if you're using
> bcc, idk if it includes a copy of clang?  If that's the case, we may
> have to work out how we can support older versions of clang for the
> express purposes of bpf.

➜  ~ (master) ✔ clang -dM -E - < /dev/null | grep -e __clang_m -e __clang_p
#define __clang_major__ 11
#define __clang_minor__ 0
#define __clang_patchlevel__ 0

I'm compiling the kernel itself with GCC.

Here's an example BPF script that fails on me:

struct sgx_enclave_add_pages {
	unsigned long src;
	unsigned long offset;
	unsigned long length;
	unsigned long secinfo;
	unsigned long flags;
	unsigned long count;
};

kprobe:sgx_ioctl
{
	if (arg1 == 0xc030a401) {
		printf("sgx_ioctl: %d, %lu\n", pid, ((struct sgx_enclave_add_pages *)(arg2))->offset);
	}

}
Note that it relies on code not yet in the mainline.

If I don't declare structs, things work just fine. E.g. the following
works:

kprobe:sgx_encl_get_backing
{
	printf("%s\n", func)
}

BTW, I don't really understand how scripts/clang-version.sh is even
supposed to work, if you compile the kernel itself with GCC. In that
case there would be no output, right? And thus version gets set to
zero...

> -- 
> Thanks,
> ~Nick Desaulniers

/Jarkko
