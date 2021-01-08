Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385632EF2A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbhAHMtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbhAHMtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:49:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1A0423975;
        Fri,  8 Jan 2021 12:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610110103;
        bh=36VZw2L66bGcuQh5lKshp8v9vfagj/C2VUJhkwmPQHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iT3tw22cOC4rEe+FXic7rm/lVuU6IAYPYgodiMJg6+41ROlW354+Xhu2uBi2ND02D
         rwBxzIxxfFUDXwiR4kAnDgpY5u5QTqx6PR1Eo5fH/GrpHPcna+ONSNYSXbgEu6sKj1
         /CL1n30AYNwZZwaEptIULV8Vn8WJ0GrdWOodfppdOI6QTU1lQV4ubFwY60TRCw18R4
         niyvX3VogLN3wRZArtLNPT000RvUjSwgItDZeAEoDFbRRmF+H1GRnsGwNuZ656+xGW
         ovwZdvqeVcPcYz/dTQPpOntJI2oEWl5HKdQhtwvsLn3T/8y3s7geRpZibEkO4h1RRy
         h4DvBXWUYX13Q==
Date:   Fri, 8 Jan 2021 12:48:16 +0000
From:   Will Deacon <will@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce
 wrprotect_tlb_flush_pending
Message-ID: <20210108124815.GA4512@willie-the-truck>
References: <20210107200402.31095-1-aarcange@redhat.com>
 <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com>
 <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com>
 <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com>
 <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 04:25:54PM -0800, Linus Torvalds wrote:
> Please. Why is the correct patch not the attached one (apart from the
> obvious fact that I haven't tested it and maybe just screwed up
> completely - but you get the idea)?

It certainly looks simple and correct to me, although it means we're now
taking the mmap sem for write in the case where we only want to clear the
access flag, which should be fine with the thing only held for read, no?

Will
