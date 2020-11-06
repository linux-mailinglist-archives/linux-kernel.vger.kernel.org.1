Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0292A9AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 18:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgKFRRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 12:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFRRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:17:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 09:17:19 -0800 (PST)
Date:   Fri, 6 Nov 2020 18:17:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604683037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGKArt70WvEzDhknOx9Bw2ar6sCsCGBDr/06mOik2gM=;
        b=g/eVfSww/b1CEhuL2eMyf53TmumsVIW07T1fqEHtbVMmtgSmmYeKcdl1yN1XXv1uiKZbNt
        /v1rZjjcYQHJ+yBllEStZOSdwmKl+XmcUKQPV6lfIz8n5mVLG23GY2coQEFPBQdA6+fxeW
        Qlj6cmvSt2hkW8+S7ZePjBNeKQQZLsBq3dvNggfK9XXctqgqcGrKUZb18HrDVOApdO13ID
        UpYaVjNwa5gYxqvbGdCVK2pikVZDL5TRXxGGMY2GglwzCuwFrxwb+RXykwXCzpxKUWprNv
        /7ID/XVjSlO5usvGZmU1Ck5nkxUin+tUckvEcEdMRGhhLEM9VQpbsLYbtPKThg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604683037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AGKArt70WvEzDhknOx9Bw2ar6sCsCGBDr/06mOik2gM=;
        b=WiqldJ8yVWQCUmLRrVxIGMZ/Uj7faaADiudmoEnof1cifn4Yf97DuPNw8rTttyw4Y2PVQy
        nZEopSnPd0IdpnAg==
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
        Peter Zijlstra <peterz@infradead.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 2/2] mm: prevent gup_fast from racing with COW during
 fork
Message-ID: <20201106171716.GA91138@lx-t490>
References: <0-v3-7358966cab09+14e9-gup_fork_jgg@nvidia.com>
 <2-v3-7358966cab09+14e9-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v3-7358966cab09+14e9-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Nov 06, 2020 at 11:55:14AM -0400, Jason Gunthorpe wrote:
...
> +	if (gup_flags & FOLL_PIN) {
> +		seq = raw_read_seqcount(&current->mm->write_protect_seq);
> +		if (seq & 1)
> +			return 0;
> +	}
> +
...
> +	if (gup_flags & FOLL_PIN) {
> +		if (read_seqcount_t_retry(&current->mm->write_protect_seq,
> +					  seq)) {
> +			unpin_user_pages(pages, nr_pinned);
> +			return 0;
> +		}
> +	}

From seqlock.h:

    /**
     * raw_read_seqcount() - read the raw seqcount_t counter value
     * ...
     * Return: count to be passed to read_seqcount_retry()
     */
    #define raw_read_seqcount(s)

Please avoid using the internal API (read_seqcount_*t*_retry) and just
use read_seqcount_retry() as the documentation suggests.

(I guess you just missed changing that last one... I'm in process of
 changing all these "*_seqcount_t_*" stuff to "do_*" as we talked on the
 v2 thread. Hopefully there will be no more confusion after that.)

Kind regards,

--
Ahmed S. Darwish
Linutronix GmbH
