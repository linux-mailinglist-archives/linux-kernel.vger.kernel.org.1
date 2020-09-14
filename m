Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7905D2695E0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:51:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgINTvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600113071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4TAwFPZaKJRM/fh5r13mTLKPcZ1fs6loBeCTPYTPvg=;
        b=PPWhCIdrm6O1eay+u4FSaIecCU8+h97B9zhTJnogrK/dz4Umz7ACKYi4vbRTdDh5Y6RyG6
        kl65SKvDYRVs0RNstziD2eIdB4DWmEiS+g+jR7Yl8E0Q7hZDqBlEEq2GZM1svyOEZSZEvB
        +jmrc9oy6GHByp4sfne9pAgMbjzOZQU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-pFCONv-BMZCM0_Wd95_Z7w-1; Mon, 14 Sep 2020 15:51:09 -0400
X-MC-Unique: pFCONv-BMZCM0_Wd95_Z7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDFDF18B9ECA;
        Mon, 14 Sep 2020 19:51:06 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FE7B10013BD;
        Mon, 14 Sep 2020 19:51:01 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:50:59 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     X86 ML <x86@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
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
Message-ID: <20200914195059.wlv6abyr5smrlhsg@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <CAPcyv4jk_SZGaCtDm39FAdMCo9fQo87gjuAj1xzUCT9isycz9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4jk_SZGaCtDm39FAdMCo9fQo87gjuAj1xzUCT9isycz9g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:06:56PM -0700, Dan Williams wrote:
> > +++ b/arch/x86/include/asm/checksum_32.h
> > @@ -49,7 +49,8 @@ static inline __wsum csum_and_copy_from_user(const void __user *src,
> >         might_sleep();
> >         if (!user_access_begin(src, len))
> >                 return 0;
> > -       ret = csum_partial_copy_generic((__force void *)src, dst, len);
> > +       ret = csum_partial_copy_generic((__force void *)force_user_ptr(src),
> > +                                       dst, len);
> 
> I look at this and wonder if the open-coded "(__force void *)" should
> be subsumed in the new macro.

I'm not sure how we could do that?  This is kind of a special case
anyway.  Most users of the macro don't need to cast the return value
because the macro already casts it to the original type.

> It also feels like the name should be "enforce" to distinguish it from
> the type cast case?

Yeah, although, to me, "enforce" has other connotations which make it
less clear.  (I can't quite put my finger on why, but "enforce" sounds
like it doesn't return a value.)  I wouldn't be opposed to changing it
if others agree.

> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -6,6 +6,7 @@
> >   */
> >  #include <linux/compiler.h>
> >  #include <linux/kasan-checks.h>
> > +#include <linux/nospec.h>
> >  #include <linux/string.h>
> >  #include <asm/asm.h>
> >  #include <asm/page.h>
> > @@ -66,12 +67,23 @@ static inline bool pagefault_disabled(void);
> >   * Return: true (nonzero) if the memory block may be valid, false (zero)
> >   * if it is definitely invalid.
> >   */
> > -#define access_ok(addr, size)                                  \
> 
> unnecessary whitespace change?

True, though it's not uncommon to fix whitespace close to where you're
changing something.  Better than spinning a whitespace-only patch IMO.

> Other than that and the optional s/force/enforce/ rename + cast
> collapse you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Thanks for the review!

-- 
Josh

