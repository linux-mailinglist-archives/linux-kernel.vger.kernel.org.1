Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA094297B72
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 10:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760034AbgJXIXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756549AbgJXIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 04:23:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44705C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 01:23:28 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0f830002f7f4f3bcfb0c40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:8300:2f7:f4f3:bcfb:c40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F0D391EC054C;
        Sat, 24 Oct 2020 10:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603527805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tr+2pft1apMM+PUb1ngTc6K/yCtzq32VUXdRTUZjc9o=;
        b=W3BI7cO0ll1kplboH+Vb1uc+at+mr4fqE1+0AGJkiF84hGMfgYt7JMb5roUPylRADGmo5r
        sWg0Zj2rfFtdfQ0f0ZI6YbbMnmY5B/cCdeKEQ/PsWc+qV7/O3+cDdDzaH+WzqTa9K1TVkI
        f4tZ/AEfMf36mWDnFm3xv7mjm3G4zWk=
Date:   Sat, 24 Oct 2020 10:23:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, x86-ml <x86@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Have insn decoder functions return success/failure
Message-ID: <20201024082316.GA11562@zn.tnic>
References: <20201021164558.GB4050@zn.tnic>
 <20201022163100.1139b28220da4eafb5e70fcc@kernel.org>
 <20201022093044.GA29222@zn.tnic>
 <20201022222140.f46e6db1243e05fdd049b504@kernel.org>
 <CALCETrWhzzZ=EAoKZ4=k3FjffvS_3R4o5N1Rkj9FkHQdiUag6A@mail.gmail.com>
 <20201023182850.c54ac863159fb312c411c029@kernel.org>
 <20201023093254.GC23324@zn.tnic>
 <20201023194704.f723c86e5f8dfc1133dd5930@kernel.org>
 <20201023232741.GF23324@zn.tnic>
 <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrVQDVLPwTTXgsRYSjxVmzeK5ekmrEiT2rWkQKO0inRLGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 05:12:49PM -0700, Andy Lutomirski wrote:
> I disagree.  A real CPU does exactly what I'm describing.  If I stick

A real modern CPU fetches up to 32 bytes insn window which it tries
to decode etc. I don't know, though, what it does when that fetch
encounters a fault - I will have to ask people. I'm not sure it would
even try to feed a shorter stream of bytes to the decoder but lemme
ask...

> 0xcc at the end of a page and a make the next page not-present, I get
> #BP, not #PF.  But if I stick 0x0F at the end of a page and mark the
> next page not-present, I get #PF.  If we're trying to decode an
> instruction in user memory, we can kludge it by trying to fetch 15
> bytes and handling -EFAULT by fetching fewer bytes, but that's gross
> and doesn't really have the right semantics.  What we actually want is
> to fetch up to the page boundary and try to decode it.  If it's a
> valid instruction or if it's definitely invalid, we're done.
> Otherwise we fetch across the page boundary.

We can do that but why would you put all that logic in the insn decoder?
Is that use case sooo important?

I mean, it would work that way anyway *even* *now* - the insn decoder
will tell you that the insn it decoded wasn't valid and you, as a
caller, know that you didn't fetch the whole 15 bytes so that means
that you still need to fetch some more. You've got all the relevant
information.

> Eventually we should wrap this whole mess up in an insn_decode_user()
> helper that does the right thing.

Oh sure, you can do that easily. Just put the logic which determines
that it copied a shorter buffer and that it attempts to decode the
shorter buffer first in it. Yah, that can work.

> And we can then make that helper
> extra fancy by getting PKRU and EPT-hacker-execute-only right, whereas
> we currently get these cases wrong.
> 
> Does this make sense?

Sure, but you could point me to those cases so that I can get a better
idea what they do exactly.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
