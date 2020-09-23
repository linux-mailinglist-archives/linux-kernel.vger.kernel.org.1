Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB88275BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgIWPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbgIWPZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:25:13 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EAD2220D;
        Wed, 23 Sep 2020 15:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600874713;
        bh=GtUNi2xC/DgdAUMktjvo6czLNTJ9nms3Adqfe/jg1gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qj/4Jc+mZHzRendLHQgw1OaMaRrMJwD/fRy0JEQ3j1lErl5LUWQo2ALwEYZ2p8Sec
         Layj50SVJrhV7oqIJe84DqBizv6cdoS1+gahgPKRshtIz+KAPn4uejW08IJ9IcoKam
         eq366HchbHDi0vTyU8Vzdb8IUnfuurDOcDMq2UKU=
Date:   Wed, 23 Sep 2020 17:25:10 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 01/12] rcu: Implement rcu_segcblist_is_offloaded()
 config dependent
Message-ID: <20200923152509.GA31465@lenoir>
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-2-frederic@kernel.org>
 <20200922002732.GT29330@paulmck-ThinkPad-P72>
 <20200922214326.GF5217@lenoir>
 <20200922231150.GK29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922231150.GK29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 04:11:50PM -0700, Paul E. McKenney wrote:
> On Tue, Sep 22, 2020 at 11:43:26PM +0200, Frederic Weisbecker wrote:
> > On Mon, Sep 21, 2020 at 05:27:32PM -0700, Paul E. McKenney wrote:
> > > On Mon, Sep 21, 2020 at 02:43:40PM +0200, Frederic Weisbecker wrote:
> > > > This simplify the usage of this API and avoid checking the kernel
> > > > config from the callers.
> > > > 
> > > > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Paul E. McKenney <paulmck@kernel.org>
> > > > Cc: Josh Triplett <josh@joshtriplett.org>
> > > > Cc: Steven Rostedt <rostedt@goodmis.org>
> > > > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > > > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > > > Cc: Joel Fernandes <joel@joelfernandes.org>
> > > 
> > > Nice cleanup!  I clearly should have done it this way to start with.
> > > 
> > > Any reason I shouldn't pull this into -rcu right now?
> > 
> > I think that very one can be applied indeed.
> 
> Very well!  I had to hand-apply it due to recent -rcu thrash, and as
> usual I could not resist wordsmithing the commit log.  Please let
> me know if I messed anything up.

Looks very good, thanks!
