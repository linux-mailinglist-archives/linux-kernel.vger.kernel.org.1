Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1642F5884
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbhANChS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726792AbhANChQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610591749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2mud6EOiQWTPZLSAaAQAKID8YRfEwmVBCdj5DWD16lE=;
        b=LLeX7Yj/6c+X+liywIL+uphzG/UdkNpIcCwEVSeZ/LApXCkIIYTQU0kr3ybDvcEekrFuqK
        Dhwlc3v2XwFWH9MfGK/V0Ts7GjtCcJwXL2DgT1hj3Jzzz37bgSaMInkAtatVHYOY3InJJO
        IQnfw9XkRTyn7NlrlvOyBTJ+xhjSNkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-IOSZym_oN-CrdgfWwCkC-Q-1; Wed, 13 Jan 2021 21:35:45 -0500
X-MC-Unique: IOSZym_oN-CrdgfWwCkC-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C08FE758;
        Thu, 14 Jan 2021 02:35:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-31.rdu2.redhat.com [10.10.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5ADE1001B2C;
        Thu, 14 Jan 2021 02:35:32 +0000 (UTC)
Date:   Wed, 13 Jan 2021 21:35:30 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yu Zhao <yuzhao@google.com>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210114023530.GB535630@redhat.com>
References: <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210108181945.GF504133@ziepe.ca>
 <X/jgLGPgPb+Xms1t@redhat.com>
 <20210109004255.GG504133@ziepe.ca>
 <20210113215638.GA528828@redhat.com>
 <20210113233936.GE4605@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210113233936.GE4605@ziepe.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:39:36PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 13, 2021 at 04:56:38PM -0500, Jerome Glisse wrote:
> 
> > is a broken model and the way GPU use GUP is less broken then RDMA. In
> > GPU driver GUP contract with userspace is that the data the GPU can
> > access is a snapshot of what the process memory was at the time you
> > asked for the GUP. Process can start using different pages right after.
> > There is no constant coherency contract (ie CPU and GPU can be working
> > on different pages).
> 
> Look at the habana labs "totally not a GPU" driver, it doesn't work
> that way, GPU compute operations do want coherency.
> 
> The mmu notifier hackery some of the other GPU drivers use to get
> coherency requires putting the kernel between every single work
> submission, and has all kinds of wonky issues and limitations - I
> think it is net worse approach than GUP, honestly.

Yes what GPU driver do today with GUP is wrong but it is only
use for texture upload/download. So that is a very limited
scope (amdkfd being an exception here).

Yes also to the fact that waiting on GPU fence from mmu notifier
callback is bad. We are thinking on how to solve this.

But what do matter is that hardware is moving in right direction
and we will no longer need GUP. So GUP is dying out in GPU
driver.

Cheers,
Jérôme

