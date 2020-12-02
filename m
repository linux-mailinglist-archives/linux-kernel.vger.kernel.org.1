Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1168E2CCAAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387704AbgLBXmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728532AbgLBXmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606952484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMp1kqJBklpxD4W8M6D/zDEhMsXVo1j/mRssWp3lW6A=;
        b=E8i7MTXHmWJHOlJld/6k6e04vcvIzp/RC6d2ji5fIlvbwzRp7Xt2AUGm/kCl+iyzwi3gYa
        TY7Pt/NBf3Sb0XIImVZ/6RU3kfAjvKQrEL+90lYOqSRKR4YvIpUWg02PJ2vIc7M0HC0fpF
        58cLzDKGc/CvEjmG8reFTtu5LBxy4+o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-Cf_N3YNfNcevlmKC2o51lQ-1; Wed, 02 Dec 2020 18:41:20 -0500
X-MC-Unique: Cf_N3YNfNcevlmKC2o51lQ-1
Received: by mail-qt1-f197.google.com with SMTP id d9so141451qtr.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:41:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cMp1kqJBklpxD4W8M6D/zDEhMsXVo1j/mRssWp3lW6A=;
        b=kuCR34GsQrt8RkL0aKBlxdOrsdrQ9AFp7Dc6zPgm+AI6Pahi30qNx4I/pwXPKpKy3e
         qZ+pWBLVYv3gF7K//1jsDPYTXorBQ9DsFdqcnvagmYWl4WXHEPdv0kpuRmDhQTYiHFGr
         V2TrIXESSUULmCSVBIS2rzkhE11S0d9PGhEs1md0kk84pOBVxjZDElg4MuPjqb4U8JJy
         69Sw0OSS/ecdDJ9GQLDBbKUqTct6i30xFHj8/VuROK5lttiSl/RJ6iQi8ZeBwAndgaNy
         vnhRI23vdlvklrFbrpDzZhzeD+OihXOVH4hCmAlPN0/pZBv/dEMgwC34yj7+AwXawMY2
         3TNg==
X-Gm-Message-State: AOAM532YNvaRv2FbxjQz7mfkLILxg4DBWjfc6iR6Ug4SExq1nMgkrrzg
        ukyXJwXKuVDub72kh+6DIs7Jg0LFTtp24T5L5RYoJ8WMBqdrzKhYFdIubJXuCmnivx42VII8LBh
        2qoB9mE8CyIK1dQK3NO8ApuoH
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr248167qkw.147.1606952480314;
        Wed, 02 Dec 2020 15:41:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKaVGTRtF16E8PGvNy2jvo2y+ClJpMXjk2QfrIJLp4FYin344GYLYLvL4cDtW5S+SEnLPSOw==
X-Received: by 2002:a05:620a:95d:: with SMTP id w29mr248151qkw.147.1606952480111;
        Wed, 02 Dec 2020 15:41:20 -0800 (PST)
Received: from xz-x1 ([142.126.94.187])
        by smtp.gmail.com with ESMTPSA id z125sm241884qke.18.2020.12.02.15.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 15:41:19 -0800 (PST)
Date:   Wed, 2 Dec 2020 18:41:17 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] mm: Don't fault around userfaultfd-registered regions
 on reads
Message-ID: <20201202234117.GD108496@xz-x1>
References: <20201130230603.46187-1-peterx@redhat.com>
 <20201201125927.GB11935@casper.infradead.org>
 <20201201223033.GG3277@xz-x1>
 <X8bZk3jTGU8QyJWc@redhat.com>
 <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2012021410260.4989@eggly.anvils>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 02:37:33PM -0800, Hugh Dickins wrote:
> On Tue, 1 Dec 2020, Andrea Arcangeli wrote:
> > 
> > Any suggestions on how to have the per-vaddr per-mm _PAGE_UFFD_WP bit
> > survive the pte invalidates in a way that remains associated to a
> > certain vaddr in a single mm (so it can shoot itself in the foot if it
> > wants, but it can't interfere with all other mm sharing the shmem
> > file) would be welcome...
> 
> I think it has to be a new variety of swap-like non_swap_entry() pte,
> see include/linux/swapops.h.  Anything else would be more troublesome.
> 
> Search for non_swap_entry and for migration_entry, to find places that 
> might need to learn about this new variety.
> 
> IIUC you only need a single value, no need to carve out another whole
> swp_type: could probably be swp_offset 0 of any swp_type other than 0.
> 
> Note that fork's copy_page_range() does not "copy ptes where a page
> fault will fill them correctly", so would in effect put a pte_none
> into the child where the parent has this uffd_wp entry.  I don't know
> anything about uffd versus fork, whether that would pose a problem.

Thanks for the idea, Hugh!

I thought about something similar today, but instead of swap entries, I was
thinking about constantly filling in a pte with a value of "_PAGE_PROTNONE |
_PAGE_UFFD_WP" when e.g. we'd like to zap a page with shmem+uffd-wp. I feel
like the fundamental idea is similar - we can somehow keep the pte with uffd-wp
information even if zapped/swapped-out, so as long as the shmem access will
fruther trap into the fault handler, then we can operate on that pte and read
that information out, like recover that pte into a normal pte (with swap/page
cache, and vma/addr information, we'll be able to) and then we can retry the
fault.

Thanks,

-- 
Peter Xu

