Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7552DEE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgLSKcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:32:47 -0500
Received: from mga18.intel.com ([134.134.136.126]:24574 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726439AbgLSKcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:32:46 -0500
IronPort-SDR: j/BktqPWDktObC4tJnmG/KwjY+qQzMeKN0ZZq106YJGFHwCZGBkhNOOGLpMPBZiWiLBLlAWIxM
 NYt17UiO8Bsg==
X-IronPort-AV: E=McAfee;i="6000,8403,9839"; a="163294823"
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="163294823"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2020 02:32:04 -0800
IronPort-SDR: 0Vk6DnzCEgMJUC14Rkbz3sbP3QUlB+L283iLLTfJNPL8v9rnVnD3q9qCcCK2FeSgq95ma6NhdH
 mwWsUSa8UocQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,433,1599548400"; 
   d="scan'208";a="339576751"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga003.jf.intel.com with ESMTP; 19 Dec 2020 02:32:02 -0800
Date:   Sat, 19 Dec 2020 18:28:20 +0800
From:   Philip Li <philip.li@intel.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [kbuild-all] Re: [linux-next:master 13538/13785]
 /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'
Message-ID: <20201219102820.GA14085@intel.com>
References: <202012191403.y8Aomjpm-lkp@intel.com>
 <20201219075606.GA20870@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201219075606.GA20870@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 19, 2020 at 08:56:06AM +0100, Pavel Machek wrote:
> Crazy robot, stop spamming. This report is obviously bogus, yet, you
> sent me 5 copies.
Thanks Pavel for input, sorry for the false positive. It tries to
bisect error like below (the new error), but it may be related to
assember support. We will adjust the system to not report this out
wrongly. Kindly allow some time for us to resolving this.

> > >> /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'

Thanks

> 
> Whoever is responsible for this, please sign emails with your real
> name!
> 
> 								Pavel
> 
> 
> On Sat 2020-12-19 14:19:16, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   0d52778b8710eb11cb616761a02aee0a7fd60425
> > commit: f08fdc654a5940aa23259e1ed53ab0f401ca7068 [13538/13785] leds: ss4200: simplify the return expression of register_nasgpio_led()
> > config: riscv-randconfig-r014-20201217 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install riscv cross compiling tool for clang build
> >         # apt-get install binutils-riscv64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=f08fdc654a5940aa23259e1ed53ab0f401ca7068
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout f08fdc654a5940aa23259e1ed53ab0f401ca7068
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > Note: the linux-next/master HEAD 0d52778b8710eb11cb616761a02aee0a7fd60425 builds fine.
> >       It may have been fixed somewhere.
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:564:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            return inw(addr);
> >                   ^~~~~~~~~
> >    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'
> >    #define inw(c)          ({ u16 __v; __io_pbr(); __v = readw_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >                                                                            ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_cpu'
> >    #define readw_cpu(c)            ({ u16 __r = le16_to_cpu((__force __le16)__raw_readw(c)); __r; })
> >                                                                                         ^
> >    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded from macro '__le16_to_cpu'
> >    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
> >                                                      ^
> >    In file included from drivers/video/fbdev/metronomefb.c:28:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            return inl(addr);
> >                   ^~~~~~~~~
> >    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
> >    #define inl(c)          ({ u32 __v; __io_pbr(); __v = readl_cpu((void*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
> >                                                                            ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_cpu'
> >    #define readl_cpu(c)            ({ u32 __r = le32_to_cpu((__force __le32)__raw_readl(c)); __r; })
> >                                                                                         ^
> >    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__le32_to_cpu'
> >    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
> >                                                      ^
> >    In file included from drivers/video/fbdev/metronomefb.c:28:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outb(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
> >    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb_cpu'
> >    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
> >                                                              ^
> >    In file included from drivers/video/fbdev/metronomefb.c:28:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outw(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
> >    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew_cpu'
> >    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_to_le16(v), (c)))
> >                                                                                      ^
> >    In file included from drivers/video/fbdev/metronomefb.c:28:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            outl(value, addr);
> >            ^~~~~~~~~~~~~~~~~
> >    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
> >    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBASE + (c))); __io_paw(); })
> >                                                                  ~~~~~~~~~~ ^
> >    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel_cpu'
> >    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
> >                                                                                      ^
> >    In file included from drivers/video/fbdev/metronomefb.c:28:
> >    In file included from include/linux/interrupt.h:11:
> >    In file included from include/linux/hardirq.h:10:
> >    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
> >    In file included from include/asm-generic/hardirq.h:17:
> >    In file included from include/linux/irq.h:20:
> >    In file included from include/linux/io.h:13:
> >    In file included from arch/riscv/include/asm/io.h:149:
> >    include/asm-generic/io.h:1005:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
> >            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
> >                                                      ~~~~~~~~~~ ^
> >    7 warnings generated.
> >    /tmp/metronomefb-846872.s: Assembler messages:
> > >> /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a2'
> > >> /tmp/metronomefb-846872.s:313: Error: unrecognized opcode `zext.b a5,a6'
> > >> /tmp/metronomefb-846872.s:350: Error: unrecognized opcode `zext.b a3,a3'
> > >> /tmp/metronomefb-846872.s:371: Error: unrecognized opcode `zext.b a4,a4'
> >    /tmp/metronomefb-846872.s:409: Error: unrecognized opcode `zext.b a2,a2'
> > >> /tmp/metronomefb-846872.s:433: Error: unrecognized opcode `zext.b s1,t1'
> > >> /tmp/metronomefb-846872.s:521: Error: unrecognized opcode `zext.b a1,a1'
> >    clang-12: error: assembler command failed with exit code 1 (use -v to see invocation)
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> -- 
> http://www.livejournal.com/~pavelmachek



> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

