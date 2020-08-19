Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1649B24927B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 03:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHSBkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 21:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgHSBkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:40:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC3E20657;
        Wed, 19 Aug 2020 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597801236;
        bh=mV68+4Pd6yCvEKHkuHjpTE4a0Mc6MZs8y2WBZe4O2os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r1zPxyH2TFURT8AISrODsgAqDEGPOgYNhZQKoXmZoix5XSKNX1TMG54xeNkaTHJwl
         x1OlPuQGE3IbdW4rHA29NUHHgyoImOM8Err6aV4f7/OFn8kqGweDNk58q8KOW+XjwE
         ZWLG7G5ytzom5QNx9MZXQ58D/bQodaTMj7OMxsF8=
Date:   Tue, 18 Aug 2020 18:40:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: [PATCH] hugetlb_cgroup: convert comma to semicolon
Message-Id: <20200818184036.d6c479446b2c3b231d1e3bff@linux-foundation.org>
In-Reply-To: <20200818064333.21759-1-vulab@iscas.ac.cn>
References: <20200818064333.21759-1-vulab@iscas.ac.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 06:43:33 +0000 Xu Wang <vulab@iscas.ac.cn> wrote:

> Replace a comma between expression statements by a semicolon.
> 
> ...
>
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -655,7 +655,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>  	cft->seq_show = hugetlb_events_show;
> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]),
> +	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
>  
>  	/* Add the events.local file */
> @@ -664,7 +664,7 @@ static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>  	cft->private = MEMFILE_PRIVATE(idx, 0);
>  	cft->seq_show = hugetlb_events_local_show;
>  	cft->file_offset = offsetof(struct hugetlb_cgroup,
> -				    events_local_file[idx]),
> +				    events_local_file[idx]);
>  	cft->flags = CFTYPE_NOT_ON_ROOT;
>  
>  	/* NULL terminate the last cft */

Fixes: faced7e0806cf4 ("mm: hugetlb controller for cgroups v2")

Wow, why does this code even work.  Presumably the initial value of
cft->file_offset simply doesn't matter.  Giuseppe, could you please
check?  We might have some unneeded code in there.
