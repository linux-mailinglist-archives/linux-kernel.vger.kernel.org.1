Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40081EE89C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgFDQbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 12:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgFDQbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:31:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260AA206DC;
        Thu,  4 Jun 2020 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591288260;
        bh=p22Qks7bzkvMwOfKr4OS5tjK01cXYo3wKjWBTk6+0r4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uV9GQ7XZ003JbvFHFVSz63OBBEqFTRLALl6oVWQ4yfQ9dpq11k7ya0hsCfTXFRHLa
         TFNkkZQI46i3s3lfPSwRZUD8h19yU6TOb/1ACMlfvrKGQ4yK28x0Xmv0ktc6JPfmys
         nDkq8YHA/Yi15oa7Wa3949Ccr6aUbWhS6FGGa6DY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0B6F835228BC; Thu,  4 Jun 2020 09:31:00 -0700 (PDT)
Date:   Thu, 4 Jun 2020 09:31:00 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Peter Enderborg <peter.enderborg@sony.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Stop shrinker loop
Message-ID: <20200604163100.GB29598@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604102320.15914-1-peter.enderborg@sony.com>
 <20200604134255.GA24897@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604134255.GA24897@pc636>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:42:55PM +0200, Uladzislau Rezki wrote:
> On Thu, Jun 04, 2020 at 12:23:20PM +0200, Peter Enderborg wrote:
> > The count and scan can be separated in time. It is a fair chance
> > that all work is already done when the scan starts. It
> > then might retry. This is can be avoided with returning SHRINK_STOP.
> > 
> > Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> > ---
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index c716eadc7617..8b36c6b2887d 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3310,7 +3310,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >  			break;
> >  	}
> >  
> > -	return freed;
> > +	return freed == 0 ? SHRINK_STOP : freed;
> >  }
> >  
> The loop will be stopped anyway sooner or later, but sooner is better :)
> To me that change makes sense.
> 
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Queued, thank you both!

							Thanx, Paul
