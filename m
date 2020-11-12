Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CA52B0070
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 08:42:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKLHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 02:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgKLHmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:42:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5051C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 23:42:02 -0800 (PST)
Date:   Thu, 12 Nov 2020 08:41:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605166920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0RO/KXPuo820PeoOyJf3Cwi0iqYWsAKrGI/WP0PspU=;
        b=tC0gOAQfFEalLGrCM9UNsK+rJvXctYRspBsP6+ftazL+w+xk4aJDFq7GJ+YGCpZ0lWCcAC
        svC6GLtPI2X3rYgASnx/94XnlESJhPljUIr93klkqZGb1OZ4VwDGptgKUNEX/qJGhX+UKy
        giUoQiumy0dS18LSJQ2Ssfw1DSDTdtkn20D3h+EhCEGzi6qmTNAqZFp96svhEY01IxHeE2
        QCA+8z1Ao07LYbfyyixL9m5Q8aLqG7PI0OwaSFjnzLCgXkjV7f0BOMUAP5We4f/O62xghq
        esgmNyFVgnIpkwjBZL2sSo25tuXG1NjmANmhLC5GyKGoabrJJE2v2BD6bjj59g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605166920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C0RO/KXPuo820PeoOyJf3Cwi0iqYWsAKrGI/WP0PspU=;
        b=evxEaMPD0PKCsm0afFHN/68H/xCD73SSgRp9LRvca7ec6QRutcUv6JQPVzqeaixqpKnNps
        8FaZH4CULP/+NDBA==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v4 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <X6znRv2Bq/LNGNsz@lx-t490>
References: <0-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
 <2-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v4-908497cf359a+4782-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:44:09PM -0400, Jason Gunthorpe wrote:
...
>
> Fixes: f3c64eda3e50 ("mm: avoid early COW write protect games during fork()")
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/r/CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

Thanks for the v3 and v4 updates.

For the seqcount_t parts:

  Acked-by: "Ahmed S. Darwish" <a.darwish@linutronix.de>
