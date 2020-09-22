Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E7E273ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 08:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgIVGWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 02:22:54 -0400
Received: from verein.lst.de ([213.95.11.211]:43268 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727939AbgIVGWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 02:22:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 17D146736F; Tue, 22 Sep 2020 08:22:50 +0200 (CEST)
Date:   Tue, 22 Sep 2020 08:22:49 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
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
Subject: Re: [PATCH 3/6] drm/i915: use vmap in shmem_pin_map
Message-ID: <20200922062249.GA30831@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-4-hch@lst.de> <20200921191157.GX32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921191157.GX32101@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 08:11:57PM +0100, Matthew Wilcox wrote:
> This is awkward.  I'd like it if we had a vfree() variant which called
> put_page() instead of __free_pages().  I'd like it even more if we
> used release_pages() instead of our own loop that called put_page().

Note that we don't need a new vfree variant, we can do this manually if
we want, take a look at kernel/dma/remap.c.  But I thought this code
intentionally doesn't want to do that to avoid locking in the memory
for the pages array.  Maybe the i915 maintainers can clarify.
