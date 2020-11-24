Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CC72C2DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389939AbgKXRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbgKXRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:05:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3413206E5;
        Tue, 24 Nov 2020 17:05:25 +0000 (UTC)
Date:   Tue, 24 Nov 2020 12:05:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hui Su <sh_def@163.com>
Cc:     mingo@redhat.com, jack@suse.cz, akpm@linux-foundation.org,
        neilb@suse.de, tj@kernel.org, trond.myklebust@hammerspace.com,
        liuzhiqiang26@huawei.com, tytso@mit.edu, cai@lca.pw,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: fix potenial dangerous pointer
Message-ID: <20201124120523.34a59eed@gandalf.local.home>
In-Reply-To: <20201124165205.GA23937@rlk>
References: <20201124165205.GA23937@rlk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 00:52:05 +0800
Hui Su <sh_def@163.com> wrote:

> The bdi_dev_name() returns a char [64], and
> the __entry->name is a char [32].
> 
> It maybe dangerous to TP_printk("%s", __entry->name)
> after the strncpy().

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This should go through the tree that has the code that uses these
tracepoints.

-- Steve


> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  include/trace/events/writeback.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
> index e7cbccc7c14c..57d795365987 100644
> --- a/include/trace/events/writeback.h
> +++ b/include/trace/events/writeback.h
> @@ -190,7 +190,7 @@ TRACE_EVENT(inode_foreign_history,
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name, bdi_dev_name(inode_to_bdi(inode)), 32);
> +		strscpy_pad(__entry->name, bdi_dev_name(inode_to_bdi(inode)), 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
>  		__entry->history	= history;
> @@ -219,7 +219,7 @@ TRACE_EVENT(inode_switch_wbs,
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,	bdi_dev_name(old_wb->bdi), 32);
> +		strscpy_pad(__entry->name, bdi_dev_name(old_wb->bdi), 32);
>  		__entry->ino		= inode->i_ino;
>  		__entry->old_cgroup_ino	= __trace_wb_assign_cgroup(old_wb);
>  		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
> @@ -252,7 +252,7 @@ TRACE_EVENT(track_foreign_dirty,
>  		struct address_space *mapping = page_mapping(page);
>  		struct inode *inode = mapping ? mapping->host : NULL;
>  
> -		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
> +		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
>  		__entry->bdi_id		= wb->bdi->id;
>  		__entry->ino		= inode ? inode->i_ino : 0;
>  		__entry->memcg_id	= wb->memcg_css->id;
> @@ -285,7 +285,7 @@ TRACE_EVENT(flush_foreign,
>  	),
>  
>  	TP_fast_assign(
> -		strncpy(__entry->name,	bdi_dev_name(wb->bdi), 32);
> +		strscpy_pad(__entry->name, bdi_dev_name(wb->bdi), 32);
>  		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
>  		__entry->frn_bdi_id	= frn_bdi_id;
>  		__entry->frn_memcg_id	= frn_memcg_id;

