Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798FD2B2251
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKMR2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgKMR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:28:19 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C271CC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:28:19 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id c66so8192567pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTeG8sIVZdSZyisMOg8nHywKwuHy9ybS7O9fYvpUUN4=;
        b=Q64Nfq4lTq6iOvUJ2t89GQXGo2O7IBAghtABXAA1TwuptUJJOcbK8z7pTKzyKw7PRn
         NJZaBRMfe1xa1Lv2jRCK6CvBRq7LxEjd5z+yoWIFYN1dlLs24+D8Pi1Ujpdcl3EY/nTQ
         mhHG43cDkdWrmDYSobWjAxcUAl+OnIb9KOTH1H1wAWL5WklNXPFjMu8sreZ/f0rQI2hn
         sMtm/ISNLb9gK9RDAyj+6QVU1/PFE+8vwv8LNach4NvJ9dlrjJwDi1tmsLcRjtz9LV1q
         8G/bOZ7uZoBr/S7+6ob7ZszLDrVJ1FEZpBxWrny4uPDQeD5w5ZdX6m92dRmhMPkTKaTv
         H2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTeG8sIVZdSZyisMOg8nHywKwuHy9ybS7O9fYvpUUN4=;
        b=P57SbYMUt6p5mplMBbiRcg7ZQjEBaCOGnzRFpKWZryWifgwIPdtzStvyrhHYBlK+wJ
         7c07KMCmucNQRcb41Zyyvha+VPKIkBnzdm4KvnKG46Iv5wnoLvM6KXNYCNAbmYojG4Ok
         Za9fRn5v5IcJ6jDLGO6ZtoH2IQEvf+MdNMXh4KMJ7T67A93rLEMuX/lf8m+eljRtwK/+
         LGgI9t7gY4Fyb1vmFfXOrL2o04D/Z4L1zoQIKXxtuVGGZ5KSyVOyGRxioRJ9Bjaxbow/
         YLJBdlkq6SlBRDV08VGgSwkOLDeOyegUJqAcnPVzW7cb6Nwz5hf4EZZ6WmlJp72peJwg
         GfeQ==
X-Gm-Message-State: AOAM533a7C5SgD0kkBoNAm1D2tWlmvz99K9fe928QPAlVtPImF+rpPHU
        BdeeNGxPtp2Qg2bogXmCROKk5GPNUlG4pIMP7Nf0gw==
X-Google-Smtp-Source: ABdhPJwAX7+5Wwn+znXFplPosCyPSFjkzIWgHud87aLAUj30hleU6A5IJPz+2cEX/Vv3IWQMhgNL3kSdhdw9lTeYWao=
X-Received: by 2002:a62:75c6:0:b029:18a:d510:ff60 with SMTP id
 q189-20020a6275c60000b029018ad510ff60mr2906568pfc.35.1605288494319; Fri, 13
 Nov 2020 09:28:14 -0800 (PST)
MIME-Version: 1.0
References: <202011131146.g8dPLQDD-lkp@intel.com>
In-Reply-To: <202011131146.g8dPLQDD-lkp@intel.com>
From:   =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Date:   Fri, 13 Nov 2020 09:28:03 -0800
Message-ID: <CAFP8O3LpSmxVnjHfQAN455k1ZRg3PbgZYhWr030evCq1T10k=Q@mail.gmail.com>
Subject: Re: Error: invalid switch -me200
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 7:22 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Fangrui,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   585e5b17b92dead8a3aca4e3c9876fbca5f7e0ba
> commit: ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51 Makefile: Fix GCC_TOOLCHAIN_DIR prefix for Clang cross compilation
> date:   4 months ago
> config: powerpc-randconfig-r031-20201113 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 9e0c35655b6e8186baef8840b26ba4090503b554)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ca9b31f6bb9c6aa9b4e5f0792f39a97bbffb8c51
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    Assembler messages:
> >> Error: invalid switch -me200
> >> Error: unrecognized option -me200
>    clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
>    make[2]: *** [scripts/Makefile.build:281: scripts/mod/empty.o] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [Makefile:1174: prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [Makefile:185: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

This can be ignored. The LLVM integrated assembler does not recognize
-me200 (-Wa,-me200 in arch/powerpc/Makefile). I guess the GNU as -m
option is similar to .arch or .machine and controls what instructions
are recognized. The integrated assembler tends to support all
instructions (conditional supporting some instructions has some
challenges; in the end I have patched parsing but ignoring `.arch` for
x86-64 and ignoring `.machine ppc64` for ppc64)

(In addition, e200 is a 32-bit Power ISA microprocessor. 32-bit
support may get less attention in LLVM.)
