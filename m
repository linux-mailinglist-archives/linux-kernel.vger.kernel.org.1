Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEDC2C66E1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgK0NbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:31:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730101AbgK0NbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606483871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ED8t4Qy7PTQ/kC+YjFAEVvZVdG/aRP0VblcEzp2WkKo=;
        b=RNIs5QbuVYNJQQOoj0IrSav2hbqN2E8+blTaIT74FwEsCwyjyqt4oyj87bjRsQGxTB9ijn
        nqN8f1TjpirKCXTDwPSLU2GjqZU/YVN/hoQ5IyqSlpalTYGPmnDQ53kM2yf1zyusIcbB5r
        Sp8+wwVe+P9yD6yzadlbnsopWSMwmm0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-A2o52v1nMqePDicUBfRBLw-1; Fri, 27 Nov 2020 08:31:10 -0500
X-MC-Unique: A2o52v1nMqePDicUBfRBLw-1
Received: by mail-qk1-f197.google.com with SMTP id p129so3671455qkc.20
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ED8t4Qy7PTQ/kC+YjFAEVvZVdG/aRP0VblcEzp2WkKo=;
        b=Zx7vWshj483tDLgL7ymNYcAxBWeZF5A+oO4Gxp1qmPDR5zgTAktfg3IBhfMY0iTbAx
         p891Gbqh2GTbUEpoKwbvLhiHTCT8KynHu7Slkm0vddfAdD4kGG21XVzmBBBbucGVuIYb
         B+HyKtPJ1FyzwiyU0t7IRPNgoTFR9ckEtcf2vDITzM40XSULzv3u1g6PHEoLNCXhke8p
         E97F5StMBJFlKVJUL8QJTy3xzDzxgkCPzqiJr8hphtP1pGhUz7epzkH+/0gSoceVGwQ5
         24sMkSbMaerDE8BBViYV1pvVz8laIc7bx6xjCv0ZbRQp0lkY/OM2i8guXE4VCxYP7hXf
         ZSCg==
X-Gm-Message-State: AOAM533WEQ+qwOOkidUXGE5nAWL1TqLAWorud7vcX8eTMUd4sWr302Jt
        m2c6xasORoEVUC8c4a6PCvN+Vfkb+3RGGhFm51h52PhFwDL57G25I3kf5Q6AoPqRGgJYe0udh5a
        uC4567zk2pcubtta6XdD5P7rm
X-Received: by 2002:ad4:4b01:: with SMTP id r1mr8236594qvw.51.1606483869219;
        Fri, 27 Nov 2020 05:31:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuuEfzOgED8+Mw/pa0JP/ReXJap7o04I6TP6rj+aZvawEET+ECQspMmP3qAsjMZTSiGhLhSw==
X-Received: by 2002:ad4:4b01:: with SMTP id r1mr8236566qvw.51.1606483868918;
        Fri, 27 Nov 2020 05:31:08 -0800 (PST)
Received: from xz-x1 ([142.126.81.247])
        by smtp.gmail.com with ESMTPSA id p62sm6006251qkf.50.2020.11.27.05.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:31:08 -0800 (PST)
Date:   Fri, 27 Nov 2020 08:31:06 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201127133106.GA6573@xz-x1>
References: <20201126222359.8120-1-peterx@redhat.com>
 <20201127081605.GX123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201127081605.GX123287@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 10:16:05AM +0200, Mike Rapoport wrote:
> On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> > Faulting around for reads are in most cases helpful for the performance so that
> > continuous memory accesses may avoid another trip of page fault.  However it
> > may not always work as expected.
> > 
> > For example, userfaultfd registered regions may not be the best candidate for
> > pre-faults around the reads.
> > 
> > For missing mode uffds, fault around does not help because if the page cache
> > existed, then the page should be there already.  If the page cache is not
> > there, nothing else we can do, either.  If the fault-around code is destined to
> > be helpless for userfault-missing vmas, then ideally we can skip it.
> > 
> > For wr-protected mode uffds, errornously fault in those pages around could lead
> > to threads accessing the pages without uffd server's awareness.  For example,
> > when punching holes on uffd-wp registered shmem regions, we'll first try to
> > unmap all the pages before evicting the page cache but without locking the
> > page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> > before shmem_truncate_range()).  When fault-around happens near a hole being
> > punched, we might errornously fault in the "holes" right before it will be
> > punched.  Then there's a small window before the page cache was finally
> > dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> > information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> > page can be writable within the small window).  That's severe data loss.
> > 
> > Let's grant the userspace full control of the uffd-registered ranges, rather
> > than trying to do the tricks.
> > 
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Andrea Arcangeli <aarcange@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> One nit below, except that
> 
> Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

Thanks!

> > +static inline bool vma_registered_userfaultfd(struct vm_area_struct *vma)
> > +{
> > +	return userfaultfd_missing(vma) || userfaultfd_wp(vma);
> > +}
> 
> We have userfaultfd_armed() that does exectly this, don't we?

Yes, will fix that up.

-- 
Peter Xu

