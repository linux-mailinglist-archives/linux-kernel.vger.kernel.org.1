Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F2220000D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgFSCHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 22:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFSCHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:07:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1F6C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:07:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v19so3680900qtq.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSAwCY/ZmSm8oTcK0Zsy9KPDecHsitrkayxPpbpBu+E=;
        b=ovUhanm83wVlXIJLufBdonsiTLRbkjAe/Gn9wbpkwh4BZMhG9AjWoGQbrLKJjAHrQ3
         X7lzK2E/2iqnNSj0vw9sF0rk51AnHSQ/TKcMfdMYSNSE0zx7PMeXQ7ul0InzyBz9h4lG
         30sXgMFW8BlBZ6U8BQq2lDehbt8EbkFTt4C4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSAwCY/ZmSm8oTcK0Zsy9KPDecHsitrkayxPpbpBu+E=;
        b=cJVAE9M+c4txkG7FzNFK+TjoUHeVGxiMekQscJh6OC9zuppZPk/aeSVRYIcgUIFYK3
         GabWN5teJW76GW7mcGxzRn3hLQDjQX+jvJwUGBALOx/TPyflaz8WmSmW/ZsFTmFGtf63
         t5BnQ2ZecbHUcBqkikig15b9BXAumu7NYk0ERxPHx27WHIxpuuLwvCJiFV3IYC5JL5k0
         GXZc1n/EvNk0JN+UkVjnRMbtQcbJ8eTQAL9K5ZTeaVK8/xmsBF7ldFrEm34rD1PPX+ff
         7rLVcoR5SZ0BUa94NpkRy04/VUgD0jh5yNXaVk8RVbdd4Dhku1JLt5d7ezMERl+k4WG4
         od7w==
X-Gm-Message-State: AOAM532HH2R7fX6kMo/PHF6QrPf3vQciz0kwJacU2vjYcWL60seGncvL
        qaUeiL/iPo4HmurIpqost6rzUWyGhKg=
X-Google-Smtp-Source: ABdhPJy45jlIU4mw1Xr0HOiQZfCMLMbPSd/j3kDmzlb7hZxO/MqAQYzxZGLHEr1pYZ7UzOhQj5/pmg==
X-Received: by 2002:ac8:7b5a:: with SMTP id m26mr1255149qtu.381.1592532439381;
        Thu, 18 Jun 2020 19:07:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e16sm5324679qtc.71.2020.06.18.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 19:07:18 -0700 (PDT)
Date:   Thu, 18 Jun 2020 22:07:18 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/3] rcu/trace: Add name of the source for gp_seq to
 prevent confusion
Message-ID: <20200619020718.GA74764@google.com>
References: <20200619013641.63453-1-joel@joelfernandes.org>
 <20200619013641.63453-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619013641.63453-3-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:36:41PM -0400, Joel Fernandes (Google) wrote:
[...]
> @@ -2019,7 +2019,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
>  			cond_resched_tasks_rcu_qs();
>  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
>  			WARN_ON(signal_pending(current));
> -			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> +			trace_rcu_grace_period(rcu_state.name, TPS("rsp"), rcu_state.gp_seq,
>  					       TPS("reqwaitsig"));
>  		}
>  
> @@ -2263,7 +2263,7 @@ int rcutree_dying_cpu(unsigned int cpu)
>  		return 0;
>  
>  	blkd = !!(rnp->qsmask & rdp->grpmask);
> -	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
> +	trace_rcu_grace_period(rcu_state.name, TPS("rsp"), READ_ONCE(rnp->gp_seq),

This should be: TPS("rnp")  :-(

Happy to fix it up and resend if you'd like. Thanks!

