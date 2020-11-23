Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DD02C0D35
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbgKWOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730113AbgKWOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:15:44 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE96FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:15:44 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id bj5so8087326plb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mh93lDv4R+xlWArTBZkqpnMY0gZ1j0TNR1Mb4V4ZZ6A=;
        b=lxg2G0DJ9n1Bq3SZ9cfI7VRgZ8jm1V0wR98IoUBM4lTzmPxdLMRTLz9utgZ5O4lH4N
         GVWWNvdfEDH+TfjS2MApx17qotEl+1OBrSyJWduRQc21z/exyAR1Hjsj4ACCEEa/cHdK
         Z5Rm8s+CI2XjqDY3WMaZZtgLxDIby4uJDvLeDt1/PrsmSB3atPefV4IonluPzRqE7kf7
         N3h+c5iVnUeALXSuQM6bUPoijqK4Tcn11jkHRv2+h7snOJG111N1rLIwYhfDTjJOmc0L
         YvHn2NDeu+8MOUkuloBzj5Rcwz9twedNsJgRZ5EdL/JeEvQ019mf3I1o4FBS/aNAWElo
         zJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mh93lDv4R+xlWArTBZkqpnMY0gZ1j0TNR1Mb4V4ZZ6A=;
        b=sH851bsDt4Zl0i3YYo9JSxTniKeDsZystH37ld0Mvli3ee9qXG+20rEThR3IYpaJMG
         CD+qvXr8pj2L8+upyEjV4e1X6jLcgwnM0M1vQlu6X2yMw0odqyT4A0DYtbH2v43Dp7Pc
         h9wytmkLYKwA7kQm5Mw6KyE5t7T/Fcjj8wnQAUP6s8d9BbQQ+EgSandeLiENJUmy58nS
         Ll8pMjprUcovW4J3g2BoOZGEOgpEM1NVtcv2I0nSs9Ozkv1p56BFfPwbbFsloKkopKbz
         mrP6D3w787nDMJ8dZER1tLA3iUNI8U5nL8gtwhNw8ad0iYqh8EwqWQyn51rqniZtUYFD
         t8rw==
X-Gm-Message-State: AOAM531xnqh5oiDA43ue8ZIOqCQ1C0Vpt6pRbzpBcFOprf18/YbiNvRG
        Eeigp2JttN7y6KwG9/CjUIKOKAMyB26fvg5wW2XY0xSldVhNkA==
X-Google-Smtp-Source: ABdhPJyn9LDIZGbub/7z8RGagN/6TYTzzDeY+OdgCnMbmw2kKtXmW9ktilhLyAwJM5GFR2KT7E7lOlS4jdP/dK/PnzA=
X-Received: by 2002:a17:902:8c8f:b029:d9:eb18:3a99 with SMTP id
 t15-20020a1709028c8fb02900d9eb183a99mr11883435plo.13.1606140944111; Mon, 23
 Nov 2020 06:15:44 -0800 (PST)
MIME-Version: 1.0
References: <202011200603.Fq2dmeMk-lkp@intel.com>
In-Reply-To: <202011200603.Fq2dmeMk-lkp@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 23 Nov 2020 15:15:33 +0100
Message-ID: <CAAeHK+zykqmcDPAa5GAeu4hSfyWF-D4PAa15y=CSgtAxSQTkGQ@mail.gmail.com>
Subject: Re: drivers/net/wan/slic_ds26522.c:205:12: warning: stack frame size
 of 12288 bytes in function 'slic_ds26522_probe'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 11:16 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3494d58865ad4a47611dbb427b214cc5227fa5eb
> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
> date:   3 months ago
> config: arm64-randconfig-r002-20201119 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project b2613fb2f0f53691dd0211895afbb9413457fca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/net/wan/slic_ds26522.c:205:12: warning: stack frame size of 12288 bytes in function 'slic_ds26522_probe' [-Wframe-larger-than=]
>    static int slic_ds26522_probe(struct spi_device *spi)
>               ^
>    1 warning generated.
> --
> >> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:194:12: warning: stack frame size of 18352 bytes in function 'st7789v_prepare' [-Wframe-larger-than=]
>    static int st7789v_prepare(struct drm_panel *panel)
>               ^
>    1 warning generated.

Same issue as reported previously. Copying my response from the other
email just in case:

This is the same issue in LLVM that was reported by Arnd for generic
KASAN (also see KASAN_STACK_ENABLE option description). By default
KASAN shouldn't have stack instrumentation enabled unless
KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
for KASAN_SW_TAGS config on the kernel test robot.

[1] https://bugs.llvm.org/show_bug.cgi?id=38809
