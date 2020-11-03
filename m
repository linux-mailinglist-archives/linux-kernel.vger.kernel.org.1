Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD722A40E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgKCJ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:57:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:57966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgKCJ5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:57:39 -0500
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB8F2242B
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 09:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604397458;
        bh=i4ifvgEq6+HMzxBl3JPq35fuBnrUfMJc2emKtbELeUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VcaLeR7Z1XjzW965JtvzT+/xXJ2rD24ochrjoKVP9ClXmGN1K7UwRmArbgOg01Vgq
         coN5rUZAgxCTGLVgOevCAI60Pl7RanwkBLkVeKiwqrkf7p7UHEaUKmqLXClpmba+Ba
         IOqTJ9lwnXYE5Sgpsv0Usmni/XoQ1AoTfaeePVLA=
Received: by mail-wr1-f53.google.com with SMTP id k10so16467923wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 01:57:37 -0800 (PST)
X-Gm-Message-State: AOAM5321WsK/xfXvo+xbKhGQLxtJc1kQyzcYJnwdiWxAJlkt1mnqqNuX
        FwPEANSF3Mg4Q1pfR8yVFC2hrNrSgt3j2tREPto=
X-Google-Smtp-Source: ABdhPJxIHUuyfXH5rsHgMrkFr6UFo+kVauC76O24z5Dnh+xGRIrUe724kSkATr1kliu1TMiiRUi6xIbYY8lXht4ebeY=
X-Received: by 2002:a5d:54c8:: with SMTP id x8mr24200238wrv.286.1604397456456;
 Tue, 03 Nov 2020 01:57:36 -0800 (PST)
MIME-Version: 1.0
References: <202011022219.0qDkLNRX-lkp@intel.com>
In-Reply-To: <202011022219.0qDkLNRX-lkp@intel.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 3 Nov 2020 10:57:20 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1DKu4YyAFY_kFjietDj=kcP=5FqCnE+hn_0m1O3PCUyg@mail.gmail.com>
Message-ID: <CAK8P3a1DKu4YyAFY_kFjietDj=kcP=5FqCnE+hn_0m1O3PCUyg@mail.gmail.com>
Subject: Re: include/uapi/sound/asound.h:562:14: error: conflicting types for '__pad_before_uframe'
To:     kernel test robot <lkp@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kbuild-all@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 2, 2020 at 3:15 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
> commit: 80fe7430c7085951d1246d83f638cc17e6c0be36 ALSA: add new 32-bit layout for snd_pcm_mmap_status/control
> date:   11 months ago
> config: mips-randconfig-r006-20201102 (attached as .config)
> compiler: mips-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80fe7430c7085951d1246d83f638cc17e6c0be36
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 80fe7430c7085951d1246d83f638cc17e6c0be36
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/mips/include/uapi/asm/byteorder.h:13,
>                     from arch/mips/include/asm/bitops.h:20,
>                     from include/linux/bitops.h:26,
>                     from include/linux/kernel.h:12,
>                     from include/asm-generic/bug.h:19,
>                     from arch/mips/include/asm/bug.h:42,
>                     from include/linux/bug.h:5,
>                     from include/linux/mmdebug.h:5,
>                     from include/linux/gfp.h:5,
>                     from include/linux/slab.h:15,
>                     from sound/core/oss/pcm_oss.c:15:
>    include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>        8 | #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>          |  ^~~~~~~
>    In file included from include/sound/asound.h:24,
>                     from include/sound/pcm.h:11,
>                     from sound/core/oss/pcm_oss.c:25:
> >> include/uapi/sound/asound.h:562:14: error: conflicting types for '__pad_before_uframe'
>      562 | typedef char __pad_before_uframe[0];
>          |              ^~~~~~~~~~~~~~~~~~~
>    include/uapi/sound/asound.h:557:14: note: previous declaration of '__pad_before_uframe' was here
>      557 | typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
>          |              ^~~~~~~~~~~~~~~~~~~

This is unrelated to my patch, and a preexisting problem with the jazz platform
when no specific machine is selected and neither big-endian nor little-endian
CPUs are enabled. Since all three machines do allow little-endian kernels,
selecting that option one level higher fixes the problem.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -406,6 +406,7 @@ config MACH_JAZZ
        select SYS_SUPPORTS_32BIT_KERNEL
        select SYS_SUPPORTS_64BIT_KERNEL
        select SYS_SUPPORTS_100HZ
+       select SYS_SUPPORTS_LITTLE_ENDIAN
        help
          This a family of machines based on the MIPS R4030 chipset which was
          used by several vendors to build RISC/os and Windows NT workstations.
