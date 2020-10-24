Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90489297B56
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 10:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759974AbgJXIAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 04:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756271AbgJXIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 04:00:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71823C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VtJ3/QfVYCJIzUimUHreYja6C5qKjpi3sBKHDNwKYcQ=; b=NDRtxukWe2cUfgssnc00+8lYub
        c2FX/x0Fp5aJvCnK31DdXCOXqDa3h6sD8kRe6OazFO8t3gu2FtKihT3ObNVUTell7gI0rHMLcENOC
        dpQcYl80m71lYTgNFJhq6hGdctXDMmzjlAfSsEhKTlEOUhSQkdmKgrf+ktLwET+3kmPF7DGDSelar
        40ywonZ2vH1lxMYTW4CELbLRCHWc6WDF/C7xiXOsTr+0kwrUZ/ee4kTVxJHMb3+T3GlzPIopEKai6
        tLLOsAQqbkl4SlpEmtxtuuNufWNkCDVlJgaMGgGbAawHNHfivfVYz17kLtC1j7PyA4s7XyKABrtxI
        TEY0OfLw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kWET1-0001XI-IZ; Sat, 24 Oct 2020 07:59:59 +0000
Date:   Sat, 24 Oct 2020 08:59:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        saberlily.xia@hisilicon.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH v1 1/2] mm: cma: introduce cma_release_nowait()
Message-ID: <20201024075959.GA4285@infradead.org>
References: <20201022225308.2927890-1-guro@fb.com>
 <20201022225308.2927890-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022225308.2927890-2-guro@fb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw, I think we also need to use this nonblocking version from
dma_free_contiguous.  dma_free* is defined to not block.  In practice
callers mostly care if they also did GFP_ATOMIC allocations, which
don't dip into CMA, but I think we do have a problem.
