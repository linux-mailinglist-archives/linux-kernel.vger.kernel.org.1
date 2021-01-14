Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05F2F697D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbhANSZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbhANSZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:25:08 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A59C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:24:28 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id az16so2752789qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J6vziYHwm+lSX1U7LWnHMslYMHEx2Y52Z3S2HKYzLPI=;
        b=gH8mdsL2KUumG1ZYcoHC+kJtx1+rH8+C+bp65QfuwRuF0YjR1pIEgDR83xFKTWYIV4
         ksSJhh9wfJjBhmvIe34DGzG0WL6U3JsuBlWbjhddQ8Ol78cs9cSG//hmGfq5U0ST+ZM0
         /ssH2rUX3J+nOSbW0b36+wc2PRSXLKwvHOVMmCBs84IA4AQuEVXk0+EFtOgYz3zbKRyd
         KUyGUpEmC6k6hvxY8uLUv39JmuCEB69OWZAA/aJC+7sdW5ifKtELk/3RnolsHU6MU9aa
         qB/GkNCs2vGgvYvPAQrZUUg3JM5TDKK0SF+hzYLHpTIuAxHk8K7A6CS+DVfPG6C+vz79
         HMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6vziYHwm+lSX1U7LWnHMslYMHEx2Y52Z3S2HKYzLPI=;
        b=pjwyfelbGnFvxLe7BO835RpQkhjbfkfUQiF5VfQz75+8CgFkIPlh0rZkb+XxIkXEaQ
         dx1g0QHZxuVI6p32DbET4bgBCFPHi/bUD3tiAiiPKXhpYqfd5k51lz/RHotSWEkQB+Jt
         Sp6tvn+bPF/WRYJ7F7uaOKSs+tiQ758L13luwLpIS6dOUv09vancg6vXNUEIutEfcrlK
         I+zKQywgNUYy05E4hneuwSs3aoTMeifG8VnF3z/inbQCzTGNPEueUXSEK7+2UmgK/5vm
         iKhSfsP5D0LlJuqvqjU1bsFIgOTkrL0ITBOGImVmEJE1c3HKBcL6OlfbNjiq7DDnDzfC
         fSYQ==
X-Gm-Message-State: AOAM533sLhA5bQYz2anuhDGetvzvmBpLOMjo9Wkbdv7+AfcbeZhuIjHy
        qa9GyzlEgmX/d7fpJgcP+mY=
X-Google-Smtp-Source: ABdhPJyIMvpH66GHIr8zgkd5ukWXBd3RnNCPZx6BkTrH5iQz++deiJrYwJF7dKn02blhX8kwHC/S2g==
X-Received: by 2002:a0c:f283:: with SMTP id k3mr8534666qvl.48.1610648667437;
        Thu, 14 Jan 2021 10:24:27 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id h1sm3255183qtr.1.2021.01.14.10.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 10:24:26 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:24:25 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Stefan Popa <stefan.popa@analog.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: Re: drivers/iio/accel/adxl372.c:949:3: warning: converting the
 result of '<<' to a boolean always evaluates to true
Message-ID: <20210114182425.GA967189@ubuntu-m3-large-x86>
References: <202101150231.fTcE6qLr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202101150231.fTcE6qLr-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 02:19:41AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   65f0d2414b7079556fbbcc070b3d1c9f9587606d
> commit: b0fc6783d4ae58f796fb183c40dbc7fa3199d51d iio: accel: adxl372: Add support for FIFO peak mode
> date:   4 months ago
> config: mips-randconfig-r026-20210114 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 68ff52ffead2ba25cca442778ab19286000daad7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b0fc6783d4ae58f796fb183c40dbc7fa3199d51d
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout b0fc6783d4ae58f796fb183c40dbc7fa3199d51d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/interrupt.h:8:
>    In file included from include/linux/cpumask.h:13:
>    In file included from include/linux/atomic.h:7:
>    arch/mips/include/asm/atomic.h:52:1: warning: converting the result of '<<' to a boolean always evaluates to true [-Wtautological-constant-compare]
>    arch/mips/include/asm/atomic.h:45:9: note: expanded from macro 'ATOMIC_OPS'
>            return xchg(&v->counter, n);                                    \
>                   ^
>    arch/mips/include/asm/cmpxchg.h:102:7: note: expanded from macro 'xchg'
>            if (!__SYNC_loongson3_war)                                      \
>                 ^
>    arch/mips/include/asm/sync.h:147:34: note: expanded from macro '__SYNC_loongson3_war'
>    # define __SYNC_loongson3_war   (1 << 31)
>                                       ^

Sorry for the noise, I have sent a patch to fix this:

https://lore.kernel.org/lkml/20210114173416.738455-1-natechancellor@gmail.com/

Cheers,
Nathan
