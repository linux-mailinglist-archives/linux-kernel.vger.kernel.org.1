Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE76A27720C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgIXNXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:23:34 -0400
Received: from verein.lst.de ([213.95.11.211]:52421 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbgIXNXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:23:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 110DA68AFE; Thu, 24 Sep 2020 15:23:29 +0200 (CEST)
Date:   Thu, 24 Sep 2020 15:23:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        intel-gfx@lists.freedesktop.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Nitin Gupta <ngupta@vflare.org>
Subject: Re: [Intel-gfx] [PATCH 4/6] drm/i915: use vmap in
 i915_gem_object_map
Message-ID: <20200924132328.GA3698@lst.de>
References: <20200918163724.2511-1-hch@lst.de> <20200918163724.2511-5-hch@lst.de> <9b5d40af-7378-9e68-ca51-73b2148287f3@linux.intel.com> <20200923134117.GB9893@lst.de> <1a421e7f-6255-c534-5403-715c2e809bd0@linux.intel.com> <20200923144455.GA15036@lst.de> <17f81582-f087-aeac-c06a-4cd1a5457fbb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17f81582-f087-aeac-c06a-4cd1a5457fbb@linux.intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:22:35PM +0100, Tvrtko Ursulin wrote:
> CI says series looks good from the i915 perspective (*).
>
> I don't know how will you handle it logistically, but when you have final 
> version I am happy to re-read and r-b the i915 patches.

I'll resend the series later today, and will make sure you are on the
Cc list.
