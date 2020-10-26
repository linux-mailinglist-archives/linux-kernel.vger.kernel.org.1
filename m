Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCCB298953
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420251AbgJZJQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:16:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgJZJQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:16:27 -0400
Received: from coco.lan (ip5f5ad5a1.dynamic.kabel-deutschland.de [95.90.213.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 953FD207C4;
        Mon, 26 Oct 2020 09:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603703786;
        bh=pQKLqfcjbVUih5iUhFZ84v4gYr3t3Bambb8ZkFTJ3Zw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=elxWFOMcqfnVmAhlV5sWGJKCdgouHiwhbeVhEKknu4LkmH19Xdhpziqc+xqxyEhMn
         DybyKhwMR9cFPCmXPWmmFGhwskg6mJib7Vdfb7LmYwl+8+6MK8gLiMEEYJKh+cau1h
         7r62rzHVjjWOLjplCuOMlvilqEwk7UMjUwn0JDnI=
Date:   Mon, 26 Oct 2020 10:16:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <20201026101620.1a11ef3e@coco.lan>
In-Reply-To: <20201026081059.GB2628@hirez.programming.kicks-ass.net>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
        <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
        <202010231039.DE05B63@keescook>
        <20201023193907.GI2974@worktop.programming.kicks-ass.net>
        <20201023134757.628f91b7@lwn.net>
        <20201024082827.08ad3010@coco.lan>
        <20201026081059.GB2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 26 Oct 2020 09:10:59 +0100
Peter Zijlstra <peterz@infradead.org> escreveu:

> On Sat, Oct 24, 2020 at 08:28:27AM +0200, Mauro Carvalho Chehab wrote:
> > If the intent is to document the struct and its internal fields,
> > this kernel-doc should work:
> > 
> > 	/**
> > 	 * struct refcount_struct - variant of atomic_t specialized for reference counts
> > 	 * @refs: atomic_t counter field
> > 	 *
> > 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> > 	 * there. This avoids wrapping the counter and causing 'spurious'
> > 	 * use-after-free bugs.
> > 	 */
> > 
> > Which produces this result:  
> 
> Who cares... :-(

Anyone that would need to use refcount_t, instead of atomic_t.

> 
> > If you want both, then you would either split struct and typedef, e. g.
> > with something like:
> > 
> > 	/**
> > 	 * struct refcount_struct - variant of atomic_t specialized for reference counts
> > 	 * @refs: atomic_t counter field
> > 	 *
> > 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> > 	 * there. This avoids wrapping the counter and causing 'spurious'
> > 	 * use-after-free bugs.
> > 	 */
> > 	struct refcount_struct {
> > 	        atomic_t refs;
> > 	};
> > 
> > 	/**
> > 	 * typedef refcount_t - variant of atomic_t specialized for reference counts
> > 	 * @refs: atomic_t counter field
> > 	 *
> > 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> > 	 * there. This avoids wrapping the counter and causing 'spurious'
> > 	 * use-after-free bugs.
> > 	 */
> > 	typedef struct refcount_struct refcount_t;
> > 
> > Or, you could add the member at the description field. E. g. something
> > like this:
> > 
> > 	/**
> > 	 * typedef refcount_t - variant of atomic_t specialized for reference counts
> > 	 *
> > 	 * The counter saturates at REFCOUNT_SATURATED and will not move once
> > 	 * there. This avoids wrapping the counter and causing 'spurious'
> > 	 * use-after-free bugs.
> > 	 *
> > 	 * Members:
> > 	 *   ``refs``
> > 	 *        atomic_t counter field
> > 	 */
> > 	typedef struct refcount_struct {
> > 	        atomic_t refs;
> > 	} refcount_t;
> > 
> > If you want to test it, you can run kernel-doc directly, to see how
> > it will parse it. For ReST output, that's the syntax:
> > 
> > 	./scripts/kernel-doc --sphinx-version 3 include/linux/refcount.h  
> 
> I'll just go ahead and remove the superfluous * from the comment... It's
> trivially clear what is meant. If the stupid tool can't deal with that,
> I don't care.

The tool is not that stupid. What's wrong here is that the markup is
asking kernel-doc to document the struct, instead documenting the typedef:

 	/**
 	 * struct refcount_t - variant of atomic_t specialized for reference counts
...

There is no such struct!

Just doing:

	s/struct/typedef/

will do what you intend to document.

Thanks,
Mauro

[PATCH] refcount.h: fix a kernel-doc markup

The kernel-doc markup is wrong: it is asking the tool to document
struct refcount_struct, instead of documenting typedef refcount_t.

Fix it.
    
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 0e3ee25eb156..f572c62261a8 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -101,7 +101,7 @@
 struct mutex;
 
 /**
- * struct refcount_t - variant of atomic_t specialized for reference counts
+ * typedef refcount_t - variant of atomic_t specialized for reference counts
  * @refs: atomic_t counter field
  *
  * The counter saturates at REFCOUNT_SATURATED and will not move once


