Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8335C2F2E58
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731116AbhALLsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbhALLsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:48:16 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F22C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 03:47:35 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e8c0026b5c8bc02f060b7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:8c00:26b5:c8bc:2f0:60b7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9613B1EC05BC;
        Tue, 12 Jan 2021 12:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610452053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9ZHI8nF07rcMZHB/X81pRY/jX50+4Tbgi/vtsI2OQw4=;
        b=SvGQcJ9YyY5ZSTBSqmpVID/OAZ+N6a4BgZVQ4VRFB0KWfKjGD8PEPRA/o5Ue/G6SYp9NwO
        iEt6ZUr4tc0tyAu9PNE+3qw84RX3xbAKJ2DYc1AIl/NMj7OuP+CUrfunfxXo9Zwx/zKDIo
        yvmjguUmGJR1wqeJN7hVAEEj7FF41f0=
Date:   Tue, 12 Jan 2021 12:47:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112114725.GA13086@zn.tnic>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic>
 <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
 <20210112010010.GA8239@zn.tnic>
 <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:13:16PM -0800, Nick Desaulniers wrote:
> Unconditionally. See
> https://sourceware.org/pipermail/binutils/2021-January/114700.html
> where that flag was rejected and the optimization was adopted as the
> optimization was obvious to GNU binutils developers. So I suspect this
> will become a problem for GNU binutils users as well after the latest
> release that contains
> https://sourceware.org/pipermail/binutils/attachments/20210105/75dd4a9d/attachment-0001.bin.

Aha, thanks for this.

> I can clean that up in v5; The section symbols were not generated then
> stripped; they were simply never generated.

I'd appreciate a more verbose writeup explaining why this is being done,
but written for outsiders who are not necessarily toolchain developers.
So that it is clear months/years from now why this was done. Something
structured like this maybe:

  Problem is A.

  It happens because of B.

  Fix it by doing C.

  (Potentially do D).

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
