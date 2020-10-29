Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E06B29EFCC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgJ2P2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgJ2P2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:28:18 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A2BC0613D5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:28:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t14so2638418pgg.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=apFGQpJNldG2edOQE4EMnGm/BVDPDRnfEMKqur5QD6U=;
        b=e2b8xCUIBxmMJWZFFdxKTaDEZEhukBhkuQSQMNDi6PdGOWHOuN19BWvM2HH9I65EFP
         t/aGj0+vE7J7fb3BlbQVFVpc67wqo39xxlB8Fqiz0/XyGjF8jbexNAJAWNmhzlJjyYrH
         9sJ1x10AfWGNbZTnJeSQXdhZN4+iEcAyTUQGXae0ZCCwQhVz1G0alZfgRHsYyCjd4MoZ
         E4b0/whUWA3weFohEH5D4BevvOrulcdh5h1tnhPmOfKePeD0KdpSi0/0InmXOGWbKqNz
         GRGGQhG5+qptwEw1W9e242HIcLvs2PIvgCOxZppG32w1NBYa5BXmAJjQngyyDZCRJAUo
         j4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=apFGQpJNldG2edOQE4EMnGm/BVDPDRnfEMKqur5QD6U=;
        b=foTWQfccOF4vKecoKsnmWkuHXmPj2DJYb1rSJEg0t/hSlQ7te1my/LQLci0wYtHWVY
         ZYUJv9atCTKT8K+lEd/F2BHHoASFh9OfMN+ccoonQMRDWUSMu/RcVwc36EzXIphS5GTS
         VfFMdHh+VtlEwBIsgFuBsZ5SMrYtxFJpz11WLEkugEIWuiIxGaNzeMMQfWgImzb3SgOG
         PkO8Sa2zoFeXw0wUFfpWGUpTFtubaC9+FW3Z2LxuPlrufmuiis43IrJZnBYM3k2H0M6G
         7UuD06+pjeYRemWrciexuH49MQoP21XT2MFUyrMUU6bC44LUZX5eovpvneoInCFR8kTA
         MqRg==
X-Gm-Message-State: AOAM531bBAK8L1yy3I2dPv2q2k1ZD8yKZx7UqbWqEGN+6/alAiorVGth
        E+rJmGt5Fm+UrSEW9eHswYgoOdKax7PDCPvtdt+/Ug==
X-Google-Smtp-Source: ABdhPJxiUY+zihYcZmcL0D9S99Sn+1JQYm46vWHTVY6QEqCusY9gO2m/NgjOAZph+pk5bmnvwF3j7Mn+jXRZ+oK2SYQ=
X-Received: by 2002:a17:90b:807:: with SMTP id bk7mr324734pjb.166.1603985297541;
 Thu, 29 Oct 2020 08:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <202010260230.VivTG0Gb-lkp@intel.com> <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
In-Reply-To: <20201025121708.04d4070a44e28146baf9a6a7@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 29 Oct 2020 16:28:06 +0100
Message-ID: <CAAeHK+wdv=X-iD208M2m3Xte9F+g2kYRDqQr4A+GP7Z1tY85BA@mail.gmail.com>
Subject: Re: drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame
 size of 13472 bytes in function 'ltv350qv_power'
To:     Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 25, 2020 at 8:17 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 26 Oct 2020 02:15:37 +0800 kernel test robot <lkp@intel.com> wrote:
>
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   d76913908102044f14381df865bb74df17a538cb
> > commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
> > date:   3 months ago
> > config: arm64-randconfig-r005-20201026 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 1c8371692dfe8245bc6690ff1262dcced4649d21)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm64 cross compiling tool for clang build
> >         # apt-get install binutils-aarch64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/video/backlight/ltv350qv.c:192:12: warning: stack frame size of 13472 bytes in function 'ltv350qv_power' [-Wframe-larger-than=]
>
> That's a lot of stack.
>
> >    static int ltv350qv_power(struct ltv350qv *lcd, int power)
> >               ^
> >    1 warning generated.
> >
> > vim +/ltv350qv_power +192 drivers/video/backlight/ltv350qv.c
>
> Odd - the code looks pretty normal.  It is possible that your compiler
> is (crazily) inlining ltv350qv_write_reg()?

This is the same issue in LLVM that was reported by Arnd for generic
KASAN (also see KASAN_STACK_ENABLE option description). By default
KASAN shouldn't have stack instrumentation enabled unless
KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
for KASAN_SW_TAGS config on the kernel test robot.

[1] https://bugs.llvm.org/show_bug.cgi?id=38809
