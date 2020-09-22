Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B8F2748A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVS41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgIVS40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:56:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4809EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:56:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a22so15004513ljp.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymw2XfYcqbrKxbh+VHjYTBZabPIEIeS/kxNNZK3Q7GE=;
        b=DV4EUlN276uVi19xQ/E+YB845hHum+zfsKpyj63GqwBiuV/FeabyS0GRc7fKnRLj2n
         El2H+Lui81CyaiWNLzdMPKDWLYLYwcx1t3Bl0cf+3L3WPo3DEuDxNQ32HUZUDZriBXaM
         MpWGnrUlGQSZRctkk3h9v7LtyueARTH7Zw6ACifO2t2eH/xXoieLo19WCHGh6emFW2HL
         GmTE8yAVvlKEsLZkzm01E/hInUAIwYjUtnkYA0EwlKOTTk4FrV1nf3ocHelxTfr1uAC7
         KyOW0HGEZ68aIlHfds/PzuFOpCRUeXZ9/wITZ9lIbqEi8gGIzTntzaPkj4b6fpNPQFBp
         MF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymw2XfYcqbrKxbh+VHjYTBZabPIEIeS/kxNNZK3Q7GE=;
        b=kXRDXE+bZ1d92j0Tu++OZUr0EWWwiaQK6yR8mYOrUneACUoPwU7UdX3hyVmXHASYtR
         s6q+JJ46fDjBgYUMvxVuaJID6FvRKNdbPQwO8u71xVnv8liRIoej782xnHPohvMsEa1Y
         +/uJi7pFf4qVXCR8JPbrRhlAYzaCKkGEv3sgr7/OUb+UKp+tqIyrOjxlKz1+PdcQr+Yt
         8+RsIrluLKOM4J8DIg5n2RVw9CeeFGMFXiSBi/D4gqIUcBcZaF/lvzIiYJ0DRiYjHYhy
         hfew5vmqWdJlFN9nEkpjBmhAnxbyeFPxNEc3Deq7ksFRZb6wrCPf3+Eq6X1cyXA0Yz+c
         QKew==
X-Gm-Message-State: AOAM532fkDP/+6wPTgcgYaAoM0UozU7O0aefFxM1amAANseFP77O7gPr
        vSwETD8gaxdQnjBIKUahKf+dtrv33DJwsFuQJVbZcQ==
X-Google-Smtp-Source: ABdhPJwLnjVHv9kqWNAXJHHZUxAgZeGN3nABkUBKLoVXg62pr+US6oGOL0/oKZAaTMwyytU8AZeTPBQ7uIKxZuOEl74=
X-Received: by 2002:a05:651c:1af:: with SMTP id c15mr2096875ljn.347.1600800984328;
 Tue, 22 Sep 2020 11:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
 <20200922114908.GZ12990@dhcp22.suse.cz> <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
 <20200922165527.GD12990@dhcp22.suse.cz> <CALvZod7K9g9mi599c5+ayLeC4__kckv155QQGVMVy2rXXOY1Rw@mail.gmail.com>
 <20200922183125.GG12990@dhcp22.suse.cz>
In-Reply-To: <20200922183125.GG12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 11:56:13 -0700
Message-ID: <CALvZod6kfF_r5u2ydZ34Q+6QWvg11ZFwfRMHdiNUvi3NJnms=A@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:31 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 22-09-20 11:10:17, Shakeel Butt wrote:
> > On Tue, Sep 22, 2020 at 9:55 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > So far I have learned that you are primarily working around an
> > > implementation detail in the zswap which is doing the swapout path
> > > directly in the pageout path.
> >
> > Wait how did you reach this conclusion? I have explicitly said that we
> > are not using uswapd like functionality in production. We are using
> > this interface for proactive reclaim and proactive reclaim is not a
> > workaround for implementation detail in the zswap.
>
> Hmm, I must have missed the distinction between the two you have
> mentioned. Correct me if I am wrong but "latency sensitive" workload is
> the one that cannot use the high limit, right.

Yes.

> For some reason I thought
> that your pro-active reclaim usecase is also not compatible with the
> throttling imposed by the high limit. Hence my conclusion above.
>

For proactive reclaim use-case, it is more about the weirdness of
using memory.high interface for proactive reclaim.

Let's suppose I want to reclaim 20 MiB from a job. To use memory.high,
I have to read memory.current and subtract 20MiB from it and then
write that to memory.high and once that is done, I have to set
memory.high to the previous value (job's original high limit).

There is a time window where the allocation of the target job can hit
the temporary memory.high which will cause uninteresting MEMCG_HIGH
event, PSI pressure and can potentially over reclaim. Also there is a
race between reading memory.current and setting the temporary
memory.high. There are many non-deterministic  variables added to the
request of reclaiming 20MiB from a job.

Shakeel
