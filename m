Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A938B2DD3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgLQPGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:06:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43092 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgLQPG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:06:26 -0500
Received: from zn.tnic (p200300ec2f10f6006fa2c94145628139.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:f600:6fa2:c941:4562:8139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BD5061EC0283;
        Thu, 17 Dec 2020 16:05:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608217544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=NVkuF7slKZ1yUxWPoTewQ9ggtLLtWrnXCQMs+i5ouFk=;
        b=n+1JHmBHnDX8RqMLg+EHbNa/tRWZ1CR4QS1NwYZG+yECXyUCiOputpt6c35PBb4bJe0M6K
        Grk9OyxFbDMDcVI/rnAAR4UoHR+iEel7x1NM5C/aSmefat8/A2dFmRcsIP1SG36Fb6edvD
        5UJW5mTvpbFUCa6eScdBdYRBz03zrNM=
Date:   Thu, 17 Dec 2020 16:05:37 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        john.stultz@linaro.org, acme@redhat.com, frederic@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>, daniel.lezcano@linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [patch 0/2] Documentation/process: Add subsystem/tree handbook
Message-ID: <20201217150537.GC23634@zn.tnic>
References: <20181107171010.421878737@linutronix.de>
 <20181107124855.328133e7@lwn.net>
 <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
 <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
 <20181108074920.4c601ee3@lwn.net>
 <alpine.DEB.2.21.1811081637550.1549@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1811081637550.1549@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 04:49:04PM +0100, Thomas Gleixner wrote:
> > Suppose I came along with my nifty new architecture, and it dragged in a
> > whole new set of timer and interrupt subsystems that duplicated a lot of
> > what's in the kernel now, but buried a few "local quirks" deep in the
> > middle.  "Don't worry", I say, "we'll factor out the common stuff later
> > once we figure out what it is; I'd rather not deal with the bikeshedding
> > now". Correct me if I'm wrong, but I suspect I might just get a response
> > back from you.  That's not how we normally do things.
> 
> Darn. Not much I can argue about.

So, that thing.

I have this ontop of 5.10 along with most comments integrated.

Now, I'm thinking if I start sending those pieces which belong into the
main process documentation, the bikeshedding that is going to ensue is
going to be insane. And we have day jobs too, you know. :)

Thus, I'm also thinking that I should do this piecemeal and once we've
all agreed on one aspect and you've applied it, Jon, I'll carve out and
send the next. Rinse and repeat.

How does that sound, makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
