Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D232D4694
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 17:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgLIQSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 11:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgLIQSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 11:18:21 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4134D23C2D;
        Wed,  9 Dec 2020 16:17:40 +0000 (UTC)
Date:   Wed, 9 Dec 2020 11:17:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: tracer_init_tracefs really slow
Message-ID: <20201209111738.73944eac@gandalf.local.home>
In-Reply-To: <a7549324e3dcbacf2b52f8260fdf3a9a98e6171e.camel@pengutronix.de>
References: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
        <20201203211854.7e5caa49@oasis.local.home>
        <31a0d6b7cf7326e7e2f55ab2b668defb0c10b140.camel@pengutronix.de>
        <20201207144713.1b19afe2@gandalf.local.home>
        <a7549324e3dcbacf2b52f8260fdf3a9a98e6171e.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Dec 2020 15:38:50 +0100
Lucas Stach <l.stach@pengutronix.de> wrote:

> -	trace_eval_init();
> -
> ... and this. Moving the trace_eval_init into its own initcall means it
> gets started before tracer_init_tracefs. As it holds the
> trace_event_sem while updating the eval maps, event_trace_init() then
> blocks further initcall execution when it tries to grab this semaphore
> a bit down the line, killing the parallelism we are trying to unlock
> here.
> 
> With those 2 lines dropped, the change seems to work as intended and
> shaves ~830ms from the kernel boot time on this system.

Ah, the rationale to do that was so that it could start parsing earlier.
But you are right, if it's really slow, and is still parsing by the time we
start populating the tracefs directory, it will then cause that to block as
well.

OK, I wont move it into its own initcall and send a v2.

-- Steve
