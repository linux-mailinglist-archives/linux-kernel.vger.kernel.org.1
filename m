Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15C22C5BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 19:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404986AbgKZS0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 13:26:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:60208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404937AbgKZS0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 13:26:17 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 305F6206B7;
        Thu, 26 Nov 2020 18:26:16 +0000 (UTC)
Date:   Thu, 26 Nov 2020 13:26:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "J. Avila" <elavila@google.com>, mingo@redhat.com,
        john.stultz@linaro.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: Potential Issue in Tracing Ring Buffer
Message-ID: <20201126132613.7f737afe@oasis.local.home>
In-Reply-To: <X79CrSX1rnpnbqPd@kroah.com>
References: <20201124223917.795844-1-elavila@google.com>
        <X79CrSX1rnpnbqPd@kroah.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 06:52:45 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Nov 24, 2020 at 10:39:17PM +0000, J. Avila wrote:
> > Hello,
> > 
> > In the ftrace logs we've collected internally, we have found that there are
> > situations where time seems to go backwards; this breaks userspace tools which
> > expect time to always go forward in these logs. For example, in this snippet
> > from a db845c running a 5.10-rc4 kernel[1] (thanks for getting us the trace,
> > John!), we see:  
> 
> Does the patch at:
> 	https://lore.kernel.org/r/20201125225654.1618966-1-minchan@kernel.org
> 
> resolve this issue for you?
> 

I think I found the bug. Can you apply this patch and let me know if it
fixes the issue for you?

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dc83b3fa9fe7..bccaf88d3706 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3291,7 +3291,7 @@ __rb_reserve_next(struct ring_buffer_per_cpu *cpu_buffer,
 			/* Nothing came after this event between C and E */
 			info->delta = ts - info->after;
 			(void)rb_time_cmpxchg(&cpu_buffer->write_stamp,
-					      info->after, info->ts);
+					      info->after, ts);
 			info->ts = ts;
 		} else {
 			/*

