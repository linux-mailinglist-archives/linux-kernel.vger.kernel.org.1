Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AFE28BB07
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbgJLOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388646AbgJLOpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:45:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB7ED20776;
        Mon, 12 Oct 2020 14:45:10 +0000 (UTC)
Date:   Mon, 12 Oct 2020 10:45:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] trace: Return ENOTCONN instead of EBADF
Message-ID: <20201012104509.6ae404d5@gandalf.local.home>
In-Reply-To: <55b99d8d-f75a-e095-63fa-3d5df8b77f1b@sony.com>
References: <20201012082642.1394-1-peter.enderborg@sony.com>
        <20201012095324.78996fd2@gandalf.local.home>
        <55b99d8d-f75a-e095-63fa-3d5df8b77f1b@sony.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Oct 2020 14:26:48 +0000
"Enderborg, Peter" <Peter.Enderborg@sony.com> wrote:

> On 10/12/20 3:53 PM, Steven Rostedt wrote:
> > On Mon, 12 Oct 2020 10:26:42 +0200
> > Peter Enderborg <peter.enderborg@sony.com> wrote:
> >  
> >> When there is no clients listening on event the trace return
> >> EBADF. The file is not a bad file descriptor and to get the
> >> userspace able to do a proper error handling it need a different
> >> error code that separate a bad file descriptor from a empty listening.  
> > I have no problem with this patch, but your description is incorrect. And
> > before making this change, I want to make sure that what you think is
> > happening is actually happening.
> >
> > This has nothing to do with "clients listening". This happens when the ring
> > buffer is disabled for some reason. The most likely case of this happening
> > is if someone sets /sys/kernel/tracing/tracing_on to zero.  
> 
> I see that as no one is listening. You start to listen by setting this tracing on
> some instance, but that is for trace_pipe. Is it the same flag for raw access and all ways you
> can invoke a trace?

I don't know what you mean by "setting this tracing on some instance".

When you boot up, who is listening? tracing_on is enabled. But there's no
listener.


> 
> Would
> 
> "When there is no instances listening on events the trace return

What instance are you talking about? What do you think needs to be
listening. And no, trace_pipe plays zero role in this.

> EBADF, it is when the tracing_on is off globally. The file is not a bad file
> descriptor and to get the userspace able to do a proper error handling it need a different
> error code that separate a bad file descriptor from a empty listening."
> 
> be a ok?
> 

No. Because I don't understand any of the above!

There's no a producer / consumer here. It's a read / write enabled or
disabled. If the ring buffer is disabled from write, and you try to write
to the ring buffer, you get an error.

Basically, it's the same analogy as trying to write to a read-only file.
Perhaps the proper error is EPERM.

-- Steve
