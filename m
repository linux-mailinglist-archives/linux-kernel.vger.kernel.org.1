Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49032F4E14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhAMPDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:03:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbhAMPDS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:03:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65E2623600;
        Wed, 13 Jan 2021 15:02:35 +0000 (UTC)
Date:   Wed, 13 Jan 2021 15:02:32 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] compiler.h: Raise minimum version of GCC to 5.1 for arm64
Message-ID: <20210113150232.GA27045@gaia>
References: <20210112224832.10980-1-will@kernel.org>
 <CAHk-=wi5oACdjFwnaonTWPVpBpwohxeJJJDvLvMS85RzrX5SYQ@mail.gmail.com>
 <CAHk-=wh-+TMHPTFo1qs-MYyK7tZh-OQovA=pP3=e06aCVp6_kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-+TMHPTFo1qs-MYyK7tZh-OQovA=pP3=e06aCVp6_kA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 06:35:50PM -0800, Linus Torvalds wrote:
> On Tue, Jan 12, 2021 at 6:14 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Ack. I'll assume I get this the usual ways from the arm64 tree..
> 
> Oh.. Actually, while you can use my ack if you decide to go this way,
> I do wonder if it might not be better to introduce a notion of an
> error at Kconfig time, and then we could make this whole GCC_VERSION
> check be something that gets covered much earlier - when configuring
> the kernel, rather than randomly (ok, very early) when building it.
> 
> We already have the CONFIG_GCC_VERSION config variable, after all.
> 
> And Kconfig already has an error functionality, which it uses for
> things like compilers not found etc.
> 
> So something like
> 
>      $(error-if,CC_IS_GCC && GCC_VERSION < 90100,"Gcc version too old")
> 
> in the arm64 Kconfig file should do it.

$(error-if) seems to expect a y/n as a condition. We do have $(failure)
and $(success) but they translate a (shell) command's return code to
y/n. Even with something like:

config GCC_IS_OLD
	def_bool CC_IS_GCC && GCC_VERSION < ...

I can't get $(error-if,GCC_IS_OLD) to expand the config value, no matter
what other. GCC_VERSION is also a config option in your example.

I'll queue Will's patch in the meantime.

-- 
Catalin
