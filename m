Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95764274536
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:27:10 -0400
Received: from verein.lst.de ([213.95.11.211]:45148 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgIVP1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:27:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6CC1F67373; Tue, 22 Sep 2020 17:27:06 +0200 (CEST)
Date:   Tue, 22 Sep 2020 17:27:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     boris.ostrovsky@oracle.com
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 6/6] x86/xen: open code alloc_vm_area in
 arch_gnttab_valloc
Message-ID: <20200922152706.GA30633@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-7-hch@lst.de> <0833b9a8-5096-d105-a850-1336150eada1@oracle.com> <20200922145819.GA28420@lst.de> <ebd69ba1-fc06-3cc7-348e-3cb0004c2a34@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebd69ba1-fc06-3cc7-348e-3cb0004c2a34@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 11:24:20AM -0400, boris.ostrovsky@oracle.com wrote:
> 
> On 9/22/20 10:58 AM, Christoph Hellwig wrote:
> > On Mon, Sep 21, 2020 at 04:44:10PM -0400, boris.ostrovsky@oracle.com wrote:
> >> This will end up incrementing area->ptes pointer. So perhaps something like
> >>
> >>
> >> pte_t **ptes = area->ptes;
> >>
> >> if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
> >>                         PAGE_SIZE * nr_frames, gnttab_apply, &ptes)) {
> >>
> >>        ...
> > Yeah.  What do you think of this version? 
> 
> 
> Oh yes, this is way better. This now can actually be read without trying to mentally unwind triple pointers. (You probably want to initialize idx to zero before calling apply_to_page_range(), I am not sure it's guaranteed to be zero).

Both instances are static variables, thus in .bss and initialized.
So unless you insist I don't think we need a manual one.
