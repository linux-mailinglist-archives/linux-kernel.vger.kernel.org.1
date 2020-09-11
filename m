Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419AD267607
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbgIKWkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgIKWkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:40:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269D5C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:40:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u4so13711099ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QVD1gZDtb4fovFqzFSv9irG+x3sWgcFoSpx/oNvkoLE=;
        b=wWvQJhNNIRUX720qs0qN6+3c+1AchsI6qKG/w09Wn7lBRPPTO9VrrYHzLzstivrpb+
         1ntUr9NR+s11KMAsEoV2yW5FVFhWj/UMQzNeUlnXk9b4of6XLFIL95AQZBMFzXDsgEzo
         8ufltuCI0KxK+2XTSpc08ZmJ4BoPeH2CA89Y0qQTRX78I9bJtA9NGelq3Hi04uPzbl10
         S64Oow+7ks4NSY/8yQlfgPXaZ4/2FgT3F35IJVfVki/Kfv/cF1kjxx/ka43qIKd3OEnz
         OYSd0D+MUzpFUSRqh8uiUTRNjAgqdPF5kun9fp6XUEaQWHVhOONtBRs7igJUcvMgFnUP
         eZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QVD1gZDtb4fovFqzFSv9irG+x3sWgcFoSpx/oNvkoLE=;
        b=dfHxOGrkMPVYJ6xH0Ncixv0FQFGWE3Xr3eW5owiaAiB8dUcNKR71SNJGr+mrLMY9FF
         sV7t5ZODUBLc2p1+jw0wFbqODt0Thc4/Qwn9tcwSC5JHr7L5HUX4lyt7T2t43WqD+E26
         i+okswIKVXlUM0gyA4NweAubsa/g04U/AYchAkh+FmXihFE2kQ6tyCpdwNuxnWmsdMRy
         AT2DnwMwf9jiMygeE1oZWlzDq0bU7KUwjGoq8/m0e4gh7K8oSDbx1uArUZ49nU9hOlpu
         K8optaLTal47zo3umtaje+HOHU2Qjo32rsadr2V4RB/pckrERlLpi2rXrFzHcZjnoma7
         9WHA==
X-Gm-Message-State: AOAM530zRd4+FArOc7vyERlehw4qRpDabifBYLsq1a20No/yQT3BGbcF
        fzTjzRfyzwsuP7pw6zMfARBBYmkyCY+bs1qD1MeZQw==
X-Google-Smtp-Source: ABdhPJxxNqP9whJBEo8PXefOIUInGr92nmFnc34eTFWtLjjf5s45gth3jWS60mVcMNMD5wKHe5/WUmhmwWvm9MNerb8=
X-Received: by 2002:a2e:541c:: with SMTP id i28mr1587321ljb.77.1599864031892;
 Fri, 11 Sep 2020 15:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200910022435.2773735-1-guro@fb.com> <20200910224309.GB1307870@carbon.dhcp.thefacebook.com>
 <CALvZod6VZLZ+ABqHK=Vv_S3m=OarSJf0ttGeAOKhw+1zGj65gQ@mail.gmail.com> <20200911213402.GB1163084@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200911213402.GB1163084@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Sep 2020 15:40:20 -0700
Message-ID: <CALvZod7+-DFfN7cpb8W7O2jHEgU1BSmPyW+-hfmTTUKUi4QG1A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg/slab: fix racy access to page->mem_cgroup in mem_cgroup_from_obj()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 2:34 PM Roman Gushchin <guro@fb.com> wrote:
>
[snip]
> >
> > Also have you taken a look at [1]? I am still trying to figure out how
> > that is possible.
> >
> > [1] https://lore.kernel.org/lkml/20200901075321.GL4299@shao2-debian/
>
> Hm, yeah, it's complicated. At the very first glance it looks like that the
> obj_cgroups vector is placed onto the very same page it describes, or at least
> it shares the kmem_cache with it, with some bad consequences. Could be something
> SLAB-specific, newer saw anything like that with SLUB.
> Or maybe it's completely unrelated and has been attributed to this commit
> by mistake.
>
> I've spent several hours running the provided test in a loop, but wasn't
> lucky enough to trigger it. Did you try?
>

Yeah same, no success in reproducing it.
