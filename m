Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CA2280DF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgJBHRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:17:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:57854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBHRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:17:08 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF5FF206B2;
        Fri,  2 Oct 2020 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601623027;
        bh=VKNPJL2bzFQr7IJTImeYEGk60ykcZAwXa6OGA3vrbfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHVwk1WBgCO5yj+pxZbKc1aPpUuioNEi4A07Nehen5d0kGzPu6f8GJW2Mdjg7isBt
         al3Sc1SPhW60rklF4P07uOxwULmV6nYkmI6hHo3koAvM8nhymgE5DkEI6jPQ73hQrv
         eKyZLqz0uRyKErzBPTcfieFqlmTW0DTMD0ooqwYU=
Date:   Fri, 2 Oct 2020 16:17:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tracing: Add support for dynamic strings to
 synthetic events
Message-Id: <20201002161703.3961a96e84314fe31157f308@kernel.org>
In-Reply-To: <86c164d6476fd1fa9595ec79634b15c25f59e5b0.1601490263.git.zanussi@kernel.org>
References: <cover.1601490263.git.zanussi@kernel.org>
        <86c164d6476fd1fa9595ec79634b15c25f59e5b0.1601490263.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 30 Sep 2020 13:40:52 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Currently, sythetic events only support static string fields such as:
> 
>   # echo 'test_latency u64 lat; char somename[32]' > /sys/kernel/debug/tracing/synthetic_events
> 
> Which is fine, but wastes a lot of space in the event.
> 
> It also prevents the most commonly-defined strings in the existing
> trace events e.g. those defined using __string(), from being passed to
> synthetic events via the trace() action.
> 
> With this change, synthetic events with dynamic fields can be defined:
> 
>   # echo 'test_latency u64 lat; char somename[]' > /sys/kernel/debug/tracing/synthetic_events

Could you add a testcase (and update existing one) of ftracetest
for this new feature too?

> 
> And the trace() action can be used to generate events using either
> dynamic or static strings:
> 
>   # echo 'hist:keys=name:lat=common_timestamp.usecs-$ts0:onmatch(sys.event).test_latency($lat,name)' > /sys/kernel/debug/tracing/events
> 
> The synthetic event dynamic strings are implemented in the same way as
> the existing __data_loc strings and appear as such in the format file.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  Documentation/trace/events.rst      |  15 +-
>  Documentation/trace/histogram.rst   |  18 +++
>  kernel/trace/synth_event_gen_test.c |  18 ++-
>  kernel/trace/trace_events_hist.c    |   9 ++
>  kernel/trace/trace_events_synth.c   | 239 ++++++++++++++++++++++++----
>  kernel/trace/trace_synth.h          |   4 +

And you might also need to update tracefs/README so that user
can check whether the kernel supports dynamic string or not.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
