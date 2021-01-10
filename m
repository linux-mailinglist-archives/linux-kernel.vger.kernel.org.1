Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD82F04D4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 03:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbhAJCzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 21:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbhAJCzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 21:55:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610247257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0lsGiAp4OZqs9wvk+K6X/L1B2hilo3HINPCrgGAl81w=;
        b=JxyUPgwxpt6/PqZtbDVzcO27oOuz56n1twXuwz7ZoY9EHFEDT5hQarvGwtF7SqTCZA1g5a
        pcUYRDCliH9rjHp+h8Dborg/ZbVKMLxm2TCz7f0TFmEX3PYBsiRnbIhwx0diI6frW5WjVw
        NMPT8ZZCcCSSM+A8+TiYhCuslK7jbhE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-lY45d8mIMyaLP5BoYyCc2w-1; Sat, 09 Jan 2021 21:54:15 -0500
X-MC-Unique: lY45d8mIMyaLP5BoYyCc2w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9968159;
        Sun, 10 Jan 2021 02:54:12 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 736E05D9D3;
        Sun, 10 Jan 2021 02:54:06 +0000 (UTC)
Date:   Sat, 9 Jan 2021 21:54:05 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/1] mm: restore full accuracy in COW page reuse
Message-ID: <X/psTXZp9xNgX3gE@redhat.com>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <20210110004435.26382-2-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110004435.26382-2-aarcange@redhat.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jan 09, 2021 at 07:44:35PM -0500, Andrea Arcangeli wrote:
> allowing a child to corrupt memory in the parent. That's a problem
> that could happen not-maliciously too. So the scenario described

I updated the above partly quoted sentence since in the previous
version it didn't have full accuracy:

https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=fc5a76b1c14e5e6cdc64ece306fc03773662d98a

"However since a single transient GUP pin on a tail page, would elevate
the page_count for all other tail pages (unlike the mapcount which is
subpage granular), the COW page reuse inaccuracy would then cross
different vmas and the effect would happen at a distance in vma of
different processes. A single GUP pin taken on a subpage mapped in a
different process could trigger 511 false positive COWs copies in the
local process, after a fork()."

This a best effort to try to document all side effects, but it'd be
great to hear from Kirill too on the above detail to have
confirmation.

Thanks and have a great weekend everyone,
Andrea

