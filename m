Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E98276297
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIWUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbgIWUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:54:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAE2C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:54:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id c3so374751plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aK2OP1WSrHtWE6Ww4bs+X3aVUzVJGpCVpz2gRcHtwA0=;
        b=kYcTwQwWMqftdxwhzWWgowTZfimTD7KqRn1l9YrD90w9ex31KHZLiIHTvhuLGG4vxT
         2qxQyiHIs3uikG4ZbHrKEUFuOazl+d1TBrTT0Jnbe2g36MGHQBpdVPhU5j8pdkJcUsFA
         ENeTY3YOtFGC5d9p0ZHaVx+EcExvEVXsKqWL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aK2OP1WSrHtWE6Ww4bs+X3aVUzVJGpCVpz2gRcHtwA0=;
        b=lYwXPKmLTGHmL6hpHUWV3drTZQ7kfJVnc24Ou7uL5eBHc+/OoPH9mYGK68w2qSKFFV
         AaTkXIwZNu9t46WyYm+edHvYwLCCqulnxiG32Jjew1429CsTSvZJplhTzC+AfOcA38PV
         gRU8iXmpicTwp2KlggkuQ5dmBoroVjsB+GaTe3PkDmuhkz8ROYh1W5pUyLAi+40LrA88
         e11XDjgVr02LlZ1oD7X8ZuZtvkIUs1+cUccLWawXNnH5yyyu2VhsNNbhNwWuQHu/NjKZ
         aBLPaxkGOnJYpJj1J/Oe6gMHT2Sgc2x40oTMOK25VwEmL3xysDcvyWt6cn/EcSQvDzr2
         YNYw==
X-Gm-Message-State: AOAM531DsIPhOJa/eglfpUNjJdL1vFSMXVbQbX02k8WAQUgL+s0j+P4d
        iNVDNCFxnIkNzPVk5S/MPvxP9g==
X-Google-Smtp-Source: ABdhPJw0q2ghXSmmnijYZ6myPLm27BfHwbtqDByFX1uiHKkHZPtlQ7zUJIY6tyEaoFCMKKilQgaB4Q==
X-Received: by 2002:a17:902:6b05:b029:d2:8b5:14 with SMTP id o5-20020a1709026b05b02900d208b50014mr1518642plk.80.1600894480529;
        Wed, 23 Sep 2020 13:54:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm656685pgi.74.2020.09.23.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:54:39 -0700 (PDT)
Date:   Wed, 23 Sep 2020 13:54:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 01/11] counters: Introduce counter and counter_atomic
Message-ID: <202009231351.2D6AC4010E@keescook>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <e57eb89132000b255b5a7952cb82725ec2f3e4e0.1600816121.git.skhan@linuxfoundation.org>
 <202009231152.5023C4656F@keescook>
 <20200923193448.GE199068@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923193448.GE199068@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:34:48PM +0200, Greg KH wrote:
> On Wed, Sep 23, 2020 at 12:04:08PM -0700, Kees Cook wrote:
> > On Tue, Sep 22, 2020 at 07:43:30PM -0600, Shuah Khan wrote:
> > > Introduce Simple atomic and non-atomic counters.
> > > 
> > > There are a number of atomic_t usages in the kernel where atomic_t api
> > > is used strictly for counting and not for managing object lifetime. In
> > > some cases, atomic_t might not even be needed.
> > 
> > Thank you for working on a counter API! I'm glad to see work here,
> > though I have some pretty significant changes to request; see below...
> > 
> > > 
> > > The purpose of these counters is twofold: 1. clearly differentiate
> > > atomic_t counters from atomic_t usages that guard object lifetimes,
> > > hence prone to overflow and underflow errors. It allows tools that scan
> > > for underflow and overflow on atomic_t usages to detect overflow and
> > > underflows to scan just the cases that are prone to errors. 2. provides
> > > non-atomic counters for cases where atomic isn't necessary.
> > > 
> > > Simple atomic and non-atomic counters api provides interfaces for simple
> > > atomic and non-atomic counters that just count, and don't guard resource
> > > lifetimes. Counters will wrap around to 0 when it overflows and should
> > > not be used to guard resource lifetimes, device usage and open counts
> > > that control state changes, and pm states.
> > > 
> > > Using counter_atomic to guard lifetimes could lead to use-after free
> > > when it overflows and undefined behavior when used to manage state
> > > changes and device usage/open states.
> > > 
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > 
> > I would really like these APIs to be _impossible_ to use for object
> > lifetime management. To that end, I would like to have all of the
> > *_return() functions removed. It should be strictly init, inc, dec,
> > read.
> > 
> > > +There are a number of atomic_t usages in the kernel where atomic_t api
> > > +is used strictly for counting and not for managing object lifetime. In
> > > +some cases, atomic_t might not even be needed.
> > 
> > Why even force the distinction? I think all the counters should be
> > atomic and then there is no chance they will get accidentally used in
> > places where someone *thinks* it's safe to use a non-atomic. So,
> > "_atomic" can be removed from the name and the non-atomic implementation
> > can get removed. Anyone already using non-atomic counters is just using
> > "int" and "long" anyway. Let's please only create APIs that are always
> > safe to use, and provide some benefit over a native time.
> 
> For "statistics", why take the extra overhead for an atomic variable
> just to be able to show to a debugging file the number of USB packets
> have been sent through the system (a current use of an atomic variable
> for some odd reason...)
> 
> And really, a "int" should be pretty safe to write from multiple places,
> you aren't going to get "tearing" on any processors that run Linux,
> worst case you get a stale value when reading them.
> 
> So I would argue that the default for a counter be just an int, not
> atomic, as odds are, most atomics are not really needed for this type of
> thing at all.

If the atomicity isn't needed, then they can just use an int. ;)

I think the _counter_ type should be robust. We're specifically looking
at replacing the users who are already using atomic_t for counting. The
idea is to separate all the atomic_t doing ref counting into refcount_t
and all the atomic_t doing statistics into "struct counter", and then
what's left can meaningfully be reasoned about. i.e. "why is this a raw
atomic)t?"

But creating "struct counter" with a non-atomic API doesn't make sense
to me. And it certainly doesn't make sense for replacing existing
atomic_t statistics use cases.

-- 
Kees Cook
