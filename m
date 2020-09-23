Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D444B275C00
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIWPhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIWPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600875453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JicKQA4BS2AeARqjvqW/mkb4QGFKS6bxgbM2Y52Kx4g=;
        b=InU1H8NWp9E4qI+Mq8T7xpkBthgShfh5GCR2FFvZYKGWPep5fTYUDphIoQGhwzXl1YYlHO
        ZICSh/1mRr6I37pBbb0QaENeMqDyaLOHOJ8v68/er3rsgj8miy/Y3Xtd7c9L2vk+3soobl
        6C4T3auoQ3MXSF7lmjeElysjpbAiOfk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-kq3IqOUyPTCuD-CxLnyMJw-1; Wed, 23 Sep 2020 11:37:29 -0400
X-MC-Unique: kq3IqOUyPTCuD-CxLnyMJw-1
Received: by mail-qt1-f199.google.com with SMTP id b39so86791qta.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 08:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JicKQA4BS2AeARqjvqW/mkb4QGFKS6bxgbM2Y52Kx4g=;
        b=amGE2LG5nz2w2MKKhnOZpr0/8sMKihFCNu4TuGKPYnEmXOy2ZKJKZvMaYDRqBkxz9p
         2gJqNHg2oI5SpsS3X5HfhfF54J7dtqdc6iLmJ7O6KY5sApMyJdL9OunSU63kiLUqRBpl
         VeN+t5tJ5lSgCJ8Ckl2fj3MzXlVm4HTsXitcRhk36Iq8hVSUiuPhhA/9cLJZ6Ak+sGRI
         +BESQk0XTS4CyuYjPiJ+Nk4WV6ev686jS9uTxW8gmEKova2mYOsEhPNocyAipLUL8xUo
         T+6Q9PPg0c3FDv0NaLzl/t0RNQnprt4WLhKWsSAqXDOWXy2BRWxNWnxHJzMo4Ze9A/ah
         +Fcg==
X-Gm-Message-State: AOAM530olHdpaPFFodR2YBEp6pEwqCCGMh8KkBDyE7NwBjSFsPZXfYvy
        FCOgaHrawVltfJ7qth6xyn/kQxRFMeKW+q6I/omVSjz1svkLmlYgIZv+cZSTySErwNdq/jGX2wb
        gSMAN3/mJhM/AJcvHmzzRG3Bo
X-Received: by 2002:a37:ef05:: with SMTP id j5mr441968qkk.456.1600875448567;
        Wed, 23 Sep 2020 08:37:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5Y/WqTPBdPVl7k7rHlQuvZjRvdy3ng6anDeCQEguVdk9j1bEqKzIDnsXNENvW9mVgbaqJ/w==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr441939qkk.456.1600875448372;
        Wed, 23 Sep 2020 08:37:28 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id 145sm225609qkf.18.2020.09.23.08.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:37:27 -0700 (PDT)
Date:   Wed, 23 Sep 2020 11:37:26 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Leon Romanovsky <leonro@nvidia.com>
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
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/5] mm: Break COW for pinned pages during fork()
Message-ID: <20200923153726.GD59978@xz-x1>
References: <20200921211744.24758-1-peterx@redhat.com>
 <20200923102119.GK1223944@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200923102119.GK1223944@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:21:19PM +0300, Leon Romanovsky wrote:
> Hi Peter,
> 
> I'm ware that this series is under ongoing review and probably not
> final, but we tested anyway and it solves our RDMA failures.

Hi, Leon,

Yes I think there'll definitely be more version(s), but thank you for the quick
follow up!  This is a very valuable information to know that we're at least
with a good base point.

Thanks,

-- 
Peter Xu

