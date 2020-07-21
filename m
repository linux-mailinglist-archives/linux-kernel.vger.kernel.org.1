Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AB22287CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 19:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGURzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 13:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGURzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:55:17 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D856020717;
        Tue, 21 Jul 2020 17:55:16 +0000 (UTC)
Date:   Tue, 21 Jul 2020 13:55:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] stm class: ftrace: use different channel accroding
 to CPU
Message-ID: <20200721135515.21a9b216@oasis.local.home>
In-Reply-To: <20200720022117.9375-5-tingwei@codeaurora.org>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
        <20200720022117.9375-5-tingwei@codeaurora.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 10:21:17 +0800
Tingwei Zhang <tingwei@codeaurora.org> wrote:

> To avoid mixup of packets from differnt ftrace packets simultaneously,
> use different channel for packets from different CPU.
> 
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  drivers/hwtracing/stm/ftrace.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/stm/ftrace.c b/drivers/hwtracing/stm/ftrace.c
> index ce868e095410..6c3bce11c8d3 100644
> --- a/drivers/hwtracing/stm/ftrace.c
> +++ b/drivers/hwtracing/stm/ftrace.c
> @@ -10,7 +10,7 @@
>  #include <linux/stm.h>
>  #include <linux/trace.h>
>  
> -#define STM_FTRACE_NR_CHANNELS 1
> +#define STM_FTRACE_NR_CHANNELS NR_CPUS

I would make this dynamic. If this causes any kind of allocation, you
do not want NR_CPUS. That's hardcoded by the distribution and is the
max number of CPUs. With machines with hundreds of CPUs today, that
could easily be 256 or 512 or more.

Instead, in the stm_ftrace_init() I would just assign it to
nr_online_cpus().

	stm_ftrace.data.nr_chans = nr_online_cpus();

Or nr_possible_cpus().

-- Steve


>  #define STM_FTRACE_CHAN 0
>  
>  static int stm_ftrace_link(struct stm_source_data *data);
> @@ -37,8 +37,9 @@ static void notrace
>  stm_ftrace_write(struct trace_export *export, const void *buf, unsigned int len)
>  {
>  	struct stm_ftrace *stm = container_of(export, struct stm_ftrace, ftrace);
> +	unsigned int cpu = smp_processor_id();
>  
> -	stm_source_write(&stm->data, STM_FTRACE_CHAN, buf, len);
> +	stm_source_write(&stm->data, STM_FTRACE_CHAN + cpu, buf, len);
>  }
>  
>  static int stm_ftrace_link(struct stm_source_data *data)

