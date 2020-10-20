Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0A293612
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405475AbgJTHt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:49:56 -0400
Received: from mail-oo1-f68.google.com ([209.85.161.68]:36145 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgJTHtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:49:55 -0400
Received: by mail-oo1-f68.google.com with SMTP id j6so243180oot.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqzc7U1mny8AwGIjM9o9u9U//G4OpC9lvx8pphKRavw=;
        b=LXEvgmfq82mQ5e0+cD2yy/IRofQgo15DeiwrUvrNwocSBliLUVPM44WuqIDkEDQnAE
         IjNbuSj3BqX3eXm3mVnYwgMGFL1iL5OFiFby2E+i+ppEvoNVKEEdOUduozxy4P9xvgkj
         XY3/LYrpRM+qan2NkqQY34uCQel9H1/LQxmGFOSupuHGAbKnUOHO8YxTXHqe2bGlYno1
         QzDwTqr9oI63+Y77f5hqpvyyAxreBvW/phFL0v+DKUE9Vy0swmudfebYkXHHkYBD5/bY
         W9XWkCObY3gemhOwlZFd9SvLPMQVqDH430qV5MoyHdLfojVVmkGdOsFjO7QchydgKAB7
         hzOA==
X-Gm-Message-State: AOAM533bE1OpWG5VuWIC5dckyjuReIe5Fchtcui2W12d1VwejNfQaAeh
        kZhwuwbytUYW+7hK6/S/0Tz8NnrAQVaFCPDw5Vw=
X-Google-Smtp-Source: ABdhPJzYvkXcNQ/8KNjNkrs7Fnw6j2i+FFxOCyhbUzfnnoD3MGJ55pWXbxIWoA4PS5WY5tGShWNqUEOBJKWudgVtVCQ=
X-Received: by 2002:a4a:4f17:: with SMTP id c23mr940468oob.11.1603180196392;
 Tue, 20 Oct 2020 00:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <202010201527.PTQTs5C6-lkp@intel.com>
In-Reply-To: <202010201527.PTQTs5C6-lkp@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 20 Oct 2020 09:49:45 +0200
Message-ID: <CAMuHMdWRXQEoa2w6NHP-GwkyS=SN5GpZk=GOxOUsisHJRntsOw@mail.gmail.com>
Subject: Re: drivers/pinctrl/renesas/pinctrl-rzn1.c:183:52: sparse: sparse:
 dubious: x | !y
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Test Robot,

On Tue, Oct 20, 2020 at 9:42 AM kernel test robot <lkp@intel.com> wrote:
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   270315b8235e3d10c2e360cff56c2f9e0915a252
> commit: 077365a941166f3a7f5894017f9d26d17cdec00e pinctrl: Rename sh-pfc to renesas
> date:   5 weeks ago
> config: x86_64-randconfig-s032-20201020 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=077365a941166f3a7f5894017f9d26d17cdec00e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 077365a941166f3a7f5894017f9d26d17cdec00e
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/pinctrl/renesas/pinctrl-rzn1.c:183:52: sparse: sparse: dubious: x | !y
>    drivers/pinctrl/renesas/pinctrl-rzn1.c:189:52: sparse: sparse: dubious: x | !y

This is a false positive, cfr.
https://lore.kernel.org/linux-renesas-soc/CAMuHMdV=aWj9ePL9gAa-vsmLLUZkY4ip2337am8A7ktxg7Yniw@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
