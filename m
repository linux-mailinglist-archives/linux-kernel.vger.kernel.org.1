Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4752CF973
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 06:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLEFLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 00:11:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:49678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgLEFLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 00:11:18 -0500
Date:   Fri, 4 Dec 2020 21:10:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607145037;
        bh=l+JQ73ajYdzS8o0e4+RNL0uZERAgdcyKPx/vWiSbNyk=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=nF5Q5QDcqVHZfmoziV4sdgz8hYItV0/1Pxi4pbrQaH5a3ewuAgCe0dIwKtMQJhclR
         4rleG5epn6dlUdW4J22MAUe1xymaLakuAF1502BoEtzRBpyU7h8rGPgoFqLOXuu5DJ
         rUzzjmOpyAiZ1dOBfPPxf85wY9EZ91fJb1ZUeN1o=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org,
        Mike Rapoport Baoquan He <"rppt@kernel.orgbhe"@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Qian Cai <cai@lca.pw>, Vlastimil Babka <vbabka@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] mm: initialize struct pages in reserved regions
 outside of the zone ranges
Message-Id: <20201204211036.48092c4bc83dabd1419f9c71@linux-foundation.org>
In-Reply-To: <20201205013238.21663-1-aarcange@redhat.com>
References: <20201201181502.2340-1-rppt@kernel.org>
        <20201205013238.21663-1-aarcange@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  4 Dec 2020 20:32:37 -0500 Andrea Arcangeli <aarcange@redhat.com> wrote:

> I'm running with these patch applied on all instances as solution to
> the compaction crashes that started to trigger after the v5.9
> upgrade. It's applied on top of
> https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org so
> that it boots and works fine even when there are memblock.reserved
> regions that don't overlap with the memblock.memory (as pfn 0 which is
> in memblock.reserved but not added to memblock.memory).

Are you planning on preparing an applicable-to-mainline version of this?
