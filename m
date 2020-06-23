Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4BD3206287
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 23:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392413AbgFWVEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 17:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbgFWVDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:03:51 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F0EE20663;
        Tue, 23 Jun 2020 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592946230;
        bh=li/oRgdLLDIhMxiF7/Lp7mtYZP2mwCtijwdf+7Qnn5g=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G2j4A721OYP7lRsAgAZ2dEgJm/gKD9ZGtJpxpdMzlIvttpwekkgi7e7mv1OzfobGr
         q9OOfDDkm+4g9P+COxHy3lBe85MF9zuVhLsInZfUjpCoE/hGclSsrQjO9WrOS837Do
         CUY8/Aa4RijfnDYj/Oxt9TOuL3afhElqSw5gXnhI=
Message-ID: <bdcdd6d10342005a8c773f4ffb882dabf398e5ac.camel@kernel.org>
Subject: Re: [PATCH 0/2] tracing: Fix config dependency and trigger parser
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jun 2020 16:03:48 -0500
In-Reply-To: <159262474473.185015.177609153974879988.stgit@devnote2>
References: <159262474473.185015.177609153974879988.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Sat, 2020-06-20 at 12:45 +0900, Masami Hiramatsu wrote:
> Hi,
> 
> These are some fixes which I found recentry on ftrace.
> 
>  - Since the boot-time tracing synthetic event feature is decoupled
>    from trigger recenty, it should use CONFIG_SYNTH_EVENT.

Oops, yeah, I missed this one in the update, thanks for finding it.

>  - The parser of event trigger seems rejecting some redundant
>    spaces. But it is hard users to find the wrong point. Such
>    spaces should be accepted.
> 

Agreed, your patch makes things much better, thanks.

You can add my reviewed-by for both patches.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks,

Tom

> BTW, I also found the trigger parser accepts some inputs which
> may not correctly formatted, e.g.
> 
>  # echo "traceon 1" > events/ftrace/print/trigger
> 
> (from the document, it must be "traceon:1")
> But I think this does not decrease the usability.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       tracing/boot: Fix config dependency for synthedic event
>       tracing: Fix event trigger to accept redundant spaces
> 
> 
>  kernel/trace/trace_boot.c           |    2 +-
>  kernel/trace/trace_events_trigger.c |   21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>

