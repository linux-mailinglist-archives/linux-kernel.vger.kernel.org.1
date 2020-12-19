Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD9D92DEDCA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 08:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgLSH5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 02:57:07 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42248 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgLSH5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 02:57:06 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2CE5A1C0B77; Sat, 19 Dec 2020 08:56:08 +0100 (CET)
Date:   Sat, 19 Dec 2020 08:56:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel test robot <lkp@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [linux-next:master 13538/13785] /tmp/metronomefb-846872.s:300:
 Error: unrecognized opcode `zext.b a2,a2'
Message-ID: <20201219075606.GA20870@amd>
References: <202012191403.y8Aomjpm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <202012191403.y8Aomjpm-lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Crazy robot, stop spamming. This report is obviously bogus, yet, you
sent me 5 copies.

Whoever is responsible for this, please sign emails with your real
name!

								Pavel


On Sat 2020-12-19 14:19:16, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.g=
it master
> head:   0d52778b8710eb11cb616761a02aee0a7fd60425
> commit: f08fdc654a5940aa23259e1ed53ab0f401ca7068 [13538/13785] leds: ss42=
00: simplify the return expression of register_nasgpio_led()
> config: riscv-randconfig-r014-20201217 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1=
e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
=2Egit/commit/?id=3Df08fdc654a5940aa23259e1ed53ab0f401ca7068
>         git remote add linux-next https://git.kernel.org/pub/scm/linux/ke=
rnel/git/next/linux-next.git
>         git fetch --no-tags linux-next master
>         git checkout f08fdc654a5940aa23259e1ed53ab0f401ca7068
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross AR=
CH=3Driscv=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> Note: the linux-next/master HEAD 0d52778b8710eb11cb616761a02aee0a7fd60425=
 builds fine.
>       It may have been fixed somewhere.
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:564:9: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return inw(addr);
>                   ^~~~~~~~~
>    arch/riscv/include/asm/io.h:56:76: note: expanded from macro 'inw'
>    #define inw(c)          ({ u16 __v; __io_pbr(); __v =3D readw_cpu((voi=
d*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>                                                                          =
  ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:88:76: note: expanded from macro 'readw_=
cpu'
>    #define readw_cpu(c)            ({ u16 __r =3D le16_to_cpu((__force __=
le16)__raw_readw(c)); __r; })
>                                                                          =
               ^
>    include/uapi/linux/byteorder/little_endian.h:36:51: note: expanded fro=
m macro '__le16_to_cpu'
>    #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>                                                      ^
>    In file included from drivers/video/fbdev/metronomefb.c:28:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:572:9: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return inl(addr);
>                   ^~~~~~~~~
>    arch/riscv/include/asm/io.h:57:76: note: expanded from macro 'inl'
>    #define inl(c)          ({ u32 __v; __io_pbr(); __v =3D readl_cpu((voi=
d*)(PCI_IOBASE + (c))); __io_par(__v); __v; })
>                                                                          =
  ~~~~~~~~~~ ^
>    arch/riscv/include/asm/mmio.h:89:76: note: expanded from macro 'readl_=
cpu'
>    #define readl_cpu(c)            ({ u32 __r =3D le32_to_cpu((__force __=
le32)__raw_readl(c)); __r; })
>                                                                          =
               ^
>    include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded fro=
m macro '__le32_to_cpu'
>    #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>                                                      ^
>    In file included from drivers/video/fbdev/metronomefb.c:28:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:580:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outb(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:59:68: note: expanded from macro 'outb'
>    #define outb(v,c)       ({ __io_pbw(); writeb_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~=
~~ ^
>    arch/riscv/include/asm/mmio.h:91:52: note: expanded from macro 'writeb=
_cpu'
>    #define writeb_cpu(v, c)        ((void)__raw_writeb((v), (c)))
>                                                              ^
>    In file included from drivers/video/fbdev/metronomefb.c:28:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:588:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outw(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:60:68: note: expanded from macro 'outw'
>    #define outw(v,c)       ({ __io_pbw(); writew_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~=
~~ ^
>    arch/riscv/include/asm/mmio.h:92:76: note: expanded from macro 'writew=
_cpu'
>    #define writew_cpu(v, c)        ((void)__raw_writew((__force u16)cpu_t=
o_le16(v), (c)))
>                                                                          =
            ^
>    In file included from drivers/video/fbdev/metronomefb.c:28:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:596:2: warning: performing pointer arithmetic=
 on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            outl(value, addr);
>            ^~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/io.h:61:68: note: expanded from macro 'outl'
>    #define outl(v,c)       ({ __io_pbw(); writel_cpu((v),(void*)(PCI_IOBA=
SE + (c))); __io_paw(); })
>                                                                  ~~~~~~~~=
~~ ^
>    arch/riscv/include/asm/mmio.h:93:76: note: expanded from macro 'writel=
_cpu'
>    #define writel_cpu(v, c)        ((void)__raw_writel((__force u32)cpu_t=
o_le32(v), (c)))
>                                                                          =
            ^
>    In file included from drivers/video/fbdev/metronomefb.c:28:
>    In file included from include/linux/interrupt.h:11:
>    In file included from include/linux/hardirq.h:10:
>    In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
>    In file included from include/asm-generic/hardirq.h:17:
>    In file included from include/linux/irq.h:20:
>    In file included from include/linux/io.h:13:
>    In file included from arch/riscv/include/asm/io.h:149:
>    include/asm-generic/io.h:1005:55: warning: performing pointer arithmet=
ic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>            return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
>                                                      ~~~~~~~~~~ ^
>    7 warnings generated.
>    /tmp/metronomefb-846872.s: Assembler messages:
> >> /tmp/metronomefb-846872.s:300: Error: unrecognized opcode `zext.b a2,a=
2'
> >> /tmp/metronomefb-846872.s:313: Error: unrecognized opcode `zext.b a5,a=
6'
> >> /tmp/metronomefb-846872.s:350: Error: unrecognized opcode `zext.b a3,a=
3'
> >> /tmp/metronomefb-846872.s:371: Error: unrecognized opcode `zext.b a4,a=
4'
>    /tmp/metronomefb-846872.s:409: Error: unrecognized opcode `zext.b a2,a=
2'
> >> /tmp/metronomefb-846872.s:433: Error: unrecognized opcode `zext.b s1,t=
1'
> >> /tmp/metronomefb-846872.s:521: Error: unrecognized opcode `zext.b a1,a=
1'
>    clang-12: error: assembler command failed with exit code 1 (use -v to =
see invocation)
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



--=20
http://www.livejournal.com/~pavelmachek

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl/dshYACgkQMOfwapXb+vKdBACgrK0DHje10cw77P3gk5GCAIQI
6BAAn06l39O+pM3prYSBuhShhaZMqlWM
=FjUP
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
