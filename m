Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171B628F649
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389163AbgJOQBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 12:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388854AbgJOQBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:01:00 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24F8321D41;
        Thu, 15 Oct 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602777660;
        bh=FWKFAhhiyNzkQFk0igN/uJKRw3eBn7twIH7wYE7Hpi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tZXtwqelGV5/sXQMx7Mx/MwKJDWExMfcPK229dz97p0KqaTS/7fLbkrw2m5U1FZzH
         ZXcRso8dTvuEQRgpg70waqjSqlcDttoHx7KVm59DX1kjoSCjVo0I24faYBKO2iPUHC
         IbjX0jLMeJk9/eCSxiTEppKbAPZVaAYnSmaLQ8jc=
Date:   Fri, 16 Oct 2020 01:00:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v3 0/3] tracing: Show real address instead of hashed
 pointer
Message-Id: <20201016010057.ad0cbfaf4892fa26d34e8ff2@kernel.org>
In-Reply-To: <20201015114931.1c9803ae@gandalf.local.home>
References: <160277369795.29307.6792451054602907237.stgit@devnote2>
        <20201015114931.1c9803ae@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:49:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 15 Oct 2020 23:54:58 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi,
> > 
> > Here is the 3rd version of the series for real address printing in trace log.
> > 
> > Here is the previous version, I've fixed [1/3] to use krealloc(), fix memory
> > allocation error check and add __printf() attribute, according to Steve's
> > comment.
> > 
> > https://lore.kernel.org/lkml/160275239876.115066.10891356497426857018.stgit@devnote2/
> > 
> > 
> > Since trace_seq_printf() use in-kernel vsprintf() at last, the %p is always
> > converted to the hash value instead of real address.
> > 
> > For the dmesg it maybe secure, but for the ftrace, I think it is
> > meaningless because
> > 
> > - tracefs is used by root user, so no need to hide it.
> > - tracefs user can access percpu/cpu*/trace_pipe_raw which stores real
> >   address on the trace buffer.
> > - external commands like perf doesn't convert to the hash value.
> > 
> > And when debugging kernel, we would like to know real address which tells
> > us the address is in which area in the kernel by comparing with kernel
> > memory mapping.
> > 
> > However, to compare the trace log with dmesg, we also need a bridging
> > information. So 3/3 gives the options/hash-ptr knob which switches
> > the output format.
> > 
> 
> Thanks Masami,
> 
> I'm going to hold off on adding this for this merge window, and look at
> applying it for the next window.

Thank you very much!
I got it, anyway I can use kernelshark or perf script to decode raw event
data, or I will use kprobe event to fetch the real address :)

-- 
Masami Hiramatsu <mhiramat@kernel.org>
