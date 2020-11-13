Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710902B2516
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgKMUEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgKMUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:04:48 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FA5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:04:47 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id a15so3060694qvk.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 12:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LXoutfO4oxEs8v+Kx1tbB1USI3p19ljNWVnpsVPx+Gg=;
        b=MSj/7DxG2Sqr6gwYHt0BG46JT3/tiFv+WOBuRXUjkadvyfmoVr2jZglqTxXB4fwRf5
         hwZ7OK+rKkUH5EbFHen1Qel71FNUrdz2ya5jfzf0swyckir8o5vTBYad0KmZilwQIHLE
         6+JdVJhGibb+dgBElY22T0MM1bX+8Rr32rWEOsB/r1847FvKyhXWldAPctK33ef8HaaT
         mVQsv0Flr9EXPNfSi9FV8JrUDBLtLHT9oIRXKlurcsRFoKM+n2s7rOSZy6XKtjj1EcT9
         7XUa/g9aAx/aYgF57m5ZP55ki0nIkKuihkscqv5O18K5zN+7ab+TTaYb9/uwneX376zn
         YTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LXoutfO4oxEs8v+Kx1tbB1USI3p19ljNWVnpsVPx+Gg=;
        b=BXt5yW1M/9lK4SV0OLXKMMFEERCVHuxpRo+cP5O5dGVZS431oobAAORGn/Ll2/ewMU
         5OWt5WsECXsAOvF00trCpvpCt4d7RmjKN69S/yMlo77Zb224Ulnbh52J7EEig42PfCT5
         jEicEOSD22V1z/g3u63mgRtWiHifTfOd+zQsbKEzCAor003/EITYAysn7NSH+cCiczkI
         AYfQH4PK3rC9xDweAo8lIKH8uxRKswC+Jto6dcQz3fFQIBBuzk6v5yOOCE2raveuxLRO
         acrdRHa3+26j2qDETpEY4xQtVNo5pQjGEHKelqOHd+bw3ghjrFaTbLPL026wuvN8N7DI
         d/jg==
X-Gm-Message-State: AOAM530Y7pl/yqVKkIj81+ODTUm8lhO6wbuUxjVpv0lbMjUylOEjIsbP
        FhcyLNicGfEiop3VV+A/Vso=
X-Google-Smtp-Source: ABdhPJwAx6q9nNJ79klcvC7PIXIAkF3s6o3E4vEIVXCdKZ3pkPThR6Ky0G/qfrx5TchNm5Cns99M1g==
X-Received: by 2002:a0c:fe0f:: with SMTP id x15mr4084918qvr.11.1605297886440;
        Fri, 13 Nov 2020 12:04:46 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id 9sm7629275qke.6.2020.11.13.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 12:04:45 -0800 (PST)
Date:   Fri, 13 Nov 2020 13:04:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201113200444.GA1496675@ubuntu-m3-large-x86>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
 <20201113190824.GA1477315@ubuntu-m3-large-x86>
 <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkEtTQhDRFRV_d66FyhQBe536vRbOW=fQjesiHz3dfeBA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 11:42:03AM -0800, Nick Desaulniers wrote:
> + MPE, PPC
> 
> On Fri, Nov 13, 2020 at 11:08 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Fri, Nov 13, 2020 at 09:28:03AM -0800, Fāng-ruì Sòng wrote:
> > > On Thu, Nov 12, 2020 at 7:22 PM kernel test robot <lkp@intel.com> wrote:
> > > >
> > > > Hi Fangrui,
> > > >
> > > > FYI, the error/warning still remains.
> > > >
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > > head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > > > commit: ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51 Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
> > > > date:   4 months ago
> > > > config: powerpc-randconfig-r031-20201113 (attached as .config)
> 
> ^ randconfig
> 
> > > > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 9e0c35655b6e8186baef8840b26ba4090503b554)
> > > > reproduce (this is a W=1 build):
> > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         # install powerpc cross compiling tool for clang build
> > > >         # apt-get install binutils-powerpc-linux-gnu
> > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> > > >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > >         git fetch --no-tags linus master
> > > >         git checkout ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    Assembler messages:
> > > > >> Error: invalid switch -me200
> > > > >> Error: unrecognized option -me200
> > > >    clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
> > > >    make[2]: *** [scripts/Makefile.build:281: scripts/mod/empty.o] Error 1
> > > >    make[2]: Target '__build' not remade because of errors.
> > > >    make[1]: *** [Makefile:1174: prepare0] Error 2
> > > >    make[1]: Target 'prepare' not remade because of errors.
> > > >    make: *** [Makefile:185: __sub-make] Error 2
> > > >    make: Target 'prepare' not remade because of errors.
> > > >
> > > > ---
> > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
> > > This can be ignored. The LLVM integrated assembler does not recognize
> > > -me200 (-Wa,-me200 in arch/powerpc/Makefile). I guess the GNU as -m
> > > option is similar to .arch or .machine and controls what instructions
> > > are recognized. The integrated assembler tends to support all
> > > instructions (conditional supporting some instructions has some
> > > challenges; in the end I have patched parsing but ignoring `.arch` for
> > > x86-64 and ignoring `.machine ppc64` for ppc64)
> > >
> > > (In addition, e200 is a 32-bit Power ISA microprocessor. 32-bit
> > > support may get less attention in LLVM.)
> >
> > This is also not a clang specific issue, I see the exact same error
> > with GCC 10.2.0 and binutils 2.35.
> >
> > $ make -skj64 ARCH=powerpc CROSS_COMPILE=powerpc64-linux- olddefconfig vmlinux
> 
> Does using a non 64b triple produce the same failure?

Yes, CROSS_COMPILE=powerpc-linux- produces the same failure.

> > ...
> > Error: invalid switch -me200
> > Error: unrecognized option -me200
> 
> There's a block in  arch/powerpc/Makefile:
> 248 cpu-as-$(CONFIG_40x)    += -Wa,-m405
> 249 cpu-as-$(CONFIG_44x)    += -Wa,-m440
> 250 cpu-as-$(CONFIG_ALTIVEC)  += $(call
> as-option,-Wa$(comma)-maltivec)
> 251 cpu-as-$(CONFIG_E200)   += -Wa,-me200
> 252 cpu-as-$(CONFIG_E500)   += -Wa,-me500
> 
> Are those all broken configs, or is Kconfig messed up such that
> randconfig can select these when it should not?

Hmmm, looks like this flag does not exist in mainline binutils? There is
a thread in 2010 about this that Segher commented on:

https://lore.kernel.org/linuxppc-dev/9859E645-954D-4D07-8003-FFCD2391AB6E@kernel.crashing.org/

Guess this config should be eliminated?

Cheers,
Nathan
