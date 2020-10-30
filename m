Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D512A10F4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 23:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgJ3WhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 18:37:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgJ3WhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 18:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604097422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qq45dMSj/bMik5Wh4gyNqqt1gMuAckWwvWSldBl/aWU=;
        b=aZydHbuLKIjduiW1IfEGPS8blFtsnXDlmYKkr7OoDWfijzIqD/XNjb1ydyh2Uwk0xstIjI
        NK8xBk5p6w0InQFkvDRYb3Tn7k9WL/iM9XMNbMIS510MOl8S1QpvEa10MasEOujavd0X01
        jES4GOVO3xb+LwqvcqfuIWH5KmQCrEg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Ux1AGhKuMRaLFUXnsdjqmQ-1; Fri, 30 Oct 2020 18:36:59 -0400
X-MC-Unique: Ux1AGhKuMRaLFUXnsdjqmQ-1
Received: by mail-qk1-f197.google.com with SMTP id q18so1647069qke.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 15:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qq45dMSj/bMik5Wh4gyNqqt1gMuAckWwvWSldBl/aWU=;
        b=T9gaAgBk6xMeIAVJgbjV1CVYmcFYc0g1E+HZbRHYBzR8Z7MuDkF1XZ0AARJ3esdNRL
         f5FjZlAh+LGtBgbc95MkGnRa7Ga4mcG4r2tZ3CWNxbF92UQFhBpVqSP7X0lKulWdAcSy
         WOM+l4D2/JW2YgS7rxFnd3yw34YY42waS+MdqtDO6EcMDVtchXz5EjEDXoYJD7IXtzxS
         RBmrN/57+dXqa86FmQAfnYPAl+jrFnnL+7ZT5Ud8CSGQwkxT+qvZLFlZA2eKC/ZjORsU
         HzXrvuEDhv1LRDk75JZ0XDP6QTtlnaG/lAQcmwycOfoKXT/QTpgbrEL6X7QYmrWecGLv
         3J7g==
X-Gm-Message-State: AOAM531g2SlWcMUTzOaY6P+n0/VccnOpwZf/xs7T4E7ALyUVfOV9GvU5
        ZATP5o20qF4kj85B6I6lngPDUfEV3QXBAmFwjT6IoG0KnDfuSoKgIulyCUFbiRkT4pkHhLWDvE0
        lbVqGi+S4xhVRnwk8NqoBmf9A
X-Received: by 2002:ac8:71d3:: with SMTP id i19mr4668192qtp.303.1604097418842;
        Fri, 30 Oct 2020 15:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx69YUegI58a8F94tm8MT3wSOUPYJaasS2eaJea/KNCuStGp448Fl2U21ozxonXFxuA0bV+cA==
X-Received: by 2002:ac8:71d3:: with SMTP id i19mr4668171qtp.303.1604097418599;
        Fri, 30 Oct 2020 15:36:58 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca. [174.95.215.133])
        by smtp.gmail.com with ESMTPSA id j16sm3566658qkg.26.2020.10.30.15.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 15:36:57 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:36:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v2 1/2] mm: reorganize internal_get_user_pages_fast()
Message-ID: <20201030223655.GA6357@xz-x1>
References: <0-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
 <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1-v2-dfe9ecdb6c74+2066-gup_fork_jgg@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:46:20AM -0300, Jason Gunthorpe wrote:
> The next patch in this series makes the lockless flow a little more
> complex, so move the entire block into a new function and remove a level
> of indention. Tidy a bit of cruft:
> 
>  - addr is always the same as start, so use start
> 
>  - Use the modern check_add_overflow() for computing end = start + len
> 
>  - nr_pinned/pages << PAGE_SHIFT needs the LHS to be unsigned long to
>    avoid shift overflow, make the variables unsigned long to avoid coding
>    casts in both places. nr_pinned was missing its cast
> 
>  - The handling of ret and nr_pinned can be streamlined a bit
> 
> No functional change.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Sorry for a very late reply (due to other distractions):

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

