Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4363A2E2118
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 21:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgLWUD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 15:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgLWUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 15:03:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C715BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:02:45 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v1so308971pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQjHGEhez9gAsCthzyBXrtWP3JdPJ9jzUZqLhtmOLQo=;
        b=pJnNiZLI1lDaq6hosav737tCuFbaNYXNhMHDQq/ZT+NB8s8SdKTVh3Kumr5YoXPbS/
         rkxTHFBW2TdMY4ZYQmG786/ifcz7Z4zj21T4HKy10KahHlzUy6kx26X/n0nndcE4chUq
         sh8wQpS7XuXgmUz1Yet+/Lb9+Bocf7a5LFllLmt4bTrJ2rDJRRcEeD+lk3/qq8f4ENZg
         xKcpfWwXFnxq2NnkKyksGXo2g0gxm4tftiQIs32a+6oJvZUgGujfsv/n2mlob+fVYRbb
         SukhJRdII1gVUBB/npGYWOJDOFAdPKh4SA7//OBB4MjuymgoYRNfXuaWNk7LL5jmHiRZ
         wCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQjHGEhez9gAsCthzyBXrtWP3JdPJ9jzUZqLhtmOLQo=;
        b=fGvTs3cPb9euZZm4eWe2wd8urIZvhhY8yCgKt6zNRNLFFRWaV6h1ZMwGJIkVIlVhbP
         XRCSvROlP3xxyJ24mimiiL8TKi1gAKofzwTwQttVr3A2wAeS+tF3A5tSX5Sabz0h2fV9
         4DqjH172VoT9Mcc4H4OGLGncu7E0bxfkNOGthPlWskeEE2FGPhBoEmsXo5mLbvcVSPu0
         H6DYZZCDJAE5jW/CZqVjOh6SEA25BVfRU02R7ZWsiIJVoZZAUsOVwU7qbmP4bcj0G3e3
         c4tSnrT3gW9/btEzvFt3cvCSd7lT4qdFjCMz5UO2bPeI3eWReP7V8XRP2JBbvMHVIzzs
         0NqQ==
X-Gm-Message-State: AOAM531xx/8g0zCRZ3bRlQO8cySODV+5am9zDNkrfPto8RPeWPtaTuWA
        UIH4k4B46FQqEMZXBjp617e6kBkt2yoyI9QJzf6v5g==
X-Google-Smtp-Source: ABdhPJwG6TIK7nqmUav0bH1tXJaSw4GOHtrAH9C8TE19ijPBw/RTQuBH0tDTaarEOvjVn5Cn/ec0Gtum6b67kkETBIw=
X-Received: by 2002:a17:90a:31c3:: with SMTP id j3mr360137pjf.25.1608753764841;
 Wed, 23 Dec 2020 12:02:44 -0800 (PST)
MIME-Version: 1.0
References: <202012180909.WhlTpWrS-lkp@intel.com> <20201223183606.GB29011@zn.tnic>
In-Reply-To: <20201223183606.GB29011@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 23 Dec 2020 12:02:33 -0800
Message-ID: <CAKwvOdkA+7AYGhPk_=FA6OPxeb9Wy7FA0_5-0KCJGr-wtn_nxw@mail.gmail.com>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 10:36 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Dec 18, 2020 at 09:03:14AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi=
/core
> > head:   b283477d394ac41ca59ee20eb9293ae9002eb1d7
> > commit: 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a [3/7] efi/libstub: EFI=
_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes
> > config: riscv-randconfig-r022-20201217 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project ce=
e1e7d14f4628d6174b33640d502bff3b54ae45)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install riscv cross compiling tool for clang build
> >         # apt-get install binutils-riscv64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/c=
ommit/?id=3D6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> >         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/=
git/tip/tip.git
> >         git fetch --no-tags tip efi/core
> >         git checkout 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
ARCH=3Driscv
>
> Something's still not good with that test - it fails much earlier for me:
>
> $ COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang /tmp/make.cross ARC=
H=3Driscv
> Compiler will be installed in /home/boris/0day
> cd: received redirection to `https://download.01.org/0day-ci/cross-packag=
e/'
> lftpget -c https://download.01.org/0day-ci/cross-package/./clang-latest/c=
lang.tar.xz
> tar Jxf clang-latest/clang.tar.xz -C /home/boris/0day
> make W=3D1 CONFIG_OF_ALL_DTBS=3Dy CONFIG_DTC=3Dy HOSTCC=3D/home/boris/0da=
y/clang-latest/bin/clang CC=3D/home/boris/0day/clang-latest/bin/clang LD=3D=
/home/boris/0day/clang-latest/bin/ld.lld HOSTLD=3D/home/boris/0day/clang-la=
test/bin/ld.lld AR=3D/home/boris/0day/clang-latest/bin/llvm-ar NM=3D/home/b=
oris/0day/clang-latest/bin/llvm-nm STRIP=3D/home/boris/0day/clang-latest/bi=
n/llvm-strip OBJDUMP=3D/home/boris/0day/clang-latest/bin/llvm-objdump OBJSI=
ZE=3D/home/boris/0day/clang-latest/bin/llvm-size READELF=3D/home/boris/0day=
/clang-latest/bin/llvm-readelf HOSTCXX=3D/home/boris/0day/clang-latest/bin/=
clang++ HOSTAR=3D/home/boris/0day/clang-latest/bin/llvm-ar CROSS_COMPILE=3D=
riscv-linux-gnu- --jobs=3D32 ARCH=3Driscv
>   SYNC    include/config/auto.conf.cmd
> ...
>
> scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-=
sr]
> scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts=
-rr]
>   DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
>   DTC     arch/riscv/boot/dts/kendryte/k210.dtb
>   HOSTCC  scripts/genksyms/parse.tab.o
>   HOSTCC  scripts/genksyms/lex.lex.o
>   HOSTLD  scripts/genksyms/genksyms
>   CC      scripts/mod/empty.o
>   HOSTCC  scripts/mod/mk_elfconfig
>   CC      scripts/mod/devicetable-offsets.s
> error: unknown target triple 'riscv-unknown-linux-gnu', please use -tripl=
e or -arch

Boris,
Thanks for taking the time to try to repro, and the report.  Just
curious, which clang are you using?  Is it from your distro?  If you
have `llc` installed, can you send me the output of `llc --version`?

The reason I ask is; unlike GCC, Clang ships with all non-experimental
backends on by default, and relies on `--target=3D<triple>` when cross
compiling. You can disable backends when configuring a build of LLVM,
but it's frowned upon for distributions to do so (I do it locally to
speed up development).  The above error is indicating that LLVM was
configured to not have RISCV support.

The RISCV backend only recently became a non-experimental (as in on by
default) backend a couple of releases ago, so either you have an old
clang that was intentionally built without experimental backends
(solution: use newer clang, where it should be on by default), or your
distro has disabled the backend (solution: encourage the package
maintainer to fix that), (or you configured LLVM yourself and didn't
enable RISCV).

Either way, you can ignore this report. Known issue with further
discussion here: https://github.com/ClangBuiltLinux/linux/issues/1220.
Happy holidays+new year.

> make[1]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets=
.s] Error 1
> make[1]: *** Waiting for unfinished jobs....
> error: unknown target triple 'riscv-unknown-linux-gnu', please use -tripl=
e or -arch
> make[1]: *** [scripts/Makefile.build:283: scripts/mod/empty.o] Error 1
> make: *** [Makefile:1199: prepare0] Error 2
> $
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20201223183606.GB29011%40zn.tnic.



--=20
Thanks,
~Nick Desaulniers
