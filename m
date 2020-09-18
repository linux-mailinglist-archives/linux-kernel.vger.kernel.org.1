Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B892705AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgIRTjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgIRTjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:39:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09082C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:39:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s14so4654189pju.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugDHAjreJcjr2sWmhzBxhqb0r9L38OJhgw/SK5/hXcA=;
        b=MMijeS5iSCBD6TdcsROq3wTBNGom0mymBli3Y7GoxookncCyXLPhiCD1hGXMM0OPi5
         FseDWPW8AhtFzulUwDfOV2C3xvDwwnImE4cEeDboLKnfr5d0EoqWPWaiBKAtg9etgxJ1
         QsnrQSM3hWlZXg8UiHNO4ulb7iMZt/9OiWq3v38GuXw68fRaJ2bKNZWfI61k64ntRwZf
         uzPs70jvLCyw0j05qFjWEogD5N0tr2ki5DrGgtt/3hABsWDoXC1CkjoQAc0IsqUrG0bC
         LACfKgVvIhbxEGYIP5RFTiKMGlbl71EUpNLtn63mpCgEKqp3RqIyxU20U5v4ocLq8a11
         8OFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugDHAjreJcjr2sWmhzBxhqb0r9L38OJhgw/SK5/hXcA=;
        b=pxSrW0XnkwcoGBHXZ8BtBs+Zb4xhiyGUll5OFhlhmIqJpgoENLA8/Nxk4+4qQnYy5e
         Dzit+GIbsY6afGMPYu9Av3EyEGZ/fHCORCUHdakXJLxFOUWBFL8A3GinrJGnwNjsh8rb
         sX0viGJKfYA6gWG5VvLqKxlihCZf8LI+HJv8cNROA3ZWPLpZvW3lVp+U+4god5nyeZkV
         0DVqrS6p9EvKcw1hs7lVSjPCwZ8rx+cnL+rFJQWqikb7erRGmBdhOygRaoSiMdhYc2b+
         YvLDrJt67ct6DUO+fPOQ3dq2zihuLSaerdcY1AMwxWLyjt63UThubLzeRMnxs5oqwgQO
         /1fQ==
X-Gm-Message-State: AOAM531i6npd7BdK2vJFvGAejGSYwcRdy0ffPpZjj6xPHgIs05H7XoYS
        rL7lqgj6qbSN74kpTwuzTG5QOwlGtGPPBfAnjP7rHw==
X-Google-Smtp-Source: ABdhPJyuTQ6eWHseHu6pz8Fdfd7MU+vsvAbZLf6HZw27l+sY0R/11CACwcB2ADGtOmcQ/AT2rgvgSVZPcMhDmT/R5Yo=
X-Received: by 2002:a17:90b:f18:: with SMTP id br24mr1807074pjb.32.1600457977854;
 Fri, 18 Sep 2020 12:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200916071950.1493-3-gilad@benyossef.com> <202009162154.fxQ0Z6wT%lkp@intel.com>
 <CAOtvUMdv9QNVdaU7N6wJVq27Asyrckuu9bf15fO=+oZUh5iKOg@mail.gmail.com>
In-Reply-To: <CAOtvUMdv9QNVdaU7N6wJVq27Asyrckuu9bf15fO=+oZUh5iKOg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Sep 2020 12:39:26 -0700
Message-ID: <CAKwvOdmW+n_g4C_pXnF+8wh2q0gZZyXAfaYR9cVNm3p1QeJ-xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: ccree - add custom cache params from DT file
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     kernel test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Network Development <netdev@vger.kernel.org>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 12:20 AM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>
> hmm...
>
> On Wed, Sep 16, 2020 at 4:48 PM kernel test robot <lkp@intel.com> wrote:
> >
> > url:    https://github.com/0day-ci/linux/commits/Gilad-Ben-Yossef/add-optional-cache-params-from-DT/20200916-152151
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
> > config: arm64-randconfig-r015-20200916 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 9e3842d60351f986d77dfe0a94f76e4fd895f188)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/crypto/ccree/cc_driver.c:120:18: warning: result of comparison of constant 18446744073709551615 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
> >            cache_params |= FIELD_PREP(mask, val);
> >                            ^~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:94:3: note: expanded from macro 'FIELD_PREP'
> >                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
> >                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:52:28: note: expanded from macro '__BF_FIELD_CHECK'
> >                    BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,         \
> >                    ~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BUG_ON_MSG'
> >    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> >    include/linux/compiler_types.h:319:22: note: expanded from macro 'compiletime_assert'
> >            _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:307:23: note: expanded from macro '_compiletime_assert'
> >            __compiletime_assert(condition, msg, prefix, suffix)
> >            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:299:9: note: expanded from macro '__compiletime_assert'
> >                    if (!(condition))                                       \
> >                          ^~~~~~~~~
>
> I am unable to understand this warning. It looks like it is
> complaining about a FIELD_GET sanity check that is always false, which
> makes sense since we're using a constant.
>
> Anyone can enlighten me if I've missed something?

Looked at some of this code recently.  I think it may have an issue
for masks where sizeof(mask) < sizeof(unsigned long long).

In your code, via 0day bot:

   107          u32 cache_params, ace_const, val, mask;
...
> 120          cache_params |= FIELD_PREP(mask, val);

then in include/linux/bitfield.h, we have:

 92 #define FIELD_PREP(_mask, _val)           \
 93   ({                \
 94     __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");  \

 44 #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)     \
...
 52     BUILD_BUG_ON_MSG((_mask) > (typeof(_reg))~0ull,   \
 53          _pfx "type of reg too small for mask"); \

so the 0ULL in FIELD_PREP is important.  In __BF_FIELD_CHECK, the
typeof(_reg) is unsigned long long (because 0ULL was passed).  So we
have a comparison between a u32 and a u64; indeed any u32 can never be
greater than a u64 that we know has the value of ULLONG_MAX.

I did send a series splitting these up, I wonder if they'd help here:
https://lore.kernel.org/lkml/20200708230402.1644819-3-ndesaulniers@google.com/
-- 
Thanks,
~Nick Desaulniers
