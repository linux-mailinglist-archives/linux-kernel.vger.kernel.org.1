Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287672B1D88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKMOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:33:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMOd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:33:28 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00212222F;
        Fri, 13 Nov 2020 14:33:27 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:33:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     xiakaixu1987@gmail.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] tracing: remove the unused value assignment in
 test_create_synth_event
Message-ID: <20201113093326.36f769de@gandalf.local.home>
In-Reply-To: <1605252810-4669-1-git-send-email-kaixuxia@tencent.com>
References: <1605252810-4669-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020 15:33:30 +0800
xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The value of variable ret is overwritten on the delete branch in the
> test_create_synth_event(), so here the value assignment is useless.
> Remove it.
> 

No. The correct fix is to remove the useless assignment of ret in the
delete portion. We care more about this error than we do about errors
happening in cleaning up the breakage.

-- Steve


> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  kernel/trace/synth_event_gen_test.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/synth_event_gen_test.c b/kernel/trace/synth_event_gen_test.c
> index edd912cd14aa..c76b4c189560 100644
> --- a/kernel/trace/synth_event_gen_test.c
> +++ b/kernel/trace/synth_event_gen_test.c
> @@ -276,10 +276,8 @@ static int __init test_create_synth_event(void)
>  	 */
>  	create_synth_test = trace_get_event_file(NULL, "synthetic",
>  						 "create_synth_test");
> -	if (IS_ERR(create_synth_test)) {
> -		ret = PTR_ERR(create_synth_test);
> +	if (IS_ERR(create_synth_test))
>  		goto delete;
> -	}
>  
>  	/* Enable the event or you won't see anything */
>  	ret = trace_array_set_clr_event(create_synth_test->tr,

