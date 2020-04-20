Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39BD1B0007
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 04:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDTCwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 22:52:55 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52155 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbgDTCwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 22:52:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 495B844GZzz9sSd;
        Mon, 20 Apr 2020 12:52:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1587351173;
        bh=uh9fqOT9z7bEfk7/YkplDW0UdjdPJX+o3SKRuK1QyDo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=E2wPco9GNgNC7836Nmf61nU3MCTlGlne14R9dD+hEyU/78I9P2TI0HktTFLlxxJFm
         HImULtkTlM1j8U2iPyXmjwATWO/EP4wtnip7hXUmYKLk9fPBIYHtDy87SY6bT4aztY
         5qVAja1DcAviCvuXEwaFrlxZD47cVLaON6oSE9YzKIhygH7oHRJ+n7/jXqFDi0FZcd
         AzmsgaMMmFH35Akx2wv7LPYY+SRjMVmscJpSiAliDKBvg1AYFq6BVnkQsxOT+Ps4bq
         jYRIc+B3m2CFZx64ukRjgn9S+kBFylLDbxRAAuTwsk26eETNTTpp5+0nTVsSm39/UN
         W9mVJlokJXjaQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "christophe.leroy\@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus\@samba.org" <paulus@samba.org>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "oss\@buserror.net" <oss@buserror.net>,
        "tglx\@linutronix.de" <tglx@linutronix.de>
Cc:     "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Subject: Re: [PATCH v2] powerpc/setup_64: Set cache-line-size based on cache-block-size
In-Reply-To: <4d84f89aa682dc78bc0d3a8df2f14b0452465da4.camel@alliedtelesis.co.nz>
References: <dd342c71e03e654a8786302d82f9662004418c6e.camel@alliedtelesis.co.nz> <20200325031854.7625-1-chris.packham@alliedtelesis.co.nz> <343c0e8b01ab74481e0b8dfbe588b1c84127a487.camel@alliedtelesis.co.nz> <87tv1jirlj.fsf@mpe.ellerman.id.au> <4d84f89aa682dc78bc0d3a8df2f14b0452465da4.camel@alliedtelesis.co.nz>
Date:   Mon, 20 Apr 2020 12:53:03 +1000
Message-ID: <877dyaj2b4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
> On Thu, 2020-04-16 at 21:43 +1000, Michael Ellerman wrote:
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>> > On Wed, 2020-03-25 at 16:18 +1300, Chris Packham wrote:
>> > > If {i,d}-cache-block-size is set and {i,d}-cache-line-size is
>> > > not,
>> > > use
>> > > the block-size value for both. Per the devicetree spec cache-
>> > > line-
>> > > size
>> > > is only needed if it differs from the block size.
>> > > 
>> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> > > ---
>> > > It looks as though the bsizep = lsizep is not required per the
>> > > spec
>> > > but it's
>> > > probably safer to retain it.
>> > > 
>> > > Changes in v2:
>> > > - Scott pointed out that u-boot should be filling in the cache
>> > > properties
>> > >   (which it does). But it does not specify a cache-line-size
>> > > because
>> > > it
>> > >   provides a cache-block-size and the spec says you don't have to
>> > > if
>> > > they are
>> > >   the same. So the error is in the parsing not in the devicetree
>> > > itself.
>> > > 
>> > 
>> > Ping? This thread went kind of quiet.
>> 
>> I replied in the other thread:
>> 
>>   
>> https://lore.kernel.org/linuxppc-dev/87369xx99u.fsf@mpe.ellerman.id.au/
>> 
>> But then the merge window happened which is a busy time.
>> 
>
> Yeah I figured that was the case.
>
>> What I'd really like is a v3 that incorporates the info I wrote in
>> the
>> other thread and a Fixes tag.
>> 
>> If you feel like doing that, that would be great. Otherwise I'll do
>> it
>> tomorrow.
>
> I'll rebase against Linus's tree and have a go a adding some more words
> to the commit message.

Thanks.

cheers
