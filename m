Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D99F2F4148
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbhAMBkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbhAMBku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:40:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590A3C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:40:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c22so417492pgg.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 17:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0c6HHoktXki3GZbMqs3WroLaVoqrCxFNA0EKtNCuyI=;
        b=bmfJtT5Ab3iuEMPkkGQIC6QXCxOJRTnNRr15T3O0NkEyhaOqKve4fLbPntIVv6Y9f9
         NWRIQH6dswLJYLp6XA7ztbbGjZhcUgdS/OOhHo2zpVJroaWxcnqcU2YEwX75RnPO1/ii
         k2pQLuOXd+yjpPP6EnndoEhHu39lgQE0AtjrYXpZvJkR7CJO+bN06vHoRTtqd68wN/qk
         LN+8w3ZdRLcLaYWvwqhODiNZmlVmaMgczsMsUF2WT17oK5jb2Nv00cn+fDStkxdCTK1a
         kLqfYGvizIgy+Dg55HlIYMPBdc1mDflB68VMAtZ3GBTlE+Pi51t6U8rCKkEqCIhoTL2Y
         4fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0c6HHoktXki3GZbMqs3WroLaVoqrCxFNA0EKtNCuyI=;
        b=HMjqv1H0iKNSEgvBX8Mwgz1C5gnJMtYsbIHce70k/RSpIXK2WvSkdJbyanvyoCTFji
         IiUn4fXj7JJHFjmMJGupB3RpYdFAMjSmSeADxQYTfXyZiWCIjDbFEr2eEKa6Jh9V/Gjg
         6NvSHplvdUm1eq4gGjmfhkrhgrRonFkJQkWqzRF8xJDkRI19+CIR4haJ9zZD6mP0EPN8
         7B5CZHtF+tgY/SoUFZq6g/vX0tTM+wN/7YqyTSD/BSnjXyvuzW/g3TIUZTTS18pJ0VtN
         V7oY8yu0SQ8ArGyVTGkeBaasZhxFytMiarEN/3t3REw2VOSsqspOOJ05KTm/yNySkMP9
         1PqA==
X-Gm-Message-State: AOAM530ZAaFBjCI1Vd9EHnfHJPsUc6Ho+7w53eGqMWTqRWH1qYMIQBAM
        uWXhVzZpIJTlTUBhC6Dz5yZVGoZ0x62nVaxnqY22SQ==
X-Google-Smtp-Source: ABdhPJyw6Mz+MPpx9tD2Z77Xsr6+ygudw61mE7415SNo1Ix7CMwzPxpla3/gtO13mI9AMuHLfPL8nqGo/ir2++CbxhI=
X-Received: by 2002:a63:1142:: with SMTP id 2mr1905914pgr.263.1610502009086;
 Tue, 12 Jan 2021 17:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20210112205542.1375847-1-natechancellor@gmail.com>
 <202101130859.JSORPQUn-lkp@intel.com> <20210113013130.GA3446359@ubuntu-m3-large-x86>
In-Reply-To: <20210113013130.GA3446359@ubuntu-m3-large-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 12 Jan 2021 17:39:57 -0800
Message-ID: <CAKwvOdnx99YTGhP-mH-9E6YTLLUfauuteFtqZSeXLv5Vy+XowA@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Implement __ubsan_handle_alignment_assumption
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 5:31 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 08:39:52AM +0800, kernel test robot wrote:
> > Hi Nathan,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on 7c53f6b671f4aba70ff15e1b05148b10d58c2837]
> >
> > url:    https://github.com/0day-ci/linux/commits/Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
> > base:    7c53f6b671f4aba70ff15e1b05148b10d58c2837
> > config: arm64-randconfig-r031-20210112 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 32bcfcda4e28375e5a85268d2acfabcfcc011abf)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://github.com/0day-ci/linux/commit/775adad26a60878926c0ee6cd460a1375bbe51e6
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Nathan-Chancellor/ubsan-Implement-__ubsan_handle_alignment_assumption/20210113-055714
> >         git checkout 775adad26a60878926c0ee6cd460a1375bbe51e6
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> >    lib/ubsan.c:192:6: warning: no previous prototype for function '__ubsan_handle_add_overflow' [-Wmissing-prototypes]
> >    void __ubsan_handle_add_overflow(void *data,
> >         ^
> >    lib/ubsan.c:192:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    void __ubsan_handle_add_overflow(void *data,
> >    ^
> >    static
> >    lib/ubsan.c:200:6: warning: no previous prototype for function '__ubsan_handle_sub_overflow' [-Wmissing-prototypes]
> >    void __ubsan_handle_sub_overflow(void *data,
> >         ^
> >    lib/ubsan.c:200:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> >    void __ubsan_handle_sub_overflow(void *data,
> >    ^
>
> Given that these are compiler inserted functions, there is not much of a
> point to having prototypes to them. If people feel shutting these
> warnings up is worthwhile, we can just add the prototypes right above
> the function definition in a follow up patch.

Same as stpcpy; it would be nice though. ;)
-- 
Thanks,
~Nick Desaulniers
