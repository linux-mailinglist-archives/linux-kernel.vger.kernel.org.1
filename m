Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B25602F1F48
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbhAKT2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:28:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388087AbhAKT2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:28:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C83822CAE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610393274;
        bh=tqYtvUHaYqDpyPKuhUK5/MI/gbHARz8MLesQiWj0ADw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a66UvBCKfxqIkHPPkARTreV55brvMT3whwaUMKxvrd4GAmCzlnHS7FLsZKwM7cMDl
         PnJkxHjzrS6n+C9NVpJvDhRqhebEImS6nwTRed9DGZwL3cDHdFqE7y2439T4BY9FNx
         EvOEmGMy1KwcjwV3Jt4mJbTniZEw5BYDgAE5xKJvtE1xU1K2V56Tm12s5SqtUE4GVz
         tXJhTbpOAwGTErzLW2FmlERwRaaV1TO7ss7fS8xwWaSYrOEnZSUpbI/qTB5YX43SED
         vfY5ZJCXgLztHfeGO/R3o/hbqVniDtxDnyWHg9wb9aM2SToMVwYcKyO60DwUnmFVAj
         s3En/M5ogjPPw==
Received: by mail-ej1-f41.google.com with SMTP id b9so43712ejy.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:27:54 -0800 (PST)
X-Gm-Message-State: AOAM531PmIgPE9jiSiW0iL5HsL+08c9o0IqKVfznd0zjI8WKUqGsFaTa
        wWUugTr9lcaj+sIJ9fuu1g0W2qf5ZTkgHeg2ebFs+w==
X-Google-Smtp-Source: ABdhPJz0qAES7okEj4inElh+VMRju5HGQPLVJ+TKvrt4jREIodqDODApY9bRbDih4qWHjMDxAtPS379VjgjhPIuewa0=
X-Received: by 2002:a17:906:52c1:: with SMTP id w1mr709722ejn.214.1610393272934;
 Mon, 11 Jan 2021 11:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20210111181520.GE25645@zn.tnic>
In-Reply-To: <20210111181520.GE25645@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Jan 2021 11:27:38 -0800
X-Gmail-Original-Message-ID: <CALCETrV98776mNd20v8r+JXt0uOUKemd_YnDYDoLXN_LDfQnog@mail.gmail.com>
Message-ID: <CALCETrV98776mNd20v8r+JXt0uOUKemd_YnDYDoLXN_LDfQnog@mail.gmail.com>
Subject: Re: gdbserver + fsgsbase kaputt
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 10:15 AM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi,
>
> so there's a breakage of a use case with gdbserver on fsgsbase machines,
> see
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=26804
>
> Tom has an even simpler reproducer:
>
> $ cat test.c
> int
> main (void)
> {
>   return 0;
> }
> $ gcc test.c -m32
> $ gdbserver localhost:12345 a.out
> ... other terminal ...
> $ gdb -batch -q -ex "target remote localhost:12345" -ex continue
> Program received signal SIGSEGV, Segmentation fault.
> 0xf7dd8bd2 in init_cacheinfo () at ../sysdeps/x86/cacheinfo.c:761
>
> The correct output is, of course:
>
> ...
> [Inferior 1 (process 1860) exited normally]
>
> I tried to bisect this but it led me to:
>
>   b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
>
> which simply enables fsgsbase so I could've made a small mistake in the
> bisection.
>
> I say small because booting with "nofsgsbase" cures it so it must be
> something fsgsbase + ptrace especially since the symptom is a corrupted
> stack canary in %gs...

Hmm.  Can you try booting with unsafe_fsgsbase and bisecting further?
And maybe send me your test binary?  I tried to reproduce this, but it
worked fine, even if I compile the test program with
-fstack-protector-all.

Off the top of my head, I would have expected this to fix it:

commit 40c45904f818c1f6555294ca27afc5fda4f09e68
Author: Andy Lutomirski <luto@kernel.org>
Date:   Fri Jun 26 10:24:29 2020 -0700

    x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase
