Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D32F30462D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394651AbhAZSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:20:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394427AbhAZSPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:15:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE5E820780;
        Tue, 26 Jan 2021 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611684905;
        bh=3pVCU2akVCfUY9nBoClkWaDk9ECtyCUfD5m0GIsKt5g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KJ8iYIzfilFtTjP0Hpob5ttwArvX0gV9/sqWYrsqoZwv/8aiWpePb9+rRldIr9iCG
         eFWQ0G4ckxKOAPckxMeEQb5IaWuxByT6CSJFir3QiDORBD4yis0I71xzTQ6vZJzipc
         h4gzvq9CxBiNpkGh527AUV+iFqDwws2/wGF55+26Uo4idRy61o1bA8B/WQ1hcAyoEw
         K6gnhdmDxgHDmrDQfWh8jgFuVtEUviSHEHPPZI+6e8WRSpnpQTxp3EYb/f0i+M59fe
         mTqhwIPnxrvJ/hF6kZcgzKIhYBXt/S4DJ4GVmthx8jwl2w7mCfuM9fXoPU5O1SZEJx
         2l/f4DRm2CqMg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9617C352268C; Tue, 26 Jan 2021 10:15:04 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:15:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        boqun.feng@gmail.com, kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] kcsan: Switch to KUNIT_CASE_PARAM for parameterized
 tests
Message-ID: <20210126181504.GF2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210113160557.1801480-1-elver@google.com>
 <20210113160557.1801480-2-elver@google.com>
 <CABVgOS=sOZ29Q0Ut8YSKD+BrXDQwGftPeYEoON_iOxajK_wL9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=sOZ29Q0Ut8YSKD+BrXDQwGftPeYEoON_iOxajK_wL9w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:35:47PM +0800, David Gow wrote:
> On Thu, Jan 14, 2021 at 12:06 AM Marco Elver <elver@google.com> wrote:
> >
> > Since KUnit now support parameterized tests via KUNIT_CASE_PARAM, update
> > KCSAN's test to switch to it for parameterized tests. This simplifies
> > parameterized tests and gets rid of the "parameters in case name"
> > workaround (hack).
> >
> > At the same time, we can increase the maximum number of threads used,
> > because on systems with too few CPUs, KUnit allows us to now stop at the
> > maximum useful threads and not unnecessarily execute redundant test
> > cases with (the same) limited threads as had been the case before.
> >
> > Cc: David Gow <davidgow@google.com>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> 
> Thanks! This looks great from the KUnit point of view: I'm
> particularly excited to see a use of the parameterised test generator
> that's not just reading from an array.
> 
> I tested this as well, and it all seemed to work fine for me.
> 
> Reviewed-by: David Gow <davidgow@google.com>

I applied both Reviewed-by tags, thank you!

							Thanx, Paul
