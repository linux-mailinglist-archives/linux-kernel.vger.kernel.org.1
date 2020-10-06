Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EA5284E21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgJFOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:36:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgJFOgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:36:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F401204FD;
        Tue,  6 Oct 2020 14:36:39 +0000 (UTC)
Date:   Tue, 6 Oct 2020 10:36:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ftrace: define seq_file only for FMODE_READ
Message-ID: <20201006103638.153e39d3@gandalf.local.home>
In-Reply-To: <20200831031104.23322-2-richard.weiyang@linux.alibaba.com>
References: <20200831031104.23322-1-richard.weiyang@linux.alibaba.com>
        <20200831031104.23322-2-richard.weiyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 11:10:59 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> The purpose of the operation is to get ftrace_iterator, which is embedded
> in file or seq_file for FMODE_WRITE/FMODE_READ respectively. Since we
> don't have a seq_file for FMODE_WRITE case, it is meaningless to cast
> file->private_data to seq_file.
> 
> Let's move the definition when there is a valid seq_file.

I didn't pull in this patch because I find the original more expressive,
and there's really no benefit in changing it.

-- Steve


> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index edc233122598..12cb535769bc 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5558,7 +5558,6 @@ static void __init set_ftrace_early_filters(void)
>  
>  int ftrace_regex_release(struct inode *inode, struct file *file)
>  {
> -	struct seq_file *m = (struct seq_file *)file->private_data;
>  	struct ftrace_iterator *iter;
>  	struct ftrace_hash **orig_hash;
>  	struct trace_parser *parser;
> @@ -5566,6 +5565,7 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
>  	int ret;
>  
>  	if (file->f_mode & FMODE_READ) {
> +		struct seq_file *m = file->private_data;
>  		iter = m->private;
>  		seq_release(inode, file);
>  	} else

