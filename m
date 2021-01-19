Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35D72FB835
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390217AbhASMJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:09:07 -0500
Received: from outbound-smtp25.blacknight.com ([81.17.249.193]:60061 "EHLO
        outbound-smtp25.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392241AbhASMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:03:15 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id DC3FBCB47B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:02:21 +0000 (GMT)
Received: (qmail 19652 invoked from network); 19 Jan 2021 12:02:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Jan 2021 12:02:21 -0000
Date:   Tue, 19 Jan 2021 12:02:20 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Scan for an idle sibling in a single pass
Message-ID: <20210119120220.GS3592@techsingularity.net>
References: <20210119112211.3196-1-mgorman@techsingularity.net>
 <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAsuY4aN6J2C+KCOpyJDULd6yEBZ_8zTLWRXwhakCq8oQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 12:33:04PM +0100, Vincent Guittot wrote:
> On Tue, 19 Jan 2021 at 12:22, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Changelog since v2
> > o Remove unnecessary parameters
> > o Update nr during scan only when scanning for cpus
> 
> Hi Mel,
> 
> I haven't looked at your previous version mainly because I'm chasing a
> performance regression on v5.11-rcx which prevents me from testing the
> impact of your patchset on my !SMT2 system.
> Will do this as soon as this problem is fixed
> 

Thanks, that would be appreciated as I do not have access to a !SMT2
system to do my own evaluation.

-- 
Mel Gorman
SUSE Labs
