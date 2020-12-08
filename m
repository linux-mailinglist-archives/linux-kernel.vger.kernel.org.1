Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0E22D20BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgLHCWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:35120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgLHCWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:22:43 -0500
Date:   Mon, 7 Dec 2020 18:22:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607394122;
        bh=qU6zM7QAs82ehJmwX3kZ3oZRWj6vTv8kXeUUdmv6o8A=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=HxySnUMJM74ZwVbsjYl7JeIR4PwaISWikylUvKa0Vsta5/e56ijMO/2ZUrCeB0Sv/
         D5Eu3IhSbb2ECL6yExnVgG6ZdSf9380fBCGY4qfzYI6+irLA5Eb8qLA1+xZkNSze5t
         VbuwSKVX6Kq4tB/KnzJG3v1OiHgz9gjepiAWT5hQ=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,memory_failure: Always pin the page in
 madvise_inject_error
Message-Id: <20201207182200.21f97d90211c78609ffd7351@linux-foundation.org>
In-Reply-To: <20201207094818.8518-1-osalvador@suse.de>
References: <20201207094818.8518-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  7 Dec 2020 10:48:18 +0100 Oscar Salvador <osalvador@suse.de> wrote:

> madvise_inject_error() uses get_user_pages_fast to translate the
> address we specified to a page.
> After [1], we drop the extra reference count for memory_failure() path.
> That commit says that memory_failure wanted to keep the pin in order
> to take the page out of circulation.
> 
> The truth is that we need to keep the page pinned, otherwise the
> page might be re-used after the put_page() and we can end up messing
> with someone else's memory.
> 
> E.g:
> 
> CPU0
> process X					CPU1
>  madvise_inject_error
>   get_user_pages
>    put_page
> 					page gets reclaimed
> 					process Y allocates the page
>   memory_failure
>    // We mess with process Y memory
> 
> madvise() is meant to operate on a self address space, so messing with
> pages that do not belong to us seems the wrong thing to do.
> To avoid that, let us keep the page pinned for memory_failure as well.
> 
> Pages for DAX mappings will release this extra refcount in
> memory_failure_dev_pagemap.

Does the bug have any known user-visible effects?  Is a deliberate
exploit conceivable?

IOW, cc:stable and if so, why?
