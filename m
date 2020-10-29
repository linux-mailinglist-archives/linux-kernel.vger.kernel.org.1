Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1260D29F534
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJ2T3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgJ2T3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:29:32 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A98C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:29:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r10so3164366pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 12:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hODTMe567eC6BMy7rW+EbRY7j8SWSkBEoRWcDjtLRZA=;
        b=eKEuZeqlhTwXlZM2Pk6nXiuecGFj7hKBx8OkLBZ+Tx13ZKnJVRAf5ewFtjcwJ7nSfA
         BIBDgKSt3v3/YRPoJ/Ab/Di4/J+DWpqZdrNbQ4lT1g9G271fXXPsOSwfaNzBPAxhM15E
         IRnsWHzqS7jXcHWKQIW8G15WVXgWHDCMzR2cfq0l1IgLM9plVD7dnohbZfZ60qpKKOpV
         7OujCqZM0haZ56FP11W9+SpoSIwm1Bzv1nD6kpjv4qlUph+8jpHTV3dlL9IGymjnWo1F
         pLzu4nqR4fySAcpMRVhqFiKCAzjQHPgwlLATvO9OmKuJbhJ63K82vIPj2KVr7Lxo/djP
         XmfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hODTMe567eC6BMy7rW+EbRY7j8SWSkBEoRWcDjtLRZA=;
        b=MaZdDzY5EX+x9CF63M6plHI7dS9I7Yh1ukbpGAfPyf63rAfB3vZV0ReEzwJHbvOnos
         50cf7/tdDU685TtstcRazP+YCv81/JfUMovRwjYlHXakGC1bmiV1rCXw8CgSq4Lt8J5e
         SYAC5BdohOGDg9LCi7sLpYu3TIvH42+1Utq3xMQiPDTIVTE3i/jvk6uTmE3KO6ApjOUA
         nVXmzB0XNe76KT00ldq2bHOR199Q6IH8E5G5+Q+eC+NeyAdG/VszL61Ws91Ig+EkzO5o
         Nxh3r5y62g/5Oyb/Ucl/zVYe3v+aBDa5C5i2V4aDKjEgIH9LvseE/dAQqofXDoslMmZe
         jQIg==
X-Gm-Message-State: AOAM531Q+iSCkd2FLoa+E7zY6+jdp732RPAceD/jgB9Lqj82NhX5QSUF
        mnDHHnNGgNNXwmB3Fk87Z9AK6IuQaOEQZ0e1PtrDZQ==
X-Google-Smtp-Source: ABdhPJxMD6xhYOm0CFI6t/h8wHRUcJOxHygP0ex75iMxxhs1thd5KDfGxGL5L1wzvtVtmGueTKoKuyslmoPNoo1hqus=
X-Received: by 2002:a63:70d:: with SMTP id 13mr5476482pgh.263.1603999745918;
 Thu, 29 Oct 2020 12:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <202010291249.MFjbb8tv-lkp@intel.com>
In-Reply-To: <202010291249.MFjbb8tv-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 29 Oct 2020 12:28:54 -0700
Message-ID: <CAKwvOdk82WZnCh9G8CidN9tJ6qiMaHYdN-e+Ad5kRa6C87Vfxg@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: amba_driver_register
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 9:57 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   23859ae44402f4d935b9ee548135dd1e65e2cbf4
> commit: ea0c0ad6b6eb36726088991d97a55b99cae456d0 memory: Enable compile testing for most of the drivers
> date:   2 months ago
> config: arm-randconfig-r024-20201028 (attached as .config)

^ Note, this was a randconfig, so the preprocessor guards on CONFIGs
might be wrong.

> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 50dfa19cc799ae7cddd39a95dbfce675a12672ad)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ea0c0ad6b6eb36726088991d97a55b99cae456d0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout ea0c0ad6b6eb36726088991d97a55b99cae456d0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: amba_driver_register
>    >>> referenced by pl353-smc.c
>    >>> memory/pl353-smc.o:(pl353_smc_driver_init) in archive drivers/built-in.a
> --
> >> ld.lld: error: undefined symbol: amba_driver_unregister
>    >>> referenced by pl353-smc.c
>    >>> memory/pl353-smc.o:(pl353_smc_driver_exit) in archive drivers/built-in.a
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202010291249.MFjbb8tv-lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
