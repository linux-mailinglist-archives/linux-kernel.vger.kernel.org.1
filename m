Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0022DD69F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgLQRyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:54:06 -0500
Received: from ms.lwn.net ([45.79.88.28]:60270 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgLQRyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:54:06 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1746B2E6;
        Thu, 17 Dec 2020 17:53:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1746B2E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1608227605; bh=jKZ1GzV4hDFyMBVEKA263kBGGBD1geznHekza+FysnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aZMtYT+89Wga5d/MpnF4YqfKyR9YzklJG+iy1uSWhMe5/Py/Uz+aywt02n8WvxDyd
         tnJ3wjA72OFJ1VE7S9N8wPkcW6dUzmGXAWskKroEQgDOAvKvP6xUHDVddv5uh3hxMe
         la7Lgl08SUwjjYAp69IngsOBkFvbhzFOWpQGPCtiOkKK0fOOVhmzWWsef9J85eYcbq
         HcIl0kmCh8BAqXa+z/5TGFAK8ULNsdv217iTYALsTLi5Cx2LMOzYFBQB3RXAS4qzH8
         IQKUEYhv1AWMSkHcMQEU/7n6Wv+ZFn3XDvdT6V/P5aPSVm8mW8Ewlj0FPsipmk5VER
         UneKDQoVwhvSg==
Date:   Thu, 17 Dec 2020 10:53:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20201217105323.4d882a7d@lwn.net>
In-Reply-To: <20201217150537.GC23634@zn.tnic>
References: <20181107171010.421878737@linutronix.de>
        <20181107124855.328133e7@lwn.net>
        <CAPcyv4goT+7t1foOhEYgGTz2kRV2Oou8QOs38D13rdC-TpfX+Q@mail.gmail.com>
        <alpine.DEB.2.21.1811072134060.1666@nanos.tec.linutronix.de>
        <20181108074920.4c601ee3@lwn.net>
        <alpine.DEB.2.21.1811081637550.1549@nanos.tec.linutronix.de>
        <20201217150537.GC23634@zn.tnic>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020 16:05:37 +0100
Borislav Petkov <bp@alien8.de> wrote:

> So, that thing.
> 
> I have this ontop of 5.10 along with most comments integrated.
> 
> Now, I'm thinking if I start sending those pieces which belong into the
> main process documentation, the bikeshedding that is going to ensue is
> going to be insane. And we have day jobs too, you know. :)
> 
> Thus, I'm also thinking that I should do this piecemeal and once we've
> all agreed on one aspect and you've applied it, Jon, I'll carve out and
> send the next. Rinse and repeat.
> 
> How does that sound, makes sense?

Gee...a response from a two-year-old thread...it's taking me a while to
page all of that back in :)

I'd love to see this work get in, I still feel bad about my part in
stalling it before.

Piecemeal could certainly work, or we could just try the whole thing and
see what happens.  We got Thorsten's reporting-issues tome in without much
trouble, after all, and that's bikeshed territory if anything is.  But
whatever works is fine; send stuff and I'll gladly look at it.

Thanks,

jon
