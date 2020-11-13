Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51C22B2441
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 20:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgKMTI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 14:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMTI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 14:08:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896D7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:08:27 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id v143so9836314qkb.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=s+DP0hsscuvVJP4FCb9JX2LW5UPLPQY316PjTDF9ajE=;
        b=m0/mbnDs0eW+RwJhCYGSOJhO4qnh9ux1mkYjo2p/A3l6vkqBpaP/IZGz/vkLTDYoki
         24PK4mAtY/uJ1fVSKuWGTYK5O/mwdIpunUFUNDCiKWEUpKuaSfdqEK+dVy4S85AEuI7p
         nuC9S7CCem4tOeUY5+0FPJRRYOEip97VNxDJU6XJ+aviFFUY3wfj+fGl5HNuJua16y/k
         ZtTTOhgdrCW1SGDlVj8+P/d2RWhHTfQPRQ79S6ynlWM4978cuDviQQIlvRP02afAi2pJ
         jHUnqUzhH3yCBifJSOkCbTFzHijYAux5Jh0TJrq+pv5bIxf0CaDgfspbblIqhGYiSKxd
         n0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=s+DP0hsscuvVJP4FCb9JX2LW5UPLPQY316PjTDF9ajE=;
        b=GYsednefTAvHe++9cDXqTsW49d5GNIJKNZOLDXctlTautdGgn6my4mx5prwMTJLOEa
         fXv5QDFjtcJ2cvccuy0zAi1q1fzPpoN0+mad4m5LIP3Wr9knw/FzROryKCRHPTDLDcEy
         3qu4/k7DzauStHdaEt0GKlfJeXIkUSPmS/cNRqV0KBXcJifnyyzdgii1FTTdpTOYR74V
         xrnsNrk0qs7Flyxt5g7yOCJEdIgFeaLoDH4DGOhjSocpkIQtlZipiYDrT4GJ7vIcncOj
         nirViiQF17HduQ3GZP/s01KPk6XZXFodEnq/xb/hPwc4eA/sWAk4gwfO+ZOx/9pRuHGB
         To2Q==
X-Gm-Message-State: AOAM532DaivaNbjK9e13JqU7w1Du0G6Lu0GmrEQG6e+P+W258wCYJHHa
        7HzwzQIZHTawQ1dYAd3FOSI=
X-Google-Smtp-Source: ABdhPJwhTdTk5ImNfDdmo7cbVP35pFaX+kpTuKwAvujbAxFm+jY4PlYXdcXHMpOYeBC6uzpNRwrhbw==
X-Received: by 2002:a37:4489:: with SMTP id r131mr3351024qka.485.1605294506613;
        Fri, 13 Nov 2020 11:08:26 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id j63sm7358525qke.67.2020.11.13.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 11:08:25 -0800 (PST)
Date:   Fri, 13 Nov 2020 12:08:24 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Error: invalid switch -me200
Message-ID: <20201113190824.GA1477315@ubuntu-m3-large-x86>
References: <202011131146.g8dPLQDD-lkp@intel.com>
 <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 09:28:03AM -0800, Fāng-ruì Sòng wrote:
> On Thu, Nov 12, 2020 at 7:22 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Fangrui,
> >
> > FYI, the error/warning still remains.
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> > commit: ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51 Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
> > date:   4 months ago
> > config: powerpc-randconfig-r031-20201113 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 9e0c35655b6e8186baef8840b26ba4090503b554)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install powerpc cross compiling tool for clang build
> >         # apt-get install binutils-powerpc-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    Assembler messages:
> > >> Error: invalid switch -me200
> > >> Error: unrecognized option -me200
> >    clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
> >    make[2]: *** [scripts/Makefile.build:281: scripts/mod/empty.o] Error 1
> >    make[2]: Target '__build' not remade because of errors.
> >    make[1]: *** [Makefile:1174: prepare0] Error 2
> >    make[1]: Target 'prepare' not remade because of errors.
> >    make: *** [Makefile:185: __sub-make] Error 2
> >    make: Target 'prepare' not remade because of errors.
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> This can be ignored. The LLVM integrated assembler does not recognize
> -me200 (-Wa,-me200 in arch/powerpc/Makefile). I guess the GNU as -m
> option is similar to .arch or .machine and controls what instructions
> are recognized. The integrated assembler tends to support all
> instructions (conditional supporting some instructions has some
> challenges; in the end I have patched parsing but ignoring `.arch` for
> x86-64 and ignoring `.machine ppc64` for ppc64)
> 
> (In addition, e200 is a 32-bit Power ISA microprocessor. 32-bit
> support may get less attention in LLVM.)

This is also not a clang specific issue, I see the exact same error
with GCC 10.2.0 and binutils 2.35.

$ make -skj64 ARCH=powerpc CROSS_COMPILE=powerpc64-linux- olddefconfig vmlinux
...
Error: invalid switch -me200
Error: unrecognized option -me200
...

Cheers,
Nathan
