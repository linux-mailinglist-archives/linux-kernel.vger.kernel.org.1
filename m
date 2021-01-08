Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A213B2EEDA7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 08:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbhAHG7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 01:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbhAHG7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 01:59:35 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DF1C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 22:58:55 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 6so13170433ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 22:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zyfooBhJts+sWxSNLv+q770xV7CBKIUuvLR9O7/XxUs=;
        b=dybQenKjNZ/nxMioP1vQ6vA9PWQUxB+DL1MSSIkwc5+6wayK9C5Yxxn4FeF399lM9W
         zgRVeem6Hz44yeMMaNaudwEEwVuZTP5BQBtq1qBVefAV1zokT4LA9puK0uSq9pro66zQ
         7clqerf49iq+xKqBQLSFOCo6kbEBlpZrNR23iHaFP/WbnR28fIzlK98QFQTkjvnnlYmF
         4QtM0gl9JMMPTmvgqmKVF/R7qAg/nsDR644FTpCesGGQCye+7Y4OfsD9BMGeWT43Nc++
         Pd6RzFZB4CtyhvhA2Sn75AzdeKLMHGvx0atRvrRk7sbuLJKrzCf7IMk241ZZOpO3I9nS
         Ar8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zyfooBhJts+sWxSNLv+q770xV7CBKIUuvLR9O7/XxUs=;
        b=XQwAZNYSdSUQAmqpApOiCzo34Rv9PZ/L6GOZ1RNGZ4OFtnWZPqNUrZG+6+iIRyNl6r
         4v5WlrAzmDhFUVoYYG+GGY0IIp7hXeL3PdY37cdeuOw+rM1AIKyOJSnyvIr9WT6U/HsM
         uC3S0VP4TCt7LIF6HbPzy21+XcxjUOaeHjDiDuPBV7c5piaHBa5KwMopgy60iH5QLkw9
         K5gHnxrgQvvJqQGSAzHC22EJCZyReY2wCgydbEwqHR8ciEcyhLH0X6lF8R6FxqOEGnwp
         rB7Jx0uk8BcMEAXH4JXBHc2We+VU7mqe3SGxQNqIEwq5SEiXYadmfw5lbSzNiZfGnd02
         p1xg==
X-Gm-Message-State: AOAM530fqUQ9gykN7sarvQF/pJCewHdQI6o2riGElKFhRPa+JZ6a79xW
        vD0ty91koyqXt5Xg3iJuMMH2exvH87KGTyU/6xDQQA==
X-Google-Smtp-Source: ABdhPJzF+WHohfJ5Ngwm/gOwgGPzKSNacc454v7d7YjJjbMbuBvERIDI1X9s/eLINQGPFnsh0zSbbKk3MKyBg/mIiik=
X-Received: by 2002:a17:906:16da:: with SMTP id t26mr1713761ejd.478.1610089133826;
 Thu, 07 Jan 2021 22:58:53 -0800 (PST)
MIME-Version: 1.0
References: <202101081429.0yyvkacR-lkp@intel.com>
In-Reply-To: <202101081429.0yyvkacR-lkp@intel.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Fri, 8 Jan 2021 07:58:43 +0100
Message-ID: <CAMGffEnd9Vv7mHMxXE_9LdGwFdQQtp3HFBC8jQr7NguXkMj3yw@mail.gmail.com>
Subject: Re: drivers/block/rnbd/rnbd-clt.c:387:2: error: implicit declaration
 of function 'sg_free_table_chained'
To:     kernel test robot <lkp@intel.com>
Cc:     Gioh Kim <gi-oh.kim@cloud.ionos.com>, kbuild-all@lists.01.org,
        open list <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 7:46 AM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f5e6c330254ae691f6d7befe61c786eb5056007e
> commit: 5a1328d0c3a757cdd8c65f4dfe0a02502a5810bc block/rnbd-clt: Dynamically allocate sglist for rnbd_iu
> date:   3 weeks ago
> config: parisc-randconfig-r011-20210108 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5a1328d0c3a757cdd8c65f4dfe0a02502a5810bc
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5a1328d0c3a757cdd8c65f4dfe0a02502a5810bc
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/block/rnbd/rnbd-clt.c: In function 'rnbd_softirq_done_fn':
> >> drivers/block/rnbd/rnbd-clt.c:387:2: error: implicit declaration of function 'sg_free_table_chained' [-Werror=implicit-function-declaration]
>      387 |  sg_free_table_chained(&iu->sgt, RNBD_INLINE_SG_CNT);
>          |  ^~~~~~~~~~~~~~~~~~~~~
>    drivers/block/rnbd/rnbd-clt.c: In function 'rnbd_queue_rq':
> >> drivers/block/rnbd/rnbd-clt.c:1142:8: error: implicit declaration of function 'sg_alloc_table_chained'; did you mean 'sg_alloc_table'? [-Werror=implicit-function-declaration]
>     1142 |  err = sg_alloc_table_chained(&iu->sgt,
>          |        ^~~~~~~~~~~~~~~~~~~~~~
>          |        sg_alloc_table
>    cc1: some warnings being treated as errors
>
>
> vim +/sg_free_table_chained +387 drivers/block/rnbd/rnbd-clt.c
Thanks for reporting, I've found the problem, we need to
select SG_POOL in Kconfig for RNBD client, will send out a fix soon today.

Regards!
Jack
