Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A93297B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759754AbgJXG2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 02:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759746AbgJXG2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 02:28:33 -0400
Received: from coco.lan (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 208AB2225F;
        Sat, 24 Oct 2020 06:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603520912;
        bh=5v86lVR1XneVpVP+Hzz236herCmsEq7eWDuD8TBA06w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bplk10sTPdwHZ5QH2EJQ1zHFzguHpaHFpQUAbpHPoF71qMsRQkeZ4svdQYs2Q3pEQ
         hWzB3zXqsxCq/NPvA13SjvyCtuSFDy4PLBjK8hkGvvNeh0lw4Yjxozyqe8s73kqfz2
         xJhXrYReVvjDdH6o+pJkALdJgd5lGKgR1qAh9FVA=
Date:   Sat, 24 Oct 2020 08:28:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <20201024082827.08ad3010@coco.lan>
In-Reply-To: <20201023134757.628f91b7@lwn.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
        <202010231039.DE05B63@keescook>
        <20201023193907.GI2974@worktop.programming.kicks-ass.net>
        <20201023134757.628f91b7@lwn.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Oct 2020 13:47:57 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri, 23 Oct 2020 21:39:07 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > >  /**
> > > > - * struct refcount_t - variant of atomic_t specialized for reference counts
> > > > + * struct refcount_struct - variant of atomic_t specialized for reference counts    
> > > 
> > > Hm, this is a weird one. Yes, it's actually "struct refcount_struct",
> > > but the usage should be refcount_t (through the typedef). I'm not sure
> > > what the right way to document this is.    
> > 
> > Yeah, this is wrong. If this is due to a kernel doc warning, the kernel
> > doc machinery is wrong *again*.  

This issue has nothing to do with warnings. The problem here is that
"struct" is a markup for structs, and not for typedefs.

> 
> ...except that, since refcount_t is a typedef, "struct refcount_t" doesn't
> actually exist.  Whether it works properly after doing s/struct// remains
> to be seen...

If the intent is to document the struct and its internal fields,
this kernel-doc should work:

	/**
	 * struct refcount_struct - variant of atomic_t specialized for reference counts
	 * @refs: atomic_t counter field
	 *
	 * The counter saturates at REFCOUNT_SATURATED and will not move once
	 * there. This avoids wrapping the counter and causing 'spurious'
	 * use-after-free bugs.
	 */

Which produces this result:

	.. c:struct:: refcount_struct

	   variant of atomic_t specialized for reference counts

	**Definition**

	::

	  struct refcount_struct {
	    atomic_t refs;
	  };

	**Members**

	``refs``
	  atomic_t counter field

	(description)

See, in this case, the identifier is not opaque: its members are
documented at the html (or man) output.

If you want, instead, to document the typedef, this is the
proper way:

	/**
	 * typedef refcount_t - variant of atomic_t specialized for reference counts
	 *
	 * The counter saturates at REFCOUNT_SATURATED and will not move once
	 * there. This avoids wrapping the counter and causing 'spurious'
	 * use-after-free bugs.
	 */

It will handle this one as an opaque type, meaning that it won't be 
showing the "refs" field - even if you forget to drop the @refs: 
at the markup. The result will be:


	.. c:type:: refcount_t

	   variant of atomic_t specialized for reference counts

	(description)

-

If you want both, then you would either split struct and typedef, e. g.
with something like:

	/**
	 * struct refcount_struct - variant of atomic_t specialized for reference counts
	 * @refs: atomic_t counter field
	 *
	 * The counter saturates at REFCOUNT_SATURATED and will not move once
	 * there. This avoids wrapping the counter and causing 'spurious'
	 * use-after-free bugs.
	 */
	struct refcount_struct {
	        atomic_t refs;
	};

	/**
	 * typedef refcount_t - variant of atomic_t specialized for reference counts
	 * @refs: atomic_t counter field
	 *
	 * The counter saturates at REFCOUNT_SATURATED and will not move once
	 * there. This avoids wrapping the counter and causing 'spurious'
	 * use-after-free bugs.
	 */
	typedef struct refcount_struct refcount_t;

Or, you could add the member at the description field. E. g. something
like this:

	/**
	 * typedef refcount_t - variant of atomic_t specialized for reference counts
	 *
	 * The counter saturates at REFCOUNT_SATURATED and will not move once
	 * there. This avoids wrapping the counter and causing 'spurious'
	 * use-after-free bugs.
	 *
	 * Members:
	 *   ``refs``
	 *        atomic_t counter field
	 */
	typedef struct refcount_struct {
	        atomic_t refs;
	} refcount_t;

If you want to test it, you can run kernel-doc directly, to see how
it will parse it. For ReST output, that's the syntax:

	./scripts/kernel-doc --sphinx-version 3 include/linux/refcount.h

Thanks,
Mauro
