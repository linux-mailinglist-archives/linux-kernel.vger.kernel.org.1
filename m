Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C779275BD8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgIWP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:29:55 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BD902137B;
        Wed, 23 Sep 2020 15:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600874994;
        bh=7l4VO5Gn17d/Ct5xI0JVWzhQ7CT5xAwugtJymierFeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkGx1xypxUZDmg9hdxcDqHvjvN5E1SfL0AKJ+KJxR5iDR8a8AgnnD8vIR9j5SzFIn
         03CDUJilH/E2nJCCdItK8sdF5AUard8jbKjsARZAySQxh2oyXrjUPV+Jq2qNUi1Di9
         ltYgZBuYHgMmGKFExoVgZ5/U4QFBTWhl+CjzZxyQ=
Date:   Wed, 23 Sep 2020 17:29:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 07/12] rcu: Shutdown nocb timer on de-offloading
Message-ID: <20200923152951.GC31465@lenoir>
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-8-frederic@kernel.org>
 <20200922001756.GP29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922001756.GP29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:17:56PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 02:43:46PM +0200, Frederic Weisbecker wrote:
> > Make sure the nocb timer can't fire anymore before we reach the final
> > de-offload state. Spuriously waking up the GP kthread is no big deal but
> > we must prevent from executing the timer callback without nocb locking.
> 
> If we had just the previous patch and not this patch, would things break?
> Or are you relying on the fact that there is not yet a connection to
> userspace controls for this functionality?

Exactly it shouldn't break because only the last patch makes the code
eventually used.

Thanks.
