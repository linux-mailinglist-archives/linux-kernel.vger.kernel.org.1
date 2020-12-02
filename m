Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FAB2CBE9A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgLBNmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:42:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:49114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbgLBNmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:42:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73D09AB63;
        Wed,  2 Dec 2020 13:41:42 +0000 (UTC)
Date:   Wed, 2 Dec 2020 14:41:39 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Qian Cai <qcai@redhat.com>
Cc:     akpm@linux-foundation.org, n-horiguchi@ah.jp.nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HWPoison: Refactor get page interface
Message-ID: <20201202134131.GA8110@linux>
References: <20201119105716.5962-1-osalvador@suse.de>
 <1ba3d19ab0629e549519fb94b73cabb0b392fb2a.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba3d19ab0629e549519fb94b73cabb0b392fb2a.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 08:34:57AM -0500, Qian Cai wrote:
> On Thu, 2020-11-19 at 11:57 +0100, Oscar Salvador wrote:
> > Hi,
> > 
> > following up on previous fix-ups an refactors, this patchset simplifies
> > the get page interface and removes the MF_COUNT_INCREASED trick we have
> > for soft offline.
> 
> Well, the madvise() EIO is back. I don't understand why we can't test it on a
> NUMA system before posting this over and over again.
> 
> # git clone https://e.coding.net/cailca/linux/mm
> # cd mm; make
> # ./ranbug 1 
> - start: migrate_huge_offline
> - use NUMA nodes 0,3.
> - mmap and free 8388608 bytes hugepages on node 0
> - mmap and free 8388608 bytes hugepages on node 3
> madvise: Input/output error

I tried it out myself enlarging the window race artificially but I was not able
to get -EIO anymore.
But as Vlastimil pointed out in the respective patch, it is better to keep the
page pinned for madvise.

I am planning to re-post leaving out the patches that remove the pinning.

Anyway, thanks for the report.

-- 
Oscar Salvador
SUSE L3
