Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFED12E2432
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgLXEjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:39:16 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59249 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbgLXEjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:39:15 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 510325C00D5;
        Wed, 23 Dec 2020 23:38:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 23 Dec 2020 23:38:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZuAOZsuNyuhekGAfAuVc4cPYDPj
        wuvIUZMlI+9EGZFw=; b=P0tHQ73n6Zk/97bKki+yq/zgjYW2E5/0zcclADwMdwW
        hHvXicBzFMFnbiYXVTRynKWcQBIcoyeZ8R+d8XCYlJyuCuEfHVPm3pX70KHVaxKw
        ko+VaehO28E6WXZxQ601VKjvWXvi8nXl2GMfloi9bMtG6JMkxhXPgSLSV4LA1+jW
        heqVQ6vkDmPBWiPD5rK2/ECEgzAk9tE0PejYD7g4wZC6tIM0OU2dLLukFY3NVwn+
        Jj79SFJSduL6jBmYcTn6Ni3m9NLZA2r1xjnVRBGzQG0z8U0WHqWcd7xCk/v8IPpL
        2QeHo7B6XXpWENlyUnyQN1V6NuWGabUZ8qIT2vYy2HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ZuAOZs
        uNyuhekGAfAuVc4cPYDPjwuvIUZMlI+9EGZFw=; b=YyvLRtpIJyopSIVz4gqp7p
        t4AZgfleFqUiwzNFyPtIwee9tlvRdp9iiPt3acpSLBn+JFnWZyN07q3XBI7ZoDp8
        H9zbYOdwB+7g0kQ3f/uETALWnr2VOG2QxurzFwLHCtwEvBV/OQKd/M0c5G1f9vWF
        msEUmhz0CcClZRO8eOlTcqsceQPpQbNoK1ohnH7MVlolN4JSNvj7P5OlQEP5JOEC
        U0f44hNj4XKjLh4wEPt11FctECj++Vch/syQDthoLnnQR87f8TzOo/KeIg1NX+1E
        lyVTlaKsiMPGlbJh0Xdgw2g/NgIT+V1u1MPpMc0Iq4bKxcpiH/AaE1Pi3mzKyikA
        ==
X-ME-Sender: <xms:MBvkX7g4h8X4d05Fuk4RuPJI0Ld7wclAueQtbbBho5CEGe9p4YyzhQ>
    <xme:MBvkX4CSHrlJiher9HaRRnMIFs1R0EbPvNv9A0JLaPFj57CIhNj4mFguYaGRjuBsA
    sXsp4a7lkJH_BkoYw8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvddtkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeifffffeekkeeifffhteekleejhfetledvvdeileefheffveduveevleef
    lefgtdenucffohhmrghinhepvghnthhrhidrshgsnecukfhppeduledvrddvgedurddvhe
    ehrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepthihtghhohesthihtghhohdrphhiiiiirg
X-ME-Proxy: <xmx:MBvkX7G4A08d8f2fBeohYY-mii_krUFX01seA_TIEOzpOwZSWx1dVQ>
    <xmx:MBvkX4QVlALfD6qcwO4gzME0yOE7lf1lhtYwHGRl-yssqhyP1DwYlg>
    <xmx:MBvkX4yFVa6JUSlW7ead94cGv1VPJWY--ZJ9u-JDhBwa279pB7S3yA>
    <xmx:MRvkXyuZgBxHa9Ht_fbJeBWtshIOzOw1PtEQBcYa9A938ZvFa234nw>
Received: from cisco (unknown [192.241.255.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA5FA1080059;
        Wed, 23 Dec 2020 23:38:07 -0500 (EST)
Date:   Wed, 23 Dec 2020 21:38:06 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Christoph Hellwig <hch@infradead.org>, schwab@suse.de,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH] riscv: return -ENOSYS for syscall -1
Message-ID: <20201224043806.GE710211@cisco>
References: <20201223082404.GB24581@infradead.org>
 <mhng-c15e4fab-6487-4875-a392-85669982b8b1@palmerdabbelt-glaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-c15e4fab-6487-4875-a392-85669982b8b1@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:54:43PM -0800, Palmer Dabbelt wrote:
> On Wed, 23 Dec 2020 00:24:04 PST (-0800), Christoph Hellwig wrote:
> > On Tue, Dec 22, 2020 at 09:22:19AM -0700, Tycho Andersen wrote:
> > > On Mon, Dec 21, 2020 at 11:52:00PM +0100, Andreas Schwab wrote:
> > > > Properly return -ENOSYS for syscall -1 instead of leaving the return value
> > > > uninitialized.  This fixes the strace teststuite.
> > > >
> > > > Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
> > > > Signed-off-by: Andreas Schwab <schwab@suse.de>
> > > > ---
> > > >  arch/riscv/kernel/entry.S | 9 +--------
> > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > > > index 524d918f3601..d07763001eb0 100644
> > > > --- a/arch/riscv/kernel/entry.S
> > > > +++ b/arch/riscv/kernel/entry.S
> > > > @@ -186,14 +186,7 @@ check_syscall_nr:
> > > >  	 * Syscall number held in a7.
> > > >  	 * If syscall number is above allowed value, redirect to ni_syscall.
> > > >  	 */
> > > > -	bge a7, t0, 1f
> > > > -	/*
> > > > -	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
> > > > -	 * If yes, we pretend it was executed.
> > > > -	 */
> > > > -	li t1, -1
> > > > -	beq a7, t1, ret_from_syscall_rejected
> > > > -	blt a7, t1, 1f
> > > > +	bgeu a7, t0, 1f
> > > 
> > > IIUC, this is all dead code anyway for the path where seccomp actually
> > > rejects the syscall, since it should do the rejection directly in
> > > handle_syscall_trace_enter(), which is called above this hunk. So it
> > > seems good to me.
> > 
> > That change really needs to be documented in the commit log, or even
> > better split into a separate patch (still documented of course!).
> 
> Unless I'm missing something, this is already how it works already?

Yes, agreed. My musing was mostly just that this is dead code that
probably should have been in removed in af33d2433b03 ("riscv: fix
seccomp reject syscall code path"), but was overlooked. Maybe this
could use a Fixes: tag for that too.

Tycho
