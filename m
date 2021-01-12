Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FBD2F2536
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbhALBA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 20:00:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbhALBA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 20:00:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F132FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 17:00:17 -0800 (PST)
Received: from zn.tnic (p200300ec2f088f0064dd88f751605e0c.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:64dd:88f7:5160:5e0c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B34B61EC0529;
        Tue, 12 Jan 2021 02:00:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610413215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMkDrWGGqxWvnwqtep6OcXKhpCNBaItznidTXPHeJCI=;
        b=kHBEzKSpwjiMcszhiCYuOQ2L3ofuxybqi+NDS++/7+1aNt5G4x1NejnKYoC/rKCcN4Pcij
        M5ZjUu/DQEVfDxwbACAK23l+frtb90FttThSbZg513uCYEAWmHCUTFcgCT0zP+fXYT9XtX
        oTlJdz3XegdhdOV+g+w/PvABWDUzyfg=
Date:   Tue, 12 Jan 2021 02:00:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112010010.GA8239@zn.tnic>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic>
 <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 04:41:52PM -0800, Fāng-ruì Sòng wrote:
> To be fair: we cannot use

Who's "we"?

> .L-prefixed local because of the objtool limitation.

What objtool limitation? I thought clang's assembler removes .text which
objtool uses. It worked fine with GNU as so far.

> The LLVM integrated assembler behavior is a good one

Please explain what "good one" means in that particular context.

> and binutils global maintainers have agreed so H.J. went ahead and
> implemented it for GNU as x86.

But they don't break old behavior, do they? Or are they removing .text
unconditionally now too?

> --generate-unused-section-symbols=[yes|no] as an assembler option has
> been rejected.

Meaning what exactly? There's no way for clang's integrated assembler to
even get a cmdline option to not strip .text?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
