Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B76C2740A0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIVLWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgIVLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:22:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v+IUea/CGhLMdjL8zbCOPAxfGNu+qZhlo3dcebaU5kY=; b=iLgsfzwxwT611QKOl+WmOf2wbN
        /apXK6gTmDsVL/BXsA2nSeYw00AYm7of+qlZIT5seKhZdu6vVFYUh9VHKNyMaCNUtuxTWQsjq/fQb
        o+HH9FqL3yy9RUdN/gEnhHaw8zj6LjLVf/SMpazertMDW0M+AsMsYpsjEY6RqiGrpxc2TfV1v186b
        /dak9QRJGkXVmw5CYmBXsQSP0ryzf3Fj1FCPgdtdTrj8+Ud5C+5S63kHgzqMV4tMTbzbXE/7lodhh
        8x3U5eQq2tiq0PS1EC76b9HHLbxCqMbJHon71YuO6JArA0Hf33RL3+JVtd3CmHZv47m4GshGX8kOv
        xhVaWjtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKgMi-000579-Gi; Tue, 22 Sep 2020 11:21:44 +0000
Date:   Tue, 22 Sep 2020 12:21:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20200922112144.GB32101@casper.infradead.org>
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-4-hch@lst.de>
 <20200921191157.GX32101@casper.infradead.org>
 <20200922062249.GA30831@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922062249.GA30831@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 08:22:49AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 08:11:57PM +0100, Matthew Wilcox wrote:
> > This is awkward.  I'd like it if we had a vfree() variant which called
> > put_page() instead of __free_pages().  I'd like it even more if we
> > used release_pages() instead of our own loop that called put_page().
> 
> Note that we don't need a new vfree variant, we can do this manually if
> we want, take a look at kernel/dma/remap.c.  But I thought this code
> intentionally doesn't want to do that to avoid locking in the memory
> for the pages array.  Maybe the i915 maintainers can clarify.

Actually, vfree() will work today; I cc'd you on a documentation update
to make it clear that this is permitted.

From my current experience with the i915 shmem code, I think that the
i915 maintainers are experts at graphics, and are unfamiliar with the MM.
There are a number of places where they do things the hard way.
