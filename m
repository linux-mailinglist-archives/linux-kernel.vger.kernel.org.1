Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F90026984E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgINVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgINVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:51:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600120276;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwTbahsND2Yz3ope7XDliFQKn4OcNlEFhaYev3tnX1g=;
        b=HI+YrhPJgwqTxZdgzqYDjBpwrMuC1Y0qm2KvfrAT47bWWYCJdEL8c0l/hHS524/pstjvcL
        qWZbDVwxPwqMnmMgFbbQmGxy7sSgENdB2UcidveUvIERRgVfWRbKQCOyWChd1Okj1/9hSQ
        A3X8G9nTG0kkXkD28DQXF07/9XWI05M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ST0-bU-rM5ywG7G9xhOq2A-1; Mon, 14 Sep 2020 17:51:14 -0400
X-MC-Unique: ST0-bU-rM5ywG7G9xhOq2A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2E5F1074642;
        Mon, 14 Sep 2020 21:51:11 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BF8B7BE76;
        Mon, 14 Sep 2020 21:51:05 +0000 (UTC)
Date:   Mon, 14 Sep 2020 16:51:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Borislav Petkov' <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200914215104.cjvycgie2wd3omtn@treble>
References: <1d06ed6485b66b9f674900368b63d7ef79f666ca.1599756789.git.jpoimboe@redhat.com>
 <20200914175604.GF680@zn.tnic>
 <2e6a4d75b38248f1b8b3b874d36065f1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e6a4d75b38248f1b8b3b874d36065f1@AcuMS.aculab.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:23:59PM +0000, David Laight wrote:
> From: Borislav Petkov
> > Sent: 14 September 2020 18:56
> > 
> > On Thu, Sep 10, 2020 at 12:22:53PM -0500, Josh Poimboeuf wrote:
> > > +/*
> > > + * Sanitize a user pointer such that it becomes NULL if it's not a valid user
> > > + * pointer.  This prevents speculative dereferences of user-controlled pointers
> > > + * to kernel space when access_ok() speculatively returns true.  This should be
> > > + * done *after* access_ok(), to avoid affecting error handling behavior.
> > 
> > Err, stupid question: can this macro then be folded into access_ok() so
> > that you don't have to touch so many places and the check can happen
> > automatically?
> 
> My thoughts are that access_ok() could return 0 for fail and ~0u
> for success.
> You could then do (with a few casts):
> 	mask = access_ok(ptr, size);
> 	/* Stop gcc tracking the value of mask. */
> 	asm volatile( "" : "+r" (mask));
> 	addr = ptr & mask;
> 	if (!addr && ptr)  // Let NULL through??
> 		return -EFAULT;
> 
> I think there are other changes in the pipeline to remove
> most of the access_ok() apart from those inside put/get_user()
> and copy_to/from_user().
> So the changes should be more limited than you might think.

Maybe, but I believe that's still going to end up a treewide change.

And, if we're going to the trouble of changing the access_ok()
interface, we should change it enough to make sure that accidental uses
of the old interface (after years of muscle memory) will fail to build.

We could either add a 3rd argument, or rename it to access_ok_mask() or
something.

-- 
Josh

