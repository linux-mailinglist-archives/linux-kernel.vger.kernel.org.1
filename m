Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB0562D6BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394331AbgLJXUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394206AbgLJXTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:19:38 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A7C061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:18:58 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n1so3029867pge.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuo3hOaqklmDAlFeyNMO9tK7FfLVT9BZ8OlP4OtCFqU=;
        b=loFvrO8ObA/6GshmdsKH7qoI9iCisWk9O7eMVsEDDZ7795PK+dK/Q+MwLj0jnH2RFz
         vH6+g/5LTdZhvhkEFVoIddq3QyjSAE3in4aK+MoNY+uX1lEgr3aoFQXm+PzxS5sajEEA
         tByw4b/yDS3LOmXy1Fag/9bVMqWF75R3JnSNCZ9MIe7dxlBFqTnDaRd/X/eWIOzlB56o
         DiOCxZOKFuuoao5akTG99bCddkdqOFHs+sIWXA+IqBtcNvihhXQAnQnyrFdCjPSEjhcx
         PYnf4I2cmhjEEB8BpxDv4p7d05/5F3UEPkaYM19XqyMZGGUjGGnVp1aCmldrS1pBtQQV
         R9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuo3hOaqklmDAlFeyNMO9tK7FfLVT9BZ8OlP4OtCFqU=;
        b=nbSBfGNSvDftuzRuL+PfQaM22ydmNx6ykru+UZGf2UVPvEnhY6131jxn4Zd4vAc02y
         8F1QTw1kuBkUiDvyQsCpg2c+PReXX19z/s/iXyuzZeP9VR2iTwDMfImYpPOYWC0XGUSA
         J2JuM+lu6u/f9iiFUY0s69SXBKONPzIA1/vWTM9q5agDgHM9blXE+xe8thrNkZjmXDR+
         YpZmYue1Deg8PjtMetW3HFuFrp8t41aazD9Q0hI+LGnIjqxI0/d1/7RyCHAgbzcpnnv8
         0Salwi0OlnvOR3QdGKMNUuMqf7A+bHKI5+8F+Tl1csb0I620T2ts60qsGZAsIhkT+alu
         gECw==
X-Gm-Message-State: AOAM531219O2ylbfOzLIPgQYjA6HZQ8Qxadbufd9xxAr4/rdRFaK+b1j
        tAaiOvh1cb7n5TonSZf/M+GHqUNZyrhDwnbsDCYHHA==
X-Google-Smtp-Source: ABdhPJyDDDi9Z5GVLzojZF2EUUtYtg8RykVb977GkQUKX/ddOlgF60hTUp1sYQqTLza67iQBIC/HbF23QhwfBnvUYp4=
X-Received: by 2002:a63:184c:: with SMTP id 12mr1370518pgy.381.1607642337689;
 Thu, 10 Dec 2020 15:18:57 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAST0Ma4bGGOA_HATzYAmRhZG=x_X=8p_9dKGX7bYc2FMA@mail.gmail.com>
 <20201104005343.4192504-1-ndesaulniers@google.com> <20201104005343.4192504-5-ndesaulniers@google.com>
 <20201124172836.GA346213@rani.riverdale.lan> <CAKwvOdkGvLrPr4pHi4LKCF5t74+wencdy7r38d3k_4pC9pQYwQ@mail.gmail.com>
 <CAKwvOdmEVM67v8PqPWHP-VyGTkQpkWv8FdOTbxQ-7ebvSummMA@mail.gmail.com> <X8psgMuL4jMjP/Oy@rani.riverdale.lan>
In-Reply-To: <X8psgMuL4jMjP/Oy@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Dec 2020 15:18:45 -0800
Message-ID: <CAKwvOd=SbbJptBbv3y39_ZCeTbO0vb_fa5ZbQQ2LUquegzLycg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Kbuild: implement support for DWARF v5
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     Jakub Jelinek <jakub@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 9:06 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Thu, Dec 03, 2020 at 03:28:14PM -0800, Nick Desaulniers wrote:
> > On Thu, Dec 3, 2020 at 3:22 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > On Tue, Nov 24, 2020 at 9:28 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > On Tue, Nov 03, 2020 at 04:53:43PM -0800, Nick Desaulniers wrote:
> > > > > DWARF v5 is the latest standard of the DWARF debug info format.
> > > > >
> > > > > Feature detection of DWARF5 is onerous, especially given that we've
> > > > > removed $(AS), so we must query $(CC) for DWARF5 assembler directive
> > > > > support.  GNU `as` only recently gained support for specifying
> > > > > -gdwarf-5.
> > > >
> > > > With gcc, using -gdwarf-5 even without -Wa,--gdwarf-5 results in
> > > > considerably smaller debug info. gcc does not seem to generate the .file 0
> > > > directive that causes older GNU as to barf.
> > > >
> > > > Should the assembler support check be restricted to CC_IS_CLANG?
> > >
> > > No, because if LLVM_IAS=1 then the assembler support need not be checked.
> >
> > Also, if your version of GCC supports DWARF Version 5, but your
> > version of GAS does not, then I'm more inclined to not allow
> > CONFIG_DEBUG_INFO_DWARF5 to be selectable, rather than mix and match
> > or partially support this for one but not the other.  Either all tools
> > used support DWARF 5, or you don't get to use DWARF 5.
> >
>
> Why? Does this actually cause any problems?
>
> It seems like the options for gcc can actually be very straightforward:
> you just need a cc-option check, and then add -gdwarf-N to both CFLAGS
> and AFLAGS and you're done.  Adding the -Wa flag is superfluous and
> carries the risk of interfering with what the compiler driver does. Just
> let the gcc driver handle the details.
>
> Clang/IAS is almost as straightforward, with the only additional edge
> case being that for assembler files, DWARF 2 doesn't work, so the CFLAGS
> is the same -gdwarf-N, but AFLAGS gets -gdwarf-N only if N > 2.
>
> The messy case is only Clang/IAS=0, which needs to check the support
> from the external assembler, and needs CFLAGS of -gdwarf-N and AFLAGS of
> -Wa,--gdwarf-N, because Clang doesn't pass that option on to an external
> assembler. This is why I was asking if the assembler support check can
> be restricted to CC_IS_CLANG: nothing but Clang/IAS=0 actually requires
> that check.

Oh, I see. Yeah, that might be a nicer approach.  What should we do in
the case of gcc < 7 though, where -gdwarf-5 won't produce DWARF v5?
Maybe that's ok, but the intent behind the Kconfig check was to
prevent the option from being selectable if the tools do not support
it.  Maybe it's more flexible to pass the arguments along, and hope
for the best?

As a gcc-5 user, I might be surprised if I chose
CONFIG_DEBUG_INFO_DWARF5 if what I got was not actually DWARF v5; it
does violate the principle of least surprise.  Maybe that doesn't
matter though?
-- 
Thanks,
~Nick Desaulniers
