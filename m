Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2572E0EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgLVT1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:27:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgLVT0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:26:02 -0500
Received: from zn.tnic (p200300ec2f0ef2002f9d5453c68bf448.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f200:2f9d:5453:c68b:f448])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 069C71EC0516;
        Tue, 22 Dec 2020 20:25:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608665121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WbFzFiZYs65Vkt660aD//2c0YmnCgd1HRy7MBsnYFYE=;
        b=IZFENNdimKt8iTQHjsvDmHHbwFolfn67G03ScVG2FofEWiN8fIfP/WoSEdL5oakg1VVPvn
        nYomLFlvMTxvIbDTWOOCcZG+fv5v1YShRwn0v2zUmFEKrULe6uSXZpr7WvDJhIj5zwJkhO
        xw8Uj62Cg2YMF7wtMK6C9R/2Z7IQofM=
Date:   Tue, 22 Dec 2020 20:25:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation/submitting-patches: Add blurb about
 backtraces in commit messages
Message-ID: <20201222192517.GE13463@zn.tnic>
References: <20201217183756.GE23634@zn.tnic>
 <20201221095425.6da68163@lwn.net>
 <20201222130555.GA13463@zn.tnic>
 <X+JCCqTJkgZASj7T@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X+JCCqTJkgZASj7T@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 10:59:22AM -0800, Sean Christopherson wrote:
> On Tue, Dec 22, 2020, Borislav Petkov wrote:
> > Ok, here's the next one which I think, is also, not really controversial.
> 
> Heh, are you trying to jinx yourself?

I was trying to conjure up some bikeshedding... and there it is! :-)

> > +Backtraces help document the call chain leading to a problem. However,
> > +not all backtraces are helpful. For example, early boot call chains are
> > +unique and obvious.
> 
> I'd argue that there is still value in the backtrace though, e.g. I find them
> very helpful when doing git archaeology.  A backtrace is an easily recognizable
> signature (don't have to read a bunch of text to understand there was a splat of
> some kind), and the call stack is often helpful even if it is unique, e.g. for
> unfamiliar code (including early boot chains) and/or code that is substantially
> different from the current upstream.

I think the intent of the text is to say not to include callchains which
are *really* obvious. As in, there's no ambiguity as to how one has
landed here.

Also, sometimes people paste backtraces from a WARN* which are almost
always superfluous - only the warn's address is important. This is at
least how I go about debugging those.

Maybe the text should be made more precise.

> I'd prefer not to encourage people to strip the info after the function name,
> though I do agree it's somewhat distracting (especially the offset/size).

Yes. Especially since they don't make any sense on another system or
even on the same system but with a different .config.

> The module, call site in the function, exact file/line if available,
> etc... provides context that I find helpful for building a mental
> model of what went wrong.

File/line is more useful, yes, but only for the current code snapshot.
When time passes and stuff gets changed, those file/line things are not
correct anymore so one would have to checkout the tree on which the
splat happened.

I guess I need to make that aspect more precise too.

> E.g. which modules are in play, which short wrapper functions can
> likely be glossed over, etc...

That example doesn't have modules. I guess I'll generate a new one.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
