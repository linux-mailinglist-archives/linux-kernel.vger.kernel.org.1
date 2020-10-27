Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDDB529A87C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896489AbgJ0J4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:56:19 -0400
Received: from verein.lst.de ([213.95.11.211]:38240 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410126AbgJ0Jzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:55:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D8C2068B02; Tue, 27 Oct 2020 10:55:45 +0100 (CET)
Date:   Tue, 27 Oct 2020 10:55:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201027095545.GA30382@lst.de>
References: <1-v1-281e425c752f+2df-gup_fork_jgg@nvidia.com> <16c50bb0-431d-5bfb-7b80-a8af0b4da90f@nvidia.com> <20201027093301.GA16090@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027093301.GA16090@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:33:01AM +0100, Jan Kara wrote:
> Actually there are callers that care about partial success. See e.g.
> iov_iter_get_pages() usage in fs/direct_io.c:dio_refill_pages() or
> bio_iov_iter_get_pages(). These places handle partial success just fine and
> not allowing partial success from GUP could regress things...

But most users do indeed not care.  Maybe an explicit FOLL_PARTIAL to
opt into partial handling could clean up a lot of the mess.  Maybe just
for pin_user_pages for now.
