Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9981B2ADA4B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgKJPX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:23:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730594AbgKJPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605021804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lwUaPMxDnPcPS2dItw+7NhhhUgIN6bqu6Myc1cFbupk=;
        b=W5pdxHrLNvXpO1sVUGnE2nN1pH87Cqx3NCaWF5iJCN15+6jEdohjr9N5y6b3L0+wRlMweT
        iduFP7Zz+Z7CBYD0omh8Rl/ZN3Zmru6JV5pLmd6Xcs0lK9namRGZ0sQZaiQaJ1CvgYtwZR
        GdfVMRcUnQGN1vr2woc835TQ/BcnV18=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-HmqNpQ7JOAGL0l8gQgY3YQ-1; Tue, 10 Nov 2020 10:23:22 -0500
X-MC-Unique: HmqNpQ7JOAGL0l8gQgY3YQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4C83804751;
        Tue, 10 Nov 2020 15:23:20 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 819781972B;
        Tue, 10 Nov 2020 15:23:12 +0000 (UTC)
Date:   Tue, 10 Nov 2020 10:23:10 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     paul@paul-moore.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: remove unused macros
Message-ID: <20201110152310.GB55411@madcap2.tricolour.ca>
References: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1604651482-9780-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-06 16:31, Alex Shi wrote:
> Some unused macros could cause gcc warning:
> kernel/audit.c:68:0: warning: macro "AUDIT_UNINITIALIZED" is not used
> [-Wunused-macros]
> kernel/auditsc.c:104:0: warning: macro "AUDIT_AUX_IPCPERM" is not used
> [-Wunused-macros]
> kernel/auditsc.c:82:0: warning: macro "AUDITSC_INVALID" is not used
> [-Wunused-macros]
> 
> remove them to tame gcc.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Paul Moore <paul@paul-moore.com> 
> Cc: Eric Paris <eparis@redhat.com> 
> Cc: linux-audit@redhat.com 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/audit.c   | 1 -
>  kernel/auditsc.c | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/kernel/audit.c b/kernel/audit.c
> index ac0aeaa99937..dfac1e0ca887 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -65,7 +65,6 @@
>  /* No auditing will take place until audit_initialized == AUDIT_INITIALIZED.
>   * (Initialization happens after skb_init is called.) */
>  #define AUDIT_DISABLED		-1
> -#define AUDIT_UNINITIALIZED	0
>  #define AUDIT_INITIALIZED	1
>  static int	audit_initialized;

This one is part of a set, so it feels like it should stay, but the code
is structured in such a way that it is not necessary.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 183d79cc2e12..eeb4930d499f 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -80,7 +80,6 @@
>  #include "audit.h"
>  
>  /* flags stating the success for a syscall */
> -#define AUDITSC_INVALID 0
>  #define AUDITSC_SUCCESS 1
>  #define AUDITSC_FAILURE 2

Same here, but this one should really be fixed by using
AUDITSC_INVALID as the value assigned to context->return_valid in
__audit_free() to avoid using magic numbers.  Similarly, the compared
values in audit_filter_rules() under the AUDIT_EXIT and AUDIT_SUCCESS
cases should be "ctx->return_valid != AUDITSC_INVALID" rather than just
"ctx->return_valid".  Same in audit_log_exit().

> @@ -102,8 +101,6 @@ struct audit_aux_data {
>  	int			type;
>  };
>  
> -#define AUDIT_AUX_IPCPERM	0
> -

Hmmm, this one looks like it was orphaned 15 years ago a couple of
months after it was introduced due to this commit:
c04049939f88 Steve Grubb <sgrubb@redhat.com> 2005-05-13
    ("AUDIT: Add message types to audit records")

Introduced here:
8e633c3fb2a2 David Woodhouse <dwmw2@shinybook.infradead.org> 2005-03-01 
    ("Audit IPC object owner/permission changes.")

I agree, remove it.

>  /* Number of target pids per aux struct. */
>  #define AUDIT_AUX_PIDS	16
>  
> -- 
> 1.8.3.1
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

