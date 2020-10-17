Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BBC291496
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 23:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439403AbgJQVII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438883AbgJQVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 17:08:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA4C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:08:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gm14so3185727pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Afuvd5tYEuIGX29FPIX8HAyz/uSeVVIbO3aOtE6/tkk=;
        b=KL1NZ2m/Mb71Ey60exoi5XqZDkw801cPbWo3qu+sAYZpfpSJB0Fww83P7CJvw494by
         Qnz3p07JSzPk4bO8U/pSX30fnAs0z+sySmgd8rpvv3MrlHH5XI9BiWOitIiJmVIT7ziI
         7juapN0enA6M49th3+DGI9SAj2mIAd7yRgv1cPxPA5xRGZVXOGsLJeSnvsVdHb7mkZ2w
         CIgfiJQAZQ1qwXeka1BrC0Z8n+x62XIXWXhZKS22EHtELGN/2EcCJa0BcQSS/DYJabu0
         VdQiipwCn9vjrk0eLfQJKgfZArhvCuax8Or/yZRuF4o6j8rnBBMxS3l4vOXPA/z1u2uQ
         Xahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Afuvd5tYEuIGX29FPIX8HAyz/uSeVVIbO3aOtE6/tkk=;
        b=GZmNdLbDZSfySil9ZP6JCjPEBjEC/Rl/Ydf1U4fH0stqQxGvXWGZnahJ4kVYElhr7A
         9NmGWFE3d0T6JcL3Cye70hrdrHBcggw35oXZApDV/2sJCGtJvUfwXn/tQR4FWcucG8AW
         t5wd7vY6eXRjXbtsy6QP4lcMHaJXYk6y73P7WvRVsFhgb99Gq1RNOFna3hKoBsd1F7MX
         TeqxoG+/NMvBS6me74eXHK1eDffQQKNm9dj8fOXyQY9suK4murBPU/857m1E1XlP3M1g
         Z5CfwGRqjRgysVs3d+zs3YYJn8Q25txEXVMj7EIT9N7E2ODisq8x7PbMTj/ebTpdTNT7
         UMhg==
X-Gm-Message-State: AOAM531K9mQQ5VMW+C/9DyFF8OnUnj/NTIcuWUHH00WW1xOe2rRkaGtN
        fwSEOXfdDdgWuPUxMliJ5+0=
X-Google-Smtp-Source: ABdhPJyWypIVAGt+gcH8h9ZJDxvO2DokBNBEsu8JSgzRl4tndlE/s7HVzdE6+OeZQQHGbrIEGXaT4Q==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id u14mr10236605pjr.112.1602968887781;
        Sat, 17 Oct 2020 14:08:07 -0700 (PDT)
Received: from localhost (g167.58-98-146.ppp.wakwak.ne.jp. [58.98.146.167])
        by smtp.gmail.com with ESMTPSA id e16sm8035580pjr.36.2020.10.17.14.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 14:08:07 -0700 (PDT)
