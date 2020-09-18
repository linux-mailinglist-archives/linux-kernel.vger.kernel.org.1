Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92E26F592
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 07:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgIRF4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 01:56:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:44914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRF4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 01:56:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600408598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PXAQlqj/RUeUbQbFytXImoknEhdO+wRjk0JmiUxm9e0=;
        b=erccW4++jiukPNVSInhhoAsaB7v4W7V+37WCq+B9fO9yl/l7vx6lS283NdY8pX6aBeMeLW
        DO58IxhKZpUeDJQQ5u612Jzr+9y8FuskXcjaYEx4ySX8DzWBXhItgfZDph5pNvSDr1aQbV
        HHtMSvc7tLGt0fpAdv0fk3W/jrUtvLEAjczN5v6vgRkNK/4gv3EhEOGIQ2p7qAD7Eg1TNR
        si0PL2y2VDAMdsupFihBQ+CWEUufLjfQEqKkZjDlrN4+3qgJIC66/7P0gq8LXGXOtA01MF
        ePIngCH+uvloZjQAmuc5ePsRk4CfV8giHYJZN3QCd8KoOXP52uftC/jcAmHCRw==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C5B7AD1B;
        Fri, 18 Sep 2020 05:57:12 +0000 (UTC)
Date:   Fri, 18 Sep 2020 07:56:37 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [v4] mm: khugepaged: avoid overriding min_free_kbytes set by user
Message-ID: <20200918055637.GB28827@dhcp22.suse.cz>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
 <20200917175217.GD29887@dhcp22.suse.cz>
 <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2231b44-6d14-fb63-43cd-43aaad02bef1@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-09-20 11:16:55, Vijay Balakrishna wrote:
> 
> 
> On 9/17/2020 10:52 AM, Michal Hocko wrote:
> > On Thu 17-09-20 10:27:16, Vijay Balakrishna wrote:
> > > 
> > > 
> > > On 9/17/2020 2:28 AM, Michal Hocko wrote:
> > > > On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
> > > > > set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> > > > > user.  Post start-of-day THP enable or memory hotplug operations can
> > > > > lose user specified min_free_kbytes, in particular when it is higher than
> > > > > calculated recommended value.
> > > > 
> > > > I was about to recommend a more detailed explanation when I have
> > > > realized that this patch is not really needed after all. Unless I am
> > > > missing something.
> > > > 
> > > > init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
> > > > it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
> > > > user_min_free_kbytes.
> > > > 
> > > > Except for value clamping when the value is reduced and this likely
> > > > needs fixing. But set_recommended_min_free_kbytes should be fine.
> > > > 
> > > 
> > > IIUC, after start-of-day if a user performs
> > > - THP disable
> > > - modifies min_free_bytes
> > > - THP enable
> > > above sequence currently wouldn't result in calling init_per_zone_wmark_min.
> > 
> > I will not, but why do you think this matters? All we should care about
> > is that auto-tuning shouldn't reduce user provided value [1] and that
> > the memory hotplug should be consistent with the boot time heuristic.
> > init_per_zone_wmark_min should make sure that the user value is not
> > reduced and thp heuristic makes sure it will not reduce this value.
> > So the property should be transitive with the existing code (modulo the
> > problem I have highlighted).
> > 
> > [1] one could argue that it shouldn't even increase the value strictly
> > speaking because an admin might have a very good reason to decrease the
> > value but this has never been the semantic and changing it now might be
> > problematic
> > 
> 
> I made an attempt to address Kirill A. Shutemov's comment.

This is for Kirill to comment on but my take would be that memory
hotplug really has to alter the user defined min_free_kbytes because it
is manipulating the amount of memory. There are usecases which are
adding a lot of memory.

We are trying to not decrease the value which is arguably a weird semantic
but this is what've been doing for years. We would need to hear a
specific usecase where this matters (e.g. memory hotremove heavy
workalod with manually tuned min_free_kbytes) that misbehaves.

> And incrased
> min_free_kbytes to see the issue in my testing and attempted a fix.  I'm ok
> leaving as it is.  Do not want introduce any changes that may cause
> regression.

I would recommend reposting the patch which adds heuristic for THP (if
THP is enabled) into the hotplug path, arguing with the consistency and
surprising results when adding memory decreases the value. Your initial
problem is in sizing as mentioned in other email thread and you should
be investigating more but this inconsistency might really come as a
surprise.

All that if Kirill is reconsidering his initial position of course.
-- 
Michal Hocko
SUSE Labs
