Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C817279740
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIZGaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:30:04 -0400
Received: from verein.lst.de ([213.95.11.211]:58442 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZGaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:30:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60DF068AFE; Sat, 26 Sep 2020 08:29:59 +0200 (CEST)
Date:   Sat, 26 Sep 2020 08:29:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
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
Message-ID: <20200926062959.GA3427@lst.de>
References: <20200924135853.875294-1-hch@lst.de> <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 07:43:49PM -0700, Andrew Morton wrote:
> On Thu, 24 Sep 2020 15:58:42 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > this series removes alloc_vm_area, which was left over from the big
> > vmalloc interface rework.  It is a rather arkane interface, basicaly
> > the equivalent of get_vm_area + actually faulting in all PTEs in
> > the allocated area.  It was originally addeds for Xen (which isn't
> > modular to start with), and then grew users in zsmalloc and i915
> > which seems to mostly qualify as abuses of the interface, especially
> > for i915 as a random driver should not set up PTE bits directly.
> > 
> > Note that the i915 patches apply to the drm-tip branch of the drm-tip
> > tree, as that tree has recent conflicting commits in the same area.
> 
> Is the drm-tip material in linux-next yet?  I'm still seeing a non-trivial
> reject in there at present.

I assumed it was, but the reject imply that they aren't.  Tvrtko, do you
know the details?
