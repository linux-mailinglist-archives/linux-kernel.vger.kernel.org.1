Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6E62B9DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 23:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgKSWoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 17:44:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727004AbgKSWoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 17:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605825840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tKxRHxunHt1N9ZBPxfMk6k1u2rcoVcD83DVFC6TLu74=;
        b=O8qS+tQVZU/WCrPPws3/28yAQUAqGPuzM6oQ0Uu+z+GC90Y/C44oD8ccOUuQpVrD7sxSmc
        EjcoMKdB4Im2DlFLnAvAeR9CA9005OsB+SbbKjYawah7cdyGQaIhsKYRU1JpW96qnMPOzi
        ENGGJHdegQfigwt4Kbc+A613Jfb10sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-uu7psJv2MnuTKJxL3UojBg-1; Thu, 19 Nov 2020 17:43:58 -0500
X-MC-Unique: uu7psJv2MnuTKJxL3UojBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C2F78143F3;
        Thu, 19 Nov 2020 22:43:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id CADE919C47;
        Thu, 19 Nov 2020 22:43:49 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 19 Nov 2020 23:43:56 +0100 (CET)
Date:   Thu, 19 Nov 2020 23:43:48 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
Message-ID: <20201119224347.GC5138@redhat.com>
References: <20201119160154.GA5183@redhat.com>
 <20201119160247.GB5188@redhat.com>
 <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Christophe Leroy wrote:
>
> I think the following should work, and not require the first patch (compile
> tested only).
>
> --- a/arch/powerpc/kernel/ptrace/ptrace-view.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
> @@ -234,9 +234,21 @@ static int gpr_get(struct task_struct *target, const
> struct user_regset *regset,
>  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
>  		     offsetof(struct pt_regs, msr) + sizeof(long));
> 
> +#ifdef CONFIG_PPC64
> +	membuf_write(&to, &target->thread.regs->orig_gpr3,
> +		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,
> orig_gpr3));
> +	membuf_store(&to, 1UL);
> +
> +	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
> +		     offsetof(struct pt_regs, softe) + sizeof(long));
> +
> +	membuf_write(&to, &target->thread.regs->trap,
> +		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
> +#else
>  	membuf_write(&to, &target->thread.regs->orig_gpr3,
>  			sizeof(struct user_pt_regs) -
>  			offsetof(struct pt_regs, orig_gpr3));
> +#endif
>  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
>  				 sizeof(struct user_pt_regs));
>  }

Probably yes.

This mirrors the previous patch I sent (https://lore.kernel.org/lkml/20190917143753.GA12300@redhat.com/)
and this is exactly what I tried to avoid, we can make a simpler fix now.

But let me repeat, I agree with any fix even if imp my version simplifies the code, just
commit this change and lets forget this problem.

Oleg.

