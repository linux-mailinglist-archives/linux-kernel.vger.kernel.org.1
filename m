Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F2128E366
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgJNPi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgJNPi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:38:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DBE2222A;
        Wed, 14 Oct 2020 15:38:25 +0000 (UTC)
Date:   Wed, 14 Oct 2020 11:38:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Add rb_check_bpage in __rb_allocate_pages
Message-ID: <20201014113823.4296521d@gandalf.local.home>
In-Reply-To: <20201014151614.29804-1-hqjagain@gmail.com>
References: <20201014151614.29804-1-hqjagain@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 23:16:14 +0800
Qiujun Huang <hqjagain@gmail.com> wrote:

> It may be better to check each page is aligned by 4 bytes. The 2
> least significant bits of the address will be used as flags.
> 
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 93ef0ab6ea20..9dec7d58b177 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1420,7 +1420,8 @@ static int rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
>  	return 0;
>  }
>  
> -static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
> +static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
> +		long nr_pages, struct list_head *pages, int cpu)
>  {
>  	struct buffer_page *bpage, *tmp;
>  	bool user_thread = current->mm != NULL;
> @@ -1464,6 +1465,8 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
>  		if (!bpage)
>  			goto free_pages;
>  
> +		rb_check_bpage(cpu_buffer, bpage);
> +
>  

Why add it here, and not just add this check to the scan in
rb_check_pages()?

-- Steve
