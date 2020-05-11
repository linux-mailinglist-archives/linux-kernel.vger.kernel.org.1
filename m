Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C361CE5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbgEKUkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 16:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729842AbgEKUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:40:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F77B20661;
        Mon, 11 May 2020 20:40:21 +0000 (UTC)
Date:   Mon, 11 May 2020 16:40:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <mingo@redhat.com>, <tj@kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangle6@huawei.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] trace: Remove duplicate semicolons at the end of line
Message-ID: <20200511164019.354a6d60@gandalf.local.home>
In-Reply-To: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
References: <1589196062-84310-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 19:21:02 +0800
Xiaoming Ni <nixiaoming@huawei.com> wrote:

> Remove duplicate semicolons at the end of line in
> include/trace/events/iocost.h

This looks like it should go through Jens's tree.

-- Steve

> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  include/trace/events/iocost.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
> index 7ecaa65b..91297eb 100644
> --- a/include/trace/events/iocost.h
> +++ b/include/trace/events/iocost.h
> @@ -152,7 +152,7 @@
>  
>  	TP_fast_assign(
>  		__assign_str(devname, ioc_name(ioc));
> -		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
> +		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
>  		__entry->new_vrate = new_vrate;
>  		__entry->busy_level = ioc->busy_level;
>  		__entry->read_missed_ppm = (*missed_ppm)[READ];

