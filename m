Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DDD278D86
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgIYQCu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:02:50 -0400
Received: from verein.lst.de ([213.95.11.211]:56622 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:02:50 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB6F368B02; Fri, 25 Sep 2020 18:02:42 +0200 (CEST)
Date:   Fri, 25 Sep 2020 18:02:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Auld <matthew.william.auld@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        x86@kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Auld <matthew.auld@intel.com>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [Intel-gfx] [PATCH 08/11] drm/i915: use vmap in
 i915_gem_object_map
Message-ID: <20200925160242.GA18229@lst.de>
References: <20200924135853.875294-1-hch@lst.de> <20200924135853.875294-9-hch@lst.de> <CAM0jSHPaqpX2A5T4iybfLF+F=cBX05GW8u54cUe7AG0QKDJt2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0jSHPaqpX2A5T4iybfLF+F=cBX05GW8u54cUe7AG0QKDJt2g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 03:08:59PM +0100, Matthew Auld wrote:
> > +       i = 0;
> > +       for_each_sgt_page(page, iter, obj->mm.pages)
> > +               pages[i++] = page;
> > +       vaddr = vmap(pages, n_pages, 0, pgprot);
> > +       if (pages != stack)
> > +               kvfree(pages);
> > +       return vaddr;
> > +}

> > -       return area->addr;
> > +       for_each_sgt_daddr(addr, iter, obj->mm.pages)
> > +               pfns[i++] = (iomap + addr) >> PAGE_SHIFT;
> 
> Missing the i = 0 fix from Dan?

Yeah, looks like I only managed to apply the one in the page based
version above.
