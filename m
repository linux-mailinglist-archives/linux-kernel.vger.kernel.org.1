Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06DA29655F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 21:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370235AbgJVT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 15:28:43 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53910 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508349AbgJVT2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 15:28:43 -0400
Received: from zn.tnic (p200300ec2f123f001db4981ffa99e10c.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:3f00:1db4:981f:fa99:e10c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D21F1EC0441;
        Thu, 22 Oct 2020 21:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603394921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dwAvHh4VaBJRq2qEzg68f2uqgOV5Dc6kNtKj7UQlfnM=;
        b=fXIQS0kbwcIpCvahwU6EOs5Zd3EOjet4So8RG82hyX4b2GjGE9ghJFaFYczqweDAxcT5B5
        ECMydbBsQEz/AdQ095qGDxIlIl8d0QQoz6NT9+PeewNVVx8oIx2f8qbYurQdL15U+9Bj3t
        SwFZrlM7WiPDYoXZn/cKSeXs9qYy9RU=
Date:   Thu, 22 Oct 2020 21:28:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20201022192829.GG29222@zn.tnic>
References: <20200908180112.GK25236@zn.tnic>
 <20200908191838.GA2014@sultan-box.localdomain>
 <20200908193029.GM25236@zn.tnic>
 <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
 <20201019171539.GF24325@zn.tnic>
 <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
 <20201020174741.GJ11583@zn.tnic>
 <2147d5853a5a3e0d753fcc0a4ed330f61b29aa83.camel@linux.intel.com>
 <1188ee0f-f3cb-988f-474d-618bd5a5b879@intel.com>
 <7c9e406c3b409bd7d4d786a7835d37bfcd5c8189.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7c9e406c3b409bd7d4d786a7835d37bfcd5c8189.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 06:11:09AM -0700, Srinivas Pandruvada wrote:
> That is the problem. There is no public document.

Well, considering how important this functionality has become, maybe
they should be made public and maybe there should be a kernel undervolt
driver, as peterz suggests.

> > I dunno.  Maybe we should try it for *one* model and see how it goes.
> > Maybe start with the one we're already poking from inside the kernel.

Yes, we can surely give it a try.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
