Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2A27EA67
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 15:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgI3N5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 09:57:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:60312 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730304AbgI3N5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 09:57:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601474239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60/DuYzuTuu/RoGHpnTicjya4jLSFnDAPXQjHEwUDFQ=;
        b=YtfW45QdidqHBbd17iP9wT7uGPvIRxr/c0yC65aXrvoGRW7/BD7fVlpWy2HKlodtox1A7F
        z5LGkoyKJm8mWG7Ah5ML4FZ7XnA9SUAvddM1zO1a4uVEgqZiPYCowhrZkf0Fwo6QCOehcB
        gN+JEBVRMTsK/G6Mz0hlb8/qlrkW6vc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82DDDAC8B;
        Wed, 30 Sep 2020 13:57:19 +0000 (UTC)
Date:   Wed, 30 Sep 2020 15:57:18 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Prasad Sodagudi <psodagud@codeaurora.org>
Cc:     rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tkjos@google.com,
        Mohammed Khajapasha <mkhaja@codeaurora.org>
Subject: Re: [PATCH 2/2] printk: Make the console flush configurable in
 hotplug path
Message-ID: <20200930135718.GI29288@alley>
References: <1600906112-126722-1-git-send-email-psodagud@codeaurora.org>
 <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600906112-126722-2-git-send-email-psodagud@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-23 17:08:32, Prasad Sodagudi wrote:
> From: Mohammed Khajapasha <mkhaja@codeaurora.org>
> 
> The thread which initiates the hot plug can get scheduled
> out, while trying to acquire the console lock,
> thus increasing the hot plug latency. This option
> allows to selectively disable the console flush and
> in turn reduce the hot plug latency.
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9b75f6b..f02d3ef 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2996,13 +3000,15 @@ static int __init printk_late_init(void)
>  			unregister_console(con);
>  		}
>  	}
> +#ifdef CONFIG_CONSOLE_FLUSH_ON_HOTPLUG
>  	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
>  					console_cpu_notify);
>  	WARN_ON(ret < 0);
>  	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
>  					console_cpu_notify, NULL);
>  	WARN_ON(ret < 0);
> -	return 0;
> +#endif
> +	return ret;

Just a comment from the printk-side view. This change is wrong, definitely.

The above calls are needed with the current printk() design. They make
sure that someone would actually push the messages to the console.
Otherwise they might stay hidden seconds/minutes/hour/days until
another random printk() does the job.

They will not be needed with the ongoing printk rework[1] where
the consoles will get handled by a dedicated kthread.

[1] https://lore.kernel.org/lkml/87k1acz5rx.fsf@linutronix.de/

Best Regards,
Petr
