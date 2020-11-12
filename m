Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E1E2B0670
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbgKLN2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:28:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgKLN2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:28:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF6C207BB;
        Thu, 12 Nov 2020 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605187701;
        bh=ZoJYtnjpFeo15zEgWAC3KwZ0Ql2KlZugewN+6qWIp5A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrDYZx2ZQO8XiDnVzzxlTVuvAdhNdpoxAzVasz+Zrnvm0Nfxz7KFRTpBO9xxiqm+U
         EqbsLlZ0lIJNXo/uIXHaO/bfzcwuDSV9XyF8YYRauuwQZF3YGRahfPk5hp2Sgc1ZfZ
         ebV1zK+50yQhmvtkku++rus7F+Iq5Jvp1Xu3q0YI=
Date:   Thu, 12 Nov 2020 14:29:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <X604rzqJOoT+O+Ox@kroah.com>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <20201111082320.GR2611@hirez.programming.kicks-ass.net>
 <7207fad6-6ca4-529b-60a8-63db998d10d9@linuxfoundation.org>
 <20201111160411.GF2628@hirez.programming.kicks-ass.net>
 <3fccb8d5-825a-a283-7b7e-6193e0c90237@linuxfoundation.org>
 <20201111175031.GI2628@hirez.programming.kicks-ass.net>
 <0aed620f-911d-4715-bd41-a6b9a37862b4@linuxfoundation.org>
 <20201111201555.GN2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111201555.GN2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 09:15:55PM +0100, Peter Zijlstra wrote:
> On Wed, Nov 11, 2020 at 11:28:13AM -0700, Shuah Khan wrote:
> > On 11/11/20 10:50 AM, Peter Zijlstra wrote:
> > > On Wed, Nov 11, 2020 at 10:34:05AM -0700, Shuah Khan wrote:
> > > 
> > > > Not sure what to make of the 6080 atomic_read()s and 3413
> > > > atomic_inc()s, some of which might be assuming uniqueness
> > > > guarantee.
> > > 
> > > Well, clearly you just did: git grep atimic_{read,inc}() | wc -l and
> > > didn't look at the usage. Equally clearly there can be bugs. Also
> > > evidently much of those are not in fact sequence numbers.
> > > 
> > 
> > Looking at the usage and classifying which usages are sequence
> > numbers is part of may audit and we are covered. Your explanation
> > and this discussion helps with do a better audit of these usages.
> 
> Auditing is fine, but I still don't see any point in actually having
> these wrapping types. It's all a waste of space and compile-time IMO.
> 
> Neither this sequence counter, nor stat_t or whatever else bring any
> actual differences. They're pure wrappers without change in semantics.
> 
> refcount_t is useful because it brought different semantics, it raises
> exceptions on invalid usage (wraps). But this is just pointless NOPs.
> 
> So do your audit, but only introduce new types for things that actually
> have different semantics. If you do a patch and the generated code is
> 100% identical but you have many more lines of code, you've only made it
> worse.

I'm sorry, but as someone who reviews the second-most code in the
kernel, I have to disagree.  If I see a "raw" atomic_t being used in a
driver, I then have to look up all instances of where that variable is
being used, to verify what they are using it for, why they are using,
and if all of the means they are really using it in the correct way.

Always remember that atomic_t is way down there on the "Rusty scale of
designing an API you can use properly" scale:
	https://ozlabs.org/~rusty/ols-2003-keynote/img46.html

If I see a sequence_t variable (or whatever we end up calling it), then
I instantly KNOW what this is for, and that is is impossible to get it
wrong when using it as the API for that variable prevents it from being
misused in horrible ways (like setting it to a value and decrementing
it.)

If me, as a kernel developer, wants to add a sequence number to my
driver, yes, I can "open code" one using an atomic_t and get it right
(or just use a u64 like we do for uevents), but then when I go back and
look at the code in 5 years, I have to try to remember exactly what I
did and where it is used and try to ensure that no one changed it
incorrectly.  Again, if this is a sequence_t, all of that goes away.

So this doesn't save codespace, or generated code, it saves mental
energy which is the most limited resource we have.  We write code for
the developers first, the compiler and cpu second, in order to create
something that us developers can maintain for long periods of time.
Kernel code is not like perl (write once, modify never), but like laws
(write once, modify constantly).

Remember us poor maintainers, who are doing the reviewing, and the
junior developers, creating new drivers where they have to implement
common features/patterns and the people that come after us and curse our
name as they try to understand exactly what a specific atomic_t was
supposed to be doing.  We want to make all of our lives easier, and this
type of api does just that.

thanks,

greg k-h
