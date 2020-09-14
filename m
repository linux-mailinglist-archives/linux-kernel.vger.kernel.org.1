Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB822695A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgINT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:27:45 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgINT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600111660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FCNGaTB2XTlKwuW28Ajr6nro1HFL/b6q2oKuURy+WoM=;
        b=NdMgJwM3F9WSt3qK5gb255nuC5RhL2+tcy5kUatD/0iNCZBipuYWTviEwTMTJBPDToFwyI
        DZkzaFGGwsxiZrbdo0iu7R3HTxvZmksnCvfTUhrlZL5YfY4OtMNEEGRaueemKF5nhivDAL
        8zNqHSM2WFeSoVlQd5a8UkNttSjS4y0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-heMWj_LSM02Qa5NoAQQtnQ-1; Mon, 14 Sep 2020 15:27:36 -0400
X-MC-Unique: heMWj_LSM02Qa5NoAQQtnQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E039B107465E;
        Mon, 14 Sep 2020 19:27:33 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D85C35DA60;
        Mon, 14 Sep 2020 19:27:27 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:27:25 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, X86 ML <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200914192725.cqja3icshjemvcxw@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
 <CAPcyv4hqxs1zuXb5jkA-6Fm72Vu0ZDCfqeWJKSePM+zFyY9kzg@mail.gmail.com>
 <20200914192156.GG680@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914192156.GG680@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:21:56PM +0200, Borislav Petkov wrote:
> On Mon, Sep 14, 2020 at 11:48:55AM -0700, Dan Williams wrote:
> > > Err, stupid question: can this macro then be folded into access_ok() so
> > > that you don't have to touch so many places and the check can happen
> > > automatically?
> > 
> > I think that ends up with more changes because it changes the flow of
> > access_ok() from returning a boolean to returning a modified user
> > address that can be used in the speculative path.
> 
> I mean something like the totally untested, only to show intent hunk
> below? (It is late here so I could very well be missing an aspect):
> 
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index 2bffba2a1b23..c94e1589682c 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -7,6 +7,7 @@
>  #include <linux/compiler.h>
>  #include <linux/kasan-checks.h>
>  #include <linux/string.h>
> +#include <linux/nospec.h>
>  #include <asm/asm.h>
>  #include <asm/page.h>
>  #include <asm/smap.h>
> @@ -92,8 +93,15 @@ static inline bool pagefault_disabled(void);
>   */
>  #define access_ok(addr, size)					\
>  ({									\
> +	bool range;							\
> +	typeof(addr) a = addr, b;					\
> +									\
>  	WARN_ON_IN_IRQ();						\
> -	likely(!__range_not_ok(addr, size, user_addr_max()));		\
> +									\
> +	range = __range_not_ok(addr, size, user_addr_max());		\
> +	b = (typeof(addr)) array_index_nospec((__force unsigned long)addr, TASK_SIZE_MAX); \
> +									\
> +	likely(!range && a == b);					\

That's not going to work because 'a == b' can (and will) be
misspeculated.

-- 
Josh

