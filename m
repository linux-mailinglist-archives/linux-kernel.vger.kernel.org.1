Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D942AA1C8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgKGA1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728110AbgKGA1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:27:02 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0CBC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:27:01 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id n132so1715576qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 16:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/cM0TFFZMZvrqgwNzLi/AHEjw0DLgiyqxlp3I+i6tBs=;
        b=D+OZ+DTluHuXiaVE1BMYD9EUtjhOiM8Qgv90tZijxaNs0234reo+o5joNaWMREpUi8
         vEz2CG6OY7s+9VxRo7OmDET6hiGTRqNFr97vadAXIU6InctkrVJDgIfkoSb3iKZB5jwj
         U7HWvBqaa6jmTRGEFSQm6XBblX5ADdhF3v4N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/cM0TFFZMZvrqgwNzLi/AHEjw0DLgiyqxlp3I+i6tBs=;
        b=Jn5Nh4z4oKZyqTmbGCofxHBelSu085g5ZjpkDiUqyi5Eiy7w66jkUFLhsIst6suMLS
         EoZDdz3VGLnOMPuhUjTeD2eW7rMMyggo6tlcGtQck/JR5E6C2oaEJJfoRz1+p1yvSsd6
         Yc1MGCa6JSAnXqu5f1I95ge9JQYr85jIZa0+CC0/a9B8zHyVndWBrdIjkfZlnQ9NNRMp
         099KbgUhQgV2yYsKA519I+HEwmxLUWtMBvGyYgJrorga2HC/dVN7n0dd/RrFnRmPxO1Q
         LgGkIdM2GEjRrG1Dg9khalPWwbMW7gT48yHgjlArGaNFPLYvabE5f9oOTiexJuP1ilQR
         PipQ==
X-Gm-Message-State: AOAM532T3paQfZ+c5IXZbKcjlWKKWGV1FJwR0BRjFANoNfObfll+LMO1
        o0tj+Zam4C1ngSzOR+t3UDx+rw==
X-Google-Smtp-Source: ABdhPJwFjgoRxwCPZiE2+6jzxcDWWbrPUP3UF7MANy5LvJc1/s0UZA5aW4E3nwNWQe9/qMxe2lC62A==
X-Received: by 2002:a37:4e8e:: with SMTP id c136mr3972194qkb.421.1604708821114;
        Fri, 06 Nov 2020 16:27:01 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s23sm1655779qks.94.2020.11.06.16.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 16:27:00 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:27:00 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 5/7] rcu/segcblist: Remove useless rcupdate.h include
Message-ID: <20201107002700.GB3144506@google.com>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-6-joel@joelfernandes.org>
 <20201105034823.GK3249@paulmck-ThinkPad-P72>
 <20201105142810.GA16800@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105142810.GA16800@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:28:10AM -0800, Paul E. McKenney wrote:
> On Wed, Nov 04, 2020 at 07:48:23PM -0800, Paul E. McKenney wrote:
> > On Tue, Nov 03, 2020 at 09:26:01AM -0500, Joel Fernandes (Google) wrote:
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > This one looks fine, but depends on the earlier "rcu/segcblist: Add
> > counters to segcblist datastructure" patch, which also changes the list
> > of #include directives for this file.  It manages to avoid conflicting
> > with "rcu/trace: Add tracing for how segcb list changes", despite this
> > one also changing the #include directives.
> > 
> > I am testing it just out of curiosity, but it might make more sense
> > to fold this one into "rcu/segcblist: Add counters to segcblist
> > datastructure".
> 
> And it does pass light rcutorture.  ;-)

Cool, I squashed it into 2/7 and updated my tree.

thanks,

 - Joel

> 							Thanx, Paul
> 
> > > ---
> > >  kernel/rcu/rcu_segcblist.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index 2a03949d0b82..e9e72d72f7a6 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -10,7 +10,6 @@
> > >  #include <linux/cpu.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/kernel.h>
> > > -#include <linux/rcupdate.h>
> > >  #include <linux/types.h>
> > >  
> > >  #include "rcu_segcblist.h"
> > > -- 
> > > 2.29.1.341.ge80a0c044ae-goog
> > > 
