Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9891AB117
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441623AbgDOTKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416834AbgDOShv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:37:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0290C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZVR1RDTh5W++EDtoDNYxDKCKa5cmx8SNT7aJ3yQ1y44=; b=PIUDneSDbdrK6atV8FBNVQSj9s
        EBbn4S2mOOnl3wLNh4nc2D0wfNzYkCewuf/mRJDdiSwd7a1PhtG4a/AuPDFPumFvXEocT2RO1JrKS
        B2RVMmMiGXUX8tG6jDXgRyrpPiwOxTvfFB/wfA8+HdiHM2s6qwpRGGZxp4Gfs1rmgmT3laSC+fvtA
        5RIBdZ8xkSrN58Q+zf0g/tsGI4fHTO25G7pUyuLeO8Wx/asB/boSK2HeL73FAmwaqtlVWutkgOS0D
        Y9+OVQoF5Y3FAKxL5CyZtOBQSXWsKbnZSb81de9FtJFZyvRWlvzBzbLxe0g0nPgRyJEKTP/WKXXia
        Cgu/jrPA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOmut-0007w7-IK; Wed, 15 Apr 2020 18:37:43 +0000
Date:   Wed, 15 Apr 2020 11:37:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Ethon Paul <ethp@qq.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: Fix a typo in comment
 "unneccssary"->"unnecessary"
Message-ID: <20200415183743.GE5820@bombadil.infradead.org>
References: <20200411065141.15936-1-ethp@qq.com>
 <9677805f-5194-b6e8-8949-6ff0cbeb504e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9677805f-5194-b6e8-8949-6ff0cbeb504e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:36:34AM -0700, Ralph Campbell wrote:
> 
> On 4/10/20 11:51 PM, Ethon Paul wrote:
> > There is a typo in comment, fix it.
> > 
> > Signed-off-by: Ethon Paul <ethp@qq.com>
> 
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

NAK.  See earlier response.
