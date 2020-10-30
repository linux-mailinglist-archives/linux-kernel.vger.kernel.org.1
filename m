Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18202A0C3D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgJ3RLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:11:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55005 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726272AbgJ3RLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604077913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xYKXOVaB9Lqk7p+DNzbwFvXdhWfTDvuqQ9VGT8imCvs=;
        b=NRTnCr1cM8+gvfpsMGiR0DOFFp+CGxGH0151jVayg3vhcFtHAtB9ARhNQgCReSpz36Me0I
        g4qeOa5nh+5ELTYwrK+0fa7ZCbh2IavjnHDaxCjdkR1ZDthtiwAxZWPBrISRY1Cdyk6ie5
        q+2fKW3OjX+5sGW0UxsiqR5cKLD02ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-W7ntctm2N0eOOxax29wTxQ-1; Fri, 30 Oct 2020 13:11:48 -0400
X-MC-Unique: W7ntctm2N0eOOxax29wTxQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B14B4107AFB6;
        Fri, 30 Oct 2020 17:11:46 +0000 (UTC)
Received: from carbon (unknown [10.36.110.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 204696EF6A;
        Fri, 30 Oct 2020 17:11:39 +0000 (UTC)
Date:   Fri, 30 Oct 2020 18:11:38 +0100
From:   Jesper Dangaard Brouer <brouer@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        brouer@redhat.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201030181138.215b2b6a@carbon>
In-Reply-To: <20201030151955.187580298@infradead.org>
References: <20201030151345.540479897@infradead.org>
        <20201030151955.187580298@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 16:13:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

>   "Look ma, no branches!"
> 
> Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Cool trick! :-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

>  kernel/events/internal.h |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> --- a/kernel/events/internal.h
> +++ b/kernel/events/internal.h
> @@ -205,16 +205,15 @@ DEFINE_OUTPUT_COPY(__output_copy_user, a
>  
>  static inline int get_recursion_context(int *recursion)
>  {
> -	int rctx;
> +	unsigned int pc = preempt_count();
> +	unsigned int rctx = 0;
>  
> -	if (unlikely(in_nmi()))
> -		rctx = 3;
> -	else if (in_irq())
> -		rctx = 2;
> -	else if (in_serving_softirq())
> -		rctx = 1;
> -	else
> -		rctx = 0;
> +	if (pc & (NMI_MASK))
> +		rctx++;
> +	if (pc & (NMI_MASK | HARDIRQ_MASK))
> +		rctx++;
> +	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
> +		rctx++;
>  
>  	if (recursion[rctx])
>  		return -1;
> 
> 



-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

