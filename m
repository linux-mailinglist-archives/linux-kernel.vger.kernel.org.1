Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D281ED82E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jun 2020 23:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFCVva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Jun 2020 17:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 17:51:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E7BC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WFKjpmFPNO5zukj90rjGUlaZxkKudJBdthF2cSc+KfU=; b=eYh60STYrQxzv5V5oc2CXmvnzV
        eA/klZU0qTEOtdIvyxcym3o2couFDr7Xv6qIbf1VHAEFgEItJw0Of3iXeWkUkUSZIeuBBvadeMM3n
        Tqur5pMfe+/EDZQtY8wJi/zaKPDJDp6g+Li6zPr7Hlb8qeNabAVKTmQwC2e+IiRkEuoDyC7iNDMat
        bZJP2OQ+05fWiJpsxGU+j6nvSuZwxbj4svujd62PaYpL5NRIwkVx2ssqAqzw3JERk/sWosBaDoZM9
        oSBVE5zI8zcFar2wnnYSPmEse/rTTszSr699hxWnpnv22xTeuDSVkJbwBQh7fFopv3144yHRMEkyg
        B59DqiKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgbIB-0002Iy-1G; Wed, 03 Jun 2020 21:51:23 +0000
Date:   Wed, 3 Jun 2020 14:51:22 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
Message-ID: <20200603215122.GR19604@bombadil.infradead.org>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
 <20200526160140.GC850116@cmpxchg.org>
 <alpine.LSU.2.11.2005271402410.6459@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2005271402410.6459@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 02:28:10PM -0700, Hugh Dickins wrote:
> Saying "source inspection" reminds me: there is another funny in there,
> but I don't think it matters very much in practice, and might need
> rather a lot of testing to justify any particular patch: where
> page_cache_sync_readahead() asks for PAGE_SIZE pages!
> 
> "end - index" seems a more reasonable number to me: but then we
> might find that reading ahead into the next huge extent had actually
> been a useful optimization (and those readahead functions impose
> their own caps, so PAGE_SIZE shouldn't work out too outrageously).

That readahead was only added in 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0
so it probably hasn't really been performance tested yet.
