Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E2C29A54A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507370AbgJ0HLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:11:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:45468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390835AbgJ0HLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:11:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603782679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TIAyPb2p8Rh2k7GpnQ+U1wvxzHtS8MTGNR/Xg0UKe0w=;
        b=KJg7AB9quVfKq/r/7pck1uJr5k635JyDVgs+Vu5bGXyEyrQEGIw4WJHPnnxAXO6C+4z050
        dXWb4HlrOGAbhKrT2IZ7MI4o8bfA/drBPtA3Z90ORjOEIWo9t0GgHp2dKNYCHddhK2zh4L
        kcNiE9143R+FwXOkawYlHYqbOpdlk/4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 927F9AC83;
        Tue, 27 Oct 2020 07:11:19 +0000 (UTC)
Date:   Tue, 27 Oct 2020 08:11:18 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Hui Su <sh_def@163.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom_kill: fix the comment of is_dump_unreclaim_slabs()
Message-ID: <20201027071118.GM20500@dhcp22.suse.cz>
References: <20200926041526.GA179745@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926041526.GA179745@rlk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26-09-20 12:15:26, Hui Su wrote:
> fix the comment of is_dump_unreclaim_slabs(), it just check
> whether nr_unreclaimable slabs amount is greater than user
> memory.

The original comment is meant to say when the function should be used.
Your update makes the comment makes it a kerneldoc for an internal
function which on its own is not very useful. It is quite clear what
the function does. The intention is not clear anymore though.

If you find the comment confusing, however, then I would just propose either
dropping it altogether or rename it to should_dump_unreclaimable_slab.
Which is quite mouthful TBH.
 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  mm/oom_kill.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index e90f25d6385d..a4a47559abcd 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -168,9 +168,9 @@ static bool oom_unkillable_task(struct task_struct *p)
>  	return false;
>  }
>  
> -/*
> - * Print out unreclaimble slabs info when unreclaimable slabs amount is greater
> - * than all user memory (LRU pages)
> +/**
> + * Check whether unreclaimable slabs amount is greater than
> + * all user memory(LRU pages).
>   */
>  static bool is_dump_unreclaim_slabs(void)
>  {
> -- 
> 2.25.1
> 
> 

-- 
Michal Hocko
SUSE Labs
