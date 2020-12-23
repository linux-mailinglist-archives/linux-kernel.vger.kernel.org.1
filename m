Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9E2E21DD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 22:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgLWVEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 16:04:55 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgLWVEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 16:04:55 -0500
Received: from zn.tnic (p200300ec2f0de60015e9d95f23f51f71.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:15e9:d95f:23f5:1f71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CDA81EC04DF;
        Wed, 23 Dec 2020 22:04:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608757453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JiX0OsrfDoKg0aP4RqkxjAFxC6TQprsZzjUhWhmJkyA=;
        b=TDuOpUMvvWJhVco+F7cBd/P608kJl0XGwlhiGmJno3tmKh7MtGC2/R02fTdLntJSWTDogH
        kAxJqvARNKKRm+akBjphof/rE8w7FYc+r9AxPetgfrz/Vp4oJdYcguQsICgHzotNrp2eOg
        gMcQlFs2KglXg7gV5CItnIYOlZE1DXY=
Date:   Wed, 23 Dec 2020 22:04:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
Message-ID: <20201223210405.GB28724@zn.tnic>
References: <202012180909.WhlTpWrS-lkp@intel.com>
 <20201223183606.GB29011@zn.tnic>
 <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 12:02:33PM -0800, Nick Desaulniers wrote:
> On Wed, Dec 23, 2020 at 10:36 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Dec 18, 2020 at 09:03:14AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi/core
> > > head:   b283477d394ac41ca59ee20eb9293ae9002eb1d7
> > > commit: 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a [3/7] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes
> > > config: riscv-randconfig-r022-20201217 (attached as .config)
> > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install riscv cross compiling tool for clang build
> > >         # apt-get install binutils-riscv64-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> > >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
> > >         git fetch --no-tags tip efi/core
> > >         git checkout 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv

...

> Thanks for taking the time to try to repro, and the report.  Just
> curious, which clang are you using?  Is it from your distro?  If you
> have `llc` installed, can you send me the output of `llc --version`?
> 
> The reason I ask is; unlike GCC, Clang ships with all non-experimental
> backends on by default, and relies on `--target=<triple>` when cross
> compiling.

I just did the steps outlined above, in the mail. Look for "reproduce
(this is a W=1 build):" above. I guess that make.cross script needs to
be fixed to do the --target thing, I haven't looked.

clang is downloaded by the script, just do the steps and you'll see:

> > cd: received redirection to `https://download.01.org/0day-ci/cross-package/'
> > lftpget -c https://download.01.org/0day-ci/cross-package/./clang-latest/clang.tar.xz

Thx.

> Happy holidays+new year.

Ditto!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
