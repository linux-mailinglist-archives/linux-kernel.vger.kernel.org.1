Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E61EE394
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 13:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFDLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 07:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDLlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:41:25 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9131206C3;
        Thu,  4 Jun 2020 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591270885;
        bh=UBKyy2292/Qs7yuV0PzlCmNj9QSdZxTW+WpRv18lofI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlFp+QAKatXoF1qb5raWmqFj/A1wIzTWq2xphgk6psHrm5QNXvJbWT1adpygeXFK7
         MsJhdM+XDyruBZ5vPL145/HNTtn2hTpnsJRK450BKZl6/sCR++8zJ8DdO7UUDuEFvI
         eL2617YoHicIftXJfMvO+RT8hjyAwPRjue8z+0iU=
Date:   Thu, 4 Jun 2020 13:41:22 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 01/10] rcu: Directly lock rdp->nocb_lock on nocb code
 entrypoints
Message-ID: <20200604114121.GA26398@lenoir>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-2-frederic@kernel.org>
 <20200520122949.GB16672@google.com>
 <20200522175739.GM2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522175739.GM2869@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 10:57:39AM -0700, Paul E. McKenney wrote:
> On Wed, May 20, 2020 at 08:29:49AM -0400, Joel Fernandes wrote:
> > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thank you for looking this over, Joel!
> 
> Is it feasible to make rcu_nocb_lock*() and rcu_nocb_unlock*() "do the
> right thing", even when things are changing?  If it is feasible, that
> would prevent any number of "interesting" copy-pasta and "just now became
> common code" bugs down the road.

This won't be pretty:

    locked = rcu_nocb_lock();
    rcu_nocb_unlock(locked);

And anyway we still want to unconditionally lock on many places,
regardless of the offloaded state. I don't know how we could have
a magic helper do the unconditional lock on some places and the
conditional on others.

Also the point of turning the lock helpers into primitives is to make
it clearer as to where we really need unconditional locking and where
we allow it to be conditional. A gift to reviewers :-)

Thanks.
