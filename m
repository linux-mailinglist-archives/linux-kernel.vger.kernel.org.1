Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710892E8DCF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 19:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbhACSjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 13:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbhACSjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 13:39:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 154C3208BA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 18:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609699141;
        bh=1gzdyXY4h/wwDwh9061JmyDJFt1tPnc1xrQ+kbmqN9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ooQXhMGDeV+50gshBN5x10evzZwMNhiw4L7U20M3QdSpH4OV1vbD4RauOpXZ3nGDR
         Lz8LfPEcHFirnXTUtnnHluXFpaXFCMm+2ZB3Pg4k1xiT+Z2+ZlHkumVSYmjYCnbNGf
         O527+5TFGgHCgokM6GRmHMuqECr/4MIi0jO+dSRB4zBihfcJP4Y/R7edoDMn85hDkb
         6mqtQvlkDrGBMdBySgnQm1Hx8emLxzd3GBcOyPdbFJHFs+SKDdtzn/SEhszzuJZafv
         BaJ9iQX0EzrtvUA5JEkjk3fhV6Fcao/ktd6jhwF6NXQPBvvFiCBHB0NZlV1NUT7dy4
         wd1Z3LTvnR4kA==
Received: by mail-ot1-f49.google.com with SMTP id w3so24099649otp.13
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 10:39:01 -0800 (PST)
X-Gm-Message-State: AOAM530pU/erMrzpD/Yhp5+6ZM/+6ZWW3COnK5hzKmnhvxfrDCOpokP0
        vELK/N/O1FhnzWRFcjgGPryuq7tjwSnhUi+gLHo=
X-Google-Smtp-Source: ABdhPJwFqfaF0KvE0DQuSO4pNB525Wq4bIJdHdLYh6etgqFgae//cMjDmYWmA6JbGIKQXNAR37XHmxWF3artosWU0rE=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr50467524otr.210.1609699140454;
 Sun, 03 Jan 2021 10:39:00 -0800 (PST)
MIME-Version: 1.0
References: <20210103140104.3853922-1-arnd@kernel.org> <871rf2km2c.wl-maz@kernel.org>
In-Reply-To: <871rf2km2c.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 3 Jan 2021 19:38:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1W7O_qKO6QuddO462fzJ--x3JGpDk=YqPk7yQm16-Zcg@mail.gmail.com>
Message-ID: <CAK8P3a1W7O_qKO6QuddO462fzJ--x3JGpDk=YqPk7yQm16-Zcg@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: remove incorrect __init annotation
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Andrew Scull <ascull@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 5:43 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 03 Jan 2021 14:00:50 +0000,
> Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > When hyp_cpu_pm_exit() is not inlined, it causes a link time warning:
> >
> > WARNING: modpost: vmlinux.o(.text+0x39974): Section mismatch in reference from the function kvm_arch_init() to the function .init.text:hyp_cpu_pm_exit()
> > The function kvm_arch_init() references
> > the function __init hyp_cpu_pm_exit().
> > This is often because kvm_arch_init lacks a __init
> > annotation or the annotation of hyp_cpu_pm_exit is wrong.
> >
> > This is not only called at boot time, so remove the annotation
> > to prevent undefined behavior in case it gets called after being
> > freed.
>
> It *is* only called at boot time (despite these functions being called
> from module_init(), KVM cannot be built as a module on arm64).

Ah, I see where I went wrong: I looked at the callers of kvm_arch_init_vm()
instead of kvm_arch_init().

      Arnd
