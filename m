Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B1027446D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgIVOjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:39:11 -0400
Received: from verein.lst.de ([213.95.11.211]:44925 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726507AbgIVOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:39:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD86767373; Tue, 22 Sep 2020 16:39:06 +0200 (CEST)
Date:   Tue, 22 Sep 2020 16:39:06 +0200
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
Message-ID: <20200922143906.GB26664@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-4-hch@lst.de> <20200921191157.GX32101@casper.infradead.org> <20200922062249.GA30831@lst.de> <20200922112144.GB32101@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922112144.GB32101@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:21:44PM +0100, Matthew Wilcox wrote:
> Actually, vfree() will work today; I cc'd you on a documentation update
> to make it clear that this is permitted.

vfree calls __free_pages, the i915 and a lot of other code calls
put_page.  They are mostly the same, but not quite and everytime I
look into that mess I'm more confused than before.

Can someone in the know write sensible documentation on when to use
__free_page(s) vs put_page?
