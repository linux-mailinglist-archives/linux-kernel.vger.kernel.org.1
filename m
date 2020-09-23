Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2742751E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726448AbgIWGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600843976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wkDalf6dpTOKDWnNv+ft21nXrG8JW1W9t9KYuN4hJoc=;
        b=Iyt2V0sDD5TAl4n6xFoPes1q19qTYhieoFmCBTLFP9V+VInEMP9zetY8j0l9v/AD8HCWdi
        9BbSu3/AW3jNJSUccchIE3ipidun6e12040t74Yupyz3sEmUTNcPoXNZ2uFlo01J7DQdRi
        QHP186OuuXQzgJAsLXHTJ7u7ssR3890=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-HTRZin0UOEWzwhxFBk4ilQ-1; Wed, 23 Sep 2020 02:52:51 -0400
X-MC-Unique: HTRZin0UOEWzwhxFBk4ilQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E15161891E8B;
        Wed, 23 Sep 2020 06:52:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id E3CCB5D9CC;
        Wed, 23 Sep 2020 06:52:38 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 23 Sep 2020 08:52:48 +0200 (CEST)
Date:   Wed, 23 Sep 2020 08:52:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
Message-ID: <20200923065237.GA21395@redhat.com>
References: <20200921211744.24758-4-peterx@redhat.com>
 <20200922100840.GA11679@redhat.com>
 <20200922101815.GB11679@redhat.com>
 <20200922153612.GF19098@xz-x1>
 <20200922154845.GE11679@redhat.com>
 <20200922160330.GH19098@xz-x1>
 <20200922165354.GG11679@redhat.com>
 <20200922181306.GJ19098@xz-x1>
 <20200922182317.GH11679@redhat.com>
 <20200922184905.GM19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922184905.GM19098@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Peter Xu wrote:
>
> On Tue, Sep 22, 2020 at 08:23:18PM +0200, Oleg Nesterov wrote:
> >
> > But I still think that !pte_none() -> pte_none() transition is not possible
> > under mmap_write_lock()...
> >
> > OK, let me repeat I don't understans these code paths enough, let me reword:
> > I don't see how this transition is possible.
>
> Though I guess I'll keep my wording, because I still think it's accurate to
> me. :)
>
> Can we e.g. punch a page hole without changing vmas?

punch a hole? I don't know what does it mean...

However, I think you are right anyway. I forgot that (at least) truncate can
clear this pte without mmap_sem after pte_unmap_unlock().

So I think you are right, the current code is wrong too.

Thanks!

Oleg.

