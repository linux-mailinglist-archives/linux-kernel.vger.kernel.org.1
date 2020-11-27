Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF3D2C65AF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgK0MW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgK0MW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:22:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6A6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 04:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=choHEX39fwjvIHdfjuTPrJ1YjikPg/jnYxn1TmDtc0c=; b=XpQwbtkUZlyFEyFnSy6qiJsW4P
        3MfAz2eBtzlGpJBA/yFDWeCxb48hdRy+zC5dNmxXJnzZMvqoz0z5j4gEe2sKOXmf2Xk1mqRSo0o6/
        4uMIEJ1ODrhQ/lCU2Az3OY1wTo+KU/9nFoRVuS5ABU4ZMUUVy8DLQTCkSp9buLpv0THNUGkxYw0MV
        /WVL8SDXzVQ8ahtpRWWhHxgNxGuGJBb9eDNRaQQqY1AHTkiLIoubF0jDtayOpHgC1ihosx4yxboYi
        sAJziN1MN7uvsRYqvZ7UGR6OAbsJJpVz+fzoQsc91p+s8Z/rP8BWt8uMzRSOYRwspGW9BqFSMXc6t
        KUrHVqug==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kicld-0003jP-23; Fri, 27 Nov 2020 12:22:25 +0000
Date:   Fri, 27 Nov 2020 12:22:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] mm: Don't fault around userfaultfd-registered regions on
 reads
Message-ID: <20201127122224.GX4327@casper.infradead.org>
References: <20201126222359.8120-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126222359.8120-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 05:23:59PM -0500, Peter Xu wrote:
> For missing mode uffds, fault around does not help because if the page cache
> existed, then the page should be there already.  If the page cache is not
> there, nothing else we can do, either.  If the fault-around code is destined to
> be helpless for userfault-missing vmas, then ideally we can skip it.

But it might have been faulted into the cache by another task, so skipping
it is bad.

> For wr-protected mode uffds, errornously fault in those pages around could lead
> to threads accessing the pages without uffd server's awareness.  For example,
> when punching holes on uffd-wp registered shmem regions, we'll first try to
> unmap all the pages before evicting the page cache but without locking the
> page (please refer to shmem_fallocate(), where unmap_mapping_range() is called
> before shmem_truncate_range()).  When fault-around happens near a hole being
> punched, we might errornously fault in the "holes" right before it will be
> punched.  Then there's a small window before the page cache was finally
> dropped, and after the page will be writable again (NOTE: the uffd-wp protect
> information is totally lost due to the pre-unmap in shmem_fallocate(), so the
> page can be writable within the small window).  That's severe data loss.

Sounds like you have a missing page_mkwrite implementation.

> This patch comes from debugging a data loss issue when working on the uffd-wp
> support on shmem/hugetlbfs.  I posted this out for early review and comments,
> but also because it should already start to benefit missing mode userfaultfd to
> avoid trying to fault around on reads.

A measurable difference?
