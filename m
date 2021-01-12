Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662D82F252F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbhALA6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729918AbhALA6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:58:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45BBE2253A;
        Tue, 12 Jan 2021 00:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1610413082;
        bh=0IbP6+yAHA6WBKI+PXFr6t+4Edq3ezr16QrKJO3wgBw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A6izqXLA99i7sd9NLwPIoH0d8c/1eFPcKbFJ/gcfNZTLoI0KKY0DOOXiY0oC3Sld5
         ukFNIcoiA7YwQmGao5t3i7O84n61o5VLD2HyjC4J6/vdwLYCm6Hs6fo7nXM9vDDUun
         H4Uwqm6huCO88se2fwlFjLGFjxbgO1FTiS8D7IHw=
Date:   Mon, 11 Jan 2021 16:58:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v3 0/2] mm: fix initialization of struct page for holes
 in  memory layout
Message-Id: <20210111165801.ef35b01b15132d5513b2f3ce@linux-foundation.org>
In-Reply-To: <20210111194017.22696-1-rppt@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 21:40:15 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> Commit 73a6e474cb37 ("mm: memmap_init: iterate over
> memblock regions rather that check each PFN") exposed several issues with
> the memory map initialization and these patches fix those issues.
> 
> Initially there were crashes during compaction that Qian Cai reported back
> in April [1]. It seemed back then that the problem was fixed, but a few
> weeks ago Andrea Arcangeli hit the same bug [2] and there was an additional
> discussion at [3].

The earlier version of these fixes had cc:stable.  Was the omission
this time deliberate?
