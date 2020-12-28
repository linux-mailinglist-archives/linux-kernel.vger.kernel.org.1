Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C082E3714
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 13:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgL1MUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 07:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbgL1MUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 07:20:14 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B11DC061794
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:19:34 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 11so8949657oty.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 04:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRRPWjvhb9GCGiPdnbC1lLZFrLRPu7On0IHDmAEES5o=;
        b=kifHkrVSse12Iaj9LaVKhUDG60P36NogPNlP8LzV6rkW2hW79mCAT2HFM8VT+LZ1Hz
         C9+0kUP2KpwdyrWMkO3t8yd0qBE3upPfoWMsJaD8AwOhk2FKbywFS3mPlhMBRrUy3D8Q
         DCJ8eL8CXQ1f5Yfb9DsTU/MWW1tFlL5izb5aRB8t8iUbwhKWSHzSS10eNc6OhRle2vtP
         QZZx39ct6EZqBFJuXQNP8jvCJpUoCxNMwabETIRr3OufvtwE1RJ2GbcLJCYtqQFJvGlh
         S/heqqYfrivOLW4hH2xA/HT+wYlTpf9Bvr1Smn74451FFuQQMBSUnnp4dSkdEEUVj56S
         eOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRRPWjvhb9GCGiPdnbC1lLZFrLRPu7On0IHDmAEES5o=;
        b=sJAZ2rUb+mU0I2aX8sZKvp1ZKhX5+riQmW5CxCpsiluACswnMhJlf0Ai81B6vh2tpW
         MoAc3mKnPnQcsprtFrAI1mRMloabVk2GtPwg4sXu4Dh6pn4SKzlNcNg9vkEf+CIHgzhP
         rhL61W4PNM7exRs4guPOuzyHaxLThzvkQbhDbe1/9HcGAHoOHOWg0YVPLSIjwIkg/uMk
         nAxziYFXQ1uZD2w8gU+4iUGmh++/6HT0/lrmuK6m7dyNU4Hlus5NOnwmH9uUdYgrP9U/
         9NPbIjHXbid87wH5xSRl3+40cHhxhX5bRbUg33Aj8wxvOWfUHZMtCuEVVkp9xTWk+5Dj
         g/oA==
X-Gm-Message-State: AOAM533e1pn1Vj8RXwJ4138gnHoVoaRt4Y77aKTDxPsHb4Gbw7yXTeHw
        VgduwiXleAG804WHf5NzEgeVEpUZGX5djSrY2dI=
X-Google-Smtp-Source: ABdhPJxX9NIZXKWJGpLpfFCXpQK3Mf3GBcobGbwOp+tp2JxxcKsOq8RiJz1IVQKqD5cGa8d+m2f/+2+t2QG69JgruWc=
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr33060969otd.72.1609157972985;
 Mon, 28 Dec 2020 04:19:32 -0800 (PST)
MIME-Version: 1.0
References: <202012281956.yA1MDkod-lkp@intel.com>
In-Reply-To: <202012281956.yA1MDkod-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Mon, 28 Dec 2020 13:19:22 +0100
Message-ID: <CAMhs-H8qN=PukxncoxVX6igvBScP-PU_=dGGiSmmLvMHpcDstg@mail.gmail.com>
Subject: Re: drivers/pinctrl/ralink/pinctrl-rt2880.c:365:12: warning: no
 previous prototype for function 'rt2880_pinmux_init'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 28, 2020 at 12:15 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sergio,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5c8fe583cce542aa0b84adc939ce85293de36e5e
> commit: 518b466a21ad7fa1e338fa4ed9d180ef439d3bc0 pinctrl: ralink: add a pinctrl driver for the rt2880 family
> date:   3 weeks ago
> config: mips-randconfig-r012-20201228 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=518b466a21ad7fa1e338fa4ed9d180ef439d3bc0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 518b466a21ad7fa1e338fa4ed9d180ef439d3bc0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/pinctrl/ralink/pinctrl-rt2880.c:365:12: warning: no previous prototype for function 'rt2880_pinmux_init' [-Wmissing-prototypes]
>    int __init rt2880_pinmux_init(void)
>               ^
>    drivers/pinctrl/ralink/pinctrl-rt2880.c:365:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    int __init rt2880_pinmux_init(void)
>    ^
>    static
>    1 warning generated.
>
>
> vim +/rt2880_pinmux_init +365 drivers/pinctrl/ralink/pinctrl-rt2880.c
>
> 0317d60de869786 drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c John Crispin       2018-03-15  364
> 1d2d116a93f0e9b drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c Sergio Paracuellos 2018-07-09 @365  int __init rt2880_pinmux_init(void)
> 1d2d116a93f0e9b drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c Sergio Paracuellos 2018-07-09  366  {
> 1d2d116a93f0e9b drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c Sergio Paracuellos 2018-07-09  367      return platform_driver_register(&rt2880_pinmux_driver);
> 1d2d116a93f0e9b drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c Sergio Paracuellos 2018-07-09  368  }
> 1d2d116a93f0e9b drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c Sergio Paracuellos 2018-07-09  369
>
> :::::: The code at line 365 was first introduced by commit
> :::::: 1d2d116a93f0e9bf0bca72da76a96edef8a1d36d Revert "staging: mt7621-pinctrl: replace core_initcall_sync with builtin_platform_driver"
>
> :::::: TO: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Already sent this morning: https://lkml.org/lkml/2020/12/28/16

Thanks,
    Sergio Paracuellos
