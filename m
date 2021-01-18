Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A602F9E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390376AbhARLfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:35:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390124AbhARLe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:34:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD4D6223E8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610969625;
        bh=txk10ZQHyvu2GMlkLWui5NfVGpXFv+qmKa1QzK/nGf8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FuABfqlzT3oMj/LQPLZjx6Uf1zfxI6yPH0S+8QGQbr1rt1oau0Pn24w3vS0DM512r
         1CYMfxdR0LriSjFsxOh797WDh/OqmX6DcHIbxIlqyjOaQS4YgMkMbULfGtF0Tdo0N4
         g/imQ3YPzeAiFOfjjtHd3UAbrmimJvQSnbQFJNI+VLO9pGhL1DCb/SLSboR8x8M3Br
         grXiYNyF3Wuwitnw1SYc0eV3YJz/rTP8QeuxvLJ55JiwjEa5wgX+pguomi8bd/vfIB
         zTBYfL4LMcYC183bPGRTDFEZ7KVVFMMDQZloclxTURkEoq/BXUdVHZ+MiS6hX4pJz5
         3qmCgo7taNvjw==
Received: by mail-ot1-f41.google.com with SMTP id 36so4382668otp.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:33:45 -0800 (PST)
X-Gm-Message-State: AOAM530MTJ2rhMrvUBLvb657dLCqM9O9LdBivLTErkp4micY75LHzD04
        AjvwaD7F4XGrTuXAgSy1vmN6T7Ws7E9wja3aEkc=
X-Google-Smtp-Source: ABdhPJwml+RiERDtONMZ73QMOzQ56HN7J1v0srndIItOmK4ALzgFsEZ2vBHWG/EGSL3kLqRnTiJSexhnlKbeLuk5l6E=
X-Received: by 2002:a9d:741a:: with SMTP id n26mr9868986otk.210.1610969625042;
 Mon, 18 Jan 2021 03:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20210118105557.186614-1-adrian.ratiu@collabora.com>
 <20210118105557.186614-2-adrian.ratiu@collabora.com> <CAK8P3a3dDgbppAB3Bm2iJA7LOqRvHZew1_e-yE1R=9mS4W4xjQ@mail.gmail.com>
 <87wnwafprh.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <87wnwafprh.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 18 Jan 2021 12:33:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1wxZH_sX9eeTGecvDYGTcniF7_ZoSj8LSOFhCTo_CB=A@mail.gmail.com>
Message-ID: <CAK8P3a1wxZH_sX9eeTGecvDYGTcniF7_ZoSj8LSOFhCTo_CB=A@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 1/2] arm: lib: xor-neon: remove unnecessary GCC
 < 4.6 warning
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 12:28 PM Adrian Ratiu
<adrian.ratiu@collabora.com> wrote:
> On Mon, 18 Jan 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> > On Mon, Jan 18, 2021 at 11:56 AM Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> No, clang does not produce vectorized code by default, not even
> with the -ftree-vectorize flag explicitely added like in the next
> patch in this series (that flag is enabled by default in clang
> anyway, so no effect).
>
> Clang needs more investigation and testing because with additional
> code changes it can be "forced" to output vectorized code, but
> that is outside the scope of this series.
>
> If you think it's a good idea I can add a warning only for Clang
> which makes more sense than telling clang users to upgrade their
> GCC, since now Clang is officially supported. What do you think?

Yes, either a warning or a Kconfig check seems better to me than
just trying to build code that ends up not doing what it is meant to.

       Arnd
