Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1929060C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406900AbgJPNLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406366AbgJPNLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602853875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZRMldPYKxC0DNF4084iHQT4UbvY2QDNxpeBekc9uRo=;
        b=YwyeBkMzdi0o3GsBksg7r6ndRpzI3Me9v9fxfpVptJarQKHoFr69OsrKJqlH4bo1267mtL
        Bj3VLj3hPbfwQb2NZOeC68UldiE3l5+XRE287KczM1fYtawKUM98n8s3FQhRQOfGXJoMIR
        kqvpeE2sn2zozhzXvCJKQysUA80y/Z4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E8E6AB8F;
        Fri, 16 Oct 2020 13:11:15 +0000 (UTC)
Date:   Fri, 16 Oct 2020 15:11:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     osalvador@suse.de
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: fix potential pte_unmap_unlock pte error
Message-ID: <20201016131112.GJ22589@dhcp22.suse.cz>
References: <20201015121534.50910-1-luoshijie1@huawei.com>
 <20201016123137.GH22589@dhcp22.suse.cz>
 <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f99d9457ae88f3692e57cce86d0e22e8@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 14:37:08, osalvador@suse.de wrote:
> On 2020-10-16 14:31, Michal Hocko wrote:
> > I do not like the fix though. The code is really confusing. Why should
> > we check for flags in each iteration of the loop when it cannot change?
> > Also why should we take the ptl lock in the first place when the look is
> > broken out immediately?
> 
> About checking the flags:
> 
> https://lore.kernel.org/linux-mm/20190320081643.3c4m5tec5vx653sn@d104.suse.de/#t

This didn't really help. Maybe the code was different back then but
right now the code doesn't make much sense TBH. The only reason to check
inside the loop would be to have a completely unpopulated address range.
Note about MPOL_MF_STRICT is not checked explicitly and I do not see how
it makes any difference.

Anyway this function would benefit from some uncluttering!

-- 
Michal Hocko
SUSE Labs
