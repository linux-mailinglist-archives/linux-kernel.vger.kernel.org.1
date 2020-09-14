Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9E382691C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 18:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbgINQjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgINPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:37:10 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D66C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:37:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u21so60175ljl.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzx2NgkB1nDMETbz5EDQ8LndFJVrNLUdv8ics0I+18I=;
        b=Afg6QaB+BSz1GeEiUUoLpaauFp1bmrgB23nL8XxTsNnVonXaOkJFrJd6jdtjqTM1E2
         7JlIwQwEe60FXwjMxUkjaSxnOKit5jPzs29jiYrCp0OR+JKTLAZo2LshQdwhiYtmKoC8
         WdYvMRlhRTD1XtrcSb9ed/dvOLW8xcU2pbsNRaRZCUaWe5ylREbLDrsLZAWV5/qDGTtF
         8tAyWxeapw0IfCZ42u/fmSTmHadUVsc2vCUD+EZtcKzXLTyAwFLHIzvaf/tr6Jml2BQF
         yU66ii6gQB4gOrHvnkv3KMBogvEKNyK99/NQLkPQtMVgWL47x9DfvCXSLlzYAOF6WuxX
         bPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzx2NgkB1nDMETbz5EDQ8LndFJVrNLUdv8ics0I+18I=;
        b=CM5KZB4Ioc1Fd2Ekj2lDWSnyuaZZDiTQiEsoKjkCL49Ns/XUawdIrR0YXM+PFfr6ih
         Gsy4edjgqGIQ7MPW6iqRIYsoInxAFXuYXpKODdyDtmNkQW6geDeJdazqVD8P9QVrLe8i
         lKriFIgx0Dxt/HkGQJMTA7BVH/FNjeoZmrqqqRwmJnTev4zk+pgVuGqJrXjVeLqyfQjj
         qq5jTWOIH8ZQZSnPwLizG1dcNy2lf5WZSR0s/Y70AJBQeKwvfBOAlwmTbBNx3bsmG2H9
         7a8V/kZhzJJbNWSumISPEkRTuKolZFVmcekCDG0oRMzSz/2+QcpxS6pCQAuUJoT6C+WF
         8V1w==
X-Gm-Message-State: AOAM532hb5fr6su+AOqT7aJjWlVgB2POA0fofCfqm21p/5lzjIcLfz5w
        Zv6pFBTuwNy8cJmxeufA0fE4M6p4MLQn9Dq+hdS7qQ==
X-Google-Smtp-Source: ABdhPJxoCOS6P041CkwHWmWs49WLL5Tsg/V9xbDyqYe8Aj0ctcgkfx7sQ26IixpG8vthsak05IPxPNQff5X8ZJ1S6Yg=
X-Received: by 2002:a2e:3511:: with SMTP id z17mr4982462ljz.58.1600097827616;
 Mon, 14 Sep 2020 08:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200914024452.19167-1-longman@redhat.com> <20200914150928.7841-1-longman@redhat.com>
In-Reply-To: <20200914150928.7841-1-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 14 Sep 2020 08:36:56 -0700
Message-ID: <CALvZod58vQ3hQAAwT8=7MO9-Xvnb=Fms37E0gW-qT746gS54uw@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mm/memcg: Simplify mem_cgroup_get_max()
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 8:09 AM Waiman Long <longman@redhat.com> wrote:
>
> The mem_cgroup_get_max() function used to get memory+swap max from
> both the v1 memsw and v2 memory+swap page counters & return the maximum
> of these 2 values. This is redundant and it is more efficient to just
> get either the v1 or the v2 values depending on which one is currently
> in use.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
