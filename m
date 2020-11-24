Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85C32C2500
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733096AbgKXLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732792AbgKXLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:52:09 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D63C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:52:08 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id 81so17259816pgf.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 03:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vNU3GMWTx/DC3GaJXt/7EgHjQNLt/FBx4UlGxf6Gj2U=;
        b=oXPgSdbPFZzPWmlTC79K7X8Eh2kSULaa7iirpjhRBjDNVs3uVtcwoz1px9+bF16sf2
         2YTND1A9WSX+R3qE3itaCGGR1wTig52shV/tE9XIDtGe3m+Y+PM0xcoqzlBgciciwk7p
         vl+pjBvlVXLpb63ynw3edmYofKoU+1p4xIZfPozqnOr2A2/q1WOqe6zCQi7DXdw9yG+5
         t2kMB8J4UlVaojX3V0y7gWIVEH1gi1GRU9kYeFHi52Mcw31uSqtz/tQBjUDhHkTniqZ/
         SJtPzpkuLxXDQo8MfHmLY6cPIE7Jao6x+DzvPYHmIUqaCj7woBamENq0v5tDS6TiAFmN
         ofrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vNU3GMWTx/DC3GaJXt/7EgHjQNLt/FBx4UlGxf6Gj2U=;
        b=kzXh2sjYYRDpyq7OXzZBXg+5bhZb/rgz7UE9fnTWzBRx12h/E5vZ+j13TKP58zx3HP
         ubQmimdKaqJbAk6cWRqEnFOC7x5r6ISyu2kbuVVpZJ7nxJn+KeGBQhFx2yGlpD1FsOIS
         6NhM5A9ri3RcwXQam/vAvn6rYdfPGwQHhTSVwRww4ejXyrSTNJQh0yXfTS2el6ANWC0X
         VI5u0KHdFHsvO8rCFpn1kMsFTf1vttN6xr5bsxmKETTJRLm/K80AOYdkymmtoGJhJLnV
         QG4S0uZL4HqLG6l2AhVO+XXWBVryIvVNAJQ5oRPP3OYuWqZs3sdXcg85fwMUvUQAWCZd
         YEEA==
X-Gm-Message-State: AOAM530FPvTvLyBZlrNGDtGtonqrUO2B5rK3md9PsjZs3MJkGNB6k2HZ
        Y6XdI3GfBr1b8IBzn4STz5O62+u/E7yynHfDAEPQFQ==
X-Google-Smtp-Source: ABdhPJz06UPRTC1bBiQswJ+8jW8anup8pq2AWgtNsGnY64BywytSkHDz6zYJwq+/MHp9LYPqfpkSQYCpoa4pWa/3WBc=
X-Received: by 2002:a62:3205:0:b029:197:f692:6a8b with SMTP id
 y5-20020a6232050000b0290197f6926a8bmr3638811pfy.2.1606218727772; Tue, 24 Nov
 2020 03:52:07 -0800 (PST)
MIME-Version: 1.0
References: <202011200603.Fq2dmeMk-lkp@intel.com> <CAAeHK+zykqmcDPAa5GAeu4hSfyWF-D4PAa15y=CSgtAxSQTkGQ@mail.gmail.com>
 <71e44c1f-3c9f-db89-0347-3e23699d67cb@intel.com>
In-Reply-To: <71e44c1f-3c9f-db89-0347-3e23699d67cb@intel.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 24 Nov 2020 12:51:57 +0100
Message-ID: <CAAeHK+wc=A=52o1fwK3KeRMk7k6QE-nuoU51TrkoRTWhAF44rQ@mail.gmail.com>
Subject: Re: [kbuild-all] Re: drivers/net/wan/slic_ds26522.c:205:12: warning:
 stack frame size of 12288 bytes in function 'slic_ds26522_probe'
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 9:02 AM Rong Chen <rong.a.chen@intel.com> wrote:
>
> On 11/23/20 10:15 PM, Andrey Konovalov wrote:
> > On Thu, Nov 19, 2020 at 11:16 PM kernel test robot <lkp@intel.com> wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   3494d58865ad4a47611dbb427b214cc5227fa5eb
> >> commit: cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4 kasan: allow enabling stack tagging for tag-based mode
> >> date:   3 months ago
> >> config: arm64-randconfig-r002-20201119 (attached as .config)
> >> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project b2613fb2f0f53691dd0211895afbb9413457fca7)
> >> reproduce (this is a W=1 build):
> >>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >>          chmod +x ~/bin/make.cross
> >>          # install arm64 cross compiling tool for clang build
> >>          # apt-get install binutils-aarch64-linux-gnu
> >>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >>          git fetch --no-tags linus master
> >>          git checkout cae9dc35ed9ff82a99754e51d57ff6c332e1f7e4
> >>          # save the attached .config to linux build tree
> >>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All warnings (new ones prefixed by >>):
> >>
> >>>> drivers/net/wan/slic_ds26522.c:205:12: warning: stack frame size of 12288 bytes in function 'slic_ds26522_probe' [-Wframe-larger-than=]
> >>     static int slic_ds26522_probe(struct spi_device *spi)
> >>                ^
> >>     1 warning generated.
> >> --
> >>>> drivers/gpu/drm/panel/panel-sitronix-st7789v.c:194:12: warning: stack frame size of 18352 bytes in function 'st7789v_prepare' [-Wframe-larger-than=]
> >>     static int st7789v_prepare(struct drm_panel *panel)
> >>                ^
> >>     1 warning generated.
> > Same issue as reported previously. Copying my response from the other
> > email just in case:
> >
> > This is the same issue in LLVM that was reported by Arnd for generic
> > KASAN (also see KASAN_STACK_ENABLE option description). By default
> > KASAN shouldn't have stack instrumentation enabled unless
> > KASAN_STACK_ENABLE is specified. Perhaps it makes sense to disable it
> > for KASAN_SW_TAGS config on the kernel test robot.
> >
> > [1] https://bugs.llvm.org/show_bug.cgi?id=38809
>
> Hi Andrey,
>
> Thanks for the explanation, we'll disable CONFIG_KASAN_SW_TAGS.

Hi Rong,

No, no, if you have a CONFIG_KASAN_SW_TAGS-based config - keep it
enabled, just disable CONFIG_KASAN_STACK_ENABLE to avoid these stack
overflows.

Thanks!
