Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE98291FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgJRURK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRURJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:17:09 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA3FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:17:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b15so6746916iod.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgDhaY7fqK+FMnZC3CevUCCUqcuSuLmtjwQEAUjRcIk=;
        b=JkkpEPD2sKts0GtmZClZI9gb1Rw0shyqd/ZXgWY4aWRGtI5oc4wR/i9RXn+hZOxUwB
         C69dDdh7Z7ObwjuWCebEHpbMBQHXQKdNgtoaY8IaIyTtZSiH7wHtxt6W4dtWt/X/iC35
         06wkrMz8wgTTPzFXrxnEWXvZMEJchYr6RTa+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgDhaY7fqK+FMnZC3CevUCCUqcuSuLmtjwQEAUjRcIk=;
        b=WKRTW46fbEmqWD4cOBhVBQbraEp5qPjeFwZ9dOIvBJ03JK4eoMK4cRmrANYUsDCynp
         jJy0DqSwQNcTbYZCr+rtcWJYPl5xVKVweMB6UwsEv7Gvnt3FRWb07vi6IvISVEMcMxhA
         7M2C8b2B0QNMZm8KH826ndQLgTnpqQNhf31ugzEEiuiYaZxO+eGIXrPKAJ3ftRFDGWVR
         ifC740Y41L1MOr0d3H0LsJqjm2UluCgavV90F4ZJW+H8OkFIpIsNRrhc3uZag61OCsiX
         v5axpzY8+m2UjG72AtrQgtm4nRYkD5k97VGOS0polsYYfpdlQRB0sr57s+QueEzlRCO9
         VHMA==
X-Gm-Message-State: AOAM533wxiFKqX6XrH/wmYeAS7K0HWv0rCunjVYwHOrNjaQt/LnzqCeE
        yzUKkejOoKD6CYaQ2p/fkXNrSweb7bGDVxCPbCZ+lQ==
X-Google-Smtp-Source: ABdhPJyIZ5xkld7dr1PxipmOsqVLdHv+ZRVpWzxlQ3NugJHHX+BXmIBfnPdshpg3MTxNJXhXT/vkIPGFv5aowNskOuM=
X-Received: by 2002:a02:ec3:: with SMTP id 186mr1543187jae.92.1603052228687;
 Sun, 18 Oct 2020 13:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201015002301.101830-1-joel@joelfernandes.org>
 <20201015002301.101830-7-joel@joelfernandes.org> <20201015133511.GB127222@lothringen>
 <20201017012753.GB4015033@google.com> <20201017143144.GA835860@rowland.harvard.edu>
In-Reply-To: <20201017143144.GA835860@rowland.harvard.edu>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sun, 18 Oct 2020 13:16:57 -0700
Message-ID: <CAEXW_YSyshFLYMNia+TGfO11Pi_iojzke1+0SG7anGt2GNUXWg@mail.gmail.com>
Subject: Re: [PATCH v7 6/6] rcu/segcblist: Add additional comments to explain smp_mb()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 7:31 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Fri, Oct 16, 2020 at 09:27:53PM -0400, joel@joelfernandes.org wrote:
> > Adding Alan as well as its memory barrier discussion ;-)
>
> I don't know the internals of how RCU works, so I'll just speak to the
> litmus test itself, ignoring issues of whether the litmus test is
> appropriate or expresses what you really want.
>
> > The following litmus test would confirm it:
> >
> > C rcubarrier+ctrldep
> >
> > (*
> >  * Result: Never
> >  *
> >  * This litmus test shows that rcu_barrier (P1) prematurely
> >  * returning by reading len 0 can cause issues if P0 does
> >  * NOT have a smb_mb() before WRITE_ONCE().
> >  *
> >  * mod_data == 2 means garbage which the callback should never see.
> >  *)
> >
> > { int len = 1; }
> >
> > P0(int *len, int *mod_data)
> > {
> >         int r0;
> >
> >         // accessed by say RCU callback in rcu_do_batch();
> >         r0 = READ_ONCE(*mod_data);
> >         smp_mb(); // Remove this and the "exists" will become true.
> >         WRITE_ONCE(*len, 0);
> > }
> >
> > P1(int *len, int *mod_data)
> > {
> >         int r0;
> >
> >         r0 = READ_ONCE(*len);
> >
> >         // rcu_barrier will return early if len is 0
> >         if (r0 == 0)
> >                 WRITE_ONCE(*mod_data, 2);
> > }
> >
> > // Is it possible?
> > exists (0:r0=2 /\ 1:r0=0)
>
> This result is indeed not possible.  And yes, some sort of memory
> barrier is needed in P0.  But it doesn't have to be smp_mb(); you could
> use a weaker barrier instead.  For example, you could replace the
> READ_ONCE in P0 with smp_load_acquire(), or you could replace the
> WRITE_ONCE with smp_store_release().  Either of those changes would
> suffice to prevent this outcome.

Right, that works as well. The main point I was trying to hit was the
control-dependency hardware ordering in P1 (due to rcu_barrier()
checking for a condition before doing whatever is after the
rcu_barrier()).

thanks,

 - Joel
