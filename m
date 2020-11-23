Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77222C13D4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 20:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbgKWSoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732920AbgKWSoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:44:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885F8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:44:08 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id v21so15093135pgi.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BWpJZTEbYYqdTndkJGPxB+inYZkPNeNKjK+AcWxClLU=;
        b=szQM99MUWB2Wyul7qI32qwELH8rheFKKRFflNwGL7g4nXUIC5bTWgygJQzT0i/fHHD
         +g3epirl+0GuU3lZ74ypvWJeJazqafDOMzGurj+nkGrGvHqZ/+k+0srsVKsL4FsddWW9
         Qg6XfRAmi+lWJkaOuZTtNRMcKgV/mbhjPqQ17XPq/MA2JxbU3dfJB1KOEsdYtFbfGhDD
         8w+Wo6JTUuVMLyV2aRdA8Bg3DNapR4F31XhD9143jJ0mHWeU0t296sJCVMYNU3UwKtz7
         /8Dx4VTrt6uv4+cn4nJtFHn6zQqmdeoXbVzL4JOvEUXY0pEgPk0Y8/Qq9g9mZBadSOE2
         7LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BWpJZTEbYYqdTndkJGPxB+inYZkPNeNKjK+AcWxClLU=;
        b=NFMw/tcZvAuLw6631BdZfq8IRn365ZWY/CN8nd0zBybKssTMc1JbUmA/WjUxiuLDMH
         HA6CFB/g9yKPLEzTgVv8gvfE5lz+0MK4q0aiG+lUthtCuz6V9PUuom2GyfiM/1lyql4/
         O+o9etBsIw/7nRxRZk3GtJBZPZroU+1yY/YFWXHfS7Vezfo+79WC45ZnaUsk39iuPJmc
         YQj5JPSircAwlF4uQSWtlwlDaNcuY2LICtbeixKAQSQp31k6F0FkU+6ijlGnk6BBdqN0
         ESV9DkDBASKrJKsM0epADX7Y+amlY+aBBrZn6n5sUGH1+LokxTAuMNIQQERge5TaOn+O
         4Ijw==
X-Gm-Message-State: AOAM531ZilKESxdBDZDptUmo+uxmohMjbRyxFdV5Yl3p1WuyvXg48TIe
        MvFkVcWdSwE4hqvucb9mc6renoo9datxsJ3Zns/trQ==
X-Google-Smtp-Source: ABdhPJzV7WgvUGjMsCL5eGYFxkRo9Z74P6af+WKqtJyjDvYYktlRIpjd8mQJ7obwSmcgVAT6r6NWwRH0BBh0hokJBAw=
X-Received: by 2002:a17:90a:d250:: with SMTP id o16mr262028pjw.25.1606157047928;
 Mon, 23 Nov 2020 10:44:07 -0800 (PST)
MIME-Version: 1.0
References: <202011220213.McOuf9IB-lkp@intel.com>
In-Reply-To: <202011220213.McOuf9IB-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Nov 2020 10:43:56 -0800
Message-ID: <CAKwvOdmWEhR3EBaCv+ErbnRbtRbLMh3upWdCVE2U3js9ORvypg@mail.gmail.com>
Subject: Re: arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit
 declaration of function 'barrier'
To:     kernel test robot <lkp@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy's fix got picked up:
https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=fixes&id=f52c08ea5fc8e2057a5913b1f6bfd534e1fb7e4c

We're going to need to ensure that this gets backported to stable along with
commit: 3347acc6fcd4ee71ad18a9ff9d9dac176b517329 compiler.h: fix
barrier_data() on clang

On Sat, Nov 21, 2020 at 10:39 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27bba9c532a8d21050b94224ffd310ad0058c353
> commit: 3347acc6fcd4ee71ad18a9ff9d9dac176b517329 compiler.h: fix barrier_data() on clang
> date:   7 days ago
> config: riscv-randconfig-r003-20201121 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3347acc6fcd4ee71ad18a9ff9d9dac176b517329
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 3347acc6fcd4ee71ad18a9ff9d9dac176b517329
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/vdso/processor.h:10,
>                     from arch/riscv/include/asm/processor.h:11,
>                     from include/linux/prefetch.h:15,
>                     from drivers/net/ethernet/intel/ixgb/ixgb_main.c:6:
>    arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> >> arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>       14 |  barrier();
>          |  ^~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/barrier +14 arch/riscv/include/asm/vdso/processor.h
>
> ad5d1122b82fbd6 Vincent Chen 2020-06-09   6
> ad5d1122b82fbd6 Vincent Chen 2020-06-09   7  static inline void cpu_relax(void)
> ad5d1122b82fbd6 Vincent Chen 2020-06-09   8  {
> ad5d1122b82fbd6 Vincent Chen 2020-06-09   9  #ifdef __riscv_muldiv
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  10     int dummy;
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  11     /* In lieu of a halt instruction, induce a long-latency stall. */
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  12     __asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  13  #endif
> ad5d1122b82fbd6 Vincent Chen 2020-06-09 @14     barrier();
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  15  }
> ad5d1122b82fbd6 Vincent Chen 2020-06-09  16
>
> :::::: The code at line 14 was first introduced by commit
> :::::: ad5d1122b82fbd6a816d1b9d26ee01a6dbc2d757 riscv: use vDSO common flow to reduce the latency of the time-related functions
>
> :::::: TO: Vincent Chen <vincent.chen@sifive.com>
> :::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
