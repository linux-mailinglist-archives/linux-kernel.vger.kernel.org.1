Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB03024F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 13:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbhAYMaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 07:30:17 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:44527 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727932AbhAYMTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:19:14 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id 65F7E15F3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:46:25 +0000 (GMT)
Received: (qmail 28150 invoked from network); 25 Jan 2021 11:46:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Jan 2021 11:46:25 -0000
Date:   Mon, 25 Jan 2021 11:46:23 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
Message-ID: <20210125114623.GY3592@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
 <20210119120220.GS3592@techsingularity.net>
 <CAKfTPtAWcVu5y_L93h47WHS1wkUZh=EPxyMDi5vSeNvx14Y_kQ@mail.gmail.com>
 <20210122101451.GV3592@techsingularity.net>
 <CAKfTPtADmw_RVL-VTZgOMr2-4-AG0m4KeQLFsNXEEioyARif8A@mail.gmail.com>
 <eb8ac8de-e6e8-3273-5368-efa6ec0cae9b@linux.intel.com>
 <20210125090419.GW3592@techsingularity.net>
 <31300317-89e0-ca5e-d095-920c6cfe8704@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <31300317-89e0-ca5e-d095-920c6cfe8704@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 07:37:55PM +0800, Li, Aubrey wrote:
> > It's interesting that patch 3 would make any difference on x64 given that
> > it's SMT2. The scan depth should have been similar. It's somewhat expected
> > that it will not be a universal win, particularly once the utilisation
> > is high enough to spill over in sched domains (25%, 50%, 75% utilisation
> > being interesting on 4-socket systems). In such cases, double scanning can
> > still show improvements for workloads that idle rapidly like tbench and
> > hackbench even though it's expensive. The extra scanning gives more time
> > for a CPU to go idle enough to be selected which can improve throughput
> > but at the cost of wake-up latency,
> 
> aha, sorry for the confusion. Since you and Vincent discussed to drop
> patch3, I just mentioned I tested 5 patches with patch3, not patch3 alone.
> 

Ah, that makes more sense.

> > 
> > Hopefully v4 can be tested as well which is now just a single scan.
> > 
> 
> Sure, may I know the baseline of v4?
> 

5.11-rc4.

-- 
Mel Gorman
SUSE Labs
