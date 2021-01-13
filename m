Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D22F5086
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbhAMRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:01:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbhAMRBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610557174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wHuSXn68MXq05QNKWqpSBophf9IckcirUGXPjI7wnpE=;
        b=D+bzi3NFw0WzrBYsDtnj66HEuGHbWZosx4heNdQ0p7qqf6BymblxttPaeWmGQZRJ1+pS3y
        3VpHRRbHwq8oJdUKLVfZjnrAkRvTNHbYjV1kYFQmmn2G0l7gdNtV7qC3+JxRCzX9Wi/yvD
        Wu7nSwlAapgxN8MSLxYMvPSlkdK0GYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-Z6M00Pe0OyuQDMedSbNh8g-1; Wed, 13 Jan 2021 11:59:30 -0500
X-MC-Unique: Z6M00Pe0OyuQDMedSbNh8g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACC048030A0;
        Wed, 13 Jan 2021 16:59:27 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76C0419934;
        Wed, 13 Jan 2021 16:59:25 +0000 (UTC)
Date:   Wed, 13 Jan 2021 10:59:23 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v4] x86/entry: emit a symbol for register restoring thunk
Message-ID: <20210113165923.acvycpcu5tzksbbi@treble>
References: <20210112115421.GB13086@zn.tnic>
 <20210112194625.4181814-1-ndesaulniers@google.com>
 <20210112210154.GI4646@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112210154.GI4646@sirena.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 09:01:54PM +0000, Mark Brown wrote:
> On Tue, Jan 12, 2021 at 11:46:24AM -0800, Nick Desaulniers wrote:
> 
> This:
> 
> > when building with LLVM_IAS=1 (Clang's integrated assembler). Josh
> > notes:
> 
> >   So basically, you can use an .L symbol *inside* a function or a code
> >   segment, you just can't use the .L symbol to contain the code using a
> >   SYM_*_START/END annotation pair.
> 
> is a stronger statement than this:
> 
> > +  Developers should avoid using local symbol names that are prefixed with
> > +  ``.L``, as this has special meaning for the assembler; a symbol entry will
> > +  not be emitted into the symbol table. This can prevent ``objtool`` from
> > +  generating correct unwind info. Symbols with STB_LOCAL binding may still be
> > +  used, and ``.L`` prefixed local symbol names are still generally useable
> > +  within a function, but ``.L`` prefixed local symbol names should not be used
> > +  to denote the beginning or end of code regions via
> > +  ``SYM_CODE_START_LOCAL``/``SYM_CODE_END``.
> 
> and seems more what I'd expect - SYM_FUNC* is also affected for example.
> Even though other usages are probably not very likely it seems better to
> keep the stronger statement in case someone comes up with one, and to
> stop anyone spending time wondering why only SYM_CODE_START_LOCAL is
> affected.

Agreed, I think the comment is misleading/wrong/unclear in multiple
ways.  In most cases the use of .L symbols is still fine.  What's no
longer fine is when they're used to contain code in any kind of
START/END pair.

> This also looks like a good candiate for a checkpatch rule, but that can
> be done separately of course.

I like the idea of a checkpatch rule.

-- 
Josh

