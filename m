Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F478276125
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 21:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWTec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 15:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgIWTeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 15:34:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DD5221EF;
        Wed, 23 Sep 2020 19:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600889670;
        bh=kJqftQF/c7SQ9CYWHHfmqrJPffe81/yqALfWPTEdaOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zfvHrfnpNrNgC4lRJRDmhq5Fr4Dx8rPDkp6f2/tFM2bkycJhI2P3pGcU17dUFz0t0
         xUWDTFUMUwo3d61cnslmhg8bpBTVSDqMkgnMPG6o1dJTquGiwKhyreukpTf9HgUrCX
         QIpkrCghZ8IbektRTQPFuBrC+lGqIHbP4eKt/mW4=
Date:   Wed, 23 Sep 2020 21:34:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] counters: Introduce counter and counter_atomic
Message-ID: <20200923193448.GE199068@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <e57eb89132000b255b5a7952cb82725ec2f3e4e0.1600816121.git.skhan@linuxfoundation.org>
 <202009231152.5023C4656F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009231152.5023C4656F@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:04:08PM -0700, Kees Cook wrote:
> On Tue, Sep 22, 2020 at 07:43:30PM -0600, Shuah Khan wrote:
> > Introduce Simple atomic and non-atomic counters.
> > 
> > There are a number of atomic_t usages in the kernel where atomic_t api
> > is used strictly for counting and not for managing object lifetime. In
> > some cases, atomic_t might not even be needed.
> 
> Thank you for working on a counter API! I'm glad to see work here,
> though I have some pretty significant changes to request; see below...
> 
> > 
> > The purpose of these counters is twofold: 1. clearly differentiate
> > atomic_t counters from atomic_t usages that guard object lifetimes,
> > hence prone to overflow and underflow errors. It allows tools that scan
> > for underflow and overflow on atomic_t usages to detect overflow and
> > underflows to scan just the cases that are prone to errors. 2. provides
> > non-atomic counters for cases where atomic isn't necessary.
> > 
> > Simple atomic and non-atomic counters api provides interfaces for simple
> > atomic and non-atomic counters that just count, and don't guard resource
> > lifetimes. Counters will wrap around to 0 when it overflows and should
> > not be used to guard resource lifetimes, device usage and open counts
> > that control state changes, and pm states.
> > 
> > Using counter_atomic to guard lifetimes could lead to use-after free
> > when it overflows and undefined behavior when used to manage state
> > changes and device usage/open states.
> > 
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> I would really like these APIs to be _impossible_ to use for object
> lifetime management. To that end, I would like to have all of the
> *_return() functions removed. It should be strictly init, inc, dec,
> read.
> 
> > +There are a number of atomic_t usages in the kernel where atomic_t api
> > +is used strictly for counting and not for managing object lifetime. In
> > +some cases, atomic_t might not even be needed.
> 
> Why even force the distinction? I think all the counters should be
> atomic and then there is no chance they will get accidentally used in
> places where someone *thinks* it's safe to use a non-atomic. So,
> "_atomic" can be removed from the name and the non-atomic implementation
> can get removed. Anyone already using non-atomic counters is just using
> "int" and "long" anyway. Let's please only create APIs that are always
> safe to use, and provide some benefit over a native time.

For "statistics", why take the extra overhead for an atomic variable
just to be able to show to a debugging file the number of USB packets
have been sent through the system (a current use of an atomic variable
for some odd reason...)

And really, a "int" should be pretty safe to write from multiple places,
you aren't going to get "tearing" on any processors that run Linux,
worst case you get a stale value when reading them.

So I would argue that the default for a counter be just an int, not
atomic, as odds are, most atomics are not really needed for this type of
thing at all.

thanks,

greg k-h
