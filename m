Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69476275C58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgIWPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:47:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWPrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:47:41 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214AE2223E;
        Wed, 23 Sep 2020 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600876061;
        bh=HmLgHeuN3iqK1yowHO5d7riEdrMBcF2EKeYaKbNiQpo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e3bKQJ0Z7Ilg8f57bV1gcAj+wyjp5sJ7tMqp6sSQgu5ABMqGZ1UErEKxPAj2HB0Za
         //cpTfj+NDAS1BD9wtjfLu+qZay5EXQSrsTlCojnmO+XaZa6QR/7Wy10uYKkfdIG+C
         4ISDfp4E3KWWlJwO/uDb0YOth5MW3GNKMJ+kBmoY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C5A3735226CB; Wed, 23 Sep 2020 08:47:40 -0700 (PDT)
Date:   Wed, 23 Sep 2020 08:47:40 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH 07/12] rcu: Shutdown nocb timer on de-offloading
Message-ID: <20200923154740.GQ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-8-frederic@kernel.org>
 <20200922001756.GP29330@paulmck-ThinkPad-P72>
 <20200923152951.GC31465@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152951.GC31465@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:29:52PM +0200, Frederic Weisbecker wrote:
> On Mon, Sep 21, 2020 at 05:17:56PM -0700, Paul E. McKenney wrote:
> > On Mon, Sep 21, 2020 at 02:43:46PM +0200, Frederic Weisbecker wrote:
> > > Make sure the nocb timer can't fire anymore before we reach the final
> > > de-offload state. Spuriously waking up the GP kthread is no big deal but
> > > we must prevent from executing the timer callback without nocb locking.
> > 
> > If we had just the previous patch and not this patch, would things break?
> > Or are you relying on the fact that there is not yet a connection to
> > userspace controls for this functionality?
> 
> Exactly it shouldn't break because only the last patch makes the code
> eventually used.

That works, thank you!

							Thanx, Paul
