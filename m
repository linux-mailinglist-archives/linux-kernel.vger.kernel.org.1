Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC22EF328
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbhAHNhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbhAHNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:37:32 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39747C0612F4
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 05:36:52 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id 14so8977660ilq.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ehVJZhNwbv/+X0MqNJz70oUJLCNIbym2FZsQKK9qJjI=;
        b=oICYMf9NNsqqEXfxvdnVjhRU6h75pdbaXZDFqkKqkmskLgh/sYnVnxQQJaydrfPQHG
         VmLJViuGJPuqcbV5E2RwKQnpWqKF/GI6gnWpwIsM5SlKGVgSYPHCBJzdc1DFj81jPhSA
         n9hOwHJS267m3LqQyZR3AieB+dihA/BHt7LYbTDJzydcXgD5PADdq3ui4N6v79qQDdHl
         eM4y03Bwf7WRXSiNdAA2sKEeLY96l1sMbbL27obXorjW/Syv7SYtaaOOaecWq0Orqgh3
         LLXm83tpodBY2Nh3mkOkdmUKB0g2eANzhTYuOsYpCGwNflGxP07RQHmeolcnoEJzMAtr
         l6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehVJZhNwbv/+X0MqNJz70oUJLCNIbym2FZsQKK9qJjI=;
        b=CA51a+avjs82o6/bGqLpijbvLXPjBnfZ6zxJ0/bD/QYOYeKVUhleqw+WE+bERFRz95
         FiK6FfmIFeVMsYL5BoGJrtbvZkFMXWwCtDoLyYu7CWUlV4hOQm5Hj8yKBOBNfXAA2wMt
         j2bXnuYfA+hMNuYTR3LHdDIz0KDDeJap5rMuRulJfgV11gE/2Je2rUGIfnBrhIJsOqYy
         v+ke4k1Tpc/Cte60JAY7iiyu4WskXScfpWOmnv0mhBZpf9BrJZ0wwUkWY+cOYMTor8Rt
         vJwGnIu45bAaohV4uIQVyyulVtjgVIElf8Hst8j2Upwy4SHsL2qE/3euOLq0AC7dGZi3
         bg5g==
X-Gm-Message-State: AOAM533RTaxWt4drX5rGw9/OfCX2cTrY4sdBJNN5iOEkZlYJrZquUkVe
        YoccITv0cdzBzcYdKmTTCYh21NQSn4nfLg==
X-Google-Smtp-Source: ABdhPJwq/xJLILBlp2Vz6XBMrfMxKijk6BrFhljxHhVPGX05Fl7lTCdfWf4H3M5kvBLcH7kCaam0oA==
X-Received: by 2002:a92:c052:: with SMTP id o18mr3832166ilf.245.1610113011579;
        Fri, 08 Jan 2021 05:36:51 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b82sm7680684ilg.44.2021.01.08.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:36:51 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kxrwf-004Ccq-VY; Fri, 08 Jan 2021 09:36:49 -0400
Date:   Fri, 8 Jan 2021 09:36:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210108133649.GE504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/eA/f1r5GXvcRWH@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:45:33PM -0500, Andrea Arcangeli wrote:
> On Thu, Jan 07, 2021 at 04:25:25PM -0400, Jason Gunthorpe wrote:
> > On Thu, Jan 07, 2021 at 03:04:00PM -0500, Andrea Arcangeli wrote:
> > 
> > > vmsplice syscall API is insecure allowing long term GUP PINs without
> > > privilege.
> > 
> > Lots of places are relying on pin_user_pages long term pins of memory,
> > and cannot be converted to notifiers.
> > 
> > I don't think it is reasonable to just declare that insecure and
> > requires privileges, it is a huge ABI break.
> 
> Where's that ABI? Are there specs or a code example in kernel besides
> vmsplice itself?

If I understand you right, you are trying to say that the 193
pin_user_pages() callers cannot exist as unpriv any more?

The majority cannot be converted to notifiers because they are DMA
based. Every one of those is an ABI for something, and does not expect
extra privilege to function. It would be a major breaking change to
have pin_user_pages require some cap.

> The whole zygote issue wouldn't even register if the child had the
> exact same credentials of the parent. Problem is the child dropped
> privileges and went with a luser id, that clearly cannot ptrace the
> parent, and so if long term unprivileged GUP pins are gone from the
> equation, what remains that the child can do is purely theoretical
> even before commit 17839856fd588f4ab6b789f482ed3ffd7c403e1f.

Sorry, I'm not sure I've found a good explanation how ptrace and GUP
are interacting to become a security problem.

17839 makes sense to me, and read-only GUP has been avoided by places
like RDMA and others for a very long time because of these issues,
adding the same idea to the core code looks OK.

The semantics we discussed during the COW on fork thread for pin user
pages were, more or less, that once pinned a page should not be
silently removed from the mm it is currently in by COW or otherwise in
the kernel.

So maybe ptrace should not be COW'ing pinned pages at all, as that is
exactly the same kind of silent corruption fork was causing.

Jason
