Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3926E2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIQRwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:52:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:34268 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgIQRwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:52:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=cantorsusede;
        t=1600365141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ACZ1i9L0eM7pFjFd6XaMh+LP19pdesYPnrbce9bvdE=;
        b=m9qgQiSVGElQlgS9Y1bmW4eQ8wF71jXeVpuMDzMUgwElV7P1mbCwz/Zv/UkQGU9Q0wpoUk
        O9BwIm4LqU4fpPS20ikdrS6Z3FNw0MALD5/aJkkPfSxSyM2DPL+8v18XO9O1uy9STJDw7W
        SmroQcsO1DBGXMthvakPKGk8BQimldnSyHzyXKsAPdspi96E2kWUsLTGIQOBOBi/9Em76k
        T/+UL+topOL0WxGchvg7SIQi3D49aiZiPWhZedfJfqFFqJJSrdwPwbiq9SnTy3+/O7SjIV
        dvSBzs/ORRMDWWa5zipmgYvF8xU+YoLJswYD4KVt9DV6r/lVuzgUjI/Q7rZMXA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ACFF4B0BE;
        Thu, 17 Sep 2020 17:52:54 +0000 (UTC)
Date:   Thu, 17 Sep 2020 19:52:17 +0200
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
Message-ID: <20200917175217.GD29887@dhcp22.suse.cz>
References: <1600324779-6782-1-git-send-email-vijayb@linux.microsoft.com>
 <20200917092805.GA29887@dhcp22.suse.cz>
 <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21c4788c-2516-2e47-5885-486c352c2b6e@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-09-20 10:27:16, Vijay Balakrishna wrote:
> 
> 
> On 9/17/2020 2:28 AM, Michal Hocko wrote:
> > On Wed 16-09-20 23:39:39, Vijay Balakrishna wrote:
> > > set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> > > user.  Post start-of-day THP enable or memory hotplug operations can
> > > lose user specified min_free_kbytes, in particular when it is higher than
> > > calculated recommended value.
> > 
> > I was about to recommend a more detailed explanation when I have
> > realized that this patch is not really needed after all. Unless I am
> > missing something.
> > 
> > init_per_zone_wmark_min ignores the newly calculated min_free_kbytes if
> > it is lower than user_min_free_kbytes. So calculated min_free_kbytes >=
> > user_min_free_kbytes.
> > 
> > Except for value clamping when the value is reduced and this likely
> > needs fixing. But set_recommended_min_free_kbytes should be fine.
> > 
> 
> IIUC, after start-of-day if a user performs
> - THP disable
> - modifies min_free_bytes
> - THP enable
> above sequence currently wouldn't result in calling init_per_zone_wmark_min.

I will not, but why do you think this matters? All we should care about
is that auto-tuning shouldn't reduce user provided value [1] and that
the memory hotplug should be consistent with the boot time heuristic.
init_per_zone_wmark_min should make sure that the user value is not
reduced and thp heuristic makes sure it will not reduce this value.
So the property should be transitive with the existing code (modulo the
problem I have highlighted).

[1] one could argue that it shouldn't even increase the value strictly
speaking because an admin might have a very good reason to decrease the
value but this has never been the semantic and changing it now might be
problematic
-- 
Michal Hocko
SUSE Labs
