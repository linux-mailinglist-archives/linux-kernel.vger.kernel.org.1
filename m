Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14782C3261
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgKXVOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728492AbgKXVOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:14:04 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037D3C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:14:04 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so242962pfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 13:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=k2UmexVgKmIao4oRvUuGEqtTpOCfNvurJXj3LvuUbJs=;
        b=M4+iOo+qWYooQEwHKxRvepHin66Hjmy4skldZ09AgajrtyIqvsbHGKhy1g/Z/ZOGwD
         Yoickv5q1PdmtAXtDUAUuxr+LXivq1oARM96mnNcExmtavlRYtC5tZoCG6iDJ5rYoep+
         vbNY/qRgqIRCVwcVQ4pgfzC/9hE4Z6z9zDjt3hDAj+ffu7sp6S5eNHtWMu0tWRp3nV2b
         4LzG9MBx5HK51E1KxGj5eyO72SCEIcbFu6kDyHSLTsArK98t7g8piyWqev3JtCtkGfuW
         DhSblj2sYpwCOSxcwgxuAzqvBAmNwolsiudQrAZu9znhQt4w9hG29+uL62BUV4rFg8oY
         LJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=k2UmexVgKmIao4oRvUuGEqtTpOCfNvurJXj3LvuUbJs=;
        b=i22dSfMeS1AOwatNekv4rThRGhQ9CD9l3KvvDG6tl9wDKYecSQDdB/pBkDkrbmxa/v
         9HVm8hCzUC1AhckeMVyyXuBkXfScGvPPK4TgJOV3ToEvrxFPvyVlNG+GhMhQ0itlzzVz
         qMmK98IKpn4h9b2KEBEJpv1pKtgh1JKJK9vZtNcYCub6enfdBGoIv/Uml2WLlwWSig7M
         b7WIYVnUew3RTwyOxHE2ZaHter1QybmwF5I8DIzTU/nQ+12ulF2wV3Cut0bjzq8suyeo
         yan/GmvAnTaq/9GjmfqWlS+SvR6fgCSzgNs8rjfpvNMGZ/gD4riY9HZoEcm956og2+Fm
         UCiw==
X-Gm-Message-State: AOAM5303HxHBqu7fz91PElMhU6Ct66d0tsi/0JfnzIZq/itvRPkEbVeM
        T51dQHXlTRZ5aBjAu8DuDKmBLt3/69/wlCzZ
X-Google-Smtp-Source: ABdhPJyqvYRvwz3KkkhpIGZloyD7wtjB9enCVPoevVWDBkT+seCwDDakOAVk8xtln8k+2ZnWNU9Zjg==
X-Received: by 2002:a63:a62:: with SMTP id z34mr237913pgk.193.1606252443427;
        Tue, 24 Nov 2020 13:14:03 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q188sm7059158pfc.204.2020.11.24.13.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 13:14:02 -0800 (PST)
Date:   Tue, 24 Nov 2020 13:14:02 -0800 (PST)
X-Google-Original-Date: Tue, 24 Nov 2020 13:14:00 PST (-0800)
Subject:     Re: drivers/clocksource/timer-riscv.c:28:16: error: implicit declaration of function 'get_cycles64'
In-Reply-To: <59ba6905-baef-02af-a424-41969f3ad0b3@infradead.org>
CC:     lkp@intel.com, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     rdunlap@infradead.org
Message-ID: <mhng-5f994c20-0b96-41b1-bb01-9aa8c71228de@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 13:13:07 PST (-0800), rdunlap@infradead.org wrote:
> On 11/21/20 6:26 AM, kernel test robot wrote:
>> Hi Palmer,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   27bba9c532a8d21050b94224ffd310ad0058c353
>> commit: d5be89a8d118a8e8d09cd74a921a808f17fbdd09 RISC-V: Resurrect the MMIO timer implementation for M-mode systems
>> date:   9 weeks ago
>> config: riscv-randconfig-r034-20201121 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project bec968cbb367dd03439c89c1d4ef968ef662d7c0)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install riscv cross compiling tool for clang build
>>          # apt-get install binutils-riscv64-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d5be89a8d118a8e8d09cd74a921a808f17fbdd09
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout d5be89a8d118a8e8d09cd74a921a808f17fbdd09
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=riscv
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>
> CONFIG_RISCV_M_MODE=y
>
> and that prevents get_cycles64() in
> arch/riscv/include/asm/timex.h from being visible.
>
> I suppose that was intended?

No, I have a fix for it that I'm about to send out.  There's also a bit more necessary.

>
>
>>>> drivers/clocksource/timer-riscv.c:28:16: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>>             sbi_set_timer(get_cycles64() + delta);
>>                           ^
>>     drivers/clocksource/timer-riscv.c:28:16: note: did you mean 'get_cycles'?
>>     arch/riscv/include/asm/timex.h:18:24: note: 'get_cycles' declared here
>>     static inline cycles_t get_cycles(void)
>>                            ^
>>     drivers/clocksource/timer-riscv.c:47:9: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>>             return get_cycles64();
>>                    ^
>>     drivers/clocksource/timer-riscv.c:52:9: error: implicit declaration of function 'get_cycles64' [-Werror,-Wimplicit-function-declaration]
>>             return get_cycles64();
>>                    ^
>>     7 warnings and 3 errors generated.
>>
>> vim +/get_cycles64 +28 drivers/clocksource/timer-riscv.c
>>
