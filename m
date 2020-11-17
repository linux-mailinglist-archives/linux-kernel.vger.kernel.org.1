Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1292B677B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgKQObg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgKQObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:31:34 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15ADDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:31:33 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 142so10845086ljj.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CRNNMopfkxn+VbJFF8fI8tGBFKP5orloO2rQjUFQKOI=;
        b=Y+j3kYy6CxUVpJjX7uiv8z7kUFQHFfUnW9E0aI+eOYbtbt9nS2SMFoEUKTnwpvBUu+
         0lQJ5/liKye2i5rZW8uFJRRyeBQdr4DuPKQCkmGL5ubzxFm+FgmZw0irLfRPvi1egPLq
         K7rVTVLzIv6K4M4L09dGY2RvA+GzzJyUPH+mFdPC013corbwI8z8WW4mn/UrK5oKw5gr
         LluD3kJed8bGNncliPXXXwWLcNRJ10BhgJryKOjPNVN2WlKvQI5C2U8xbjZCHi/yR/ZI
         E2+u3W2f/DAZD4LPtLkl0hkebQXMIplJD52nG+lA8FsslNMvewcGYddshfKBsh6NSY52
         A77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CRNNMopfkxn+VbJFF8fI8tGBFKP5orloO2rQjUFQKOI=;
        b=BE8nft6xyXS4XVPpb5wjFx4G2JtGwkQA7g2bLv94BcJM+6qAdOZFaoxmtCVAZT7yqE
         TGDQ2lOOxVYsaSXAVSdr6xW3A8qMtAJctGmQi4pskehVt6Q4xnVDgemG2oWgpVTn8iic
         Dm7Q3XSSUHbX2tEv4A8ySPyKFnfC4wvWbDvCxkt28vc7GRFzCb4lgQTI246o+tyeR0rP
         POuTHRSUPOU1r1msCLiNowDpnL4qQXAsZFvlC9EKUm363LVFbHt373D924ZFxO/+7z8p
         uVmiYY38NInSeokk2HmKJpCRq3VQiB9/pt6eKud2+xE3HHlCkE2ARdGJ+HN+OL5U/Kud
         QaEg==
X-Gm-Message-State: AOAM530lOLDBbo9TP2pFq5w+ZaUujK/gJL4AMARkA8LWozCKuJEs3+BT
        49miXzE1Iq86aT1al/OdfJDc2f7ERHi9S7AA305Xjw==
X-Google-Smtp-Source: ABdhPJwhFmmmrgC7UXjA7BTEFoJsK9fNW3jfe2IY5edq9Fj8wxs51CC8G1UDkNLs8JvWkLj1TaUUNtitFeqWzOQCp6g=
X-Received: by 2002:a2e:8050:: with SMTP id p16mr2174189ljg.69.1605623491013;
 Tue, 17 Nov 2020 06:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20201117134222.31482-1-mgorman@techsingularity.net>
 <20201117134222.31482-4-mgorman@techsingularity.net> <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
In-Reply-To: <20201117141814.GN3121392@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 17 Nov 2020 15:31:19 +0100
Message-ID: <CAKfTPtDQgv8RCe1RRCGg0px0Bp6GbdAhXbRKTH5zeVaRDmK+vg@mail.gmail.com>
Subject: Re: [PATCH 3/3] sched/numa: Limit the amount of imbalance that can
 exist at fork time
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 15:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 17, 2020 at 01:42:22PM +0000, Mel Gorman wrote:
> > -                     if (local_sgs.idle_cpus)
> > +                     if (local_sgs.idle_cpus >= (sd->span_weight >> 2))
> >                               return NULL;
>
> Is that the same 25% ?

same question for me
could we encapsulate this 25% allowed imbalance like for adjust_numa_imbalance
