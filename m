Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA081B3F38
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 12:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgDVKfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 06:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731107AbgDVKfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:35:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE9AC03C1A8;
        Wed, 22 Apr 2020 03:35:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so1711997ljg.5;
        Wed, 22 Apr 2020 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EcjcBCMisxSrvOIyXUn8t/Z2HQERoHgRrxwf6c0lYoA=;
        b=Pl9SzVv1JQtR3HbMFszvij+VHWA9WVSyFHTToSyD+LB//HCJRy260B2Wp2RQzrxuTw
         9NPqH/cRptXKxFTZrKvJgy9cUbISAuo9jW3F6V8Pz8ajARd9xizsEvReCxiWYR4N2fec
         H/orW+bSltcvbneXsFJw28PjL72pvwS6FzVtED8bAdnQ8x2Uu7lQeW/5Ds9FGU4970YS
         zU/CWpkpKjjWg1jgvqUduNmS6CAxCUkU5i41f40SgnlXW440KxIW28nuqs8zCHxODru+
         uGBhVRT9FKsLDSj5TIkQI+D4PTqk6BBEDv9sBcrY03uNLW+NwqfJQmbOB1guC+Z8vGPX
         kjSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EcjcBCMisxSrvOIyXUn8t/Z2HQERoHgRrxwf6c0lYoA=;
        b=CxXpS/6q463N03nACgt2yl2z/9DlHDy3dNNnZmomDS0EnA7vlLdp3/rSbQyNs2l8WM
         c3iVQlD3fjelzWLaG/zovkV0YuyBwcm+vzgtVxbR58kvPEFrf/oE6hFXb0M2ws8RnFxL
         PezyrCM/znK1vGw04/oM8+VParRmKHjYBm+OB6CZXF2Stxq2MQl806bvrDk3bAFcmZAp
         83h8JneKDc8YHUdhWe6ugYdThqAkzsyxC7msnsqc7FJrtAnuOY4y0ldIQoL3xSvrSjok
         N8jtdGjbYjQZmO9gSpMMFI1Se79faccxLInrsFVEzN4eZq5SxjOaPiKyphVBRI/54aJ/
         aqmg==
X-Gm-Message-State: AGi0Pua5K8ZTbYWFbywZb49kxe8v+EyNg8YUkmXDUre2MJ9sqzZOPOXd
        DZp+yaQibTJzd/BEtGx8CYo=
X-Google-Smtp-Source: APiQypI8yrYLAQ1fShd21gimlYy0KkVj7Jgppggs0qJFJV/wXUgMQ+RzDIYpdbzsCODzrKnxrOxGTw==
X-Received: by 2002:a2e:a586:: with SMTP id m6mr14589992ljp.32.1587551746322;
        Wed, 22 Apr 2020 03:35:46 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id v8sm4248533lfp.85.2020.04.22.03.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:35:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 22 Apr 2020 12:35:36 +0200
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH rcu/dev -fixes 2/4] rcu/tree: Skip entry into the page
 allocator for PREEMPT_RT
Message-ID: <20200422103536.GA16263@pc636>
References: <20200420153837.194532-1-joel@joelfernandes.org>
 <20200420153837.194532-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420153837.194532-3-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 11:38:35AM -0400, Joel Fernandes (Google) wrote:
> To keep kfree_rcu() path working on raw non-preemptible sections,
> prevent the optional entry into the allocator as it uses sleeping locks.
> In fact, even if the caller of kfree_rcu() is preemptible, this path
> still is not, as krcp->lock is a raw spinlock as done in previous
> patches. With additional page pre-allocation in the works, hitting this
> return is going to be much less likely soon so just prevent it for now
> so that PREEMPT_RT does not break. Note that page allocation here is an
> optimization and skipping it still makes kfree_rcu() work.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Co-developed-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Uladzislau Rezki <urezki@gmail.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cf68d3d9f5b81..cd61649e1b001 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3092,6 +3092,18 @@ kfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp,
>  		if (!bnode) {
>  			WARN_ON_ONCE(sizeof(struct kfree_rcu_bulk_data) > PAGE_SIZE);
>  
> +			/*
> +			 * To keep this path working on raw non-preemptible
> +			 * sections, prevent the optional entry into the
> +			 * allocator as it uses sleeping locks. In fact, even
> +			 * if the caller of kfree_rcu() is preemptible, this
> +			 * path still is not, as krcp->lock is a raw spinlock.
> +			 * With additional page pre-allocation in the works,
> +			 * hitting this return is going to be much less likely.
> +			 */
> +			if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +				return false;
> +
>  			bnode = (struct kfree_rcu_bulk_data *)
>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
>  		}
This will not be correctly working by just reverting everything to the
"rcu_head path" for CONFIG_PREEMPT_RT kernel. We need to preallocate at
least once. I can add caching on top of this series to address it.

--
Vlad Rezki
