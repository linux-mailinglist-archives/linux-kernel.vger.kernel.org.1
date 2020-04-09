Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 467431A38D0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 19:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbgDIRVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 13:21:15 -0400
Received: from outbound-smtp52.blacknight.com ([46.22.136.236]:55435 "EHLO
        outbound-smtp52.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726642AbgDIRVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:21:15 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp52.blacknight.com (Postfix) with ESMTPS id BA00BFADA1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 18:21:13 +0100 (IST)
Received: (qmail 24392 invoked from network); 9 Apr 2020 17:21:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2020 17:21:13 -0000
Date:   Thu, 9 Apr 2020 18:21:11 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Cgroup memory barrier usage and call frequency from scheduler
Message-ID: <20200409172111.GL3818@techsingularity.net>
References: <20200409154413.GK3818@techsingularity.net>
 <20200409164919.GF20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200409164919.GF20713@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 06:49:19PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 09, 2020 at 04:44:13PM +0100, Mel Gorman wrote:
> 
> > For 1, the use of a full barrier seems unnecessary when it appears that
> > you could have used a read barrier and a write barrier. The following
> > patch drops the profile overhead to 0.1%
> 
> Yikes. And why still .1% the below should be a barrier() on x86. Is the
> compiler so contrained by that?
> 

The 0.1% is still doing all the work up until just after the barrier with
this check;

	if (cgroup_rstat_cpu(cgrp, cpu)->updated_next)
		return;

That must often be true as samples were not gathered in the rest of the
function. As this function is called on every update_curr(), it gets
called a lot.

-- 
Mel Gorman
SUSE Labs
