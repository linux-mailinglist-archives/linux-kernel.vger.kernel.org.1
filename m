Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9D5286C0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 02:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgJHAVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 20:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgJHAVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 20:21:09 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C1B02076B;
        Thu,  8 Oct 2020 00:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602116468;
        bh=GE1GIK+aJj6I39ugfiGVlewjavshzVGd/3dwngROgH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSAHV7feF8WfikLQKnhlPtnCfIcWk0gbBCSTyAxHfQkx8OE+aAecCl7tdjHGdge5M
         D6/VGBTzBdQY8rATuT72l9Myqt0ytabwNpnNSp2XrU6HfL0BeeHxQVXZybDFyK0ctX
         oLI4S/clE9MrMVd/zHLfIP+7xyY/pLLiFVFMDdRQ=
Date:   Thu, 8 Oct 2020 09:21:05 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, axelrasmussen@google.com, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/7] selftests/ftrace: Add test case for synthetic
 event dynamic strings
Message-Id: <20201008092105.ee97e88f31e1629cec2957ef@kernel.org>
In-Reply-To: <74445afb005046d76d59fb06696a2ceaa164dec9.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
        <74445afb005046d76d59fb06696a2ceaa164dec9.1601848695.git.zanussi@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Oct 2020 17:14:08 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> Add a selftest that defines and traces a synthetic event that uses a
> dynamic string event field.
> 
> Signed-off-by: Tom Zanussi <zanussi@kernel.org>

This looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!
> ---
>  .../trigger-synthetic-event-dynstring.tc      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> new file mode 100644
> index 000000000000..3d65c856eca3
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# description: event trigger - test inter-event histogram trigger trace action with dynamic string param
> +# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README
> +
> +fail() { #msg
> +    echo $1
> +    exit_fail
> +}
> +
> +echo "Test create synthetic event"
> +
> +echo 'ping_test_latency u64 lat; char filename[]' > synthetic_events
> +if [ ! -d events/synthetic/ping_test_latency ]; then
> +    fail "Failed to create ping_test_latency synthetic event"
> +fi
> +
> +echo "Test create histogram for synthetic event using trace action and dynamic strings"
> +echo "Test histogram dynamic string variables,simple expression support and trace action"
> +
> +echo 'hist:key=pid:filenamevar=filename:ts0=common_timestamp.usecs' > events/sched/sched_process_exec/trigger
> +echo 'hist:key=pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_process_exec).ping_test_latency($lat,$filenamevar) if comm == "ping"' > events/sched/sched_process_exit/trigger
> +echo 'hist:keys=filename,lat:sort=filename,lat' > events/synthetic/ping_test_latency/trigger
> +
> +ping $LOCALHOST -c 5
> +
> +if ! grep -q "ping" events/synthetic/ping_test_latency/hist; then
> +    fail "Failed to create dynamic string trace action inter-event histogram"
> +fi
> +
> +exit 0
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
