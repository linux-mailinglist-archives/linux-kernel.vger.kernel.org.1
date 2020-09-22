Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19E274512
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgIVPQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:16:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:52078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVPQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:16:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600787815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJgGLrQcC32JUla74uN+fGhEo/pFo1Hw1KVkIOSTccw=;
        b=HpRb403AygbNrLzidxYcwwdgrn0Zjm7gWlIbekXXY1DXA/e0TWZHEa7Tk9jgYju+TjT3GW
        NI2bUjG4twrmGe1nIwFPhYEPWHooGZwlG4fx+GqPfzx4x+/WEfvwZ3NyQPKdfxRvymPTTv
        gPn05rxQ9QNhN6aqSgLzYgf4CEKY9jA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2A387ACAC;
        Tue, 22 Sep 2020 15:17:32 +0000 (UTC)
Date:   Tue, 22 Sep 2020 17:16:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: Machine lockups on extreme memory pressure
Message-ID: <20200922151654.GA12990@dhcp22.suse.cz>
References: <CALvZod4FWLsV9byrKQojeus7tMDhHjQHFF5J_JpNsyB0HkaERA@mail.gmail.com>
 <20200922111202.GY12990@dhcp22.suse.cz>
 <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod6=VwQduoG3GiW-=csAQja4vCsXAhKH_tSuA4JYx0dEiA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 06:37:02, Shakeel Butt wrote:
[...]
> > I would recommend to focus on tracking down the who is blocking the
> > further progress.
> 
> I was able to find the CPU next in line for the list_lock from the
> dump. I don't think anyone is blocking the progress as such but more
> like the spinlock in the irq context is starving the spinlock in the
> process context. This is a high traffic machine and there are tens of
> thousands of potential network ACKs on the queue.

So there is a forward progress but it is too slow to have any reasonable
progress in userspace?

> I talked about this problem with Johannes at LPC 2019 and I think we
> talked about two potential solutions. First was to somehow give memory
> reserves to oomd and second was in-kernel PSI based oom-killer. I am
> not sure the first one will work in this situation but the second one
> might help.

Why does your oomd depend on memory allocation?
-- 
Michal Hocko
SUSE Labs
