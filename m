Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17332ED5C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbhAGRhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:37:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbhAGRhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610040971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HAodYt2HQFDdAV3Nlwj/zRiTtI08o4QNW6FChKlHIwI=;
        b=VREKnqPw8DtlosGR8JZEVxU6wAKZxVSXxfZ2aUggMax4F9+FFmQlL8MJIZgfgpWAtwQ/ib
        4JyuQVF8kNVvDJf5rb+mXKRERi75kY5irEdIZRwIHVLKWbLr12Xxk70y/KIW0MnBvUUI/M
        8E1i4HnU3OzMl0OmAVIa2NDJYIDlxMA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-jdWXXdCXP9mMnCa2FnvqhA-1; Thu, 07 Jan 2021 12:36:06 -0500
X-MC-Unique: jdWXXdCXP9mMnCa2FnvqhA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5073C100F349;
        Thu,  7 Jan 2021 17:36:05 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDEC860C0F;
        Thu,  7 Jan 2021 17:36:04 +0000 (UTC)
Date:   Thu, 7 Jan 2021 12:36:04 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmap: replace if (cond) BUG() with BUG_ON()
Message-ID: <X/dGhD/R8r5yeElq@redhat.com>
References: <1607743586-80303-1-git-send-email-alex.shi@linux.alibaba.com>
 <1607743586-80303-2-git-send-email-alex.shi@linux.alibaba.com>
 <e50574aa-87b8-8ddf-2235-ef98e22bcb7d@linux.alibaba.com>
 <alpine.LSU.2.11.2101051919130.1361@eggly.anvils>
 <20210106114620.5c221690f3a9cad7afcc3077@linux-foundation.org>
 <X/YY+mjpq15nmryI@redhat.com>
 <alpine.LSU.2.11.2101061213540.2492@eggly.anvils>
 <bd10e2dc-7a5e-835d-9a1f-9fff36cc22b5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd10e2dc-7a5e-835d-9a1f-9fff36cc22b5@suse.cz>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 06:28:29PM +0100, Vlastimil Babka wrote:
> On 1/6/21 9:18 PM, Hugh Dickins wrote:
> > On Wed, 6 Jan 2021, Andrea Arcangeli wrote:
> >> 
> >> I'd be surprised if the kernel can boot with BUG_ON() defined as "do
> >> {}while(0)" so I guess it doesn't make any difference.
> > 
> > I had been afraid of that too, when CONFIG_BUG is not set:
> > but I think it's actually "if (cond) do {} while (0)".
> 
> It's a maze of configs and arch-specific vs generic headers, but I do see this
> in include/asm-generic/bug.h:
> 
> #else /* !CONFIG_BUG */
> #ifndef HAVE_ARCH_BUG
> #define BUG() do {} while (1)
> #endif
> 
> So seems to me there *are* configurations possible where side-effects are indeed
> thrown away, right?

But this not BUG_ON, and that is an infinite loop while(1), not an
optimization away as in while (0) that I was suggesting to just throw
away cond and make it a noop. BUG() is actually the thing to use to
move functional stuff out of BUG_ON so it's not going to be causing
issues if it just loops.

This overall feels mostly an aesthetically issue.

Thanks,
Andrea

