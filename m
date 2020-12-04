Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71BE2CF0AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgLDPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgLDPYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:24:41 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D25C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:24:00 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id y24so5512539otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yb5cBIaAgEvdW65I3gct0bwLgiUK91VDJcIaRSW+Ncc=;
        b=sRKUpMlQ59l+3cbTx0lnBOA3ymo9+Yci+V54ir0P78wJxW+jgWpMtSkcmozBRfO4V/
         Sie5dSF+3Et8P0ZTea3qFcxJm0dLd5nqfSoN2Btx7kkTU2aUdSe6sKV80LoGYiJ5z8QG
         oTI+oDZHZBfKukdaoViC/uS2Q6ec4WFM+VVf44yf629jUqIV7ni8nUi3FMRTTz68xSDb
         CwPz8SsD9/i2TLe9OPzgRXuJt9q1/crJYdvcVhKotWVuRfrRjZC01RnYKF37Ud50EAwN
         K3sGOA6ZfVH9VRiQIJWq+8GfLYX9C3/d0FsTSZd4cLaL5Ak5hJ/A7MDn2Jjo8D1GR8Xa
         EZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yb5cBIaAgEvdW65I3gct0bwLgiUK91VDJcIaRSW+Ncc=;
        b=EZn6RM1F9owZaeILcL7mwK6LSAYuNJuG6/OmG+pI+/1a1yoA2cPUiDGrbD/CaEXSBN
         3Hi31XLb0O2rCQt8AqslnbUvewT6Xv2eeoAbBc41NA2apvzJEiFDKiYFbyCy6w+wmYTA
         VIATiaqiXydg9K27ubA0ExrsNr/UEVYSfFrlSa+wBB+WuU8FwimmVhW5bxxOoUD04V2x
         NJPEt0mCv91G1K1L+mSP6LTHvHu3llYXgRgK5l7dhMsLQcEDplwR95I2EVYTTEHnYS50
         6uDsb4B2S6yOgMGtVWIK4uDUezHMqBEniN4lSH5l/BREKeU4+hapLZ7KJNnHOZ1L9vHP
         uXcQ==
X-Gm-Message-State: AOAM532N6SlMntQD2xPMzPsffzs111MjHfGOBgT66/9uGuiy9WqVX7IS
        nGgvcMF1z0Hjkq/AU7KolA5BNcOuVVXMi2vnLF5imw==
X-Google-Smtp-Source: ABdhPJz4ZiGgzBwku8kZ+7K3e1xIWnzb2buQ4O4MkOqVJW7ksN5oxo6OTCx9XRDlmhVV8vN84bTjfUB9O18ezhC/zLo=
X-Received: by 2002:a05:6830:2ef:: with SMTP id r15mr4106721ote.261.1607095440313;
 Fri, 04 Dec 2020 07:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net> <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net> <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net> <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
 <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com> <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
 <20201204143115.GB3371@techsingularity.net>
In-Reply-To: <20201204143115.GB3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 16:23:48 +0100
Message-ID: <CAKfTPtBXUK7NnhN1Rxeq-o5t-G+csN6Tj0yP=BSV_sdD1uZS0g@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 15:31, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Dec 04, 2020 at 02:47:48PM +0100, Vincent Guittot wrote:
> > > IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> > > If the target's sibling is removed from select_idle_mask from select_idle_core(),
> > > select_idle_cpu() will lose the chance to pick it up?
> >
> > This is only relevant for patch 10 which is not to be included IIUC
> > what mel said in cover letter : "Patches 9 and 10 are stupid in the
> > context of this series."
> >
>
> Patch 10 was stupid in the context of the prototype because
> select_idle_core always returned a CPU. A variation ended up being
> reintroduced at the end of the Series Yet To Be Posted so that SMT siblings
> are cleared during select_idle_core() but select_idle_cpu() still has a
> mask with unvisited CPUs to consider if no idle cores are found.
>
> As far as I know, this would still be compatible with Aubrey's idle
> cpu mask as long as it's visited and cleared between select_idle_core
> and select_idle_cpu. It relaxes the contraints on Aubrey to some extent
> because the idle cpu mask would be a hint so if the information is out
> of date, an idle cpu may still be found the normal way.

But even without patch 10, just replacing sched_domain_span(sd) by
sds_idle_cpus(sd->shared) will ensure that sis loops only on cpus that
get a chance to be idle so select_idle_core is likely to return an
idle_candidate

>
> --
> Mel Gorman
> SUSE Labs
