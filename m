Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D162D1E73
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgLGXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:39:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727370AbgLGXjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:39:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38B8123998;
        Mon,  7 Dec 2020 23:38:44 +0000 (UTC)
Date:   Mon, 7 Dec 2020 18:38:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: Ftrace startup test and boot-time tracing
Message-ID: <20201207183842.5374eed6@gandalf.local.home>
In-Reply-To: <20201208082649.93bdd57eb397296c81baf64c@kernel.org>
References: <20201207230259.250ecc2a52281def3f8335f4@kernel.org>
        <20201207152540.2d569a36@gandalf.local.home>
        <20201208082649.93bdd57eb397296c81baf64c@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 08:26:49 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Steve,
> 
> On Mon, 7 Dec 2020 15:25:40 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 7 Dec 2020 23:02:59 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > There will be the 2 options, one is to change kconfig so that user can not
> > > select FTRACE_STARTUP_TEST if BOOTTIME_TRACING=y, another is to provide
> > > a flag from trace_boot and all tests checks the flag at runtime.
> > > (moreover, that flag will be good to be set from other command-line options)
> > > What would you think?  
> > 
> > Yeah, a "disable_ftrace_startup_tests" flag should be implemented. And
> > something that could also be on the kernel command line itself :-)
> > 
> >  "disabe_ftrace_startup_tests"
> > 
> > Sometimes when debugging something, I don't want the tests running, even
> > though the config has them, and I don't want to change the config.  
> 
> OK, BTW, I found tracing_selftest_disabled, it seemed what we need.
> 

Yeah, I thought we had something like this. It's getting hard to keep track
of ;-)

-- Steve
