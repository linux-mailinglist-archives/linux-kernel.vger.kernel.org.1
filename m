Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9887300414
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhAVNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727442AbhAVNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:23:48 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8FFC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:22:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id x23so6480918lji.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dlLJO6jimId6EJsncVivsPX+l64PBMqOs921XyJpHA=;
        b=c00xADeTOhigVGdMbnIU9Cl9YxVuBfvlEyv2hzJg9kl+WSIDiSBDnT+aCpEsFZtBBv
         5jxVvHv7OZafaNg41JCUGIP1QVbZf+Zme9kKfZ4tHSiUXDDtQ21d4j/E3Cgx80eEmx3E
         CVK7eptZWiy5w2+6V8UhLilqMCp7cjJ5qMwJzWJ71MuN9hIJUqfcPOqTm+MQRIQJQjdT
         L1peGn+mvievW5U+/NZB2efL4aZMtxoJP7N1wZEQIgdUgSMaQcFZ2V0FDt5GbAKOSMSB
         3X6G3cgS3al19s58GyD5Mr1ozFjhX0oQoMbuzHPC9eO4mEf2zdsbg3osmkkMp7/A7PLQ
         3dEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dlLJO6jimId6EJsncVivsPX+l64PBMqOs921XyJpHA=;
        b=RZqWEdjYUL4zLsGc81q3eJa33EXGzUgAEUIN4wG39tUqpaGt08vyOhkDO8AV7SEy9C
         3QXirATJU8ixr0oxOBD4N1k/fICX/LAyxvoJDSzrW9bS6n+gZqjzeDV6xpueua+4Vo05
         rKJTfQJdBwor+u8kTX1EfqG2TAKnSBYHZ3Iul1gPWSO6EDQPX6gZF7QRwqJvjsO9Edht
         ZgCrYPn6EW1JBazarpTrKQsA9RBSNMA+KZkgz5eb9wxeG2qDPuRf0Jy6N/zMP8uY3zNh
         H5PGsrt5X67z2GBz1UYSjnW5hhMXcqihjX91ovBkC71f5QsT3t4HkTsuoHNZEw/Ruf4D
         sSOg==
X-Gm-Message-State: AOAM5322vcBPnUiFfXBfFoiwXqR9OUkrZsR2qCL8YmjDNk3vErRdzkWK
        WaoruWNA71xeBVlpccWXYiMtS3Eo0Hy2P7EXPnrVUg==
X-Google-Smtp-Source: ABdhPJwxt7JID1hIl/F5HBEOcsbDE0mB6FQghCfYyuyAC6L43CU/08jyyt/UjTIUCfbft2K6QRtqe+QhpFaQ5NhoCQo=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr1253380ljm.445.1611321773620;
 Fri, 22 Jan 2021 05:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net> <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
 <20210122101451.GV3592@techsingularity.net>
In-Reply-To: <20210122101451.GV3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 22 Jan 2021 14:22:42 +0100
Message-ID: <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jan 2021 at 11:14, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Jan 22, 2021 at 10:30:52AM +0100, Vincent Guittot wrote:
> > Hi Mel,
> >
> > On Tue, 19 Jan 2021 at 13:02, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Tue, Jan 19, 2021 at 12:33:04PM +0100, Vincent Guittot wrote:
> > > > On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > > >
> > > > > Changelog since v2
> > > > > o Remove unnecessary parameters
> > > > > o Update nr during scan only when scanning for cpus
> > > >
> > > > Hi Mel,
> > > >
> > > > I haven't looked at your previous version mainly because I'm chasing a
> > > > performance regression on v5.11-rcx which prevents me from testing the
> > > > impact of your patchset on my !SMT2 system.
> > > > Will do this as soon as this problem is fixed
> > > >
> > >
> > > Thanks, that would be appreciated as I do not have access to a !SMT2
> > > system to do my own evaluation.
> >
> > I have been able to run tests with your patchset on both large arm64
> > SMT4 system and small arm64 !SMT system and patch 3 is still a source
> > of regression on both. Decreasing min number of loops to 2 instead of
> > 4 and scaling it with smt weight doesn't seem to be a good option as
> > regressions disappear when I remove them as I tested with the patch
> > below
> >
> > hackbench -l 2560 -g 1 on 8 cores arm64
> > v5.11-rc4 : 1.355 (+/- 7.96)
> > + sis improvement : 1.923 (+/- 25%)
> > + the patch below : 1.332 (+/- 4.95)
> >
> > hackbench -l 2560 -g 256 on 8 cores arm64
> > v5.11-rc4 : 2.116 (+/- 4.62%)
> > + sis improvement : 2.216 (+/- 3.84%)
> > + the patch below : 2.113 (+/- 3.01%)
> >
> > So starting with a min of 2 loops instead of 4 currently and scaling
> > nr loop with smt weight doesn't seem to be a good option and we should
> > remove it for now
> >
>
> Ok
>
> Note that this is essentially reverting the patch. As you remove "nr *=
> sched_smt_weight", the scan is no longer proportional to cores, it's

Yes. My goal above was to narrow the changes only to lines that
generate the regressions but i agree that removing patch 3 is the
right solution


> proportial to logical CPUs and the rest of the patch and changelog becomes
> meaningless. On that basis, I'll queue tests over the weekend that remove
> this patch entirely and keep the CPU scan as a single pass.
>
> --
> Mel Gorman
> SUSE Labs
