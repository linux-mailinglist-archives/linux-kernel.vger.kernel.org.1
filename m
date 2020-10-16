Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B18290AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 19:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgJPRs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 13:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgJPRsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 13:48:55 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E201C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:48:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a3so4342200ejy.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 10:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zENxSAeGKbpBnEX6rPV0TIBwim48VlxqhCDWWJ45340=;
        b=KbnasV8wlhnzpfAjJOGWYrKSUXRjEXVMc6NIUg6+i4B+1iAmCYXqt/l1oNakb7OGl3
         uJ7JEXtaL22zXDNAXEMRRkN4eRQCACMROFEHF8QpoR/6BKFr8srRjgrMvcXbRt9tClZX
         HxO72oLQhXbxkTUAIzy6ZwB9yPTeJrL+e0MgKsfgsw0KwfZbC0/UK72ptfByd9QjZ5QN
         OsvKmH5CWlsD2x26Erx3ofnvWiVBT7/7aLc17fHjv/ecF/VaGA8UvVQqtENqF37G3sGM
         3P7SiDSSx468C3MSnilSRAVhhy33Ok/sRHP/iUyc/qEfjZ2bX/Mhl62DbDF7wzCh0Czm
         dccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zENxSAeGKbpBnEX6rPV0TIBwim48VlxqhCDWWJ45340=;
        b=G9ltk2S0WFPTsaQ24YneesmzvVnLpAPUY14i4j3BA2OUSUdte6Gxr+ETIZu9w6OSgY
         y62uldvA2KuypBLLa07VXvcWCTNIwXXBZk+2Guw9AIEzPE+NYswhF3rIJTmDOO18561U
         N8p9l978uOJf8cWxKz5Ij6B6Z17OwOwCQBQVOHIB7HR63jMihqpZfIv6tbId91enrryN
         aE+KHB/K0qt3jAKyvqyicMu/U2R6/1UDwg3vy6o2y9RhddKI68AHUwYucMNtwTip9UTB
         wyfGnYJ+m72a52kKJ5rpA+4YJkYcQsjcTXdGlz7NwejADM91+RZQ3SGb65ELh7d0LPEF
         YZMQ==
X-Gm-Message-State: AOAM531bAg97lcO+xwzfQxRcuXkNIWF+wcoYx5zN560CpsrGEoH87JI+
        XhBYSKXwpiGBIFD8MUmwNPETpjVQ/CTWQ9U/mJAq3g==
X-Google-Smtp-Source: ABdhPJzclNZXVNgVy7Ev6EJkWt3mPQiX3CMGguiVhSrKZadJWD9KqF4e7oW29m7BAk7ApuGbMBPWdhBW3d3M2Ukq95c=
X-Received: by 2002:a17:906:364f:: with SMTP id r15mr4909815ejb.388.1602870533554;
 Fri, 16 Oct 2020 10:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201016163634.857573-1-wvw@google.com> <CAJZ5v0in0N6USFqvuLcccpirahj=oOki67+Lq9_5i_q7Ep7T6g@mail.gmail.com>
 <CAGXk5yq_xcHYizG_z+FV14ieWya-4qeyVFz1gQZ9_gbJxUcQqg@mail.gmail.com> <CAJZ5v0jSC3oD+SFEzhyk=PqhSZoz9yt7jojXj3T5BXhjJ-CaFw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jSC3oD+SFEzhyk=PqhSZoz9yt7jojXj3T5BXhjJ-CaFw@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Fri, 16 Oct 2020 10:48:42 -0700
Message-ID: <CAGXk5yoNxZBD9gX-8RvtsqAwB4rO=hFQKBewFhOGoMO171aJVA@mail.gmail.com>
Subject: Re: [PATCH] sched: cpufreq_schedutil: maintain raw cache when next_f
 is not changed
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Quentin Perret <qperret@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 10:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, Oct 16, 2020 at 7:18 PM Wei Wang <wvw@google.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 10:01 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Fri, Oct 16, 2020 at 6:36 PM Wei Wang <wvw@google.com> wrote:
> > > >
> > > > Currently, raw cache will be reset when next_f is changed after
> > > > get_next_freq for correctness. However, it may introduce more
> > > > cycles. This patch changes it to maintain the cached value instead of
> > > > dropping it.
> > >
> > > IMV you need to be more specific about why this helps.
> > >
> >
> > I think the idea of cached_raw_freq is to reduce the chance of calling
> > cpufreq drivers (in some arch those may be costly) but sometimes the
> > cache will be wiped for correctness. The purpose of this patch is to
> > still keep the cached value instead of wiping them.
>
> Well, I see what the problem is and how the patch is attempting to
> address it (which is not the best way to do that because of the extra
> struct member that doesn't need to be added if I'm not mistaken), but
> IMO the changelog is way too vague from the problem statement
> perspective.

Just want to bring this up in the mainline kernel. I think we can
change the patch to use a variable insides sugov_update_single. This
is adapted from Android common kernel where it has some off tree
functions making a single variable not possible but also making the
issue more obvious.
