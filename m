Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCF0295392
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439292AbgJUUnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405621AbgJUUnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:43:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12042C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Lu+hGrdqeWMftTlTMobTvofpTtHSyJ0i3sN8+ViuhWw=; b=pLs6Fw24U1S/xJW6kT9LgOdc9c
        PWDGagljMAqzy5KHOnNjTRQcryrg5kVEes3Zg606P5R9ZYCCgiq+txRfD1azjEtzpXUO9hJhmRX1B
        UsVa2NlBMR3PqHSgkVzNMAHgcGb78y0WuxEYZEREcf5Drnwgd5ZNqQorfvh29IFvDye5TnXTQgSB0
        xj9oQHf3+awaZoPT4GvbpHrlHiI1+SgKals5HFonQRbLu1ujJAjupODb3G41ETA/IVz395xT4rT2X
        RHag7AJBAv8F7XetNQn583a7t9reBkHsk1yVbBfB9bwOdg0V2fK6vhwD9f7maJcMUmaPN0EeGpey6
        wlUSVVbA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVKxI-0006Cw-GM; Wed, 21 Oct 2020 20:43:32 +0000
Date:   Wed, 21 Oct 2020 21:43:32 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove pagevec_lookup_range_nr_tag
Message-ID: <20201021204332.GN20115@casper.infradead.org>
References: <20201021193926.101474-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021193926.101474-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 03:39:26PM -0400, Jeff Layton wrote:
> With the merge of 2e1692966034 (ceph: have ceph_writepages_start call
> pagevec_lookup_range_tag), nothing calls this anymore.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
