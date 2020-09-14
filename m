Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D06269604
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgINUGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgINUGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:06:39 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E94C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:06:39 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id f11so496826qvw.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QQ6aCPdG2QPUAFXbI31hiSG8duU31qYkUqnym/zfAOs=;
        b=DDUw00qEYFEz+Y8bW19PWw7p11dTYrzPACmnFC+taOkczHQUgKUDdiVlotlxED3P+K
         lZIRsldxmFF9/mWfqeOZpB3Gr8SxvE4pqeMOnrVanyMTVhp9rfDKmASDby70Rzr8TwAh
         zUY6Lm7ovaEuL/QC1S+4pFCoMpOBvak01ypMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QQ6aCPdG2QPUAFXbI31hiSG8duU31qYkUqnym/zfAOs=;
        b=iy5/ABamRQq91G1K9QUKrb+v7ZkiIFnM72QJpcdj6Z6qIFtclvXGt3IjBBW89teoBm
         vWvp7wybNJm9UPYTzWr5XLibuyTWN3XrZrbPJd/bQZZHOz5RlT0yYn83TvLR5MabF5NL
         42URUEt7FbcCdALzk6+kIgAsRr4FIrA4QITtInhIFEyEg3FrANWdpoAvyQK5TNm0cwLR
         lOu1fAJ+FibZDe/+Ot1p7BNjBXv4rJd9BYIwF09Qo8FG58dz93lKSHR3ZmMfaJO7VDBp
         80LZmmvrbldXSt4iUbpLjwo/HGKyx2u+md1OWqa3+zDBR1YxdtQPX2esPbJ4lNLlJVW8
         pMOA==
X-Gm-Message-State: AOAM533x7/tX5HnOptDm2/CyGuCHih+S3qytsPnS3izahpp7Yg1IwUR7
        7qOYC5pTJw5q6C3m4t8dVWCKuQ==
X-Google-Smtp-Source: ABdhPJy/4Ht1mgt1u17L6uG2In0LLESe1QfZMiBUMcIHwyFz+ISB51621oWZfV8dMDjrQwJJJYKL3Q==
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr14777298qvq.21.1600113997836;
        Mon, 14 Sep 2020 13:06:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q142sm15101909qke.48.2020.09.14.13.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:06:37 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:06:36 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RCU:  Question   rcu_preempt_blocked_readers_cgp  in
 rcu_gp_fqs_loop func
Message-ID: <20200914200636.GB2579423@google.com>
References: <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
 <20200819155808.GA8817@pc636>
 <20200820223957.GB120898@google.com>
 <20200821153328.GH2855@paulmck-ThinkPad-P72>
 <BYAPR11MB263285B19261BE8096D87F65FF260@BYAPR11MB2632.namprd11.prod.outlook.com>
 <BYAPR11MB2632FD34F68A89CCE039018BFF260@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200909112241.GE29330@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909112241.GE29330@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 04:22:41AM -0700, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 07:03:39AM +0000, Zhang, Qiang wrote:
> > 
> > When config preempt RCU,  and then  there are multiple levels  node,  the current task is preempted  in rcu  read critical region.
> > the current task be add to "rnp->blkd_tasks" link list,  and the "rnp->gp_tasks"  may be assigned a value .  these rnp is leaf node in RCU tree.
> > 
> > But in "rcu_gp_fqs_loop" func, we check blocked readers in root node. 
> > 
> > static void rcu_gp_fqs_loop(void)
> >  {
> >             .....
> >             struct rcu_node *rnp = rcu_get_root();
> >             .....
> >             if (!READ_ONCE(rnp->qsmask) &&
> >                                !rcu_preempt_blocked_readers_cgp(rnp))    ------> rnp is root node
> >                      break;
> >             ....
> > }
> > 
> > the root node's blkd_tasks never add task, the "rnp->gp_tasks" is never be assigned value,  this check is invailed.
> >  Should we check leaf nodes like this 
> 
> There are two cases:
> 
> 1.	There is only a single rcu_node structure, which is both root
> 	and leaf.  In this case, the current check is required:  Both
> 	->qsmask and the ->blkd_tasks list must be checked.  Your
> 	rcu_preempt_blocked_readers() would work in this case, but
> 	the current code is a bit faster because it does not need
> 	to acquire the ->lock nor does it need the loop overhead.
> 
> 2.	There are multiple levels.  In this case, as you say, the root
> 	rcu_node structure's ->blkd_tasks list will always be empty.
> 	But also in this case, the root rcu_node structure's ->qsmask
> 	cannot be zero until all the leaf rcu_node structures' ->qsmask
> 	fields are zero and their ->blkd_tasks lists no longer have
> 	tasks blocking the current grace period.  This means that your
> 	rcu_preempt_blocked_readers() function would never return
> 	true in this case.
> 
> So the current code is fine.
> 
> Are you seeing failures on mainline kernels?  If so, what is the failure
> mode?

Nice question! He had me wondering there too for a bit ;-)

Thanks,

 - Joel

