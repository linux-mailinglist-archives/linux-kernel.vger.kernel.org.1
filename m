Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9AC28A319
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390702AbgJJW63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbgJJTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:53:14 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E618221E9;
        Sat, 10 Oct 2020 14:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602340992;
        bh=GWFhMPGzdDt2r4FY4tLJKaBiauA0MwBtH4ivN0f+JYw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pqvs3LO3urnFDlsoMkBHc/UXx6qfTsXhgrEV53wTDUCSG5e+UQdGosC45zyZipJxp
         mX1KvjXeGT7gr60SoD7kuA7NbdqM5cXujkSCqWrjpgCYtVBXVYSk1pWWJJMesn6J5U
         2de1t4kACkM9ZhpHcyC9v5YM6XOnk8c1IkQLHRyw=
Date:   Sat, 10 Oct 2020 23:43:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] selftests/ftrace: Change synthetic event name for
 inter-event-combined test
Message-Id: <20201010234308.a4e4181beb90f7c7fe7221db@kernel.org>
In-Reply-To: <58a991068a6fb8c03aa0755dfd72c9b8e83ee536.1602255803.git.zanussi@kernel.org>
References: <cover.1602255803.git.zanussi@kernel.org>
        <58a991068a6fb8c03aa0755dfd72c9b8e83ee536.1602255803.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Oct 2020 10:17:11 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> This test uses waking+wakeup_latency as an event name, which doesn't
> make sense since it includes an operator.  Illegal names are now
> detected by the synthetic event command parsing, which causes this
> test to fail.  Change the name to 'waking_plus_wakeup_latency' to
> prevent this.

Good catch!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

> 
> Fixes: f06eec4d0f2c (selftests: ftrace: Add inter-event hist triggers testcases)
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>
> ---
>  .../inter-event/trigger-inter-event-combined-hist.tc      | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> index 7449a4b8f1f9..9098f1e7433f 100644
> --- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
> @@ -25,12 +25,12 @@ echo 'wakeup_latency u64 lat pid_t pid' >> synthetic_events
>  echo 'hist:keys=pid:ts1=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger
>  echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts1:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) if next_comm=="ping"' > events/sched/sched_switch/trigger
>  
> -echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
> -echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
> -echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
> +echo 'waking_plus_wakeup_latency u64 lat; pid_t pid' >> synthetic_events
> +echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking_plus_wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
> +echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking_plus_wakeup_latency/trigger
>  
>  ping $LOCALHOST -c 3
> -if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
> +if ! grep -q "pid:" events/synthetic/waking_plus_wakeup_latency/hist; then
>      fail "Failed to create combined histogram"
>  fi
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
