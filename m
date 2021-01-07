Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDBD2ED3FC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAGQK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728246AbhAGQK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:10:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 515C123433
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 16:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610035816;
        bh=vapd4O3zO+WFwOHRjONF5NNNhlVJffBZwsqWNIoaipg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aXgpa2fI9I9KmOzQNA+drIIhpRXmu1N7lB7Jy9H365Yof5/Y15u2SCET+q78z6Sl6
         PvS0Mj6hI5pmuZDteIBJy38VU/OdbdyMaftLTDWILpWMjdL1T/xloY8lHNfzSOt8Fk
         9vIQr7AJQXmGWZktas9CGqZlE1hlKmsdqe8ipSqJg7RksMOelfa80CJxYF2GrHs4df
         cYfiXIH/79ich68rsTa6NTNu11W/AJz8K8Kr2oOGbrplYKSAo9owOekIPD6i+5kycz
         9zo/ydAG0HxB2efxzpYSmOmZoX6CQpBhgGkDp6vkVIWkC1x7qaofiWI0w6Ojm2cCTG
         Z9SaDxW6hB+OQ==
Received: by mail-ot1-f51.google.com with SMTP id b24so6793496otj.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 08:10:16 -0800 (PST)
X-Gm-Message-State: AOAM532dxEAlb4PckkYItoHz2tJZOw3gmZIis1SUe8g42VXOShrhomn9
        iSnHOtE45RjFM6bq5LnaoXObW9N33JhBYgK9yUI=
X-Google-Smtp-Source: ABdhPJwn/fP7SDlXqDclnhOBWcwdtcInO7gVhxLM5h1d5IoCHJiOfp9I3NLwapW9GDUznpYCdxzm9V/aBMIfIfIOTsA=
X-Received: by 2002:a9d:7a4b:: with SMTP id z11mr7058883otm.305.1610035815622;
 Thu, 07 Jan 2021 08:10:15 -0800 (PST)
MIME-Version: 1.0
References: <20201230154749.746641-1-arnd@kernel.org> <202101061350.913E1FDF6@keescook>
 <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
In-Reply-To: <CAK8P3a1tSaUE2uzb2JbQ1f7LWmkiHQtSxzJHmfa=fqT3fNXOPA@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Thu, 7 Jan 2021 17:09:59 +0100
X-Gmail-Original-Message-ID: <CAK8P3a220+yeN8_PjS-jzA85m7QPbqn0oxEqjCzVR9S7p4LaZg@mail.gmail.com>
Message-ID: <CAK8P3a220+yeN8_PjS-jzA85m7QPbqn0oxEqjCzVR9S7p4LaZg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: disable unsigned-integer-overflow sanitizer with clang
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        George Popescu <georgepope@android.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 11:12 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Jan 6, 2021 at 10:57 PM Kees Cook <keescook@chromium.org> wrote:
> > On Wed, Dec 30, 2020 at 04:47:35PM +0100, Arnd Bergmann wrote:
> > > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > > index 8b635fd75fe4..e23873282ba7 100644
> > > --- a/lib/Kconfig.ubsan
> > > +++ b/lib/Kconfig.ubsan
> > > @@ -122,6 +122,8 @@ config UBSAN_SIGNED_OVERFLOW
> > >
> > >  config UBSAN_UNSIGNED_OVERFLOW
> > >       bool "Perform checking for unsigned arithmetic overflow"
> > > +     # clang hugely expands stack usage with -fsanitize=object-size
> > > +     depends on !CC_IS_CLANG
> > >       depends on $(cc-option,-fsanitize=unsigned-integer-overflow)
> >
> > Because of Clang implementation issues (see commit c637693b20da), this is
> > already "default n" (and not supported under GCC at all). IIUC, setting
> > this to "depends on !COMPILE_TEST" won't work for randconfigs, yes?
>
> Ah, I had not realized this is clang specific. Adding the !COMPILE_TEST
> dependency would hide it for me, which may be good enough for me.
>
> > Is there some better way to mark this as "known to have issues, please
> > don't include in randconfig?"
> >
> > I'd like to keep it around so people can continue to work out the
> > problems with it, but not have unexpecting folks trip over it. ;)
>
> I've reverted that patch locally now and default-enabled for randconfigs.
> Now that I have an otherwise clean build, this should provide me
> with a full set of files that produce the warning. If the number is
> small enough, I could try opening individual github issues.

A day's worth of randconfig builds with clang-11 or clang-12 shows these
instances that exceeded the warning limit:

crypto/blake2b_generic.c:98:13: error: stack frame size of 9636 bytes
in function 'blake2b_compress' [-Werror,-Wframe-larger-than=]
crypto/sha512_generic.c:151:13: error: stack frame size of 1292 bytes
in function 'sha512_generic_block_fn' [-Werror,-Wframe-larger-than=]
lib/crypto/curve25519-fiat32.c:312:22: error: stack frame size of 2180
bytes in function 'fe_mul_impl' [-Werror,-Wframe-larger-than=]
lib/crypto/curve25519-fiat32.c:444:22: error: stack frame size of 1588
bytes in function 'fe_sqr_impl' [-Werror,-Wframe-larger-than=]
fs/btrfs/scrub.c:3028:31: error: stack frame size of 1132 bytes in
function 'scrub_stripe' [-Werror,-Wframe-larger-than=]
drivers/net/ethernet/intel/e1000/e1000_main.c:3590:6: warning: stack
frame size of 1100 bytes in function 'e1000_update_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/broadcom/tg3.c:11829:13: warning: stack frame
size of 1188 bytes in function 'tg3_get_estats' [-Wframe-larger-than=]
drivers/net/ethernet/intel/igb/igb_main.c:6551:6: warning: stack frame
size of 1348 bytes in function 'igb_update_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/intel/igc/igc_main.c:3608:6: warning: stack frame
size of 1124 bytes in function 'igc_update_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/qlogic/qed/qed_l2.c:1759:1: warning: stack frame
size of 1300 bytes in function '__qed_get_vport_port_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7022:6: warning: stack
frame size of 1564 bytes in function 'ixgbe_update_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/intel/ixgb/ixgb_main.c:1590:1: warning: stack
frame size of 1140 bytes in function 'ixgb_update_stats'
[-Wframe-larger-than=]
drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c:145:6: warning:
stack frame size of 1068 bytes in function 'mlx5i_get_stats'
[-Wframe-larger-than=]
drivers/staging/media/atomisp/pci/atomisp_cmd.c:5600:5: warning: stack
frame size of 1052 bytes in function 'atomisp_set_fmt'
[-Wframe-larger-than=]

All of these *only* happen on 32-bit x86, and can be reproduced in a
i386_defconfig, with the corresponding drivers (btrfs, sha512, blake2b,
curve25519, and the ethernet ones) and UBSAN_UNSIGNED_OVERFLOW
manually enabled. Given that few people still care about i386, maybe
we could just make the option depend on !CONFIG_X86_32

That config also runs into two more BUILD_BUG_ON() that I had not
seen in randconfig tests:

(i386 defconfig plus ubsan)
ld.lld: error: undefined symbol: __compiletime_assert_207
>>> referenced by cpu_entry_area.c
>>>               mm/cpu_entry_area.o:(setup_cpu_entry_area_ptes) in archive arch/x86/built-in.a

(x86-64 defconfig plus ubsan)
ld.lld: error: undefined symbol: __compiletime_assert_362
>>> referenced by efi_64.c
>>>               platform/efi/efi_64.o:(efi_sync_low_kernel_mappings) in archive arch/x86/built-in.a

      Arnd
