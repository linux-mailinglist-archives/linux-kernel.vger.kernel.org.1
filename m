Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114622837F0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJEOiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:38:10 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C713BC0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:38:09 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g3so9707019qtq.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGjcwRAoiqcduLL2bxQ4mHoOvaw+GK5le8AMRCfmziw=;
        b=Bmw2n+ZEzJQaKE0lF5o7u1Lny3AaHHJ1s/MBbnlqcsehpjY15tpnjoS32mD482jU+8
         GqOGgIv5kVYk/89W/E4oaUfgOT7R1AxCmW1IB36WtIvZxuHdbUwphs4F5otG5l4NMVKh
         ctvXvL01VhWc29V2l6tVKaiiczQVgnQWDQ4Gk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGjcwRAoiqcduLL2bxQ4mHoOvaw+GK5le8AMRCfmziw=;
        b=UmJSJ3Wb0xG52KcTrnF/ot3sYSvCy/a6s07qMuZpZT/AXxfErpT61BXDpk0dfgXHEM
         dUEGVboowDm5qu9PE2d0tAnQy0YRTs7n6+acdCPA7n13cGIi1tq8jMqMz3D7s67ub6D4
         zvgZDBRdNB8JlDPTV6CZso38HSZG9DZJk6Xfv0bV2F7cRTx8rjPG/ZiR0xkB02tJ6D6z
         X7G6pxSjEi17lFdEwWCiuFwtu66hMQkbLxZ7fGODsMzxDOIMcrwJsEAIWTnHqbpCD+fM
         mezJXGCBobgGqIneaPFef585J7oy2WSHjE3rlIr0kceRVm/ybJjAK5wxQEv53tRn4QO8
         7DEw==
X-Gm-Message-State: AOAM530qXT3lWhWlVZ0g60toUWztpYeOK19a+/XkfWu1hAfBGIgiAqih
        Jv+Hl+2VZfBbkFpOMallYlC0GRBoLWtg+w==
X-Google-Smtp-Source: ABdhPJwlsLhBT0dRBWHT+f4KE7q+zVHQeWZVqYsZai7MVOu1pu+fWrvddx8Y+xXI+Z25jCQFeGPMDw==
X-Received: by 2002:ac8:5d0d:: with SMTP id f13mr117396qtx.87.1601908688715;
        Mon, 05 Oct 2020 07:38:08 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n7sm463339qtp.93.2020.10.05.07.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 07:38:08 -0700 (PDT)
Date:   Mon, 5 Oct 2020 10:38:07 -0400
From:   joel@joelfernandes.org
To:     linux-kernel@vger.kernel.org
Cc:     neeraju@codeaurora.org, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] rcu/tree: nocb: Avoid raising softirq when there are
 ready to execute CBs
Message-ID: <20201005143807.GA524504@google.com>
References: <20201005021132.146534-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005021132.146534-1-joel@joelfernandes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 04, 2020 at 10:11:32PM -0400, Joel Fernandes (Google) wrote:
> During testing, I see it is possible that rcu_pending() returns 1 when
> offloaded callbacks are ready to execute thus raising the RCU softirq.
> 
> However, softirq does not execute offloaded callbacks. They are executed in a
> kthread which is awakened independent of the softirq.
> 
> This commit therefore avoids raising the softirq in the first place. That's
> probably a good thing considering that the purpose of callback offloading is to
> reduce softirq activity.
> 
> Passed 30 minute tests of TREE01 through TREE09 each.
> 
> On TREE08, I notice that there is atmost 150us from when the softirq was
> NOT raised when ready cbs were present, to when the ready callbacks were
> invoked by the rcuop thread. This also further confirms that there is no
> need to raise the softirq for ready cbs in the first place.

Hi Paul,
You had asked me about whether removing this softirq invocation indirectly
slows down grace period progression.

This morning, I ran rcutorture.fwd_progress on TREE08 and I don't see any
difference in number of grace periods with/without this patch. Just want to
let you know.

Thanks,

 - Joel

> 
> Cc: neeraju@codeaurora.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
> 
> v1->v2: Also cleaned up another test of the nocb configuration macro.
> 
>  kernel/rcu/tree.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index f78ee759af9c..2b1e1b21db92 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3652,13 +3652,13 @@ static int rcu_pending(int user)
>  		return 1;
>  
>  	/* Does this CPU have callbacks ready to invoke? */
> -	if (rcu_segcblist_ready_cbs(&rdp->cblist))
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
> +	    rcu_segcblist_ready_cbs(&rdp->cblist))
>  		return 1;
>  
>  	/* Has RCU gone idle with this CPU needing another grace period? */
>  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> -	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
> -	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
> +	    (!rcu_segcblist_is_offloaded(&rdp->cblist)) &&
>  	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>  		return 1;
>  
> -- 
> 2.28.0.806.g8561365e88-goog
