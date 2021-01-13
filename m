Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58E72F55D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 02:35:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbhANBaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 20:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbhANBT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 20:19:58 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEA1C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:27:22 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id c12so2214376pfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 15:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rhh6w6PnAshqzzDi7tIorGSnjSwjXHOfLfkdJH6Oxgk=;
        b=UsAe64kOAc8ogK7jOBzOesd7Gj13f2B4Po8m+3R3dmVXJk6pEq3gYcmuaRd7El09bO
         Pp9zCxf2v08t8ZWzssQTx0k0WdOnBcT3jgcHctNfwEtJoZYm3e3My7kUgzf5amFidX7U
         3RAcgUTqJ/nW4n7VBXamre7h42HseZwdwLdsy8OXsvbzJcBMowDxF2ZoCDZz1+kzzXJv
         j704xO1uL9COVu3l3LUelEPeCyK9q/+k0NcEh72F2vqTVL5V6wFlhm4hKS66EXiGDsqT
         OIP8nNh5erhaKpw9pbAOhJIe0W3K8OMJi6dJhV32YQQE5oiccvLsW6hzifztteos5F4h
         cXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rhh6w6PnAshqzzDi7tIorGSnjSwjXHOfLfkdJH6Oxgk=;
        b=e/PZAv/ADC/vjBgESQ4PjOY0mqrDRgJQ5xZG0rTaUhRxOSMLXne9y8RpLg8tumnWYR
         9G8353FudHFhL6s/oMSrS9Wj5mncQ8N22Ohs1pBuaK0C2DA6hltLllxaq+iUEocaP3WO
         u5EIOkRqIUQS/XCBibx4rDFCirkc3dekh7tKiwvvyBZ1XTNwOpQvb3gv4QqEOcy5Ap/m
         DFpbwnEGYHo2rZLiPl8FYsCE1ofdtBPRCAN1lTf0tl4vB0fgCdjEazO8otB74RMHz96w
         NuArKn8lJaZf1/5ADxMrkuCrZJ93LSxaOD9kaVKIlfnCYqYo/6DlxzLZV/yCTM60kcon
         5Dxg==
X-Gm-Message-State: AOAM532dRay9azmLD/fy9KYQq99Gg0ZUoYQPQseVdBHu2/uk45chR2em
        balqCFq/IKKcNd8M5UOszEZVQ5ylR+0FEuWatDImQ5vSEJmiYg==
X-Google-Smtp-Source: ABdhPJynbg/QsB8oO89RHz2rLF3RFS5Hrqec+YsAoymztXcghiURgnIYfZbNXYr16Sz5/nfz/+3mrTX2fRX2z2LbEqI=
X-Received: by 2002:a63:1142:: with SMTP id 2mr4397001pgr.263.1610580441323;
 Wed, 13 Jan 2021 15:27:21 -0800 (PST)
MIME-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
 <20210113003235.716547-3-ndesaulniers@google.com> <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
In-Reply-To: <CA+icZUV6pNP1AN_JEhqon6Hgk3Yfq0_VNghvRX0N9mw6pGtpVw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 13 Jan 2021 15:27:09 -0800
Message-ID: <CAKwvOdm40Z3YutxwWyV922XdchN7Dz+v9kJNjF13vKxNUXrJnQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] Kbuild: make DWARF version a choice
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sedat,
Thanks for testing, and congrats on https://lwn.net/Articles/839772/.
I always appreciate you taking the time to help test my work, and
other Clang+Linux kernel patches!

On Wed, Jan 13, 2021 at 1:24 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jan 13, 2021 at 1:32 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -826,12 +826,16 @@ else
> >  DEBUG_CFLAGS   += -g
> >  endif
> >
> > -ifneq ($(LLVM_IAS),1)
> > -KBUILD_AFLAGS  += -Wa,-gdwarf-2
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF2) := 2
> > +dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
> > +DEBUG_CFLAGS   += -gdwarf-$(dwarf-version-y)

^ DEBUG_CFLAGS are set for everyone (all toolchains) if
CONFIG_DEBUG_INFO is defined.

> > +ifneq ($(dwarf-version-y)$(LLVM_IAS),21)

^ "If not using dwarf 2 and LLVM_IAS=1", ie. CONFIG_DEBUG_INFO_DWARF5
&& CONFIG_CC_IS_GCC

> > +# Binutils 2.35+ required for -gdwarf-4+ support.
> > +dwarf-aflag    := $(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y))
> > +ifdef CONFIG_CC_IS_CLANG

^ "if clang"

> > +DEBUG_CFLAGS   += $(dwarf-aflag)
> >  endif
>
> Why is that "ifdef CONFIG_CC_IS_CLANG"?

That's what Arvind requested on v2, IIUC:
https://lore.kernel.org/lkml/X8psgMuL4jMjP%2FOy@rani.riverdale.lan/

> When I use GCC v10.2.1 DEBUG_CFLAGS are not set.

You should have -gdwarf-4 (and not -Wa,-gwarf-4) set for DEBUG_CFLAGS
when compiling with GCC and enabling CONFIG_DEBUG_INFO_DWARF4. Can you
please confirm? (Perhaps you may have accidentally disabled
CONFIG_DEBUG_INFO by rerunning `make defconfig`?)
-- 
Thanks,
~Nick Desaulniers
