Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2162B27A45A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 00:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI0WT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 18:19:27 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58056 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgI0WT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 18:19:27 -0400
Received: from zn.tnic (p200300ec2f249200fb52c51f0a966e24.dip0.t-ipconnect.de [IPv6:2003:ec:2f24:9200:fb52:c51f:a96:6e24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 577F31EC026F;
        Mon, 28 Sep 2020 00:19:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601245166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kCF4efe8uD7pMjREjHs1dzHUblYM4vi/JwTHT/UjuqE=;
        b=JCbiiYjfPBhgyt3HhgoVNiw2nII5ehmehytdxwD33bEtR1tTaoivJSy+AQoDDBwQ3zjoau
        O2+1pP/GrzQt86VpKNQnesYWsupfFRK/OXPu7jRNO6CVBHpqmPi3sQxx/d8ZTINV/AlX/t
        AimMBmXUY5tN0P96nLSJRdxJgTSiXKA=
Date:   Mon, 28 Sep 2020 00:19:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "Song, Youquan" <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86/mce: Add Skylake quirk for patrol scrub reported
 errors
Message-ID: <20200927221917.GB4746@zn.tnic>
References: <20200615184056.26531-1-tony.luck@intel.com>
 <20200616192952.GO13515@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F670974@ORSMSX115.amr.corp.intel.com>
 <20200617074158.GB10118@zn.tnic>
 <20200617184901.GA387@agluck-desk2.amr.corp.intel.com>
 <20200828202150.GA11854@agluck-desk2.amr.corp.intel.com>
 <20200925191912.GO16872@zn.tnic>
 <20200925230620.GA26621@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925230620.GA26621@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 04:06:20PM -0700, Luck, Tony wrote:
> In some ways that's pretty neat. But it would still be ugly if we need
> to extend it further for other issues. Especially if they don't have such
> a simple rule to adjust the severity.

I'm still secretly hoping that one fine day one of your minions will
come with a conversion series around the corner; series, which gets rid
of this unreadable mess and we get something *actually* readable like
mce_severity_amd().

And on that day I'll even take one patch per severities[] member so that
it is absolutely clear how the conversion has happened and review can be
good and catch any lurking errors.

One day... :-)

Because after that day, we can do arbitrary rules to adjust the severity
and there won't be any problems with extending it anymore because then
it'll be nice and flexible C code only.

> This would be better as a bit mask. I don't think we need this same
> hack on the next generation of CPUs ... but if we did, the bank numbers
> that would be affected don't form a continuous sequence.

Ok, feel free to adjust it how you think it is better.

> I'd need to stare at the placement of this in the sequence of rules at some
> non-Friday-afternoon time. It might be right, but as we've grumbled together
> many times before that code is full of surprise side effects.

Nah, I just put it there so that I can see the macros in the same window
and don't have to scroll - I'm purely relying on you here to place it in
the right spot.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