Date:   Sun, 18 Oct 2020 06:08:04 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jann Horn <jannh@google.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, kbuild-all@lists.01.org,
        Martijn Coenen <maco@android.com>,
        kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-stable-rc:linux-5.4.y 665/2391]
 drivers/android/binder.c:3776: Error: unrecognized keyword/register name
 `l.lwz
Message-ID: <20201017210804.GC2512402@lianli.shorne-pla.net>
References: <202010160523.r8yMbvrW-lkp@intel.com>
 <CAG48ez3VixjDrMnz6+7JjGW_ZLZCD4+dTYWUD_tNOcfEfpu1Bg@mail.gmail.com>
 <CAAfxs77_h-DHOMFCJBWMuj1H5Rj8OiqC_U1Trs3A8gNCiPvo7w@mail.gmail.com>
 <20201016090638.GA1749385@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016090638.GA1749385@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 11:06:38AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Oct 16, 2020 at 08:05:17AM +0900, Stafford Horne wrote:
> > On Fri, Oct 16, 2020, 6:46 AM Jann Horn <jannh@google.com> wrote:
> > 
> > > +openrisc folks
> > >
> > > On Thu, Oct 15, 2020 at 11:28 PM kernel test robot <lkp@intel.com> wrote:
> > > > tree:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > linux-5.4.y
> > > > head:   85b0841aab15c12948af951d477183ab3df7de14
> > > > commit: c5665cafbedd2e2a523fe933e452391a02d3adb3 [665/2391] binder:
> > > Prevent context manager from incrementing ref 0
> > > > config: openrisc-randconfig-r002-20201014 (attached as .config)
> > > > compiler: or1k-linux-gcc (GCC) 9.3.0
> > > > reproduce (this is a W=1 build):
> > > >         wget
> > > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > > -O ~/bin/make.cross
> > > >         chmod +x ~/bin/make.cross
> > > >         #
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c5665cafbedd2e2a523fe933e452391a02d3adb3
> > > >         git remote add linux-stable-rc
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > > >         git fetch --no-tags linux-stable-rc linux-5.4.y
> > > >         git checkout c5665cafbedd2e2a523fe933e452391a02d3adb3
> > > >         # save the attached .config to linux build tree
> > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> > > ARCH=openrisc
> > > >
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > All errors (new ones prefixed by >>):
> > > >
> > > >    drivers/android/binder.c: Assembler messages:
> > > > >> drivers/android/binder.c:3776: Error: unrecognized keyword/register
> > > name `l.lwz ?ap,4(r25)'
> > > >    drivers/android/binder.c:3781: Error: unrecognized keyword/register
> > > name `l.addi ?ap,r0,0'
> > >
> > > binder is basically doing this:
> > >
> > > u64 data_ptr;
> > > if (get_user(data_ptr, (u64 __user *)ptr))
> > >   return -EFAULT;
> > >
> > > and GCC complains that that doesn't turn into valid assembly on
> > > openrisc, where get_user() of size 8 expands into this:
> > >
> > > #define __get_user_asm2(x, addr, err)                   \
> > > {                                                       \
> > >         unsigned long long __gu_tmp;                    \
> > >         __asm__ __volatile__(                           \
> > >                 "1:     l.lwz %1,0(%2)\n"               \
> > >                 "2:     l.lwz %H1,4(%2)\n"              \
> > >                 "3:\n"                                  \
> > >                 ".section .fixup,\"ax\"\n"              \
> > >                 "4:     l.addi %0,r0,%3\n"              \
> > >                 "       l.addi %1,r0,0\n"               \
> > >                 "       l.addi %H1,r0,0\n"              \
> > >                 "       l.j 3b\n"                       \
> > >                 "       l.nop\n"                        \
> > >                 ".previous\n"                           \
> > >                 ".section __ex_table,\"a\"\n"           \
> > >                 "       .align 2\n"                     \
> > >                 "       .long 1b,4b\n"                  \
> > >                 "       .long 2b,4b\n"                  \
> > >                 ".previous"                             \
> > >                 : "=r"(err), "=&r"(__gu_tmp)            \
> > >                 : "r"(addr), "i"(-EFAULT), "0"(err));   \
> > >         (x) = (__typeof__(*(addr)))(                    \
> > >                 (__typeof__((x)-(x)))__gu_tmp);         \
> > > }
> > >
> > > and apparently the "l.lwz %H1,4(%2)" and "l.addi %H1,r0,0" don't turn
> > > into valid assembly when %H1 expands to "?ap"?
> > >
> > > I don't know anything about OpenRISC, but this seems like it's
> > > probably an issue in the get_user() implementation.
> > >
> > 
> > This is fixed in 5.9.  I think the patch can be cherry picked by itself.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/openrisc?h=v5.9&id=d877322bc1adcab9850732275670409e8bcca4c4
> 
> Does not apply cleanly to 5.8.y or 5.4.y, can someone please properly
> backport it and send it to stable@vger.kernel.org?

I will do it.

-Stafford
