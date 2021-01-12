Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A132F3D32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437923AbhALVej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 16:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:39682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437101AbhALVDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 16:03:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3BB2D2311F;
        Tue, 12 Jan 2021 21:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610485349;
        bh=mqgTIR/4dJzxefUyLCCyIKX0u33hmXbXJc7zpzyVpNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uAFq5wox3wQldNptnu9tUBsbKiL86oesVKz60jCJMEzSkloJmFkWMq9fRpIxgiju9
         6nkj6ecrUCKnOhFiBxrVfYul+ViCovg9HpZFpunr5jJqJQ9Vqru+5jnu0SwUW1kIfS
         RSyrSzyTQgr78e6fgmJF+REHDf+1MhEBoqFAwZTOVS8aeXoNhGKzU+uYEqN4ru8HoB
         XgCRoATzV37Kf/t432esHrqdpF6VFHG4h12youy7ZibFbTA/7W5z+xXaAXBWEHSXkc
         Ij13HTgALGiuu9WtiQaU8sNFlDxO2c7fyeDqYa6RusOHo9boZr9IgzpGwhM1wCQX9h
         XLba3/yFFt7QQ==
Date:   Tue, 12 Jan 2021 21:01:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112210154.GI4646@sirena.org.uk>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mXDO3udm/xYWQeMQ"
Content-Disposition: inline
In-Reply-To: <20210112194625.4181814-1-ndesaulniers@google.com>
X-Cookie: Stay away from hurricanes for a while.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mXDO3udm/xYWQeMQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2021 at 11:46:24AM -0800, Nick Desaulniers wrote:

This:

> when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
> notes:

>   So basically, you can use an .L symbol *inside* a function or a code
>   segment, you just can't use the .L symbol to contain the code using a
>   SYM_*_START/END annotation pair.

is a stronger statement than this:

> +  Developers should avoid using local symbol names that are prefixed with
> +  ``.L``, as this has special meaning for the assembler; a symbol entry will
> +  not be emitted into the symbol table. This can prevent ``objtool`` from
> +  generating correct unwind info. Symbols with STB_LOCAL binding may still be
> +  used, and ``.L`` prefixed local symbol names are still generally useable
> +  within a function, but ``.L`` prefixed local symbol names should not be used
> +  to denote the beginning or end of code regions via
> +  ``SYM_CODE_START_LOCAL``/``SYM_CODE_END``.

and seems more what I'd expect - SYM_FUNC* is also affected for example.
Even though other usages are probably not very likely it seems better to
keep the stronger statement in case someone comes up with one, and to
stop anyone spending time wondering why only SYM_CODE_START_LOCAL is
affected.

This also looks like a good candiate for a checkpatch rule, but that can
be done separately of course.

--mXDO3udm/xYWQeMQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/+DkEACgkQJNaLcl1U
h9Cq7wf/T25FXiQQZ1vqQuvuSs9y7UidITjNn00or2An/9AZvjd7fNSIGitE6JZF
ulLa3Dnm6DnJ8IHxCom/f9HA0Bhqduottun00gPpRE4yYnc6I6rs4+jD3D3yaM+e
P48KYy2zaNF6Xgud3wdMdBWrO6wHbpk/FtrGu9myxKXbPoaWXCc/2JO+lQGHy2Ld
stRoPLzuNHGsqiiQyQVFUCJcva6y2q5UTYqWG21loFirQ0khEI1aHwVuifeddpjE
JamhRqQhmlTD8qRrnf8c4iVj6oexQsKzjOKkaKX2qpyYhK8bxdgvG8r0kwJfnuZM
LObeotMsynR86MF2K/fVFTw7r4fXMw==
=H9dS
-----END PGP SIGNATURE-----

--mXDO3udm/xYWQeMQ--
