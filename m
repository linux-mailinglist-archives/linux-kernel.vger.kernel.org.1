Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA8762618C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 20:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732155AbgIHSCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 14:02:37 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38970 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbgIHSBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:01:18 -0400
Received: from zn.tnic (p200300ec2f10bf0059bdf9fa8e813382.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:59bd:f9fa:8e81:3382])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3C9511EC0489;
        Tue,  8 Sep 2020 20:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599588077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=72WG1McxFqIGqR0+XMVCYnaTg8/Pu4r+S87nI13px98=;
        b=ls4q+gxq01ufyfWCGaDIr4cX0hDa7QQPPRNqrHWOp9VTyGguOSzHrsGSotlWrzuk+CGZSV
        jte8+0fkjQm1FsAfuFrt0UUtL9edHhcws3KnwZDKIplufTwJYPvkwwvLyNm59pc4yax0aq
        O6Ogqmuru1rmAYWqsFZHp9hSMNGeyDQ=
Date:   Tue, 8 Sep 2020 20:01:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20200908180112.GK25236@zn.tnic>
References: <20200907094843.1949-1-Jason@zx2c4.com>
 <20200907100647.GB10657@zn.tnic>
 <22617e57e541e460fac09db04fdb370f8e96e8ef.camel@linux.intel.com>
 <CAHmME9rh8N-Qui2KVxGP33Aar5tao_obA70XKwR2x5Qp1AytTw@mail.gmail.com>
 <20200908172558.GG25236@zn.tnic>
 <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic>
 <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:42:12PM +0200, Jason A. Donenfeld wrote:
> Are you prepared to track down all the MSRs that might maybe do
> something naughty?

I'm not prepared - that's why this MSR filtering. To block *all* direct
MSR accesses from userspace in the future.

> Does `dd` warn when you run `dd if=/dev/zero of=/dev/sda`?

Yah, because that's the same as bricking your hardware. Geez.

> Probably not possible. Optimal values are related to the "silicon
> lottery" that occurs when you buy a new CPU. Different optimal values
> for different individual chips.

Let's wait for what Srinivas finds out. I'd let Intel decide what they
wanna do.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
