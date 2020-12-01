Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E112CAEF6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390451AbgLAVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390151AbgLAVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:39:43 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59ACC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 13:38:29 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id b23so190289vsp.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUrtE9bCHLR1tahsqjwEvkYE/b4ecWVyJ0MZJXEWDmk=;
        b=LlVOL6rcXHeSwM5BfXBlegfhvMNR6VZLsv8rQyvwqckYHKPxMBEs8sd4bBTAM/NLL3
         QfSrVdpBBi9HSJdB+f6fk0mhQ0BxaAKNFB0n1aU5/sn8CKof8rf6tGib5lo7AwsjVbtO
         gqVtBXLMhiTbrGlloNzu8T6tvpiz27BbcOnycLdGlVz2ugezRzd2JMoM2BqA3hcR6vKi
         EJm05Ay+yi6Dx/TQFmeOHCJIzxbERp6ltaL44JwVtSGrFOpvIsL8fv3iWmKklSxL111V
         30zMFkTFejU9xFkfvhVP0U7UVLEYPZ6PBtQsmlZrIayJ+SsfsJck0mktwWBdnyqd60yN
         cBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUrtE9bCHLR1tahsqjwEvkYE/b4ecWVyJ0MZJXEWDmk=;
        b=pQKFmqFNT8gkdypI6aa+5dBZgRT+tvz/V4pJdpB9aBASRAPLxkqdAwoe4umg/dFUO0
         lXa90xhle+A2d+4VOi5Umk+q9rzNprCpzPOkqX8GjgfelncbDgnAZWuc2rMEGnFLDkvT
         SzjYME/hpSTsYnulyJM/ngcIYXz+3vnIo3lOrdxXvbRrORovX9tcchtVRBsjK6jK7knC
         oKfcux7GpYpBnzF1XHOPbRICAAzWvkeHd76vyvaw2QDN1mxOMlkfMsgsbmzZDuxxc3mY
         X8qoDjDpHQhGliahQYd6e1+pX+O7pxtZCmBftidiAflHj+NTgpIDtrPtlFyR36uYlynl
         qy9A==
X-Gm-Message-State: AOAM533B+V0S+b/PKZ3WB+Io5W11Oaf4NgJf3wPlzLKiK075wepCsdZh
        CC9aQYFbG9xm4xMhLkBEspaNdBlMlMKNW/INvX4pEw==
X-Google-Smtp-Source: ABdhPJyZHamjyZPb6fRzG5c1CShB2WPqyseO+WRJb2mo1g11IDe33LiL+wOMY00AgUGmgDLmQlcIjPJL3fjLk1JEgqs=
X-Received: by 2002:a67:f74f:: with SMTP id w15mr4961669vso.54.1606858708924;
 Tue, 01 Dec 2020 13:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
 <20201130120130.GF24563@willie-the-truck> <202012010929.3788AF5@keescook> <CAKwvOdkcfg9ae_NyctS+3E8Ka5XqHXXAMJ4aUYHiC=BSph9E2A@mail.gmail.com>
In-Reply-To: <CAKwvOdkcfg9ae_NyctS+3E8Ka5XqHXXAMJ4aUYHiC=BSph9E2A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 1 Dec 2020 13:38:17 -0800
Message-ID: <CABCJKudBfoE-Ya6_ZuS4d+DqOWObhFFU1bNe_NpfHroLvfOiyQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/17] Add support for Clang LTO
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 1, 2020 at 11:51 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Tue, Dec 1, 2020 at 9:31 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Nov 30, 2020 at 12:01:31PM +0000, Will Deacon wrote:
> > > Hi Sami,
> > >
> > > On Wed, Nov 18, 2020 at 02:07:14PM -0800, Sami Tolvanen wrote:
> > > > This patch series adds support for building the kernel with Clang's
> > > > Link Time Optimization (LTO). In addition to performance, the primary
> > > > motivation for LTO is to allow Clang's Control-Flow Integrity (CFI) to
> > > > be used in the kernel. Google has shipped millions of Pixel devices
> > > > running three major kernel versions with LTO+CFI since 2018.
> > > >
> > > > Most of the patches are build system changes for handling LLVM bitcode,
> > > > which Clang produces with LTO instead of ELF object files, postponing
> > > > ELF processing until a later stage, and ensuring initcall ordering.
> > > >
> > > > Note that v7 brings back arm64 support as Will has now staged the
> > > > prerequisite memory ordering patches [1], and drops x86_64 while we work
> > > > on fixing the remaining objtool warnings [2].
> > >
> > > Sounds like you're going to post a v8, but that's the plan for merging
> > > that? The arm64 parts look pretty good to me now.
> >
> > I haven't seen Masahiro comment on this in a while, so given the review
> > history and its use (for years now) in Android, I will carry v8 (assuming
> > all is fine with it) it in -next unless there are objections.
>
> I had some minor stylistic feedback on the Kconfig changes; I'm happy
> for you to land the bulk of the changes and then I follow up with
> patches to the Kconfig after.

These are included in v8, which I just sent out.

Sami
