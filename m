Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D733D1B509E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 01:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDVXDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 19:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgDVXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:03:24 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C738AC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:03:24 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w18so1907155qvs.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q+ZUmGFleIQNVOFy8fFchFqrYnQYIl2Kzm4X0Ut4dcY=;
        b=oZ6I3DZ+oVw9DiS9NwH9ubCLOmCZjMFu1LmScEI32LKMmsrmV8ERXRrqSIdw2wctfi
         /sduzA/W/yc2gYcBwwRDVv40zmcI4Z45eG+c3sfRB/CFQxip2mHDO/dj7oQ7CDgm/sXm
         d+18N/vsSc0iLhx+gvnDebageo5+ke+0dGWas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q+ZUmGFleIQNVOFy8fFchFqrYnQYIl2Kzm4X0Ut4dcY=;
        b=aae7kSgkECyJZunDz6lG8RvF0y3Bx9XE4z2CBKJ9uDjnm+RyZGhEFWs4FX5P3cd3cx
         Re9OZUb7LIfeNmXEdZnsNCDmhjh8333Yh0+GdaeuIBLZ1qHOMRe7pu70jPcJWCRjn3zp
         YGsNRBaxW1Ni7tpVj2TLBHUZ6EIIu7G7T7kATiMgpWx4yGjiEetVgoElBtecRvGs6ul9
         ybhpgrrtqyw50YhjeYJGKUBTmIfb5E+07o3s8Pn+QMtlF2CaDHqSHfenYTtWaBj7lGGx
         Ss6maN4dPLugh46ZksG7yY8OezZP1tmjTxSN+dW6Tu5E4E6+znliKzkwH6+VuoFZB9Id
         oFzQ==
X-Gm-Message-State: AGi0Puac6XexbY+dV5LomN/El4sYMbJB0EoVC/CgLHaHySr8OGr+hqCk
        rqoXOV7oTxhISID8YYtqT9hnkQ==
X-Google-Smtp-Source: APiQypLG48pUEwzbOklpqni6odRxIsyj2/KAASfEwNNej9pTvyYVGnFgJ4r2rHVRVvuHh0XP9YEo0w==
X-Received: by 2002:a0c:9e6d:: with SMTP id z45mr1420079qve.206.1587596603750;
        Wed, 22 Apr 2020 16:03:23 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g133sm400658qke.73.2020.04.22.16.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:03:23 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:03:22 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 5/6] rcu: rename kfree_call_rcu()/__kfree_rcu()
Message-ID: <20200422230322.GA100393@google.com>
References: <20200315181840.6966-1-urezki@gmail.com>
 <20200315181840.6966-6-urezki@gmail.com>
 <20200316152541.GD190951@google.com>
 <20200316190144.GB10577@pc636>
 <20200420201527.679247f6fa76cba4331f3cd3@linux-foundation.org>
 <20200421120358.GA5117@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421120358.GA5117@pc636>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:03:58PM +0200, Uladzislau Rezki wrote:
> Hello, Andrew.
> 
> > > > I based the kfree_rcu shrinker patches on an 'rcu/kfree' branch in my git
> > > > tree: https://github.com/joelagnel/linux-kernel/tree/rcu/kfree
> > > > 
> > > > For now I manually applied 5/6. All others applied cleanly.
> > > > 
> > > > Updated the tree as I continue to review your patches.
> > > >
> > 
> > I'm not sure what's happening here - these patches aren't yet in
> > linux-next.
> > 
> Please have a look here, i explained in detail in my cover latter
> what we would like to achieve: https://lkml.org/lkml/2020/3/23/242
> 
> > A couple of thoughts:
> > 
> > - Please cc linux-mm@kvack.org on this patchset and anything else
> >   which impacts MM.
> > 
> OK. I thought that is related to RCU, therefore i did not want to
> spam, but i included you :) Next time we will keep linux-mm@kvack.org
> in a loop. Sorry for that.

Sorry from my side as well. Will keep linux-mm in the loop henceforth.

thanks,

 - Joel


> 
> >
> > - It's a bit strange to create new infrastructure which has but a
> >   single call site.  Please tell us much more about "there was also
> >   request/interest so there will be new comers" to set minds at ease. 
> > 
> >   Who/where are these possible new callsites and when can we expect to
> >   see that code?
> > 
> https://lkml.org/lkml/2020/3/23/242 here i wrote motivation. Please
> check it. If you have some questions please ask.
> 
> --
> Vlad Rezki
