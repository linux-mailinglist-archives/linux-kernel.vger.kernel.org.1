Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C165274873
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgIVSoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726573AbgIVSoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600800254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j6MP6GjsyhJTZoS+wvVeQLSanb3L9bd67goL6s8H9bY=;
        b=P9tMI7aEifqUn64FnpsBK/nD5Zou6G7WAa6Yzemi3NQI4XW3EooQL4s8CPdFp6hfUXZYKR
        TDosnR0qTxiavNgHRb0MfzbnhijB3/PqxEc+ysA3MaQfvmfAPYcNhpuzEGkHlGpBAc/VR4
        QiX4Nnw1o3k93jnmE8GMqHALGO/tXlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-rEpsucqAN32nwnaZAUjGxQ-1; Tue, 22 Sep 2020 14:44:11 -0400
X-MC-Unique: rEpsucqAN32nwnaZAUjGxQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12DAC8030A6;
        Tue, 22 Sep 2020 18:44:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.146])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC09B1A800;
        Tue, 22 Sep 2020 18:44:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 22 Sep 2020 20:44:08 +0200 (CEST)
Date:   Tue, 22 Sep 2020 20:44:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 4/5] mm: Do early cow for pinned pages during fork() for
 ptes
Message-ID: <20200922184359.GI11679@redhat.com>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200921212028.25184-1-peterx@redhat.com>
 <20200922114839.GC11679@redhat.com>
 <20200922124013.GD11679@redhat.com>
 <20200922155842.GG19098@xz-x1>
 <20200922165216.GF11679@redhat.com>
 <20200922183438.GL19098@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922183438.GL19098@xz-x1>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22, Peter Xu wrote:
>
> Or I can also do it in inverted order if you think better:
>
>         if (unlikely(copy_ret == COPY_MM_BREAK_COW)) {
>                 WARN_ON_ONCE(!data.cow_new_page);
>                 ...
>         }

Peter, let me say this again. I don't understand this code enough, you
can safely ignore me ;)

However. Personally I strongly prefer the above. Personally I really
dislike this part of 4/5:

	 again:
	+	/* We don't reset this for COPY_MM_BREAK_COW */
	+	memset(&data, 0, sizeof(data));
	+
	+again_break_cow:

If we rely on "copy_ret == COPY_MM_BREAK_COW" we can unify "again" and
"again_break_cow", we don't need to clear ->cow_new_page, this makes the
logic more understandable. To me at least ;)

Oleg.

