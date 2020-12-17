Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223D62DCDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgLQIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgLQIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:34:34 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9C0C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:33:54 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id l207so31377706oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thhaLAgz45LXgVBC1/MqGvib+cCHCRwUvsuzHaYFmDY=;
        b=Z6ySiqnaq/KVj1rPuvXEBmxhjzhgTIM1jas9qc78gT9zkl9CCnAb80b2nzXnrjQJRg
         d9/z0MT0RF16htAcEbZVWhjnmik6I0d+iGAgpit9+ZEjPBZmRmbfT7CGu2oGquxHF7V7
         yqn8HnzyhmZNkNS09pm5jPANdyxcsvTHmU8LzAp08ebxEQcHq8D4kdzKj++uwLlsdyNs
         umKYbpp9jjDoy/roRg0YfmRtMZEnr9wQdGJjGc6bFMQgDbKtk7rIThufxD8LyYx/xi4o
         o32ToztJzw0mPz5EoyWQfsJQG+VqAflbXZTeDYR3CrWzhBSpXf2qjCrsOCdCzST4qUf2
         u85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thhaLAgz45LXgVBC1/MqGvib+cCHCRwUvsuzHaYFmDY=;
        b=KsqAUkX4TDKikDjq6xJ/pfAyWOdlWUowZQ6rSv3KKLC6U9aOTppnOavzrb2UimErg2
         ViusEgCeMw7expab2TstAzcAE4v8MOSxHX8Si6BZmuKcV86s21nVrk+2jZd4jGInDLpG
         cJsbWxaGGMlVCukOzTKH2SBpXlHLF6iGxUxDOBfGDQ/y+IPICfgb/5ZgOODw/qoBGOfa
         s9ki7j7PwPkOexDR4snIlTRihzogTpcNhRxlkldEJ0FBxmmpj7XxI2Eg3ZKfwJMPmyqS
         eCGrmBfNmfoOCrDS3zcBs+Peni8gAWbGHLo31SM/wQ+e1Uo0z28TmEdr2xBioTrlwMvi
         1J/Q==
X-Gm-Message-State: AOAM530XogzURQfeka/nL/yJpALmL/uxpk9WGyD1x2i5yCBxg6iVygmC
        BUHmGqb5W1mCoAfqTC1GW753Jpx1Ps27VM2+ZRmJTdRODq4=
X-Google-Smtp-Source: ABdhPJxNwoJ0n2s/fs9/89qrJClbc3VAPOR1wn2caoplsOdhVwNb8aOC+BdB0OaR9QCmO1vNglZ4SvsRt9bhqYGNa9Y=
X-Received: by 2002:a54:4817:: with SMTP id j23mr4290303oij.158.1608194033914;
 Thu, 17 Dec 2020 00:33:53 -0800 (PST)
MIME-Version: 1.0
References: <202012171008.TsSBPhT7-lkp@intel.com>
In-Reply-To: <202012171008.TsSBPhT7-lkp@intel.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 17 Dec 2020 09:33:43 +0100
Message-ID: <CAMhs-H_nHshVFvBvi1KmVEPTxX7bpNpp0jL9+UY9c9z-iqf5gQ@mail.gmail.com>
Subject: Re: drivers/pinctrl/ralink/pinctrl-rt2880.c:365:12: warning: no
 previous prototype for 'rt2880_pinmux_init'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Dec 17, 2020 at 3:17 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sergio,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   accefff5b547a9a1d959c7e76ad539bf2480e78b
> commit: 518b466a21ad7fa1e338fa4ed9d180ef439d3bc0 pinctrl: ralink: add a pinctrl driver for the rt2880 family
> date:   9 days ago
> config: mips-randconfig-r025-20201217 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=518b466a21ad7fa1e338fa4ed9d180ef439d3bc0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 518b466a21ad7fa1e338fa4ed9d180ef439d3bc0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/pinctrl/ralink/pinctrl-rt2880.c:365:12: warning: no previous prototype for 'rt2880_pinmux_init' [-Wmissing-prototypes]
>      365 | int __init rt2880_pinmux_init(void)
>          |            ^~~~~~~~~~~~~~~~~~
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

Yes, there is no such prototype for this global. This should be
declared 'static' instead as it is only used from this driver code
using 'core_initcall_sync'.
Will send a patch with this change. CC'ed Linus because this driver is
in his subsystem now.

>
> :::::: The code at line 365 was first introduced by commit
> :::::: 1d2d116a93f0e9bf0bca72da76a96edef8a1d36d Revert "staging: mt7621-pinctrl: replace core_initcall_sync with builtin_platform_driver"

Not really, it was there from the very beginning but I made a change
to try to use this in a later stage in the boot process without
success. Thus, this commit is the revert for that one.

>
> :::::: TO: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> :::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Best regards,
    Sergio Paracuellos
