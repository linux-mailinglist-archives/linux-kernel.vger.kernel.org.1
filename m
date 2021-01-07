Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05B62ED56D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbhAGRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbhAGRWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:22:42 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A04C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 09:22:02 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c79so4274728pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 09:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1sXzvs3mOYm88CqZyrkyfbEZtdG04fG5cAHRm8cuwGE=;
        b=C3StsWUeH5vPFv7yR6f4bxasLGMt7eSHo3rwGkrq4axTlRv/ut8jDaqXuvX2PjRmOQ
         6yOUJOkointmmm3JkrOj+0vzxkqYJV65L2K17xzneKRaan73Vwx/KA34m+B2gYaqQyjq
         SveymMAje7/eJYnE0NKQWq+9AHGcd3RZVtT4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1sXzvs3mOYm88CqZyrkyfbEZtdG04fG5cAHRm8cuwGE=;
        b=HjKluJbxYXkIT8fo7jZEeEVwINs8yFTrWco2Pa1g4656SvMLOWiuLb5atCrO9p15r4
         m9c0CW7AyZl7QxbeJw/E7PdHHrbHXHJQ5hI74q+4D7wRLpfXiwOwgE7Fxnl4APht0Skv
         rR/ANeVVBStaGt1RU2HSbI3sVDlkhAM7OTKqsRkhDOBzm7a9netzULjX6tk/lVpfiH/F
         kz0YhsCe0HCT6PkwNT+DmQaPfDKe/8sV5UH49vdJplLAURidq4Yqree+H64gPFFFfNea
         XToBc0zpCabdMhc9X7325Rmc/tBQ0WodY9xX9UlJHfVtubXENRoz0WM9zgAwJbZIekGr
         hvDA==
X-Gm-Message-State: AOAM532UkdEbN/3g9tYSaFAdado3Rb0I9FKALd73E4SOJdM4n+ydmhB1
        ERnKmOjumAj91D88kKlc2s4U5A==
X-Google-Smtp-Source: ABdhPJzZQh4dkF8F6FLXinF9ypvBFCYFGSnTKMkFUa6TGzXcE7vu9MCozEN2Qctxp5Wmx4LGU3MQZA==
X-Received: by 2002:a05:6a00:15ca:b029:19d:9ba1:b910 with SMTP id o10-20020a056a0015cab029019d9ba1b910mr3033547pfu.57.1610040121663;
        Thu, 07 Jan 2021 09:22:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v15sm6276240pfn.217.2021.01.07.09.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 09:22:00 -0800 (PST)
Date:   Thu, 7 Jan 2021 09:22:00 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with
 clang
Message-ID: <202101070919.2E20432140@keescook>
References: <20201230154749.746641-1-arnd@kernel.org>
 <202101061350.913E1FDF6@keescook>
 <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
 <CAK8P3a220+yeN8_PjS-jzA85m7QPbqn0oxEqjCzVR9S7p4LaZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a220+yeN8_PjS-jzA85m7QPbqn0oxEqjCzVR9S7p4LaZg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:09:59PM +0100, Arnd Bergmann wrote:
> On Wed, Jan 6, 2021 at 11:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Wed, Jan 6, 2021 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
> > > > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > > > index 8b635fd75fe4..e23873282ba7 100644
> > > > --- a/lib/Kconfig.ubsan
> > > > +++ b/lib/Kconfig.ubsan
> > > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > > >
> > > >  config UBSAN_UNSIGNED_OVERFLOW
> > > >       bool "Perform checking for unsigned arithmetic overflow"
> > > > +     # clang hugely expands stack usage with -fsanitize=object-size
> > > > +     depends on !CC_IS_CLANG
> > > >       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> > >
> > > Because of Clang implementation issues (see commit c637693b20da), this is
> > > already "default n" (and not supported under GCC at all). IIUC, setting
> > > this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?
> >
> > Ah, I had not realized this is clang specific. Adding the !COMPILE_TEST
> > dependency would hide it for me, which may be good enough for me.
> >
> > > Is there some better way to mark this as "known to have issues, please
> > > don't include in randconfig?"
> > >
> > > I'd like to keep it around so people can continue to work out the
> > > problems with it, but not have unexpecting folks trip over it. ;)
> >
> > I've reverted that patch locally now and default-enabled for randconfigs.
> > Now that I have an otherwise clean build, this should provide me
> > with a full set of files that produce the warning. If the number is
> > small enough, I could try opening individual github issues.
> 
> A day's worth of randconfig builds with clang-11 or clang-12 shows these
> instances that exceeded the warning limit:
> 
> crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes
> in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
> crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes
> in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
> lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180
> bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
> lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588
> bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
> fs/btrfs/scrub.c:3028:31: error: stack frame size of 1132 bytes in
> function 'scrub_stripe' [-Werror,-Wframe-larger-than=]
> drivers/net/ethernet/intel/e1000/e1000_main.c:3590:6: warning: stack
> frame size of 1100 bytes in function 'e1000_update_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/broadcom/tg3.c:11829:13: warning: stack frame
> size of 1188 bytes in function 'tg3_get_estats' [-Wframe-larger-than=]
> drivers/net/ethernet/intel/igb/igb_main.c:6551:6: warning: stack frame
> size of 1348 bytes in function 'igb_update_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/intel/igc/igc_main.c:3608:6: warning: stack frame
> size of 1124 bytes in function 'igc_update_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/qlogic/qed/qed_l2.c:1759:1: warning: stack frame
> size of 1300 bytes in function '__qed_get_vport_port_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7022:6: warning: stack
> frame size of 1564 bytes in function 'ixgbe_update_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/intel/ixgb/ixgb_main.c:1590:1: warning: stack
> frame size of 1140 bytes in function 'ixgb_update_stats'
> [-Wframe-larger-than=]
> drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c:145:6: warning:
> stack frame size of 1068 bytes in function 'mlx5i_get_stats'
> [-Wframe-larger-than=]
> drivers/staging/media/atomisp/pci/atomisp_cmd.c:5600:5: warning: stack
> frame size of 1052 bytes in function 'atomisp_set_fmt'
> [-Wframe-larger-than=]
> 
> All of these *only* happen on 32-bit x86, and can be reproduced in a
> i386_defconfig, with the corresponding drivers (btrfs, sha512, blake2b,
> curve25519, and the ethernet ones) and UBSAN_UNSIGNED_OVERFLOW
> manually enabled. Given that few people still care about i386, maybe
> we could just make the option depend on !CONFIG_X86_32

I'm fine with that -- or maybe any 32-bit architecture, if the problem
is poor stack space optimization on 32-bit archs?

> 
> That config also runs into two more BUILD_BUG_ON() that I had not
> seen in randconfig tests:
> 
> (i386 defconfig plus ubsan)
> ld.lld: error: undefined symbol: __compiletime_assert_207
> >>> referenced by cpu_entry_area.c
> >>>               mm/cpu_entry_area.o:(setup_cpu_entry_area_ptes) in archive arch/x86/built-in.a

That one I don't think I've seen before.

> 
> (x86-64 defconfig plus ubsan)
> ld.lld: error: undefined symbol: __compiletime_assert_362
> >>> referenced by efi_64.c
> >>>               platform/efi/efi_64.o:(efi_sync_low_kernel_mappings) in archive arch/x86/built-in.a

I think this is:
https://github.com/ClangBuiltLinux/linux/issues/256
and that bug needs re-opening? Or maybe there's a new bug I can't find?

-- 
Kees Cook
