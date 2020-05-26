Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B674D1BB1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 00:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgD0W7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 18:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgD0W7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:59:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E083206D4;
        Mon, 27 Apr 2020 22:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588028345;
        bh=cLUGvbDc/Zbl/9PEqINH3URqTzf19cVvf8QERgljLUA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wNaqED5JyA9j5GJljfV2rKBw5YPLUihDF/E2zPwwkaGXUxr0xEudgEDIMCsM34/fZ
         xRePfzrpIBWUM6A1lITzNFIbEB4hkzi1OK2GlTchnFSguZXM5nwrTTOlK0VUdUupIn
         jy5r1vh3TaXGIiMs7+JY6gALGlrUnI37NBKwgNfE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id DFD3135227CC; Mon, 27 Apr 2020 15:59:04 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:59:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jon Masters <jcm@jonmasters.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH tip/core/rcu 2/6] Documentation/memory-barriers.txt:
 ACCESS_ONCE() provides cache coherence
Message-ID: <20200427225904.GQ7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <f3cdec26-480e-d2e0-3e54-4b0536831fcd@jonmasters.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3cdec26-480e-d2e0-3e54-4b0536831fcd@jonmasters.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:36:19PM -0400, Jon Masters wrote:
> Hi Paul,
> 
> On 2/17/14 4:26 PM, Paul E. McKenney wrote:
> 
> > The ACCESS_ONCE() primitive provides cache coherence, but the
> > documentation does not clearly state this.  This commit therefore upgrades
> > the documentation.
> 
> <snip>
> 
> > +     In short, ACCESS_ONCE() provides "cache coherence" for accesses from
> > +     multiple CPUs to a single variable.
> 
> (ACCESS_ONCE is now READ_ONCE/WRITE_ONCE but the above added the original
> language around cache coherence)
> 
> I would argue that we might want to avoid describing it in this manner. The
> hardware provides cache coherency in order to keep a single memory location
> coherent between multiple observers. These kernel macros only tell the
> compiler to perform the load once. They take advantage of the properties of
> coherence in the presence of multiple observers.

You lost me on this one.  Are you advocating that this be described
as constraining the compiler from invalidating the cache coherency
(single-variable sequential consistency) provided by modern hardware?

Just for background, my view is that "cache coherence", like "real time",
is a property of the system that can be destroyed by any component.

							Thanx, Paul
