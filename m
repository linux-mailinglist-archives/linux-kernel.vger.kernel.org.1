Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0511B2A90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgDUO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbgDUO7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:59:51 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B192068F;
        Tue, 21 Apr 2020 14:59:50 +0000 (UTC)
Date:   Tue, 21 Apr 2020 10:59:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
Message-ID: <20200421105948.4f5a36f5@gandalf.local.home>
In-Reply-To: <20200421130755.18370-1-longman@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 09:07:55 -0400
Waiman Long <longman@redhat.com> wrote:

> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index 7ecaa65b7106..c2f580fd371b 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -130,7 +130,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
>  
>  TRACE_EVENT(iocost_ioc_vrate_adj,
>  
> -	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 (*missed_ppm)[2],
> +	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
>  		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
>  		int nr_surpluses),
>  
> @@ -155,8 +155,8 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
>  		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
>  		__entry->new_vrate = new_vrate;
>  		__entry->busy_level = ioc->busy_level;
> -		__entry->read_missed_ppm = (*missed_ppm)[READ];
> -		__entry->write_missed_ppm = (*missed_ppm)[WRITE];
> +		__entry->read_missed_ppm = missed_ppm[READ];
> +		__entry->write_missed_ppm = missed_ppm[WRITE];
>  		__entry->rq_wait_pct = rq_wait_pct;
>  		__entry->nr_lagging = nr_lagging;
>  		__entry->nr_shortages = nr_shortages;

Regardless if this helps systemtap or not, I like the patch because the
current code is rather ugly, and this patch makes it more readable.

Suggestion: change the topic to remove systemtap, as that's not going to be
the true reason for acceptance of this patch. It should just be about
cleaning up the trace event itself.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
