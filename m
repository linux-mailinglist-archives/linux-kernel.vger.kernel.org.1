Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 614E319F8E7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 17:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgDFPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 11:32:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728853AbgDFPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:32:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF1B248A6;
        Mon,  6 Apr 2020 15:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586187157;
        bh=BlQIdrrOFcqez9JdgtwsN+l2kO70gj3jBKINTfGXigA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uKGLaV9BTR1Sg2s2h8xuNINXNdm6rXaM+umYKUvRXEMf7lx64q1DcNEhCquatzuf0
         c7RgzdFZx+JY1IfZuzvDTvl83flSwuGOy4ISSAPE5MzxGioEMqck6EnTGmoERsWAze
         oUehZaKpTNKzHKeqaNMjDHNJr2GaTX/zgiGwPkyw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1924A35230D1; Mon,  6 Apr 2020 08:32:37 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:32:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: db4ead2cd5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200406153237.GF19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <5e89ae97.XlZ1PbIKMXWOOfLI%lkp@intel.com>
 <20200405145232.GY19865@paulmck-ThinkPad-P72>
 <20200406025056.GA13310@madhuparna-HP-Notebook>
 <20200406152259.GG83565@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406152259.GG83565@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 11:22:59AM -0400, Joel Fernandes wrote:
> On Mon, Apr 06, 2020 at 08:20:57AM +0530, Madhuparna Bhowmik wrote:
> > On Sun, Apr 05, 2020 at 07:52:32AM -0700, Paul E. McKenney wrote:
> > > On Sun, Apr 05, 2020 at 06:10:31PM +0800, kernel test robot wrote:
> > > > Greetings,
> > > > 
> > > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.21a
> > > 
> > > Is some of the required conversion still left to be done?  Or on its
> > > way up some other tree?
> > > 
> > > If either of these two, my normal approach would be to hold this commit
> > > back in order to give the fixes time to hit mainline.
> > > 
> > > But either way, please let me know!
> > >
> > Yes, some of the patches are not yet reviewed by maintainers and we will
> > resend them. Also, this report reports a few new ones that we haven't
> > fixed yet (need some help from maintainers to do so).
> > We are working on fixing them. May be holding the commit is a
> > good idea.
> 
> I am Ok with holding on to the commit for mainline. But I would like it into
> linux-next so that we and others can get some more velocity on fixing the
> remaining issues (and any maintainers who have not yet accepted patches to
> review those). We fixed most of them but there could be some more lurking.
> Paul, how does that sound?

Once v5.7-rc1 comes out, it sounds great!

(Just got my knuckles rapped (gently) for forgetting to pull this stuff
out of -next for all of last week.)

So early next week it returns to -next.

							Thanx, Paul

> Either way, we should consider that this feature is turned on only for
> lockdep-enabled kernels so it is only used for debugging.
> 
> thanks,
> 
>  - Joel
> 
