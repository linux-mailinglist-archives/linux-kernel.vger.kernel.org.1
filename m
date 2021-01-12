Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81AB2F2E77
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbhALLzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbhALLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:55:03 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C0AC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:54:23 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e8c0026b5c8bc02f060b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8c00:26b5:c8bc:2f0:60b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 976E11EC05BC;
        Tue, 12 Jan 2021 12:54:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610452461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=pbmP+Y+nQ4eRzxNH1AOZNvl8RJ+TeM4Bs8STiGzFims=;
        b=pso3UWjE71pnIktyfAqh8a4iKQWMqXdCxGwupp93WFtRRiMrxRa0pmHb16sqi0kbG75jqJ
        GmV2CPiHdfDWYkk5eW8vTwt+HVpWq1gCS0fdv0iTmD4qzzrjc7BFYeZZTZTRhGQxyo0zj3
        5wl6mAOok6jfuAxx95rUQijpbJMiyx4=
Date:   Tue, 12 Jan 2021 12:54:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112115421.GB13086@zn.tnic>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic>
 <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
 <20210112010010.GA8239@zn.tnic>
 <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
 <20210112015952.jdystnwkvuxsrwa2@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112015952.jdystnwkvuxsrwa2@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:59:52PM -0600, Josh Poimboeuf wrote:
> Right.  In the vast majority of cases, .L symbols are totally fine.
> 
> The limitation now being imposed by objtool (due to these assembler
> changes) is that all code must be contained in an ELF symbol.  And .L
> symbols don't create such symbols.
> 
> So basically, you can use an .L symbol *inside* a function or a code
> segment, you just can't use the .L symbol to contain the code using a
> SYM_*_START/END annotation pair.
> 
> It only affects a tiny fraction of all .L usage.  Just a handful of code
> sites I think.

@Nick, this belongs into the commit message too pls.

Also,

Documentation/asm-annotations.rst
include/linux/linkage.h

would need some of that blurb added explaining to users *why* they
should not use .L local symbols as SYM_* macro arguments.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
