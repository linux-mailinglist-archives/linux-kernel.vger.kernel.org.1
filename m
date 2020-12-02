Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6172CBE73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgLBNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:36:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32591 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgLBNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606916105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IUNhvEsHyr+W6ta/75nQ/HuPXfM1ypWOzhwwE2ms5js=;
        b=BVmMVAb/qotz2Qza4VEA/ydA1TRd09y9g4P4RuxaGZybt5wkdYYhFWFYARuwgI2254DcjZ
        8DnCIhoon08tOfAYTsvuu7MjqPiDI5I1oxBWY7T9T1dItLC/n5f6/H1u1XWwVPjzY5/5Ug
        WOulNNvbhAVVHg/PcBF9pkDSXelgQ6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-4Q8D0UXVOi6CcuFILuUWjQ-1; Wed, 02 Dec 2020 08:35:00 -0500
X-MC-Unique: 4Q8D0UXVOi6CcuFILuUWjQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78DED190D341;
        Wed,  2 Dec 2020 13:34:59 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456675D9C6;
        Wed,  2 Dec 2020 13:34:58 +0000 (UTC)
Message-ID: <1ba3d19ab0629e549519fb94b73cabb0b392fb2a.camel@redhat.com>
Subject: Re: [PATCH 0/7] HWPoison: Refactor get page interface
From:   Qian Cai <qcai@redhat.com>
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Dec 2020 08:34:57 -0500
In-Reply-To: <20201119105716.5962-1-osalvador@suse.de>
References: <20201119105716.5962-1-osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-11-19 at 11:57 +0100, Oscar Salvador wrote:
> Hi,
> 
> following up on previous fix-ups an refactors, this patchset simplifies
> the get page interface and removes the MF_COUNT_INCREASED trick we have
> for soft offline.

Well, the madvise() EIO is back. I don't understand why we can't test it on a
NUMA system before posting this over and over again.

# git clone https://e.coding.net/cailca/linux/mm
# cd mm; make
# ./ranbug 1 
- start: migrate_huge_offline
- use NUMA nodes 0,3.
- mmap and free 8388608 bytes hugepages on node 0
- mmap and free 8388608 bytes hugepages on node 3
madvise: Input/output error

[ 1270.054919][ T7497] Soft offlining pfn 0x1958e00 at process virtual address 0x7f7d9ca00000
[ 1270.067318][ T7497] Soft offlining pfn 0x18d0600 at process virtual address 0x7f7d9c800000
[ 1270.078856][ T7497] Soft offlining pfn 0x1ac800 at process virtual address 0x7f7d9ca00000
[ 1270.091268][ T7497] Soft offlining pfn 0x1e10a00 at process virtual address 0x7f7d9c800000
[ 1270.101946][ T7497] Soft offlining pfn 0x18c800 at process virtual address 0x7f7d9ca00000
[ 1270.111678][ T7497] soft offline: 0x18c800: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.126133][ T7497] Soft offlining pfn 0x18b5400 at process virtual address 0x7f7d9c800000
[ 1270.136581][ T7497] Soft offlining pfn 0x211c00 at process virtual address 0x7f7d9ca00000
[ 1270.146214][ T7497] soft offline: 0x211c00: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.160624][ T7497] Soft offlining pfn 0x19bee00 at process virtual address 0x7f7d9c800000
[ 1270.170896][ T7497] Soft offlining pfn 0x1e21a00 at process virtual address 0x7f7d9ca00000
[ 1270.185011][ T7497] Soft offlining pfn 0x1fd1200 at process virtual address 0x7f7d9c800000
[ 1270.195341][ T7497] Soft offlining pfn 0x1882400 at process virtual address 0x7f7d9ca00000
[ 1270.480593][ T7497] Soft offlining pfn 0x18bc000 at process virtual address 0x7f7d9c800000
[ 1270.491961][ T7497] soft offline: 0x18bc000: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.506018][ T7497] Soft offlining pfn 0x1e76a00 at process virtual address 0x7f7d9c800000
[ 1270.590266][ T7497] Soft offlining pfn 0x1b3c00 at process virtual address 0x7f7d9ca00000
[ 1270.600207][ T7497] soft offline: 0x1b3c00: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.614316][ T7497] Soft offlining pfn 0x1882600 at process virtual address 0x7f7d9c800000
[ 1270.662427][ T7497] Soft offlining pfn 0x1b3c00 at process virtual address 0x7f7d9ca00000
[ 1270.744249][ T7497] Soft offlining pfn 0x18bc000 at process virtual address 0x7f7d9c800000
[ 1270.754314][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1270.765204][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.816653][ T7497] Soft offlining pfn 0x18d0400 at process virtual address 0x7f7d9c800000
[ 1270.827049][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1270.837997][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.852156][ T7497] Soft offlining pfn 0x186ca00 at process virtual address 0x7f7d9c800000
[ 1270.862350][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1270.872922][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.887133][ T7497] Soft offlining pfn 0x18ac200 at process virtual address 0x7f7d9c800000
[ 1270.897450][ T7497] Soft offlining pfn 0x211c00 at process virtual address 0x7f7d9ca00000
[ 1270.907416][ T7497] soft offline: 0x211c00: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.921365][ T7497] Soft offlining pfn 0x1e1cc00 at process virtual address 0x7f7d9c800000
[ 1270.931700][ T7497] Soft offlining pfn 0x18c800 at process virtual address 0x7f7d9ca00000
[ 1270.941580][ T7497] soft offline: 0x18c800: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.955649][ T7497] Soft offlining pfn 0x1e6ae00 at process virtual address 0x7f7d9c800000
[ 1270.966063][ T7497] Soft offlining pfn 0x211c00 at process virtual address 0x7f7d9ca00000
[ 1270.975965][ T7497] soft offline: 0x211c00: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1270.990059][ T7497] Soft offlining pfn 0x1e72e00 at process virtual address 0x7f7d9c800000
[ 1271.000323][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1271.011006][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.025152][ T7497] Soft offlining pfn 0x1e22200 at process virtual address 0x7f7d9c800000
[ 1271.035395][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1271.045916][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.060159][ T7497] Soft offlining pfn 0x1e6fe00 at process virtual address 0x7f7d9c800000
[ 1271.070695][ T7497] Soft offlining pfn 0x18c800 at process virtual address 0x7f7d9ca00000
[ 1271.080596][ T7497] soft offline: 0x18c800: hugepage isolation failed: 0, page count 2, type bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.094725][ T7497] Soft offlining pfn 0x1968200 at process virtual address 0x7f7d9c800000
[ 1271.105006][ T7497] Soft offlining pfn 0x18d1200 at process virtual address 0x7f7d9ca00000
[ 1271.115567][ T7497] soft offline: 0x18d1200: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.129775][ T7497] Soft offlining pfn 0x1e1ae00 at process virtual address 0x7f7d9c800000
[ 1271.140285][ T7497] Soft offlining pfn 0x18c800 at process virtual address 0x7f7d9ca00000
[ 1271.150185][ T7497] soft offline: 0x18c800: hugepage isolation failed: 0, page count 2, type bfffc[ 1271.468115][ T7497] Soft offlining pfn 0x1de4600 at process virtual address 0x7f7d9c800000
[ 1271.479348][ T7497] Soft offlining pfn 0x145e00 at process virtual address 0x7f7d9ca00000
[ 1271.489928][ T7497] soft offline: 0x145e00: hugepage isolation 1271.538433][ T7497] Soft offlining pfn 0x1fae00 at process virtual address 0x7f7d9c800000
[ 1271.548880][ T7497] Soft offlining pfn 0x1995e00 at process virtual address 0x7f7d9ca00000
[ 1271.558877][ T7497] soft offline: 0x1995e00: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.573055][ T7497] Soft offlining pfn 0x221e00 at process virtual address 0x7f7d9c800000
[ 1271.583453][ T7497] Soft offlining pfn 0x1901800 at process virtual address 0x7f7d9ca00000
[ 1271.593440][ T7497] soft offline: 0x1901800: hugepage isolation failed: 0, page count 2, type 3bfffc00001000e (referenced|uptodate|dirty|head)
[ 1271.610005][ T7497] Soft offlining pfn 0x232400 at process virtual address 0x7f7d9c800000
[ 1271.620439][ T7497] Soft offlinin[ 1272.005890][ T7497] Soft offlining pfn 0x230e00 at process virtual address 0x7f7d9c800000
[ 1272.017226][ T7497] Soft offlining pfn 0x185fe00 at process virtual address 0x7f7d9ca00000
[ 1272.029194][ T7497] Soft offlining pfn 0x1f1400 at process virtual address 0x7f7d9c800000
[ 1272.040088][ T7497] Soft offlining pfn 0x1f9e00 at process virtual address 0x7f7d9ca00000
[ 1272.052415][ T7497] Soft offlining pfn 0x1885a00 at process virtual address 0x7f7d9c800000
[ 1272.062510][ T7497] Soft offlining pfn 0x18b6000 at process virtual address 0x7f7d9ca00000
[ 1272.071931][ T7497] soft_offline_page: 0x18b6000: unknown page type: 3bfffc000000000 ((%pG?))

