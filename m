Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7937F2EC591
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbhAFVRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFVRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:17:42 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06736C061757
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 13:17:02 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id u26so4098189iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LqnpZZaOgAY4yAAIC3yU2hn9Amq6TciTL0LFzqShfbA=;
        b=Y8ijcEeM5nuL9Ru39V/RIYZZ4SaD/88k8WrESfGFmXotkW+FeGGCnO7pvS2rwOFYl/
         kkuLIztOSX1jI99KJ3SdPBSJ01D0w4JrijmB60Xilq44KvOb2h+gOHgMHHldS2l3uB6Y
         xSvSiV4UQ3La73/i6aECnPj4Myp2haPjPjzXgRWzDAISBOsP+6t12MIOz3o1VktYQUOE
         kaD5w67T+2ethvyzIEAMmK1Tt7ROvcjzMAqO8VyhkU1d8kyoLqVUkglRwEomm7bBBsx8
         6xYNwU/c8mZ2etEsVtvyaz4IBeGSX0vZ3zJxKolgO0mZtS1lOUDSOkfgC9map+50E5ZP
         42Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LqnpZZaOgAY4yAAIC3yU2hn9Amq6TciTL0LFzqShfbA=;
        b=Ql+a5t2wT2ep4AU8eUxGt2dZ9+jH3vVfR/nZEyfZTV8DaXiSXvU90Dc8NMNvCjb5T5
         WonfVFuGkoSKh4f8SkzWtDxoaow8SPc+9WXPhQbIpywvi3rgCRa5AIRjtftv7UGsgoIU
         pzBw4dkfR0TITB8elWNq45P+oycbrFt9/Gw+lRKEX4xElUcwh2lJACmv12gbfKX59315
         57qBruUO4lDTMbqklTmzkHsPIZJzYyp1O6QJYjoFxlx5ntJmapZN0O0QCWvoBcOP+0YN
         9lOUFQGQS/8nrNDkThJSssd4ranffbR4wjXDHa1bw2Ie+s59DXWqh8COvGLaUMKOgg0W
         c0IA==
X-Gm-Message-State: AOAM530ys+HXw0da6FT23Mk0oKoie8sMyIMEzCCU6ac9XWEK23Al6twr
        T8Tcz/Q91n61xxp/prCUw+olRhLQniaOAZeZEFGrk5PD5xHaqg==
X-Google-Smtp-Source: ABdhPJxghafYjyj+Y8W59tnCmzWx9h+dy/If4GHa7ylzA6pbBezUs4wlNQDsCnuopPCFzShrV42SAdJNKeGIGw9fwHY=
X-Received: by 2002:a02:b042:: with SMTP id q2mr5237158jah.29.1609967821243;
 Wed, 06 Jan 2021 13:17:01 -0800 (PST)
MIME-Version: 1.0
References: <20210106004850.GA11682@paulmck-ThinkPad-P72> <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
In-Reply-To: <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 6 Jan 2021 13:16:50 -0800
Message-ID: <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list specifications
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 1:50 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 05, 2021 at 04:49:55PM -0800, paulmck@kernel.org wrote:
> > From: Paul Gortmaker <paul.gortmaker@windriver.com>
> >
> > It seems that a common configuration is to use the 1st couple cores
> > for housekeeping tasks, and or driving a busy peripheral that generates
> > a lot of interrupts, or something similar.
> >
> > This tends to leave the remaining ones to form a pool of similarly
> > configured cores to take on the real workload of interest to the user.
> >
> > So on machine A - with 32 cores, it could be 0-3 for "system" and then
> > 4-31 being used in boot args like nohz_full=, or rcu_nocbs= as part of
> > setting up the worker pool of CPUs.
> >
> > But then newer machine B is added, and it has 48 cores, and so while
> > the 0-3 part remains unchanged, the pool setup cpu list becomes 4-47.
> >
> > Deployment would be easier if we could just simply replace 31 and 47
> > with "last" and let the system substitute in the actual number at boot;
> > a number that it knows better than we do.
> >
> > No need to have custom boot args per node, no need to do a trial boot
> > in order to snoop /proc/cpuinfo and/or /sys/devices/system/cpu - no
> > more fencepost errors of using 32 and 48 instead of 31 and 47.
> >
> > A generic token replacement is used to substitute "last" with the
> > number of CPUs present before handing off to bitmap processing.  But
> > it could just as easily be used to replace any placeholder token with
> > any other token or value only known at/after boot.
>
> Aside from the comments Yury made, on how all this is better in
> bitmap_parselist(), how about doing s/last/N/ here? For me something
> like: "4-N" reads much saner than "4-last".
>
> Also, it might make sense to teach all this about core/node topology,
> but that's going to be messy. Imagine something like "Core1-CoreN" or
> "Nore1-NodeN" to mean the mask all/{Core,Node}0.

If you just want to teach bitmap_parselist() to "s/Core0/0-4",  I think
it's doable if we add a hook to a proper subsystem in bitmap_parselist().

> And that is another feature that seems to be missing from parselist,
> all/except.

We already support groups in a range. I think it partially covers the
proposed all/except.

Can you share examples on what you miss?
