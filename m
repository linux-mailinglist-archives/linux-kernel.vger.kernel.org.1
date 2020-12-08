Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851532D1EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgLHARN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Dec 2020 19:17:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbgLHARN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:17:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84F6323A04;
        Tue,  8 Dec 2020 00:16:32 +0000 (UTC)
Date:   Mon, 7 Dec 2020 19:16:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracing: Rework synthetic event command parsing
Message-ID: <20201207191630.1d644037@gandalf.local.home>
In-Reply-To: <dcfa0a4cfdc05824cfd89227f635071c60113992.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
        <dcfa0a4cfdc05824cfd89227f635071c60113992.1603723933.git.zanussi@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 10:06:10 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Now that command parsing has been delegated to the create functions
> and we're no longer constrained by argv_split(), we can modify the
> synthetic event command parser to better match the higher-level
> structure of the synthetic event commands, which is basically an event
> name followed by a set of semicolon-separated fields.
> 
> Since we're also now passed the raw command, we can also save it
> directly and can get rid of save_cmdstr().
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
> 

This patch fails to build with:

  CC      kernel/trace/trace_events_synth.o
/work/git/linux-trace.git/kernel/trace/trace_events_synth.c: In function ‘create_or_delete_synth_event’:
/work/git/linux-trace.git/kernel/trace/trace_events_synth.c:1372:8: error: implicit declaration of function ‘check_command’ [-Werror=implicit-function-declaration]
 1372 |  ret = check_command(raw_command);
      |        ^~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:283: kernel/trace/trace_events_synth.o] Error 1
make[2]: *** [/work/git/linux-trace.git/scripts/Makefile.build:500: kernel/trace] Error 2
make[1]: *** [/work/git/linux-trace.git/Makefile:1799: kernel] Error 2
make[1]: Leaving directory '/work/git/nobackup/bxtest/trace'
make: *** [Makefile:185: __sub-make] Error 2

-- Steve
