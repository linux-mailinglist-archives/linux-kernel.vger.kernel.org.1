Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A965C30005D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbhAVK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 05:26:11 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:36813 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727847AbhAVKPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:15:49 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id 6CC7E1C75DF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:14:53 +0000 (GMT)
Received: (qmail 13926 invoked from network); 22 Jan 2021 10:14:53 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Jan 2021 10:14:53 -0000
Date:   Fri, 22 Jan 2021 10:14:51 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
Message-ID: <20210122101451.GV3592@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net>
 <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 10:30:52AM +0100, Vincent Guittot wrote:
> Hi Mel,
> 
> On Tue, 19 Jan 2021 at 13:02, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Jan 19, 2021 at 12:33:04PM +0100, Vincent Guittot wrote:
> > > On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
> > > >
> > > > Changelog since v2
> > > > o Remove unnecessary parameters
> > > > o Update nr during scan only when scanning for cpus
> > >
> > > Hi Mel,
> > >
> > > I haven't looked at your previous version mainly because I'm chasing a
> > > performance regression on v5.11-rcx which prevents me from testing the
> > > impact of your patchset on my !SMT2 system.
> > > Will do this as soon as this problem is fixed
> > >
> >
> > Thanks, that would be appreciated as I do not have access to a !SMT2
> > system to do my own evaluation.
> 
> I have been able to run tests with your patchset on both large arm64
> SMT4 system and small arm64 !SMT system and patch 3 is still a source
> of regression on both. Decreasing min number of loops to 2 instead of
> 4 and scaling it with smt weight doesn't seem to be a good option as
> regressions disappear when I remove them as I tested with the patch
> below
> 
> hackbench -l 2560 -g 1 on 8 cores arm64
> v5.11-rc4 : 1.355 (+/- 7.96)
> + sis improvement : 1.923 (+/- 25%)
> + the patch below : 1.332 (+/- 4.95)
> 
> hackbench -l 2560 -g 256 on 8 cores arm64
> v5.11-rc4 : 2.116 (+/- 4.62%)
> + sis improvement : 2.216 (+/- 3.84%)
> + the patch below : 2.113 (+/- 3.01%)
> 
> So starting with a min of 2 loops instead of 4 currently and scaling
> nr loop with smt weight doesn't seem to be a good option and we should
> remove it for now
> 

Ok

Note that this is essentially reverting the patch. As you remove "nr *=
sched_smt_weight", the scan is no longer proportional to cores, it's
proportial to logical CPUs and the rest of the patch and changelog becomes
meaningless. On that basis, I'll queue tests over the weekend that remove
this patch entirely and keep the CPU scan as a single pass.

-- 
Mel Gorman
SUSE Labs
