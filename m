Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A91E92A6E53
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgKDTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgKDTyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:54:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79DC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:54:24 -0800 (PST)
Date:   Wed, 4 Nov 2020 20:54:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604519662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gtsVWgMSeMVXhnpXYOlQXpvYf1v4RBF/nsEHCTo1y4=;
        b=BGTDno4RfZispU1N29WBB7OgsoFmpgpKgMywMwCPYaTfcnhmkx2pCKslxx0QEFy9WMWPnP
        zgBfOj+yD56Rkm9YbIJBI4Ve5DC/tVEHDPAwDt0AKBNwlyBhPPjuGjRrqhttp6V2wMVpeZ
        0qvBrx9D9SkCgRKMqgwYng/sbp8Hj/8mGT07IooFA73BjQeECmPts29kC0tNrZxGp8gzMq
        xE29iY7BGwjdDImUx/GZbOBTfg3fkl9fF+8+1SDSvd5j68KeLD2E0IH2YT+24Lz3tKxkDX
        Nod7gYghL7lZzhTIQG+USCRwmwITkbqHuBnkj7TZzGF9TO2XXoh6MBkXe5m9zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604519662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gtsVWgMSeMVXhnpXYOlQXpvYf1v4RBF/nsEHCTo1y4=;
        b=uGyj84SQ+NJnDhuoQElNPpssM6zhcDzMDZEbjXRujmte1uKv27Go6+e4z9N2J75QeeZhcD
        2P7kKeeosh2ebNCg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201104195420.GA5741@lx-t490>
References: <20201103001712.GB52235@lx-t490>
 <20201103002532.GL2620339@nvidia.com>
 <20201103004133.GD52235@lx-t490>
 <e03dba4e-fd1d-a32c-c99c-fc3fa51419c4@nvidia.com>
 <20201103065225.GA63301@lx-t490>
 <CAHk-=wgB8nyOQufpn0o6a5BpJCJPnXvH+kRxApujhsgG+7qAwQ@mail.gmail.com>
 <20201104013212.GA82153@lx-t490>
 <29e4f7f7-5774-7d8f-694b-75eb55ae1b2e@nvidia.com>
 <20201104031711.GA227990@lx-t490>
 <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wikhGExmprXgaW+MVXG1zsGpztBbVwOb23vetk41EtTBQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 10:38:57AM -0800, Linus Torvalds wrote:
...
>
> Looks reasonable to me.
>
> And can you add a few comments to the magic type macros, so that it's
> a lot more obvious what the end result was.
...
>
> I can see it when I really look, but when looking at the actual use,
> it's very non-obvious indeed.
>

ACK, will do.

>                  Linus

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
