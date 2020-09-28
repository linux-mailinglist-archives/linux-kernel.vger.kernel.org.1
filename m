Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072E827AB9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgI1KNt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 06:13:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:28447 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgI1KNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:13:48 -0400
IronPort-SDR: vJxDrUcG9dz3BuJFcj+XCdvjunMZqD0Kcde9x3VEfzkcViNDFxqRAyILjETuJAKFkr0Ut+acA5
 r4f7UdNiab2Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="180124701"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="180124701"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 03:13:47 -0700
IronPort-SDR: oynyLpLaEo8E2hmYKjUK2eLejsF9h1nd7bvB1+8YkaeLPVcxKUTeXs7JzHnC+u3AXBq2RQNnIu
 AssYzP9UKYBw==
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="456766108"
Received: from jrcarrol-mobl.ger.corp.intel.com (HELO localhost) ([10.252.31.240])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 03:13:41 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200926062959.GA3427@lst.de>
References: <20200924135853.875294-1-hch@lst.de> <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org> <20200926062959.GA3427@lst.de>
Subject: Re: remove alloc_vm_area v2
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Stephen Rothwell <sfr@canb.auug.org.au>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
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
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160128801808.6464.1013594053120198786@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Mon, 28 Sep 2020 13:13:38 +0300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Dave and Daniel
+ Stephen

Quoting Christoph Hellwig (2020-09-26 09:29:59)
> On Fri, Sep 25, 2020 at 07:43:49PM -0700, Andrew Morton wrote:
> > On Thu, 24 Sep 2020 15:58:42 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > this series removes alloc_vm_area, which was left over from the big
> > > vmalloc interface rework.  It is a rather arkane interface, basicaly
> > > the equivalent of get_vm_area + actually faulting in all PTEs in
> > > the allocated area.  It was originally addeds for Xen (which isn't
> > > modular to start with), and then grew users in zsmalloc and i915
> > > which seems to mostly qualify as abuses of the interface, especially
> > > for i915 as a random driver should not set up PTE bits directly.
> > > 
> > > Note that the i915 patches apply to the drm-tip branch of the drm-tip
> > > tree, as that tree has recent conflicting commits in the same area.
> > 
> > Is the drm-tip material in linux-next yet?  I'm still seeing a non-trivial
> > reject in there at present.
> 
> I assumed it was, but the reject imply that they aren't.  Tvrtko, do you
> know the details?

I think we have a gap that after splitting the drm-intel-next pull requests into
two the drm-intel/for-linux-next branch is now missing material from
drm-intel/drm-intel-gt-next.

I think a simple course of action might be to start including drm-intel-gt-next
in linux-next, which would mean that we should update DIM tooling to add
extra branch "drm-intel/gt-for-linux-next" or so.

Which specific patches are missing in this case?

Regards, Joonas
