Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DB82B7884
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 09:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgKRIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 03:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKRIXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 03:23:03 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1085EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 00:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=vUnXFIJZqzZmzNV0LWSeeHYXP66FIk+CkNnUB9dnKCU=; b=G+IerEHERnznmyiYJon9vagogl
        KUqxAiX3uYlGGgqhN44pkFOs4WfCJThCRqXJ4FDo1TthjsfzrJsUUykNpPS65nWZdrK3rlIY1MPl0
        Xc/G0JUiwrWpB9j3kEAFZjvFuG+5MbGZSNGrcUQu/Y0S/lCwoAHxe6D8WwWuDheFUHRcDH3wjhvBh
        bFIjmdOolrfqpBKDeMebImeVz+wghtLetV5dzggQJtRpU1lUxbWc18qxiGtPxUQ9hTLsT16PHtxAQ
        /5GKdAHQ7+ze9YZCVwFG+46+TARGxnYDTl4UR2+5ooMbsCo4WmDg9ZZ6GANb3+4wwLLNTFyY9Blwz
        YSVV1lMQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfIjv-0008Fr-SM; Wed, 18 Nov 2020 08:22:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 321D7301959;
        Wed, 18 Nov 2020 09:22:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11A472BBF0492; Wed, 18 Nov 2020 09:22:54 +0100 (CET)
Date:   Wed, 18 Nov 2020 09:22:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        X86 ML <x86@kernel.org>
Subject: Re: WARNING: can't access registers at asm_common_interrupt
Message-ID: <20201118082254.GH3121378@hirez.programming.kicks-ass.net>
References: <33843b7f-ed8a-8fcb-19bc-c76cf00f453d@citrix.com>
 <20201111194206.GK2628@hirez.programming.kicks-ass.net>
 <20201111195900.2x7kfce2ejkmrzi3@treble>
 <20201111200730.GM2628@hirez.programming.kicks-ass.net>
 <20201111201506.bftpmx4svxn376tn@treble>
 <61b2538f-7be6-8f4a-9395-03071b5cc6f0@citrix.com>
 <CALCETrXcTKB_j9MQC1mcZobKGt_cZ5ivDPjU3zwRBmj7DAUCsA@mail.gmail.com>
 <f105a63d-6b51-3afb-83e0-e899ea40813e@suse.com>
 <20201116130413.GC3121392@hirez.programming.kicks-ass.net>
 <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e1ca6c8c-e32d-879a-1972-5605f0892176@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 07:47:36AM +0100, J=FCrgen Gro=DF wrote:
> On 16.11.20 14:04, Peter Zijlstra wrote:
> > On Mon, Nov 16, 2020 at 12:56:32PM +0100, J=FCrgen Gro=DF wrote:
> > > > > > > > > static inline notrace unsigned long arch_local_save_flags=
(void)
> > > > > > > > > {
> > > > > > > > >      PVOP_CALL_ARGS;
> > > > > > > > >      PVOP_TEST_NULL(irq.save_fl);
> > > > > > > > >      asm_inline volatile(ALTERNATIVE(paravirt_alt(PARAVIR=
T_CALL),
> > > > > > > > >                                      "PUSHF; POP _ASM_AX",
> > > > > > > > >                                      X86_FEATURE_NATIVE)
> > >=20
> > > I am wondering whether we really want a new feature (basically "not
> > > XENPV). We could use ~X86_FEATURE_XENPV and teach apply_alternatives()
> > > to understand negated features (yes, this limits the number of featur=
es
> > > to 32767, but I don't think this is a real problem for quite some tim=
e).
> > >=20
> > > Thoughts?
> >=20
> > I went with the simple thing for now... If we ever want/need another
> > negative alternative I suppose we can do as you suggest...
> >=20
> > I was still poking at objtool to actually dtrt though..
>=20
> I'd like to include this part in my series (with a different solution
> for the restore_fl part, as suggested by Andy before).
>=20
> Peter, are you fine with me taking your patch and adding your SoB?

Sure, note that I only compile tested it, as it was my test-bed for
playing with objtool (which I still haven't managed to get back to and
finish :/).

So if it actually _works_ feel free to take it, otherwise you can have
whatever bits and pieces remain after you've butchered it to do as you
want.
