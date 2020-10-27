Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF76229B9CE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1803232AbgJ0Pw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:52:27 -0400
Received: from m12-15.163.com ([220.181.12.15]:39571 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1799224AbgJ0Pa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=3oDqx
        WCgFd8JrOidOt8LxnLGY8nQi1Gnn/BvOHEBY+o=; b=kDCrMmSDYdZ646fXY9nLz
        nCe9pWrGjLJ/nZ6Q6MMhTn6yiklMIDkI815NVkqgpNl3/QPjdYPxVu3km4J+STnM
        7gYHpH7BifJacAGkr4lYaYveHzEQC7FIEkkNQpCMXz1jKCXppetg01YdVByI1swl
        +OQalbyoan2/VOdA13DlEI=
Received: from localhost (unknown [101.86.209.121])
        by smtp11 (Coremail) with SMTP id D8CowACnzxO8OJhfdX+LFA--.52256S2;
        Tue, 27 Oct 2020 23:11:57 +0800 (CST)
Date:   Tue, 27 Oct 2020 23:11:56 +0800
From:   Hui Su <sh_def@163.com>
To:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill.c: remove the unmatched comments
Message-ID: <20201027151156.GA4336@rlk>
References: <20201027144529.GA3558@rlk>
 <20201027145814.GY20500@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027145814.GY20500@dhcp22.suse.cz>
X-CM-TRANSID: D8CowACnzxO8OJhfdX+LFA--.52256S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrurW8tF43XFWfur1rKryDWrg_yoWktFbE9a
        nrtw4DJr4kGF95CF4IkayrZ39rWr4kAa15Z3W0qr12q34YqFZ3Wrn2qFn3Xa4DXFWIy34j
        9FyDJay3AwnFqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1JPEPUUUUU==
X-Originating-IP: [101.86.209.121]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJh3KX1v2eytZOgAAsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 03:58:14PM +0100, Michal Hocko wrote:
> On Tue 27-10-20 22:45:29, Hui Su wrote:
> > is_dump_unreclaim_slabs() just check whether nr_unreclaimable
> > slabs amount is greater than user memory, not match witch comment.
> 
> As I've tried to explain, the comment is not explaining what the
> function does but how it should be used. It is not a kerneldoc afterall.
> So it is a good match. I can see how that might confuse somebody so I am
> not against changing this but the changelog shouldn't really be
> confusing on its own. What do you think about the following instead.
> 

Hi, Michal:

Thanks for your fast reply, your changlog is much more accurate.

And should i resend a patch V3 use the changlog below?

Thanks.

> "
> Comment for is_dump_unreclaim_slabs is not really clear whether it is
> meant to instruct how to use the function or whether it is an outdated
> information of the past implementation of the function. it doesn't realy
> help that is_dump_unreclaim_slabs is hard to grasp on its own.
> Rename the helper to should_dump_unreclaim_slabs which should make it
> clear what it is meant to do and drop the comment as the purpose should
> be pretty evident now.
> "
> 


