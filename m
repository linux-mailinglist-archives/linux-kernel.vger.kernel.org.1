Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011A42F25F7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 03:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbhALCB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 21:01:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25851 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbhALCB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 21:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610416801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OavUnJ3v/lGFi5ijff6RJv5HrBBprqBfJamMYtY2KXQ=;
        b=N8G1GiaXgoTUD/i9sM43KI8SqqlbwGZ3ULwu9IUK1jqn/4MIUSaG2pyoVdfsNxCIIWsvHe
        4609oUqCZzHxlqSq7DQTu7/pWXJtzjLf83XNl7RJKE+R1OVhRHS6U0yYEPOOlb0dE9I5jm
        RLQub4sqghViB/oCbvTKwZ9PEbpBbQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-H8oABsysMYWAmo0_0k7Rmw-1; Mon, 11 Jan 2021 20:59:57 -0500
X-MC-Unique: H8oABsysMYWAmo0_0k7Rmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA7321009456;
        Tue, 12 Jan 2021 01:59:55 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0CF51349A;
        Tue, 12 Jan 2021 01:59:54 +0000 (UTC)
Date:   Mon, 11 Jan 2021 19:59:52 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v3] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210112015952.jdystnwkvuxsrwa2@treble>
References: <20210106015810.5p6crnh7jqtmjtv4@treble>
 <20210111203807.3547278-1-ndesaulniers@google.com>
 <20210112003839.GL25645@zn.tnic>
 <CAFP8O3+uEE4Lity-asyFLN6_+8qRUD3hgcZVapXwk6EfmGM+DA@mail.gmail.com>
 <20210112010010.GA8239@zn.tnic>
 <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmGS97e4Rj_oW+RnkYAMjycTFQiiPJAfCvKTdxgv2KfEA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:13:16PM -0800, Nick Desaulniers wrote:
> On Mon, Jan 11, 2021 at 5:00 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Jan 11, 2021 at 04:41:52PM -0800, Fāng-ruì Sòng wrote:
> > > To be fair: we cannot use
> >
> > Who's "we"?
> >
> > > .L-prefixed local because of the objtool limitation.
> >
> > What objtool limitation? I thought clang's assembler removes .text which
> > objtool uses. It worked fine with GNU as so far.
> 
> I don't think we need to completely stop using .L prefixes in the
> kernel, just this one location since tracking the control flow seems a
> little tricky for objtool. Maybe Josh can clarify more if needed?

Right.  In the vast majority of cases, .L symbols are totally fine.

The limitation now being imposed by objtool (due to these assembler
changes) is that all code must be contained in an ELF symbol.  And .L
symbols don't create such symbols.

So basically, you can use an .L symbol *inside* a function or a code
segment, you just can't use the .L symbol to contain the code using a
SYM_*_START/END annotation pair.

It only affects a tiny fraction of all .L usage.  Just a handful of code
sites I think.

-- 
Josh

