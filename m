Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65C9927CD82
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgI2Mob convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Sep 2020 08:44:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:27198 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgI2Mno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:43:44 -0400
IronPort-SDR: WdT3gftJuhCDMZnSeGGgk/nDN0y+kQrhJBx7KmXaM17c9P0vF4T/aesPDbnUS/jKHUt2TWOSUb
 /nQ+UF7im6bQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159556144"
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="159556144"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 05:43:39 -0700
IronPort-SDR: 7NX3Uj2736sJSbglPVjhaPntDnQdsledhJmbVZ7ccHlY/O7oFpamoLrlz94VPls0ygLxWO+Opt
 LlneFgXipAmw==
X-IronPort-AV: E=Sophos;i="5.77,318,1596524400"; 
   d="scan'208";a="457266308"
Received: from akoski1-mobl7.ger.corp.intel.com (HELO localhost) ([10.252.11.87])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 05:43:33 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200928123741.GA4999@lst.de>
References: <20200924135853.875294-1-hch@lst.de> <20200925194349.d0ee9dbedb2ec48f0bfcd2ec@linux-foundation.org> <20200926062959.GA3427@lst.de> <160128801808.6464.1013594053120198786@jlahtine-mobl.ger.corp.intel.com> <20200928123741.GA4999@lst.de>
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
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To:     Christoph Hellwig <hch@lst.de>
Subject: Re: remove alloc_vm_area v2
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160138340987.15771.13645983702040612672@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Tue, 29 Sep 2020 15:43:30 +0300
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christoph Hellwig (2020-09-28 15:37:41)
> On Mon, Sep 28, 2020 at 01:13:38PM +0300, Joonas Lahtinen wrote:
> > I think we have a gap that after splitting the drm-intel-next pull requests into
> > two the drm-intel/for-linux-next branch is now missing material from
> > drm-intel/drm-intel-gt-next.
> > 
> > I think a simple course of action might be to start including drm-intel-gt-next
> > in linux-next, which would mean that we should update DIM tooling to add
> > extra branch "drm-intel/gt-for-linux-next" or so.
> > 
> > Which specific patches are missing in this case?
> 
> The two dependencies required by my series not in mainline are:
> 
>     drm/i915/gem: Avoid implicit vmap for highmem on x86-32
>     drm/i915/gem: Prevent using pgprot_writecombine() if PAT is not supported
> 
> so it has to be one or both of those.

Hmm, those are both committed after our last -next pull request, so they
would normally only target next merge window. drm-next closes the merge
window around -rc5 already.

But, in this specific case those are both Fixes: patches with Cc: stable,
so they should be pulled into drm-intel-next-fixes PR.

Rodrigo, can you cherry-pick those patches to -next-fixes that you send
to Dave?

Regards, Joonas
