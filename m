Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375322EE813
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbhAGWEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726477AbhAGWEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610056985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JrnpLFfBtiXLpDV0Rk0B5DNVndwdwJuqAhmGaVVEq5M=;
        b=SC5JuOcPWBLKD10fx0XZnpjUcJ2KJaWr/GDS2iEHPC6lzeRPnVX1F7r3G1hpShDKnq7TMf
        xWNRT61n/7uZ7wftoAfxl7W0ewbWNV2rvoBqKj8ZBFdpoZ4mZ8fxv/PxEU9LOMJzNqGKkz
        W2nKK3eLbBWMHch2a9Hy6DfyxkFUgjg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-KF08uPqtPfmCwAVyIqqE-g-1; Thu, 07 Jan 2021 17:03:01 -0500
X-MC-Unique: KF08uPqtPfmCwAVyIqqE-g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A57351842140;
        Thu,  7 Jan 2021 22:02:57 +0000 (UTC)
Received: from mail (ovpn-112-222.rdu2.redhat.com [10.10.112.222])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74BCB6090F;
        Thu,  7 Jan 2021 22:02:51 +0000 (UTC)
Date:   Thu, 7 Jan 2021 17:02:50 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <X/eFCt/lxRKgoPXu@redhat.com>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com>
User-Agent: Mutt/2.0.4 (2020-12-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 01:05:19PM -0800, Linus Torvalds wrote:
> I think those would very much be worth fixing, so that if
> UFFDIO_WRITEPROTECT taking the mmapo_sem for writing causes problems,
> we can _fix_ those problems.
> 
> But I think it's entirely wrong to treat UFFDIO_WRITEPROTECT as
> specially as Andrea seems to want to treat it. Particularly with
> absolutely zero use cases to back it up.

Again for the record: there's nothing at all special in
UFFDIO_WRITEPROTECT in this respect.

If you could stop mentioning UFFDIO_WRITEPROTECT and only focus on
softdirty/clear_refs, maybe you wouldn't think my judgment is biased
towards clear_refs/softdirty too.

You can imagine the side effects of page_count doing a COW
erroneously, as corollary of the fact that KSM won't ever allow to
merge two pages if one of them is under GUP pin. Why is that?

Thanks,
Andrea

