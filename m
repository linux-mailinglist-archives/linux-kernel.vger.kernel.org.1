Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1568C2D3139
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 18:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbgLHRhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 12:37:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729585AbgLHRho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 12:37:44 -0500
Message-ID: <084304b37aadc6815836fff192b11e8c5dfa3705.camel@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607449024;
        bh=HrrJZmLb0KDAr7R5/mtl1VcdITtRUdq8cg5JLRw3psc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TPQwg0AOaFpbjGDmnD9HFfJombiRUfuOVaQ3OPxlRtRlEiXtHkgCJrW3ZpjrV/4ih
         PtsuPXi3Y7WbALBQCmpjCgwGzCHd81Q9ewuTBWluVlO/RGx1cBOmnhZ3PZrCKASWtI
         bUuQL/Hu94JmK4DrjsGC8gCskEkAYF/g6wqlQnqU6KkMl4xfx3tesVIWjWkFdNo4XU
         JmXUlGeRf22kvhaUrw35u+Y1ltWB2rUnnqX5qw/ik2Jkh+r5Pt+yjfFOJyWmKSuu/O
         AdbfyeDT8T1gmaHngkFJYaUeAFP/FapfHsN06jc1Wj0CgXDq22svfDNez5m+TyZ6sn
         SwBukSAsV00tw==
Subject: Re: [PATCH v3 2/5] tracing: Rework synthetic event command parsing
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 08 Dec 2020 11:37:02 -0600
In-Reply-To: <20201207191630.1d644037@gandalf.local.home>
References: <cover.1603723933.git.zanussi@kernel.org>
         <dcfa0a4cfdc05824cfd89227f635071c60113992.1603723933.git.zanussi@kernel.org>
         <20201207191630.1d644037@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, 2020-12-07 at 19:16 -0500, Steven Rostedt wrote:
> On Mon, 26 Oct 2020 10:06:10 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > Now that command parsing has been delegated to the create functions
> > and we're no longer constrained by argv_split(), we can modify the
> > synthetic event command parser to better match the higher-level
> > structure of the synthetic event commands, which is basically an
> > event
> > name followed by a set of semicolon-separated fields.
> > 
> > Since we're also now passed the raw command, we can also save it
> > directly and can get rid of save_cmdstr().
> > 
> > Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> > ---
> > 
> 
> This patch fails to build with:
> 
>   CC      kernel/trace/trace_events_synth.o
> /work/git/linux-trace.git/kernel/trace/trace_events_synth.c: In
> function ‘create_or_delete_synth_event’:
> /work/git/linux-trace.git/kernel/trace/trace_events_synth.c:1372:8:
> error: implicit declaration of function ‘check_command’ [-
> Werror=implicit-function-declaration]
>  1372 |  ret = check_command(raw_command);
>       |        ^~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [/work/git/linux-trace.git/scripts/Makefile.build:283:
> kernel/trace/trace_events_synth.o] Error 1
> make[2]: *** [/work/git/linux-trace.git/scripts/Makefile.build:500:
> kernel/trace] Error 2
> make[1]: *** [/work/git/linux-trace.git/Makefile:1799: kernel] Error
> 2
> make[1]: Leaving directory '/work/git/nobackup/bxtest/trace'
> make: *** [Makefile:185: __sub-make] Error 2
> 

Oops, yeah, a stray check_command() call got left behind in that patch
when refactoring, should be moved to the next patch.

Tom

> -- Steve

