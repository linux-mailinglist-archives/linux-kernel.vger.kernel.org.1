Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11727F0B2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgI3Rsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3Rsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:48:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0BC0613D0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:48:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y74so2795625iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3QPmNeUX1bWiynEkFpQ8LFbxgXrdGF1ePUmA+g1hmvc=;
        b=K+46e+Uog+2T1I+TOuHcyrukfXR8Dcsi2XAT/Jv3NckuYxiup+3IpVVhjucX0+FBu1
         xJ/juyanFTPgTdLxYe1kUJZoRIqmoDVkhGbjtk4zYqN44Ktbab3olfVq/M/9fxiOZLUN
         e1x/bw+NZ6QvGb3sNnwb0entFB/LOCfhKhK2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3QPmNeUX1bWiynEkFpQ8LFbxgXrdGF1ePUmA+g1hmvc=;
        b=hAy86Gg+JAFifE8PPFcsE/tO/X18v1bGzNUewfUnqL3sSSZHzb+OFOeoMJOiSKMjT4
         xPvygePXzPt1EYBUgY0CqxmRLhNoqjC+KiMFh3YkYr+C+mo0fAU+pjtkDRvNRVc9/ZWz
         8Q1zgTHilEyJnsKVuXWhmZ+Hcb53TsdImrywK9HKmsl8v3pB5fP7d78uiAwxS2n8wtyY
         ui0JTgbpvNmcebDNcpj8Jf69bJNRAJxNQO5qrtctuT4zE7iIa519ukW8TcDzN/4lA4xr
         2NXFh7WCCAiAuiNA2i5dC59buEibTkubpxeqcgeYNWfcpukyN5VpUnf+S6mS0Nd4TEeu
         1KVw==
X-Gm-Message-State: AOAM530dRRtJDib9AVwZgDpnH0PjpD3LnaoEHvApEAejc5om1G0yWfvq
        5KRxq7xIRws2NjDiMC6VR6FOpZqSEU9vCQy8mjADMA==
X-Google-Smtp-Source: ABdhPJyH2qooLdafccnV5z+ZBU82is4eon7Xxy75LgeCjygNOkk23NrnAjI6C0Bhrv7s9SoJD2KS3uAUeLcKSBakYnc=
X-Received: by 2002:a05:6602:2a4b:: with SMTP id k11mr2470720iov.85.1601488132303;
 Wed, 30 Sep 2020 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200923103706.GJ3179@techsingularity.net> <20200923154105.GO29330@paulmck-ThinkPad-P72>
 <20200923232251.GK3179@techsingularity.net> <20200924081614.GA14819@pc636>
 <20200925080503.GC3389@dhcp22.suse.cz> <20200925153129.GB25350@pc636>
 <20200925154741.GI3389@dhcp22.suse.cz> <20200930152517.GA1470428@google.com>
 <20200930164822.GX2277@dhcp22.suse.cz> <CAEXW_YSLhXR=7Asa19v7z2Aj=AqDiehHQLych3B7S+qxgPEWzQ@mail.gmail.com>
 <20200930172205.GY2277@dhcp22.suse.cz>
In-Reply-To: <20200930172205.GY2277@dhcp22.suse.cz>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 30 Sep 2020 13:48:40 -0400
Message-ID: <CAEXW_YSvnC+hv2Y47Nrg5TS1gZ8UPnSBooqMv7krcrxe94EWSQ@mail.gmail.com>
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
To:     Michal Hocko <mhocko@suse.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 1:22 PM Michal Hocko <mhocko@suse.com> wrote:

> > > > I think documenting is useful.
> > > >
> > > > Could it be more explicit in what the issue is? Something like:
> > > >
> > > > * Even with GFP_ATOMIC, calls to the allocator can sleep on PREEMPT_RT
> > > > systems. Therefore, the current low-level allocator implementation does not
> > > > support being called from special contexts that are atomic on RT - such as
> > > > NMI and raw_spin_lock. Due to these constraints and considering calling code
> > > > usually has no control over the PREEMPT_RT configuration, callers of the
> > > > allocator should avoid calling the allocator from these cotnexts even in
> > > > non-RT systems.
> > >
> > > I do not mind documenting RT specific behavior but as mentioned in other
> > > reply, this should likely go via RT tree for now. There is likely more
> > > to clarify about atomicity for PREEMPT_RT.
> >
> > I am sorry, I did not understand what you meant by something missing
> > in Linus Tree. CONFIG_PREEMPT_RT is there.
>
> OK, I was not aware we already CONFIG_PREEMPT_RT in the three. There is
> still a lot from the RT patchset including sleeping spin locks that make
> a real difference. Or maybe I haven't checked properly.
>
> > Could you clarify? Also the CONFIG_PREEMPT_RT is the only thing
> > driving this requirement for GFP_ATOMIC right? Or are there non-RT
> > reasons why GFP_ATOMIC allocation cannot be done from
> > NMI/raw_spin_lock ?
>
> I have already sent a clarification patch [1]. NMI is not supported
> regardless of the preemption mode. Hope this clarifies it a bit.
>
> [1] http://lkml.kernel.org/r/20200929123010.5137-1-mhocko@kernel.org

That works for me. Thanks,

  - Joel
