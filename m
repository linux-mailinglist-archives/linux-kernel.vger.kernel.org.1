Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01F7276BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgIXI05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 04:26:57 -0400
Received: from verein.lst.de ([213.95.11.211]:51414 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgIXI04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 04:26:56 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E20A468AFE; Thu, 24 Sep 2020 10:26:52 +0200 (CEST)
Date:   Thu, 24 Sep 2020 10:26:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Uninitialized variable in
 i915_gem_object_map_page()
Message-ID: <20200924082652.GA14084@lst.de>
References: <20200924081830.GA1568157@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924081830.GA1568157@mwanda>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 11:18:30AM +0300, Dan Carpenter wrote:
> The "i" iterator is never set to zero.  This probably doesn't affect
> testing because GCC sometimes initializes variables and also we have a
> new pluggin to initialize stack variables to zero.
> 
> Fixes: 7edd32a9e614 ("drm/i915: use vmap in i915_gem_object_map")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Hi Andrew, this should probably go through the -mm tree and get folded
> into the original patch.

FYI, I'll need to resend anyway, and I've folded this into the latest
branch.
