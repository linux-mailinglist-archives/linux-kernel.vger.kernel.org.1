Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28937274B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 23:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgIVVn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 17:43:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgIVVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 17:43:29 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8212722262;
        Tue, 22 Sep 2020 21:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600811009;
        bh=C0Pq2Jva7ep1iKtzZ7p1pfFIlKzwaru5SHy3dZ8FJcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwK/OYDwzDdqshCMFJr1i7Ga+b0v2qtBy7WPk+EVb/dgH2fad5BgQ3swIzy/7DZOF
         Tq2cS4uE6JQTbejKHf72rHlbhp2jhKHwbovnqlQnGqgP7aO/1Q162FG9nnLVqAstZj
         RYwTeZ/0J3wMXUirtiFGUS14lL6yNx5W51K5HfSM=
Date:   Tue, 22 Sep 2020 23:43:26 +0200
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
Message-ID: <20200922214326.GF5217@lenoir>
References: <20200921124351.24035-1-frederic@kernel.org>
 <20200921124351.24035-2-frederic@kernel.org>
 <20200922002732.GT29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922002732.GT29330@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 05:27:32PM -0700, Paul E. McKenney wrote:
> On Mon, Sep 21, 2020 at 02:43:40PM +0200, Frederic Weisbecker wrote:
> > This simplify the usage of this API and avoid checking the kernel
> > config from the callers.
> > 
> > Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Josh Triplett <josh@joshtriplett.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> > Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> > Cc: Joel Fernandes <joel@joelfernandes.org>
> 
> Nice cleanup!  I clearly should have done it this way to start with.
> 
> Any reason I shouldn't pull this into -rcu right now?

I think that very one can be applied indeed.

Thanks!
