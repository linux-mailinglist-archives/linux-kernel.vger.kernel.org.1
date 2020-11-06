Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFBC2A9CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 19:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgKFSwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 13:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgKFSwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 13:52:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35ADDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 10:52:54 -0800 (PST)
Date:   Fri, 6 Nov 2020 19:52:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604688772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkB+nPiTqd0ov6gJZapMyoAvwMdJAByGg5JH/L4gbn8=;
        b=hdPIudFWcETkWOjaJvsRugVdIEtO9j6JQ7akRq5keNWer4sEVJkVOfD7eMrMq0rVsaXDja
        VUr2ObK72R6Eu2FAGiI8cHRjeskZpqbdbHWaLxw7r2kqUn3sP76DVWjNHeCjNGcwKjRyoo
        Q34wjOXwwAyA+ruNbnuUl5CUlXkho6Wu2+N4+2VVHqrsZze978Rb/6fbYQ53FA3HqRgdpM
        jagNuPg7mdgbHceZ+CmfpZAlxJkIeBfvSv2rNPWZFxaPvMOKbQCmSsnH8kAwZ5aDQm5RSV
        dpAVZvMv7fZTE5I6pcE+icDsOEV29PqyNNrNGLsaIt2nCFwLQ6wb7awjRad3FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604688772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xkB+nPiTqd0ov6gJZapMyoAvwMdJAByGg5JH/L4gbn8=;
        b=tdG/lnQyhpZP30eMeUHc/jRaEKAc1OSnRkAuhSRbg8Hm5poYn0m3uCat8tGQ5kSYXrcGRA
        78uf4K/NwzwMhgBA==
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
        Oleg Nesterov <oleg@redhat.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 0/2] Add a seqcount between gup_fast and
 copy_page_range()
Message-ID: <20201106185250.GA90682@lx-t490>
References: <0-v3-7358966cab09+14e9-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0-v3-7358966cab09+14e9-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:55:12AM -0400, Jason Gunthorpe wrote:
...
>
>  arch/x86/kernel/tboot.c    |   1 +
>  drivers/firmware/efi/efi.c |   1 +
>  include/linux/mm_types.h   |   8 +++
>  kernel/fork.c              |   1 +
>  mm/gup.c                   | 118 +++++++++++++++++++++++--------------
>  mm/init-mm.c               |   1 +
>  mm/memory.c                |  13 +++-
>  7 files changed, 97 insertions(+), 46 deletions(-)
>

Nitpick: Please also use the "--base" option of git format-patch. This
will produce a nice "base-commit: " tag behind the diffstat.

Konstantin's amazing "b4" tool gets much happier with that ;-)

All the best,

--
Ahmed S. Darwish
Linutronix GmbH
