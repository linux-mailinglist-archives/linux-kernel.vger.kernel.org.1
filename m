Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987952A458F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbgKCMuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgKCMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604407844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czYSHEkJZRKBHJc6+H3B9w8RmjDMKNgYyM8LaMqolZw=;
        b=VMsEE6Y1zplAdZk7YralgLB5F1aOY65et04JnOngvOJSf9ocAandXhEcmmFWSM/68/yzG6
        G2xGRywXTuWACnzWV20St/YTNkD5I25Rxxf48IhDOorAP0jsbazYlAxdg7bQKCMiSBnq2z
        qMsNgN2mQWUUwTSoPTSbzNJfhQY6VzE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-8apJzIFdN-egZ6oA7GB6Hw-1; Tue, 03 Nov 2020 07:50:41 -0500
X-MC-Unique: 8apJzIFdN-egZ6oA7GB6Hw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFC81106C10A;
        Tue,  3 Nov 2020 12:50:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id CF925672C0;
        Tue,  3 Nov 2020 12:50:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 Nov 2020 13:50:38 +0100 (CET)
Date:   Tue, 3 Nov 2020 13:50:34 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Mark Mossberg <mark.mossberg@gmail.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jannh@google.com,
        kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer
 error message
Message-ID: <20201103125034.GA30391@redhat.com>
References: <20201002042915.403558-1-mark.mossberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002042915.403558-1-mark.mossberg@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02, Mark Mossberg wrote:
>
> Printing "Bad RIP value" if copy_code() fails can be misleading for
> userspace pointers, since copy_code() can fail if the instruction
> pointer is valid, but the code is paged out.

Another problem is that show_opcodes() makes no sense if user_mode(regs)
and tsk is not current. Try "echo t > /proc/sysrq-trigger".

In this case copy_from_user_nmi() will either fail, or (worse) it will
read the "random" memory from current->mm.

Perhaps we can add something like

	if (user_mode(regs) && regs != task_pt_regs(current))
		return;

at the start of show_opcodes() ?

> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -115,7 +115,8 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
>  	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
>  
>  	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
> -		printk("%sCode: Bad RIP value.\n", loglvl);
> +		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
> +		       loglvl, prologue);
>  	} else {
>  		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
>  		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
> -- 
> 2.25.1
> 

