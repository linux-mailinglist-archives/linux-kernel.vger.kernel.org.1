Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D1A2E96EA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbhADOM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:12:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:52254 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbhADOM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:12:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609769501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PpHTWcsYu9aNWGoDskPr9Uf5ufkrRwaG/jWt3MgTzyA=;
        b=rq1Z8r68W7HjqKG1WwTpf79rB+ObjSTRRi/+lAubzIldoZmbbcVXbwNYyzlX2VKD5BvgrY
        Vu8U1EoQwJG5Fe1as9KIiwZyf7IZrX95roWS1rUMbaiVY6pTDLi7+8mfxrWsabeGEtg/R1
        fFX8iN1OEhm1uzFOMTF/a9zQCmwP7hY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 403AFB770;
        Mon,  4 Jan 2021 14:11:41 +0000 (UTC)
Date:   Mon, 4 Jan 2021 15:11:40 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 1/2] mm: page_counter: relayout structure to reduce false
 sharing
Message-ID: <20210104141140.GH13207@dhcp22.suse.cz>
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com>
 <20210104130357.GF13207@dhcp22.suse.cz>
 <20210104133445.GA101866@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104133445.GA101866@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 04-01-21 21:34:45, Feng Tang wrote:
> Hi Michal,
> 
> On Mon, Jan 04, 2021 at 02:03:57PM +0100, Michal Hocko wrote:
> > On Tue 29-12-20 22:35:13, Feng Tang wrote:
> > > When checking a memory cgroup related performance regression [1],
> > > from the perf c2c profiling data, we found high false sharing for
> > > accessing 'usage' and 'parent'.
> > > 
> > > On 64 bit system, the 'usage' and 'parent' are close to each other,
> > > and easy to be in one cacheline (for cacheline size == 64+ B). 'usage'
> > > is usally written, while 'parent' is usually read as the cgroup's
> > > hierarchical counting nature.
> > > 
> > > So move the 'parent' to the end of the structure to make sure they
> > > are in different cache lines.
> > 
> > Yes, parent is write-once field so having it away from other heavy RW
> > fields makes sense to me.
> >  
> > > Following are some performance data with the patch, against
> > > v5.11-rc1, on several generations of Xeon platforms. Most of the
> > > results are improvements, with only one malloc case on one platform
> > > shows a -4.0% regression. Each category below has several subcases
> > > run on different platform, and only the worst and best scores are
> > > listed:
> > > 
> > > fio:				 +1.8% ~  +8.3%
> > > will-it-scale/malloc1:		 -4.0% ~  +8.9%
> > > will-it-scale/page_fault1:	 no change
> > > will-it-scale/page_fault2:	 +2.4% ~  +20.2%
> > 
> > What is the second number? Std?
> 
> For each case like 'page_fault2', I run several subcases on different
> generations of Xeon, and only listed the lowest (first number) and
> highest (second number) scores.
> 
> There are 5 runs and the result are: +3.6%, +2.4%, +10.4%, +20.2%,
> +4.7%, and +2.4% and +20.2% are listed.

This should be really explained in the changelog and ideally mention the
model as well. Seeing a std would be appreciated as well.

-- 
Michal Hocko
SUSE Labs
