Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB528CEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387582AbgJMNFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387449AbgJMNFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:05:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC19922B2D;
        Tue, 13 Oct 2020 13:05:13 +0000 (UTC)
Date:   Tue, 13 Oct 2020 09:05:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: add tgid into common field
Message-ID: <20201013090511.1f2f71f6@gandalf.local.home>
In-Reply-To: <20201013055454.52634-1-laoar.shao@gmail.com>
References: <20201013055454.52634-1-laoar.shao@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Oct 2020 13:54:54 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -67,6 +67,7 @@ struct trace_entry {
>  	unsigned char		flags;
>  	unsigned char		preempt_count;
>  	int			pid;
> +	int			tgid;
>  };
>  

Sorry, this adds another 4 bytes to *every* event, if you want it to or
not. I'd rather have some ways to remove fields from this header, and not
add more to it.

I can't take this patch.

-- Steve
