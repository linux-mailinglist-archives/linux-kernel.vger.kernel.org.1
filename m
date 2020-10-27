Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CCE29C8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372115AbgJ0TZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:25:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36080 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502262AbgJ0TX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:23:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603826608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUSGe3J/qpyb5gjYq/iuORJOCh7IUjTdzSGyiD/xoBo=;
        b=VH9ym3Lod2k93UJK4FuakqAzgbWf2SWKxITD2fnaSinCjAJeoUknu4B3xS0xfrGnnQoiwy
        0WMdWBGdcUDOcQMip4oSl+8W5yjbzTnu5gQEj1tCX4EU/wHcLYsKrWKNMHyEhlxLhtsFcX
        D8PIDVjDrSfWHxORGerSzJtiEufN6jw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C56B4ABB2;
        Tue, 27 Oct 2020 19:23:28 +0000 (UTC)
Date:   Tue, 27 Oct 2020 20:23:22 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill.c: remove the unmatched comments
Message-ID: <20201027192322.GA20500@dhcp22.suse.cz>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
 <20201027151156.GA4336@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027151156.GA4336@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-10-20 23:11:56, Hui Su wrote:
> On Tue, Oct 27, 2020 at 03:58:14PM +0100, Michal Hocko wrote:
> > On Tue 27-10-20 22:45:29, Hui Su wrote:
> > > is_dump_unreclaim_slabs() just check whether nr_unreclaimable
> > > slabs amount is greater than user memory, not match witch comment.
> > 
> > As I've tried to explain, the comment is not explaining what the
> > function does but how it should be used. It is not a kerneldoc afterall.
> > So it is a good match. I can see how that might confuse somebody so I am
> > not against changing this but the changelog shouldn't really be
> > confusing on its own. What do you think about the following instead.
> > 
> 
> Hi, Michal:
> 
> Thanks for your fast reply, your changlog is much more accurate.
> 
> And should i resend a patch V3 use the changlog below?

Yes, just repost in reply to this email.

With the updated changelog Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

> 
> Thanks.
> 
> > "
> > Comment for is_dump_unreclaim_slabs is not really clear whether it is
> > meant to instruct how to use the function or whether it is an outdated
> > information of the past implementation of the function. it doesn't realy
> > help that is_dump_unreclaim_slabs is hard to grasp on its own.
> > Rename the helper to should_dump_unreclaim_slabs which should make it
> > clear what it is meant to do and drop the comment as the purpose should
> > be pretty evident now.
> > "
> > 
> 
> 

-- 
Michal Hocko
SUSE Labs
