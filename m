Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439822C3260
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgKXVNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgKXVNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:13:14 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820B6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=bRma0OFbi1m6TM+oYAu2kkAVbhOo6D7XSE0W8Im9z/E=; b=ANPhSDmdhsOahQQ1LnaippPFR1
        4ectuHnLsqS6Id+o1+mypTq8jzk54EEQa+eepIx2OKaYPWplIw09Uk3YVNBzHC1dmNYKMVy50Tc3X
        de3iO0YsFMeeARQeC1IGQ/1/KTNItfy6Kdu+xFfJBj1BXfkwJufGWh0wGWlTuS2WdCWrWDNGg/NOY
        yDn2p7gvdgfQMUGPyjibYiciC9uq7yPspc7PgjdwKTNxU3pLOSt9I4b/hZAjD6vVlCz3sqNLkIh/t
        EG8WkIog0Ek3C1i1G3Nhd0k0WSIL1odPF7BOqJsZQ2odBg8ao30rMCxz/JzBUeP5l3vfB6YlQg2gd
        bcb/KYHQ==;
Received: from [2601:1c0:6280:3f0::1935] (helo=dragon.site)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khfcd-00005v-NI; Tue, 24 Nov 2020 21:13:12 +0000
Subject: Re: drivers/clocksource/timer-riscv.c:28:16: error: implicit
 declaration of function 'get_cycles64'
To:     kernel test robot <lkp@intel.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <202011212217.9IAK7t1V-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <59ba6905-baef-02af-a424-41969f3ad0b3@infradead.org>
Date:   Tue, 24 Nov 2020 13:13:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <202011212217.9IAK7t1V-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/20 6:26 AM, kernel test robot wrote:
> Hi Palmer,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27bba9c532a8d21050b94224ffd310ad0058c353
> commit: d5be89a8d118a8e8d09cd74a921a808f17fbdd09 RISC-V: Resurrect the MMIO timer implementation for M-mode systems
> date:   9 weeks ago
> config: riscv-randconfig-r034-20201121 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project bec968cbb367dd03439c89c1d4ef968ef662d7c0)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install riscv cross compiling tool for clang build
>          # apt-get install binutils-riscv64-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5be89a8d118a8e8d09cd74a921a808f17fbdd09
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout d5be89a8d118a8e8d09cd74a921a808f17fbdd09
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

CONFIG_RISCV_M_MODE=y

and that prevents get_cycles64() in
arch/riscv/include/asm/timex.h from being visible.

I suppose that was intended?


>>> drivers/clocksource/timer-riscv.c:28:16: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>             sbi_set_timer(get_cycles64() + delta);
>                           ^
>     drivers/clocksource/timer-riscv.c:28:16: note: did you mean 'get_cycles'?
>     arch/riscv/include/asm/timex.h:18:24: note: 'get_cycles' declared here
>     static inline cycles_t get_cycles(void)
>                            ^
>     drivers/clocksource/timer-riscv.c:47:9: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>             return get_cycles64();
>                    ^
>     drivers/clocksource/timer-riscv.c:52:9: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>             return get_cycles64();
>                    ^
>     7 warnings and 3 errors generated.
> 
> vim +/get_cycles64 +28 drivers/clocksource/timer-riscv.c
> 


