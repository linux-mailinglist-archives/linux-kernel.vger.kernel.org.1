Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA67B2ED393
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbhAGPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:33:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbhAGPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:33:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 86F2C23405;
        Thu,  7 Jan 2021 15:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610033564;
        bh=J2A8dkQ/NsxKAvM9Lqfg4UecX1/COeevtflgDIMOHY8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=a+wzvgqa8wzPiEk8G1t1Tp2ibB2qv2IUqNl/mc63eyMlHWpFJVs4ZqQpzco/s407u
         deTVFnbeO53I2GZT51Tn12GVf3hg6PaQQlwObwngxuoTWe099NsO9NTbesTuojUmFA
         gQdGa3AU2PenCHy2CzE2oRWgE6gAkSJRp8CSxuVOGIroa+XalA5UrOZNOxgoUnrUEK
         0kyssDkOhRpyG+ZXv1kmcS1d/hfmwVD6bnYpOl9c1sWiIonQx8XSwGgRMmQ+UDXKOL
         soHC5rSjR7VSBp++PthSIwV4WIFymFHKoODsw2AOIEDRnRAmZGBUu5GRgqbe9tyYUJ
         n8lQLeF2xCIIA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 53BF73522589; Thu,  7 Jan 2021 07:32:44 -0800 (PST)
Date:   Thu, 7 Jan 2021 07:32:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com, Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH RFC cpumask 4/5] cpumask: Add "last" alias for cpu list
 specifications
Message-ID: <20210107153244.GL2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
 <20210106004956.11961-4-paulmck@kernel.org>
 <X/WHk1hY3cmMAXQz@hirez.programming.kicks-ass.net>
 <CAAH8bW9jfSeYe+d6feQUTKuqwKr_U0aCGPZEiBh6Hp=KT2iPrA@mail.gmail.com>
 <X/cYR474/PiTvjfC@hirez.programming.kicks-ass.net>
 <20210107144757.GK2743@paulmck-ThinkPad-P72>
 <X/ch3gaCCRMT/Cxw@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/ch3gaCCRMT/Cxw@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 03:59:42PM +0100, Peter Zijlstra wrote:
> On Thu, Jan 07, 2021 at 06:47:57AM -0800, Paul E. McKenney wrote:
> > > I don't really see the use of the ranges thing, CPU enumeration just
> > > isn't sane like that. Also, I should really add that randomization pass
> > > to the CPU enumeration :-)
> > 
> > Please don't!!!
> 
> Why not, the BIOS more or less already does that on a per machine basis
> anyway. Doing it per boot just makes things more reliably screwy ;-)

Fixing BIOS would be much more productive, now wouldn't it?

							Thanx, Paul
