Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0DC229A8D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732668AbgGVOtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 10:49:55 -0400
Received: from smtp1.axis.com ([195.60.68.17]:14468 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbgGVOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1497; q=dns/txt; s=axis-central1;
  t=1595429393; x=1626965393;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=baYZLtX3aKwOTSmhfy5KuJLM6gJoW1ANGxx/SmqyNeM=;
  b=V3gnVArd1m0aNyepSqn7Ey0d0PRqam8QQOllnszO43nPZug/MzR5Rskw
   wYM4t5UFnFMmAKg39rd/g8MiUt+m14D4bdXkKP2AaPDsk/SPcfHwNonIF
   MnfK3AzOV5dM4tk4g5gFvo1weodgRUMuIa2zq+NFHPAQoQlATsv61+oo0
   CFhlueCtdRRrCQlsIP+VVk9Giu5sbXqRTnULHIiwtgSZFuNaxtVSyDWlC
   ZcwbnqjZAYHTa0CfyKaYDT9EVnGBeHtIfBNeSh6U0w1no2XbDL8x/Y7EH
   Y95vN4L4sRkSWidzIPa81JsiT1zjE6jFSr9D1ty/Bdw5pkGwllfV02gRm
   w==;
IronPort-SDR: mbTTJiW2W07rlCfh+N3FwpryhyE49fPLBLEbRRDKrFN9xWDIL9d5SYwEzDGYo843hu+yRO09OZ
 4iaikNhwCBXuryiyAulLv211P85iWTszHr5xP86bH/zm+LhhivbpRQQ/9iKgRbH/21shZD6Ycu
 VLysSAqi/QGKM7J0sHYfAib2WYpqcHcMluQ/HgidsjoDLMi0uDFIq6I9QGj+qirIuok7ULCPrC
 dcp67YgMUEpa1rGY+iDxlaP7fGtvjWts72Re/IaE4YzuXWAsLFgaKGbhJJTS2zOR4Hv2INWakp
 HLw=
X-IronPort-AV: E=Sophos;i="5.75,383,1589234400"; 
   d="scan'208";a="11110818"
Date:   Wed, 22 Jul 2020 16:49:52 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "mingo@redhat.com" <mingo@redhat.com>, kernel <kernel@axis.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCH] dynamic debug: allow printing to trace event
Message-ID: <20200722144952.2mewrgebgkyr2zyf@axis.com>
References: <20200721141105.16034-1-vincent.whitchurch@axis.com>
 <20200721173045.540ae500@oasis.local.home>
 <87eep3zmg9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87eep3zmg9.fsf@jogness.linutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 03:52:22PM +0200, John Ogness wrote:
> On 2020-07-21, Steven Rostedt <rostedt@goodmis.org> wrote:
> >> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> >> index 321437bbf87d..9f6d8867af7c 100644
> >> --- a/lib/dynamic_debug.c
> >> +++ b/lib/dynamic_debug.c
> [..]
> >> +static void dynamic_printk(unsigned int flags, const char *fmt, ...)
> >> +{
> >> +	if (flags & _DPRINTK_FLAGS_TRACE) {
> >> +		va_list args;
> >> +
> >> +		va_start(args, fmt);
> >> +		/*
> >> +		 * All callers include the KERN_DEBUG prefix to keep the
> >> +		 * vprintk case simple; strip it out for tracing.
> >> +		 */
> >> +		dynamic_trace(fmt + strlen(KERN_DEBUG), args);
> 
> Do we really need a separate tracing event for this? Why not just:
> 
>                 ftrace_vprintk(fmt + strlen(KERN_DEBUG), args);

Thanks, I tried that out now and it seems to work, but it results in the
trace_printk() splat (even if the feature is not used), though:

 **********************************************************
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **                                                      **
 ** trace_printk() being used. Allocating extra memory.  **
 **                                                      **
 ** This means that this is a DEBUG kernel and it is     **
 ** unsafe for production use.                           **
 **                                                      **
 ** If you see this message and you are not debugging    **
 ** the kernel, report this immediately to your vendor!  **
 **                                                      **
 **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
 **********************************************************
