Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41CCE2E2078
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 19:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgLWSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 13:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgLWSgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:36:46 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FC4C061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 10:36:06 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de6004e8e0a920ee38f04.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:4e8e:a92:ee3:8f04])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC06B1EC04A6;
        Wed, 23 Dec 2020 19:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608748564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=T3szGHnqh9g5WowsiNoMytWNIPTlrye+Cl/FcvQGf0s=;
        b=VrjvyS4C+uRU4RdoJN3Wt2B6lC3DAjFtEMhFrzxRihsyWJUEw+Ou1No+fB20cNGd2+Jxm8
        ds9WBqYI0zsSlPa/RLiGJtp7o+QY74jPJBtyC27SQMdJQr5oGgMYBZF2S5rxNn3yvcwcYm
        B1zct207fSLuB6Q/68G61Qnwpewo60Y=
Date:   Wed, 23 Dec 2020 19:36:06 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [tip:efi/core 3/7] /tmp/slab-258052.s:9870: Error: unrecognized
 opcode `zext.b a2,a2'
Message-ID: <20201223183606.GB29011@zn.tnic>
References: <202012180909.WhlTpWrS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202012180909.WhlTpWrS-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 18, 2020 at 09:03:14AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git efi/core
> head:   b283477d394ac41ca59ee20eb9293ae9002eb1d7
> commit: 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a [3/7] efi/libstub: EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER should not default to yes
> config: riscv-randconfig-r022-20201217 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip efi/core
>         git checkout 6edcf9dc2e1aff3aa1f5a69ee420fb30dd0e968a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv 

Something's still not good with that test - it fails much earlier for me:

$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang /tmp/make.cross ARCH=riscv
Compiler will be installed in /home/boris/0day
cd: received redirection to `https://download.01.org/0day-ci/cross-package/'  
lftpget -c https://download.01.org/0day-ci/cross-package/./clang-latest/clang.tar.xz
tar Jxf clang-latest/clang.tar.xz -C /home/boris/0day                                                     
make W=1 CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y HOSTCC=/home/boris/0day/clang-latest/bin/clang CC=/home/boris/0day/clang-latest/bin/clang LD=/home/boris/0day/clang-latest/bin/ld.lld HOSTLD=/home/boris/0day/clang-latest/bin/ld.lld AR=/home/boris/0day/clang-latest/bin/llvm-ar NM=/home/boris/0day/clang-latest/bin/llvm-nm STRIP=/home/boris/0day/clang-latest/bin/llvm-strip OBJDUMP=/home/boris/0day/clang-latest/bin/llvm-objdump OBJSIZE=/home/boris/0day/clang-latest/bin/llvm-size READELF=/home/boris/0day/clang-latest/bin/llvm-readelf HOSTCXX=/home/boris/0day/clang-latest/bin/clang++ HOSTAR=/home/boris/0day/clang-latest/bin/llvm-ar CROSS_COMPILE=riscv-linux-gnu- --jobs=32 ARCH=riscv
  SYNC    include/config/auto.conf.cmd
...

scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
  DTC     arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dtb
  DTC     arch/riscv/boot/dts/kendryte/k210.dtb
  HOSTCC  scripts/genksyms/parse.tab.o
  HOSTCC  scripts/genksyms/lex.lex.o
  HOSTLD  scripts/genksyms/genksyms
  CC      scripts/mod/empty.o
  HOSTCC  scripts/mod/mk_elfconfig
  CC      scripts/mod/devicetable-offsets.s
error: unknown target triple 'riscv-unknown-linux-gnu', please use -triple or -arch
make[1]: *** [scripts/Makefile.build:117: scripts/mod/devicetable-offsets.s] Error 1
make[1]: *** Waiting for unfinished jobs....
error: unknown target triple 'riscv-unknown-linux-gnu', please use -triple or -arch
make[1]: *** [scripts/Makefile.build:283: scripts/mod/empty.o] Error 1
make: *** [Makefile:1199: prepare0] Error 2
$

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
