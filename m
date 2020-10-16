Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE329007C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:06:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405287AbgJPJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404570AbgJPJGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:06:08 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4087720723;
        Fri, 16 Oct 2020 09:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602839167;
        bh=iHh+KLBBt7BpsQXhiDYwxCEnjCkkHel4kb+7focSrbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3w1uo9SLvhJ0kVnSAuSMBb2BIQtE7gIYT++5rzDRWaKfEv8OS9w6/xrSz/Kz4yiX
         3Vqrq3cjqmPmB6st78wiqi7C+fISQGevw4oPnmfmdwSIunft1OOPo6ICDS3po8AmaY
         z3iM/BLOdutEMU/CrfUCCNNf+oXFLh7p/DPQRQWQ=
Date:   Fri, 16 Oct 2020 11:06:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jann Horn <jannh@google.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org, kbuild-all@lists.01.org,
        Martijn Coenen <maco@android.com>,
        kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-stable-rc:linux-5.4.y 665/2391]
 drivers/android/binder.c:3776: Error: unrecognized keyword/register name
 `l.lwz
Message-ID: <20201016090638.GA1749385@kroah.com>
References: <202010160523.r8yMbvrW-lkp@intel.com>
 <CAG48ez3VixjDrMnz6+7JjGW_ZLZCD4+dTYWUD_tNOcfEfpu1Bg@mail.gmail.com>
 <CAAfxs77_h-DHOMFCJBWMuj1H5Rj8OiqC_U1Trs3A8gNCiPvo7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfxs77_h-DHOMFCJBWMuj1H5Rj8OiqC_U1Trs3A8gNCiPvo7w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 08:05:17AM +0900, Stafford Horne wrote:
> On Fri, Oct 16, 2020, 6:46 AM Jann Horn <jannh@google.com> wrote:
> 
> > +openrisc folks
> >
> > On Thu, Oct 15, 2020 at 11:28 PM kernel test robot <lkp@intel.com> wrote:
> > > tree:
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-5.4.y
> > > head:   85b0841aab15c12948af951d477183ab3df7de14
> > > commit: c5665cafbedd2e2a523fe933e452391a02d3adb3 [665/2391] binder:
> > Prevent context manager from incrementing ref 0
> > > config: openrisc-randconfig-r002-20201014 (attached as .config)
> > > compiler: or1k-linux-gcc (GCC) 9.3.0
> > > reproduce (this is a W=1 build):
> > >         wget
> > https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> > -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         #
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=c5665cafbedd2e2a523fe933e452391a02d3adb3
> > >         git remote add linux-stable-rc
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > >         git fetch --no-tags linux-stable-rc linux-5.4.y
> > >         git checkout c5665cafbedd2e2a523fe933e452391a02d3adb3
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross
> > ARCH=openrisc
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/android/binder.c: Assembler messages:
> > > >> drivers/android/binder.c:3776: Error: unrecognized keyword/register
> > name `l.lwz ?ap,4(r25)'
> > >    drivers/android/binder.c:3781: Error: unrecognized keyword/register
> > name `l.addi ?ap,r0,0'
> >
> > binder is basically doing this:
> >
> > u64 data_ptr;
> > if (get_user(data_ptr, (u64 __user *)ptr))
> >   return -EFAULT;
> >
> > and GCC complains that that doesn't turn into valid assembly on
> > openrisc, where get_user() of size 8 expands into this:
> >
> > #define __get_user_asm2(x, addr, err)                   \
> > {                                                       \
> >         unsigned long long __gu_tmp;                    \
> >         __asm__ __volatile__(                           \
> >                 "1:     l.lwz %1,0(%2)\n"               \
> >                 "2:     l.lwz %H1,4(%2)\n"              \
> >                 "3:\n"                                  \
> >                 ".section .fixup,\"ax\"\n"              \
> >                 "4:     l.addi %0,r0,%3\n"              \
> >                 "       l.addi %1,r0,0\n"               \
> >                 "       l.addi %H1,r0,0\n"              \
> >                 "       l.j 3b\n"                       \
> >                 "       l.nop\n"                        \
> >                 ".previous\n"                           \
> >                 ".section __ex_table,\"a\"\n"           \
> >                 "       .align 2\n"                     \
> >                 "       .long 1b,4b\n"                  \
> >                 "       .long 2b,4b\n"                  \
> >                 ".previous"                             \
> >                 : "=r"(err), "=&r"(__gu_tmp)            \
> >                 : "r"(addr), "i"(-EFAULT), "0"(err));   \
> >         (x) = (__typeof__(*(addr)))(                    \
> >                 (__typeof__((x)-(x)))__gu_tmp);         \
> > }
> >
> > and apparently the "l.lwz %H1,4(%2)" and "l.addi %H1,r0,0" don't turn
> > into valid assembly when %H1 expands to "?ap"?
> >
> > I don't know anything about OpenRISC, but this seems like it's
> > probably an issue in the get_user() implementation.
> >
> 
> This is fixed in 5.9.  I think the patch can be cherry picked by itself.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/openrisc?h=v5.9&id=d877322bc1adcab9850732275670409e8bcca4c4

Does not apply cleanly to 5.8.y or 5.4.y, can someone please properly
backport it and send it to stable@vger.kernel.org?

thanks,

greg k-h
