Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356BE2B24BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgKMTmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKMTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:42:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13294C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:42:15 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id v12so8461710pfm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bpaBEkCKEdHgW1h3duZgowAHWMVwm/wa+XAmGoyCFHI=;
        b=oFn/RXDyVA1j0y1YQDQOB2ftvc0uvORFJdjpj9LDlBrrNhMvbFReEzpWp24e286756
         4uT8WsjYCxktEdM0u6GrTe3zP/6MtEsFGCS4cmMGgtjYGJJ4FivdbALYSUP1DDjb73Wq
         EICO1cd3IrEkLRz/QdnDx+5qAwOofb0VdoEyfxzyPPvf9aDDudrOp8yJmeKdOO1SPZk+
         aO0NhK5SD16xRb2puDAUjDqglJe/OAjuPVAqxKxXAF0LEycfYydU/hJ7W5yzCKdEXs4B
         CCjEOXDtRhs4YQMdFVA1O8gksAFUltf/8U126y8IgS1rdV2diGiuqZ4VIE1lehcRpMj/
         uLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bpaBEkCKEdHgW1h3duZgowAHWMVwm/wa+XAmGoyCFHI=;
        b=X3/wKB3c5XbO9lUfIoZ+en9mI4dQu+qWowl4IAxZAfZZH23wLppPFkiBnf6B6/O4td
         qzIlP3Tt2+KVMPab/Noxc8Aj2jHPQKMYBF0lThRlmwmQvqm2hmgaTnv3i4aBqBPGb5ry
         tImG5A//oeCpuFW4gq8wJpiQA16U5coyhpnoOy3Ys3QRmg3igWL/8jihYDdiioCsK7O1
         9smm+13xf+OZxdia9SJW1P8GOcKVy1NoPX84sxk42L9Hlaaq/ygFxV1HJJ8FiP4fDJ3K
         FklMBwtp4jv0A+rmAYyqGCw7kj0+mejUsksCAIpg9yHuJXTHiiA5jP4u6ru4tQVM+6du
         qVAg==
X-Gm-Message-State: AOAM533vPtVkgq9HMJmWRqKB+shnhgF9zV0ukrEltr8tvxDayEx/Lgff
        6RYxsYN41T5/jw8bn4V8gWXFkV/uI9FsoWXIo63C0Q==
X-Google-Smtp-Source: ABdhPJxBGruW0CFPMXPkH6jCYQnUWGpwTUjThVpylwpIL+AcMQOGFSV+GJvuRANsp1Q7nkVoV1fQ8L8DYU8vKQJ5bkc=
X-Received: by 2002:a65:4b81:: with SMTP id t1mr3343357pgq.263.1605296534160;
 Fri, 13 Nov 2020 11:42:14 -0800 (PST)
MIME-Version: 1.0
References: <202011131146.g8dPLQDD-lkp@intel.com> <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
In-Reply-To: <20201113190824.GA1477315@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 13 Nov 2020 11:42:03 -0800
Message-ID: <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
Subject: Re: Error: invalid switch -me200
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ MPE, PPC

On Fri, Nov 13, 2020 at 11:08 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Nov 13, 2020 at 09:28:03AM -0800, F=C4=81ng-ru=C3=AC S=C3=B2ng wr=
ote:
> > On Thu, Nov 12, 2020 at 7:22 PM kernel test robot <lkp@intel.com> wrote=
:
> > >
> > > Hi Fangrui,
> > >
> > > FYI, the error/warning still remains.
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git master
> > > head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > > commit: ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51 Makefile: Fix GCC_TO=
OLCHAIN_DIR prefix for Clang cross compilation
> > > date:   4 months ago
> > > config: powerpc-randconfig-r031-20201113 (attached as .config)

^ randconfig

> > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project =
9e0c35655b6e8186baef8840b26ba4090503b554)
> > > reproduce (this is a W=3D1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install powerpc cross compiling tool for clang build
> > >         # apt-get install binutils-powerpc-linux-gnu
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux.git/commit/?id=3Dca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> > >         git remote add linus https://git.kernel.org/pub/scm/linux/ker=
nel/git/torvalds/linux.git
> > >         git fetch --no-tags linus master
> > >         git checkout ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cros=
s ARCH=3Dpowerpc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    Assembler messages:
> > > >> Error: invalid switch -me200
> > > >> Error: unrecognized option -me200
> > >    clang-12: error: assembler command failed with exit code 1 (use -v=
 to see invocation)
> > >    make[2]: *** [scripts/Makefile.build:281: scripts/mod/empty.o] Err=
or 1
> > >    make[2]: Target '__build' not remade because of errors.
> > >    make[1]: *** [Makefile:1174: prepare0] Error 2
> > >    make[1]: Target 'prepare' not remade because of errors.
> > >    make: *** [Makefile:185: __sub-make] Error 2
> > >    make: Target 'prepare' not remade because of errors.
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> > This can be ignored. The LLVM integrated assembler does not recognize
> > -me200 (-Wa,-me200 in arch/powerpc/Makefile). I guess the GNU as -m
> > option is similar to .arch or .machine and controls what instructions
> > are recognized. The integrated assembler tends to support all
> > instructions (conditional supporting some instructions has some
> > challenges; in the end I have patched parsing but ignoring `.arch` for
> > x86-64 and ignoring `.machine ppc64` for ppc64)
> >
> > (In addition, e200 is a 32-bit Power ISA microprocessor. 32-bit
> > support may get less attention in LLVM.)
>
> This is also not a clang specific issue, I see the exact same error
> with GCC 10.2.0 and binutils 2.35.
>
> $ make -skj64 ARCH=3Dpowerpc CROSS_COMPILE=3Dpowerpc64-linux- olddefconfi=
g vmlinux

Does using a non 64b triple produce the same failure?

> ...
> Error: invalid switch -me200
> Error: unrecognized option -me200

There's a block in  arch/powerpc/Makefile:
248 cpu-as-$(CONFIG_40x)    +=3D -Wa,-m405
249 cpu-as-$(CONFIG_44x)    +=3D -Wa,-m440
250 cpu-as-$(CONFIG_ALTIVEC)  +=3D $(call
as-option,-Wa$(comma)-maltivec)
251 cpu-as-$(CONFIG_E200)   +=3D -Wa,-me200
252 cpu-as-$(CONFIG_E500)   +=3D -Wa,-me500

Are those all broken configs, or is Kconfig messed up such that
randconfig can select these when it should not?
--=20
Thanks,
~Nick Desaulniers
