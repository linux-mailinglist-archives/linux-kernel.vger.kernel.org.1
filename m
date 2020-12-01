Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B142CADE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgLAU4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgLAU4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:56:44 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2B0C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:56:04 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id w187so1944567pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jvZxaR1uxdRFvn7XeforUrhpQcomda06FE9z8v9SF+I=;
        b=TFwSRXZw8tzrXF6TjZXpiOFHg1eTcIgsU/gnBsZvwrvBMi/VZtwhWsjJP6MDcyV7Xq
         EY1E3QlJDD2LP1zBZrGfMVxa/86yeHYBcTCHMhgcRUuE1NU55SXri1WRb5qI4RcXvbGK
         JWM4/WDllREpTawjswqFJddFIBj+qQ75I3XUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jvZxaR1uxdRFvn7XeforUrhpQcomda06FE9z8v9SF+I=;
        b=XXmThpiQKR725wFYhuYXmMmP0rNDCGdriBXzFGdWo3nxmH1zuKpdIE3Q9ZlK1rhZPB
         k8UK/sMq9KhBTZbxi/Ogpp/EOqi9fOWRBY40UlZVplweykfri3SyVYLyvDpDn3rVlxGz
         QZqZ6pDRUpmoTppA3BrjDr8Ysm+O0AycJ4YqLXTtx/bsPCq/0sS5SHGWVbkr/W6rg7GP
         Bl3BJxRn0azze8QqIMZEmV0sao+S6lIucsajp01SH+/3jwDOQqV41ncJ9ZQE31UI7ygY
         xzxmYL3HpAgdJK75hxa2oe//7s4Gq9lNkvmnzQnI/vlGtMDiPysxrU4d10ZQo3utxJi1
         aquw==
X-Gm-Message-State: AOAM533zGpDP24AYVQLBe6uzDRiiO4Ox7zX+LEhGm30z76PZJSuhz5at
        L7H7HDyOPxS1UGYyy9DphK9IvA==
X-Google-Smtp-Source: ABdhPJzCxMuBuZrRcsbYPBK43PxlNzAPIn7sX9mea5Y6YmB2SSRco81+JiT9a3Pib4DSr+575XOIFA==
X-Received: by 2002:a62:293:0:b029:197:96c2:bef6 with SMTP id 141-20020a6202930000b029019796c2bef6mr4299536pfc.62.1606856164000;
        Tue, 01 Dec 2020 12:56:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i26sm597443pfq.148.2020.12.01.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:56:02 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:56:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] kbuild: Disable CONFIG_LD_ORPHAN_WARN for ld.lld
 10.0.1
Message-ID: <202012011255.9D677ED3@keescook>
References: <20201113195553.1487659-1-natechancellor@gmail.com>
 <20201119204656.3261686-2-natechancellor@gmail.com>
 <CAKwvOdkPgwL8H4EGF6=-VuxTdmxA8JHhGbLHVYcLJj9MmAvW=g@mail.gmail.com>
 <202011241421.A2F3062A70@keescook>
 <CAK7LNAR=_+1K7EtpvGzgyM+ans-iNOT0PBXdLRApnsyAzakQ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAR=_+1K7EtpvGzgyM+ans-iNOT0PBXdLRApnsyAzakQ3w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:31:37PM +0900, Masahiro Yamada wrote:
> On Wed, Nov 25, 2020 at 7:22 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Nov 19, 2020 at 01:13:27PM -0800, Nick Desaulniers wrote:
> > > On Thu, Nov 19, 2020 at 12:57 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > ld.lld 10.0.1 spews a bunch of various warnings about .rela sections,
> > > > along with a few others. Newer versions of ld.lld do not have these
> > > > warnings. As a result, do not add '--orphan-handling=warn' to
> > > > LDFLAGS_vmlinux if ld.lld's version is not new enough.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1187
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1193
> > > > Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
> > > > Reported-by: kernelci.org bot <bot@kernelci.org>
> > > > Reported-by: Mark Brown <broonie@kernel.org>
> > > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > >
> > > Thanks for the additions in v2.
> > > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > I'm going to carry this for a few days in -next, and if no one screams,
> > ask Linus to pull it for v5.10-rc6.
> >
> > Thanks!
> >
> > --
> > Kees Cook
> 
> 
> Sorry for the delay.
> Applied to linux-kbuild.

Great, thanks!

> But, I already see this in linux-next.
> Please let me know if I should drop it from my tree.

My intention was to get this to Linus this week. Do you want to do that
yourself, or Ack the patches in my tree and I'll send it?

-Kees

-- 
Kees Cook
