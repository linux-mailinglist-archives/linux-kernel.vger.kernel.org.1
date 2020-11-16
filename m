Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F73B2B433B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgKPMA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:00:26 -0500
Received: from outbound-smtp13.blacknight.com ([46.22.139.230]:47129 "EHLO
        outbound-smtp13.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbgKPMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:00:26 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id BE76D1C43FA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:00:24 +0000 (GMT)
Received: (qmail 31835 invoked from network); 16 Nov 2020 12:00:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 16 Nov 2020 12:00:24 -0000
Date:   Mon, 16 Nov 2020 12:00:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Loadavg accounting error on arm64
Message-ID: <20201116120022.GO3371@techsingularity.net>
References: <20201116091054.GL3371@techsingularity.net>
 <20201116114938.GN3371@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201116114938.GN3371@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 11:49:38AM +0000, Mel Gorman wrote:
> On Mon, Nov 16, 2020 at 09:10:54AM +0000, Mel Gorman wrote:
> > I'll be looking again today to see can I find a mistake in the ordering for
> > how sched_contributes_to_load is handled but again, the lack of knowledge
> > on the arm64 memory model means I'm a bit stuck and a second set of eyes
> > would be nice :(
> > 
> 
> This morning, it's not particularly clear what orders the visibility of
> sched_contributes_to_load exactly like other task fields in the schedule
> vs try_to_wake_up paths. I thought the rq lock would have ordered them but
> something is clearly off or loadavg would not be getting screwed. It could
> be done with an rmb and wmb (testing and hasn't blown up so far) but that's
> far too heavy.  smp_load_acquire/smp_store_release might be sufficient
> on it although less clear if the arm64 gives the necessary guarantees.
> 

And smp_* can't be used anyway because sched_contributes_to_load is a
bit field that is not protected with a specific lock so it's "special".

-- 
Mel Gorman
SUSE Labs
