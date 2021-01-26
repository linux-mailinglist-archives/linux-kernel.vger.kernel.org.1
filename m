Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4782304F44
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405492AbhA0Bre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:47:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730989AbhAZTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:06:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611687874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ZGdEc60KAecPlxEjKLfHIPIF9lQTPmew9gSACISr/M=;
        b=bODFJiNee/ik8BNIHPoT7GVB6rRC0eq+/kxpqxpdJhGB8nH7niqTivmT+DH0UnUQQKemZL
        zdgE6vxGevAw+zQGwM1ckvVepqkF+7rkxBuu0asTZma7Ovflhg/dVbsgCftAiNY5QSqF78
        usrN2rwLKWgn4Qz3BEEGn5HbYaumXak=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-I6zRFouzNj6RNsWkP7pEqw-1; Tue, 26 Jan 2021 14:04:30 -0500
X-MC-Unique: I6zRFouzNj6RNsWkP7pEqw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00769B8101;
        Tue, 26 Jan 2021 19:04:29 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CDA15D760;
        Tue, 26 Jan 2021 19:04:20 +0000 (UTC)
Date:   Tue, 26 Jan 2021 14:04:18 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     menglong8.dong@gmail.com
Cc:     paul@paul-moore.com, Yang Yang <yang.yang29@zte.com.cn>,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: Make audit_filter_syscall() return void
Message-ID: <20210126190418.GM2015948@madcap2.tricolour.ca>
References: <20210126131151.10418-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126131151.10418-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-26 05:11, menglong8.dong@gmail.com wrote:
> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> No invoker users the return value of audit_filter_syscall().
> So make it return void.

That was my oversight when ripping out the AUDIT_FILTER_ENTRY list:
5260ecc2e048 <rgb@redhat.com> 2018-02-14 ("audit: deprecate the AUDIT_FILTER_ENTRY filter")

Might as well also amend the function comment block to remove the
reference to syscall entry since that is no longer relevant.

> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>

Reviewed-by: Richard Guy Briggs <rgb@redhat.com>

> ---
>  kernel/auditsc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ce8c9e2279ba..c8e16b9c0f21 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -804,7 +804,7 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
>   * also not high enough that we already know we have to write an audit
>   * record (i.e., the state is AUDIT_SETUP_CONTEXT or AUDIT_BUILD_CONTEXT).
>   */
> -static enum audit_state audit_filter_syscall(struct task_struct *tsk,
> +static void audit_filter_syscall(struct task_struct *tsk,
>  					     struct audit_context *ctx,
>  					     struct list_head *list)
>  {
> @@ -812,7 +812,7 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
>  	enum audit_state state;
>  
>  	if (auditd_test_task(tsk))
> -		return AUDIT_DISABLED;
> +		return;
>  
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(e, list, list) {
> @@ -821,11 +821,11 @@ static enum audit_state audit_filter_syscall(struct task_struct *tsk,
>  				       &state, false)) {
>  			rcu_read_unlock();
>  			ctx->current_state = state;
> -			return state;
> +			return;
>  		}
>  	}
>  	rcu_read_unlock();
> -	return AUDIT_BUILD_CONTEXT;
> +	return;
>  }
>  
>  /*
> -- 
> 2.25.1
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

