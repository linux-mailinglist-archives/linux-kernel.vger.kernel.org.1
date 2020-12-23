Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC322E2289
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgLWWoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:44:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:59998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgLWWoi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:44:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32F7222955
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 22:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608763437;
        bh=e3uxPs28+l1dD9Lo5bTzDIl6z6hyTPiL2F3J/U6867o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FdM9M0mIPb4MizMhZjdz7nXuzFZQe1WA94hX1NaudFhd7771UyjcTCqmGVpzlxfsY
         xTkJMqg+Y9vnmm7FsFDXBappPLRTPAuNgXHCSeXOilasuXBptUK+VOML9GT9+e4GnF
         e0o6ekhHbaOoiZzj0BkL1ETKss9foGmKOIeY+K9mr2GT9SddZx8eUzKNuJInwYo+Lj
         O02//Gqh5O/PfpqZrKaPPpunFAI8KlKL4vla0pnIzQnQyBP0maG3EWkMAgvYCPmdhe
         Dat1Z13da28CewGNTmbtU404a0+LEPXK/UFq9K0tw1RfDTUQqlsNRLSY9n3tEbM8Yq
         M5o+2EheuGpGA==
Received: by mail-oi1-f176.google.com with SMTP id q205so642293oig.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 14:43:57 -0800 (PST)
X-Gm-Message-State: AOAM532PbjwXSCdJ9XDpBgK2KnmdiWVyYvUldiapdnMPAK2UHNEYSEIO
        II8GzZGXnOMN3rJOWuB44VuctAf0BY5VmMcNJAc=
X-Google-Smtp-Source: ABdhPJy4LKLsjNqJCHj3vCE48sWw8SlmKzW0U2l2/nFNy9XVOIoUl8HAtqU/f6d7WlAchOXY9tNyaj5y+NnmMFEPCLQ=
X-Received: by 2002:aca:210f:: with SMTP id 15mr1292225oiz.174.1608763436546;
 Wed, 23 Dec 2020 14:43:56 -0800 (PST)
MIME-Version: 1.0
References: <202012180909.WhlTpWrS-lkp@intel.com> <20201223183606.GB29011@zn.tnic>
 <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com> <20201223210405.GB28724@zn.tnic>
In-Reply-To: <20201223210405.GB28724@zn.tnic>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 23 Dec 2020 23:43:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG58+DdfA9RDE9gnELf8ZT0dTX+g8D+3W0pVM8RUSF_OQ@mail.gmail.com>
Message-ID: <CAMj1kXG58+DdfA9RDE9gnELf8ZT0dTX+g8D+3W0pVM8RUSF_OQ@mail.gmail.com>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Boris,

On Wed, 23 Dec 2020 at 22:04, Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Dec 23, 2020 at 12:02:33PM -0800, Nick Desaulniers wrote:
> > On Wed, Dec 23, 2020 at 10:36 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Dec 18, 2020 at 09:03:14AM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi/core
> > > > head:   b283477d394ac41ca59ee20eb9293ae9002eb1d7
> > > > commit: 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a [3/7] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes
> > > > config: riscv-randconfig-r022-20201217 (attached as .config)
> > > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # install riscv cross compiling tool for clang build
> > > >         # apt-get install binutils-riscv64-linux-gnu
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> > > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > > >         git fetch --no-tags tip efi/core
> > > >         git checkout 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
>

I hope this report is not holding up the PR for efi/core?

> ...
>
> > Thanks for taking the time to try to repro, and the report.  Just
> > curious, which clang are you using?  Is it from your distro?  If you
> > have `llc` installed, can you send me the output of `llc --version`?
> >
> > The reason I ask is; unlike GCC, Clang ships with all non-experimental
> > backends on by default, and relies on `--target=<triple>` when cross
> > compiling.
>
> I just did the steps outlined above, in the mail. Look for "reproduce
> (this is a W=1 build):" above. I guess that make.cross script needs to
> be fixed to do the --target thing, I haven't looked.
>
> clang is downloaded by the script, just do the steps and you'll see:
>
> > > cd: received redirection to `https://download.01.org/0day-ci/cross-package/'
> > > lftpget -c https://download.01.org/0day-ci/cross-package/./clang-latest/clang.tar.xz
>
> Thx.
>
> > Happy holidays+new year.
>
> Ditto!
>
> :-)
>

Likewise!
