Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFB42791C7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgIYUMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYUKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:10:30 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B182E23888;
        Fri, 25 Sep 2020 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601063596;
        bh=p6WXfRRraIUl2lU50knkM7m42pz+rDwh/eBQev4odNA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=q/18Vp0G6F+/m7vRaVkMahLSJgqiYgqQBhgPMzxcis0UYtZBITQhGh20tpBSl0c5L
         QH525wHEa5DiEmpc48uXoyliwU36xZSc/CAbT4Ei+91i5epXBb88UwZ7c8oTqTCxMB
         fmOzGiP3VodtuWExkmhw4UF0xQKZ7/tWPJPQAQBc=
Message-ID: <60fa4f01eef2c78dd63e8581d405d45a396f9f5c.camel@kernel.org>
Subject: Re: [RFC PATCH 1/1] tracing: support dynamic string field types for
 synthetic events
From:   Tom Zanussi <zanussi@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 25 Sep 2020 14:53:14 -0500
In-Reply-To: <20200925190806.1870935-2-axelrasmussen@google.com>
References: <20200925190806.1870935-1-axelrasmussen@google.com>
         <20200925190806.1870935-2-axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

On Fri, 2020-09-25 at 12:08 -0700, Axel Rasmussen wrote:
> It's typical [1] to define tracepoint string fields as "const char *",
> using the __string, __assign_str, and __get_str helpers. For synthetic
> event definitions, the only available mechanism to define a string type
> is a fixed-size char array ("char[]") [2].
> 
> Without this patch, since the type strings aren't identical, and the
> sizes don't match (since one is an array, and the other is a "dynamic
> string" integer), they are considered incompatible [3].
> 
> This patch modifies that check, so as to let us setup synthetic events,
> and plumb through string values from typical tracepoints. It turns out
> this is already handled correctly, as long as the check during
> definition parsing doesn't prevent it.
> 
> [1] grep -r "__string" include/trace/events/
> [2] See synth_field_is_string in kernel/trace/trace_events_synth.c
> [3] See check_synth_field in kernel/trace/trace_events_hist.c
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  kernel/trace/trace_events_hist.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 0b933546142e..e064feb3cc65 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3280,9 +3280,18 @@ static int check_synth_field(struct synth_event *event,
>  	field = event->fields[field_pos];
>  
>  	if (strcmp(field->type, hist_field->type) != 0) {
> -		if (field->size != hist_field->size ||
> -		    field->is_signed != hist_field->is_signed)
> -			return -EINVAL;

One thing is that this check doesn't just apply to strings, so dropping
this will skip those other cases.  In any case, the patch I'm working
on will handle this properly along with the other changes.

Thanks,

Tom

> +		/*
> +		 * If both are kinds of strings, they match. We can't use
> +		 * is_string_field for the hist_field, as it's only sort of
> +		 * partially initialized at this point.
> +		 */
> +		if (strstr(field->type, "char[") == NULL ||
> +		    strstr(hist_field->type, "char[") == NULL) {
> +			/* They still match if size and signedness match. */
> +			if (field->size != hist_field->size ||
> +			    field->is_signed != hist_field->is_signed)
> +				return -EINVAL;
> +		}
>  	}
>  
>  	return 0;

