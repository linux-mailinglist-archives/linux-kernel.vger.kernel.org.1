Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C28269115
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgINQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgINQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:04:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6025C061351
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:04:15 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id k25so122282ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 09:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zc4tFKUvGTvhn1QE7lK3J14QslNtyRPDaXb9i1LUKBU=;
        b=PoIztMw/R8ooNdzbG8hdAqllhURlvNlmHAj13cJlsx+VQxVA0IluJ4j+Wd9a4my2Y1
         /pQDeqLDYKyTakj0x4wR66a1BJevAJm6+wU+zIbTO3xhQgF2ZqTUMjJhTcrp3eezoF0+
         tot2YkDb338wdSMsA15VrOfGdGPz3hX9e579Ew6o9sOQyRF9ggAHHHy9AeQ1v980m3+u
         Sdo4NNrWo2XAuoIj/J0tKzkJpvX70SzH09OczLTEuEzYsUqao8JyPeX62wlNavx3aP9f
         Ja6YlmlCrOsdYYZMUcxRa4qMab78DD/1fQIQHey4vU7bdS0910CwYYyknZrzAY11hR17
         UVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zc4tFKUvGTvhn1QE7lK3J14QslNtyRPDaXb9i1LUKBU=;
        b=Kp+F5EHLuhc/B/smzh2JwgSYc51ghEP9Z+feq1sAt+mJwn3MS7XadzhYLZX1jh/19R
         wGZBdctLKX6kzG5UAvfevyMAgsSUkPejqIEouE7mxk16Dt/Yuf8LzFoBSb6HZ4kHpMZj
         QKoqAtywGVxjdBEyGuWydCCkekfwHiXiNNyrBW39Ur5KusZi87qz3p3uIipbxCV+6DhJ
         eygdUAIxi6XgxTFFaDl6QIts3APfXSLJl2b4t38Up+77Bu3jI5kyRu6Jbg7VU2RoMBAS
         1/H+NfnMCWUUqbRftBX+4PnxzsMkGQZ+hb1XOEEGhQpTUj5D+Cn+xtIdhoC0jWbPybcP
         eFeg==
X-Gm-Message-State: AOAM530UrU9/0hs39wymhy2UzS+/203EQbaYLkjdAhOHbojBrh1IK5VN
        5tIDC+DD9rRFzm8gBUpU+iHGZvjQ8+QnUsnLJxHCDA==
X-Google-Smtp-Source: ABdhPJxDW6NFg3aLpV0oKAsADv+HHyydbuH4uopuuJDo1C12WMKg/tvvHOOGO33+w8bpE5H8Pmfgmo+xH6EAnKImQkU=
X-Received: by 2002:a2e:81d7:: with SMTP id s23mr5669605ljg.69.1600099454139;
 Mon, 14 Sep 2020 09:04:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
 <20200914114202.GQ1362448@hirez.programming.kicks-ass.net> <20200914155059.GF3117@suse.de>
In-Reply-To: <20200914155059.GF3117@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Sep 2020 18:04:02 +0200
Message-ID: <CAKfTPtAK5nR4_gqDq+T+Fk5MTb+bwuKSnQY0KmPKRpEpeXbY_Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] sched/fair: Improve fairness between cfs tasks
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 at 17:51, Mel Gorman <mgorman@suse.de> wrote:
>
> On Mon, Sep 14, 2020 at 01:42:02PM +0200, peterz@infradead.org wrote:
> > On Mon, Sep 14, 2020 at 12:03:36PM +0200, Vincent Guittot wrote:
> > > Vincent Guittot (4):
> > >   sched/fair: relax constraint on task's load during load balance
> > >   sched/fair: reduce minimal imbalance threshold
> > >   sched/fair: minimize concurrent LBs between domain level
> > >   sched/fair: reduce busy load balance interval
> >
> > I see nothing objectionable there, a little more testing can't hurt, but
> > I'm tempted to apply them.
> >
> > Phil, Mel, any chance you can run them through your respective setups?
>
> They're queued but the test grid is backlogged at the moment. It'll be
> a few days before the tests complete.

Thanks Mel

>
> --
> Mel Gorman
> SUSE Labs
