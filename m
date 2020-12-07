Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55442D16C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgLGQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgLGQrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:47:53 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0BFD23877;
        Mon,  7 Dec 2020 16:47:12 +0000 (UTC)
Date:   Mon, 7 Dec 2020 11:47:11 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: tracer_init_tracefs really slow
Message-ID: <20201207114711.0748b19c@gandalf.local.home>
In-Reply-To: <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
        <20201203211854.7e5caa49@oasis.local.home>
        <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 17:24:58 +0100
Lucas Stach <l.stach@pengutronix.de> wrote:

> > We could make a thread that does this, that the init wakes up and runs,
> > letting the kernel to move forward. Would you like to make that patch
> > or shall I?  
> 
> I guess you are much more likely to come up with a correct patch, as
> I'm not really clear yet on when we would need to synchronize this
> thread, to make sure things are available before they get used by
> something. I likely won't have time in the near future to read enough
> code in this particular spot of the kernel.

No problem. I've just been told to try to delegate when I can ;-)

> 
> I would be happy to test a patch on our whimpy machines, though. :)

The code is only needed for user space, and we can make it a separate
thread to do the work to let kernel move forward. The code is wrapped with
a mutex so that even if it's still processing when user space is up and
running, and it tries to access the code, it should block until it's
finished as well.

I'll write something up and send it to you.

Thanks for the report!

-- Steve
