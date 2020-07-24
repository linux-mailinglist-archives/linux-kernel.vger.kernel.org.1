Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9453C22C26F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgGXJjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGXJjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:39:13 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137BFC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:39:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id l19so2081382lfh.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e87pQfx8rofdbtpB+k1lVjV0rqeHMke4If5qI9EWahk=;
        b=Y4+w5u8cY8DhrvfNyQVRaOuT2MwiffsUSOIKfp7iGhYg3cgQU2H1cqrToBpkZ4hNW8
         SMUOQu9DZ51yMymP/P+JdaPGx9+Jc7cUVjOBrTOBEL9oYTyn3z1JYMwXO9wY4xgSNRCh
         Xbio0E39MgfQiDBJxTPR1pL6RMZ225AHXydPzNsSNH3vVAUrc5zVB6IbseAExFZcz2YR
         7j7kE7MvKwk7ebBzerOVJ1qXcbjKXxo3PZ9jAPR2RD/JLMWigBVHd95+YgrSIaiNtsDH
         vJ/nDj9Y4AsBd/Ks+1vFCag7arwXvvMqfLfF80A9GVj7zQVNtQRkvNYs7uAAqKrjTe7p
         Bs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e87pQfx8rofdbtpB+k1lVjV0rqeHMke4If5qI9EWahk=;
        b=efM/KF6FOpDy+/HgAI0PKqJ3stwqNbJY7fPZDxtrVSu2kBOm33e7oeEDReMZz6PD+y
         Y0op5+TwpASqD3KMPb/6DKxgnTDXqVD2nKmr6tis2QeHB5q8r2Y1gGhbXNydyt1LE8Yu
         0kOl2PJHT+6EPFNaKebhECc9mh9Mo1ngBixKMnHuxnMgmrWLZpvjojgabVz0YtDsLTqm
         JirzN2MjhVg1SqSDYWnViuTnjc2bFAusEPPWi7MxXQrkTThfNb8ZIyxUFpfP3xXu6vXO
         21OYTxboBJ1UaxKkTD5otmLzmhi7ZP63UN+Px1iymy1Jt4M164XpOgHCKJcrd2sSdRjX
         RxDQ==
X-Gm-Message-State: AOAM5301xjeXS3kQUx2sVoVcMn95bobxqXdTrJnab7w/cGdUbw3Clxwa
        y56r2orNTWO4kV6l77Zy+rn7gpw5Y45NJ/A+1hd1AQ==
X-Google-Smtp-Source: ABdhPJwrk/sx8atD//iNfYobLYDJtoQv1iSlE/6jXlDbBOUDPBPH1quNCCUeoEZv9dcE0R3Soo1wyLvdA+Zs8BZioDs=
X-Received: by 2002:a19:834f:: with SMTP id f76mr4267082lfd.25.1595583551391;
 Fri, 24 Jul 2020 02:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594289009.git.viresh.kumar@linaro.org> <20200709124349.GA15342@arm.com>
 <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
In-Reply-To: <20200710030032.3yq3lqqybhy5m744@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 24 Jul 2020 11:38:59 +0200
Message-ID: <CAKfTPtBpOdRSV0gb2CoC8J9GnuPiqZ+MbQLLc6NdSmjJhb0cgA@mail.gmail.com>
Subject: Re: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Puhov <peter.puhov@linaro.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jul 2020 at 05:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Thanks for the quick reply Ionela.
>
> On 09-07-20, 13:43, Ionela Voinescu wrote:
> > I'll put all my comments here for now, as they refer more to the design
> > of the solution.
> >
> > I hope it won't be too repetitive compared to what we previously discussed
> > offline.
>
> > I understand you want to get additional points of view.
>
> Not necessarily, I knew you would be one of the major reviewers here
> :)
>
> I posted so you don't need to review in private anymore and then the
> code is somewhat updated since the previous time.
>
> > On Thursday 09 Jul 2020 at 15:43:32 (+0530), Viresh Kumar wrote:
> > I believe the code is unnecessarily invasive for the functionality it
> > tries to introduce and it does break existing functionality.
> >
> >
> >  - (1) From code readability and design point of view, this switching
> >        between an architectural method and a driver method complicates
> >        an already complicated situation. We already have code that
> >        chooses between a cpufreq-based method and a counter based method
> >        for frequency invariance. This would basically introduce a choice
> >        between a cpufreq-based method through arch_set_freq_scale(), an
> >        architectural counter-based method through arch_set_freq_tick(),
> >        and another cpufreq-based method that piggy-backs on the
> >        architectural arch_set_freq_tick().
>
> I agree.
>
> >        As discussed offline, before I even try to begin accepting the
> >        possibility of this complicated mix, I would like to know why
> >        methods of obtaining the same thing by using the cpufreq
> >        arch_set_freq_scale()
>
> The problem is same as that was in case of x86, we don't know the real
> frequency the CPU may be running at and we need something that fires
> up periodically in a guaranteed way to capture the freq-scale.

Yeah it's exactly the same behavior as x86 and re using the same
mechanism seems the  best solution

The main problem is that AMU currently assumes that it will be the
only to support such tick based mechanism whereas others like cppc can
provides similar information

>
> Though I am thinking now if we can trust the target_index() helper and
> keep updating the freq-scale based on the delta between last call to
> it and the latest call. I am not sure if it will be sufficient.
>
> >        or even the more invasive wrapping of the
> >        counter read functions is not working.
>
> I am not sure I understood this one.
>
> >  - (2) For 1/3, the presence of AMU counters does not guarantee their
> >        usability for frequency invariance. I know you wanted to avoid
> >        the complications of AMUs being marked as supporting invariance
> >        after the cpufreq driver init function, but this breaks the
> >        scenario in which the maximum frequency is invalid.
>
> Is that really a scenario ? i.e. Invalid maximum frequency ? Why would
> that ever happen ?
>
> And I am not sure if this breaks anything which already exists,
> because all we are doing in this case now is not registering cppc for
> FI, which should be fine.

IIUC, AMU must wait for cpufreq drivers to be registered in order to
get the maximum freq and being able to enable its FIE support.
Could we have a sequence like:
cppc register its scale_freq_tick function
AMU can then override the tick function for cpu which supports AMU

>
> >  - (3) For 2/3, currently we support platforms that have partial support
> >        for AMUs, while this would not be supported here. The suggestions
> >        at (1) would give us this for free.
>
> As both were counter based mechanisms, I thought it would be better
> and more consistent if only one of them is picked. Though partial
> support of AMUs would still work without the CPPC driver.
>
> --
> viresh
