Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416EE27ADFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgI1Mhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:37:51 -0400
Received: from verein.lst.de ([213.95.11.211]:35427 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgI1Mhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:37:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0954568AFE; Mon, 28 Sep 2020 14:37:41 +0200 (CEST)
Date:   Mon, 28 Sep 2020 14:37:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
Subject: Re: remove alloc_vm_area v2
Message-ID: <20200928123741.GA4999@lst.de>
References: <20200924135853.875294-1-hch@lst.de> <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org> <20200926062959.GA3427@lst.de> <160128801808.6464.1013594053120198786@jlahtine-mobl.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160128801808.6464.1013594053120198786@jlahtine-mobl.ger.corp.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 01:13:38PM +0300, Joonas Lahtinen wrote:
> I think we have a gap that after splitting the drm-intel-next pull requests into
> two the drm-intel/for-linux-next branch is now missing material from
> drm-intel/drm-intel-gt-next.
> 
> I think a simple course of action might be to start including drm-intel-gt-next
> in linux-next, which would mean that we should update DIM tooling to add
> extra branch "drm-intel/gt-for-linux-next" or so.
> 
> Which specific patches are missing in this case?

The two dependencies required by my series not in mainline are:

    drm/i915/gem: Avoid implicit vmap for highmem on x86-32
    drm/i915/gem: Prevent using pgprot_writecombine() if PAT is not supported

so it has to be one or both of those.
