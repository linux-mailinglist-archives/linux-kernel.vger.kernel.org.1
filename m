Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD52D1A7A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 21:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgLGU0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 15:26:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLGU0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 15:26:22 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA5A523406;
        Mon,  7 Dec 2020 20:25:41 +0000 (UTC)
Date:   Mon, 7 Dec 2020 15:25:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: Ftrace startup test and boot-time tracing
Message-ID: <20201207152540.2d569a36@gandalf.local.home>
In-Reply-To: <20201207230259.250ecc2a52281def3f8335f4@kernel.org>
References: <20201207230259.250ecc2a52281def3f8335f4@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 23:02:59 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> There will be the 2 options, one is to change kconfig so that user can not
> select FTRACE_STARTUP_TEST if BOOTTIME_TRACING=y, another is to provide
> a flag from trace_boot and all tests checks the flag at runtime.
> (moreover, that flag will be good to be set from other command-line options)
> What would you think?

Yeah, a "disable_ftrace_startup_tests" flag should be implemented. And
something that could also be on the kernel command line itself :-)

 "disabe_ftrace_startup_tests"

Sometimes when debugging something, I don't want the tests running, even
though the config has them, and I don't want to change the config.

-- Steve