> 
> Please, note that this patchset is on top of [1] and [2].
> 
> This patchset does three things:
> 
>  1) Drops MF_COUNT_INCREASED trick
>  2) Refactors get page interface
>  3) Places a common entry for grabbin a page from both hard offline
>     and soft offline guarded by zone_pcp_{disable/enable}, so we do not
>     have to drain pcplists by ourself and retry again.
> 
> Note that the MF_COUNT_INCREASED trick was left because if get_hwpoison_page
> races with put_page (e.g:)
> 
> CPU0                         CPU1
> put_page (refcount decremented to 0)
>  __put_single_page
>   free_unref_page
>    free_unref_page_prepare
>     free_pcp_prepare
>      free_pages_prepare                           soft_offline_page
>      :page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP     get_any_page
>                             			    get_hwpoison_page
>    free_unref_page_commit
>     free_one_page
>      __free_one_page (place it in buddy)
> 
> get_hwpoison_page sees that page has a refcount of 0, but since it was not
> placed
> in buddy yet we cannot really handle it.
> We now have a sort of maximum passes in get_any_page, so in case we race
> with either an allocation or a put_page, we retry again.
> 
> After an off-list discussion with Naoya, he agreed to proceed.
> 
> [1] https://patchwork.kernel.org/project/linux-mm/list/?series=364009
> [2] https://patchwork.kernel.org/project/linux-mm/list/?series=381903
> 
> Naoya Horiguchi (3):
>   mm,madvise: call soft_offline_page() without MF_COUNT_INCREASED
>   mm,hwpoison: remove MF_COUNT_INCREASED
>   mm,hwpoison: remove flag argument from soft offline functions
> 
> Oscar Salvador (4):
>   mm,hwpoison: Refactor get_any_page
>   mm,hwpoison: Drop pfn parameter
>   mm,hwpoison: Disable pcplists before grabbing a refcount
>   mm,hwpoison: Remove drain_all_pages from shake_page
> 
>  drivers/base/memory.c |   2 +-
>  include/linux/mm.h    |   9 +--
>  mm/madvise.c          |  19 +++--
>  mm/memory-failure.c   | 168 +++++++++++++++++-------------------------
>  4 files changed, 85 insertions(+), 113 deletions(-)
> 

