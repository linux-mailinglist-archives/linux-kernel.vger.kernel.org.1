Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829542A0A16
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgJ3Pmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:42:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37285 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgJ3Pmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604072552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fOKOxoysO3IM/w6PSj+eBBbx1khdElITpnmLIcXMry0=;
        b=FCh+ow15+c0KHnYpXPd5exiur64L8Gebjm1Neli3LLktQRvvAyw7eGlQqedJq1gI8TWT0+
        yUTGNYzUbIdxoS9k/hPHCv1kXdH3nMmCteRFu1EAtG3fEAr9nw8GXHNcZk0c9aOrIc5RK8
        LcVSee7U8XoUosDfdX2Y+FgfuUhGr7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-KCDb9ZJPNKGgyvAYSFNwsw-1; Fri, 30 Oct 2020 11:42:28 -0400
X-MC-Unique: KCDb9ZJPNKGgyvAYSFNwsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 468AF8F62C1;
        Fri, 30 Oct 2020 15:42:26 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-113-38.phx2.redhat.com [10.3.113.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0807B672C0;
        Fri, 30 Oct 2020 15:42:17 +0000 (UTC)
Date:   Fri, 30 Oct 2020 11:42:16 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Hui Su <sh_def@163.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: remove the spin_lock operations
Message-ID: <20201030154216.GA142259@lorien.usersys.redhat.com>
References: <20201030144621.GA96974@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030144621.GA96974@rlk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:46:21PM +0800 Hui Su wrote:
> Since 'ab93a4bc955b ("sched/fair: Remove
> distribute_running fromCFS bandwidth")',there is
> nothing to protect between raw_spin_lock_irqsave/store()
> in do_sched_cfs_slack_timer().
> 
> So remove it.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/fair.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..5ecbf5e63198 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5105,9 +5105,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  		return;
>  
>  	distribute_cfs_runtime(cfs_b);
> -
> -	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
>  
>  /*
> -- 
> 2.29.0
> 
> 

Nice :)

Reviewed-by: Phil Auld <pauld@redhat.com>
-- 

