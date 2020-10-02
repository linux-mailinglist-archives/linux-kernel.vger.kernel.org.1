Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1925928141E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387931AbgJBNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgJBNfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:35:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B240C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:35:41 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id m9so512156qth.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=codGx/T8mDPVCiIP/olqY2I2T+lDjbhdj0z/6U9xvIk=;
        b=JrZnREceC+xUPaW2VXOncrQdsU2Kv0sa6npCGfH5JXFyofW5keOgF28jZWW421dToD
         4RG+D6qOBvyOkJKoFXaxdCeAggqsmAVpgl1JA9Si+oCZwyTq9ano+9DiIwCKtvOWyZcX
         iWO5YT8tQuwbLrCz4y37iAO4sXfQGy9nnfkZ84aoK/z57x4CPW95YztH13C47KY3I+hu
         3EahvWEHTZMFhsR/KjMTEXqbg6xJ1GLm97AMBoyLZt69hzL+nomYauj/4J9NHdcFc3YE
         D/IgUBKbuuzt5w07A7GkfNoE4gGI8EGZLPeVI3aoG0UMxsvN4YoNKHlcpy4E8TZTYcD/
         BfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=codGx/T8mDPVCiIP/olqY2I2T+lDjbhdj0z/6U9xvIk=;
        b=Sz9J4D0eDH86lyadw+dr4AlpbO1FLc/gJBAqHiBk7kDR51qaflTlyQSj6dJ6cJGhJf
         PwaFgy+m0hI/pVisAsEG80ApoxavOe0Ja+KMp9mVAYb/6XBbxpFLsiR+ysGZWiKybH6Q
         tjSDxFeT5NAHWHTUkrtqPmqEZrL1oCK0vHvDBXKMAmzow9alro8BMNDsmTti4Ig2Ud8K
         CDH/p1ZqGnIjfnscqRubkeiy6N8g6JY0GlWEQaGZf3TWB8vghAe7pmQPpHlAtm6aNekL
         PAejLBS8a6C5nNhqqLRuKdwlzAs4y3PT6CGOIGHGcSCCOK86/QC0n2ov+5e9SP067E8m
         7nHA==
X-Gm-Message-State: AOAM531j2q/3mauXAW0UBNZmaNJe/uLlguAvRJuPtIBYKdPRL617wd/8
        HEoCbElbd5rTP04wL/iuy3Y=
X-Google-Smtp-Source: ABdhPJxWdPd8OcLKCtq9nYO131EpbZhB3dhhVzUWVQwAcN3EhTQk3A3/rTrZdMDt51FXslpFZKJSlw==
X-Received: by 2002:aed:26a7:: with SMTP id q36mr2255549qtd.57.1601645740624;
        Fri, 02 Oct 2020 06:35:40 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x49sm1025133qtc.94.2020.10.02.06.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Oct 2020 06:35:40 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4328227C0054;
        Fri,  2 Oct 2020 09:35:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 02 Oct 2020 09:35:39 -0400
X-ME-Sender: <xms:qix3X6YW1NSifFJj4AUNhBkc0qeOWzynUA6BzxoIUpjwUHhNzAcLZw>
    <xme:qix3X9bkpEfC7ilQTZZXZQAoQmZYSltJfyqeGyX2NGIabc3wLerZYbhrHfYc4N0y5
    LtR3d1HmUKXZJiqAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvleeigedugfegveejhfejveeuveeiteejieekvdfgjeefudehfefhgfegvdeg
    jeenucfkphephedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:qix3X08LdidyNjXzNg-WWLpH1MQuKcwmI1j-NSNAKrNbes1BN3CJOQ>
    <xmx:qix3X8o2Iw_rzjgs2oOntFf3B1SF8NSq4EQMStOq-ePSizW_fRH8ng>
    <xmx:qix3X1qUs_-qKH-s3wbB6XrXA48LjLMInAFDQEFLf4josRqT-EbCBg>
    <xmx:qyx3X-ANCahBIzywQhQUHJ8-wGekilSrRG752bgBF6gJn6LHHEfx6w>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 264413064610;
        Fri,  2 Oct 2020 09:35:37 -0400 (EDT)
Date:   Fri, 2 Oct 2020 21:35:36 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     g@hirez.programming.kicks-ass.net, Qian Cai <cai@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep null-ptr-deref
Message-ID: <20201002133536.GF17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <5fd046115645daa00f8841f5467da4c4d960ca92.camel@redhat.com>
 <20200929230823.GC17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930091610.GV2628@hirez.programming.kicks-ass.net>
 <20200930094937.GE2651@hirez.programming.kicks-ass.net>
 <20200930121818.GD17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200930190228.GL2611@hirez.programming.kicks-ass.net>
 <20201002123602.GE17810@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20201002130929.GW2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002130929.GW2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 03:09:29PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 02, 2020 at 08:36:02PM +0800, Boqun Feng wrote:
> 
> > But what if f2() is called with interrupt disabled? Or f2() disables
> > interrupt inside the function, like:
> > 
> > 	void f2(...)
> > 	{
> > 		local_irq_disable();
> > 		spin_lock(&B);
> > 		g(...);
> > 		...
> > 		local_irq_enable();
> > 	}
> > 
> > In this case, there wouldn't be any LOCK_ENABLED_*_READ usage for
> > rwlock_t A. As a result, we won't see it in the lockdep splat.
> 
> Hurm, fair enough. So just to make sure, you're arguing for:
> 
> -#define LOCK_TRACE_STATES              (XXX_LOCK_USAGE_STATES*4 + 1)
> +#define LOCK_TRACE_STATES              (XXX_LOCK_USAGE_STATES*4 + 2)
> 
> On top of my earlier patch, right?

Yep. Thanks ;-)

Regards,
Boqun
