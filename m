Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3A62904BE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407204AbgJPMHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 08:07:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407197AbgJPMHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 08:07:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602850073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMvmrgpjMkX0xJOTXr8Pz+UkBkQEErVHRE0b+uty4jo=;
        b=MsTJuYeFBaY1lUdcdwkieCiuRiuoHH/KEexOXZihB/7wj6fcen0rY7ib52Q8Q9Vd+dsEmk
        /xagWKCpLyntf1KWzA+EwuUbRbMPqd4ABTRuAvoj2TqI0Muh7oPpZLre7+yc+Ab91dliAV
        RFNaoo1GdLos0vZygjYfSC83Q9IcmdI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 785A6AD72;
        Fri, 16 Oct 2020 12:07:53 +0000 (UTC)
Date:   Fri, 16 Oct 2020 14:07:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Message-ID: <20201016120749.GG22589@dhcp22.suse.cz>
References: <20201016033952.1924-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016033952.1924-1-tian.xianting@h3c.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16-10-20 11:39:52, Xianting Tian wrote:
> In shrink_slab(), it directly goes to 'out' label only when it
> can't get the lock of shrinker_rwsew. In this case, it doesn't
> do the real work of shrinking slab, so we don't need trigger a
> reschedule by cond_resched().

Your changelog doesn't explain why this is not needed or undesirable. Do
you see any actual problem?

The point of this code is to provide a deterministic scheduling point
regardless of the shrinker_rwsew.

> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  mm/vmscan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 466fc3144..676e97b28 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -687,8 +687,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
>  	}
>  
>  	up_read(&shrinker_rwsem);
> -out:
> +
>  	cond_resched();
> +out:
>  	return freed;
>  }
>  
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
