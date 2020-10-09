Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C31288A66
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgJIOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJIOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:11:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3EC0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9xmiR5UuTb85WLe9OUDuBH/UlRUMFVs7vOqcU8BIODE=; b=HIxxr8A8yiNCKphMPp12sb4phZ
        TH7unp2O64X/kynBo9R0RbWnRpjj914sMVtv6EDKXChaHL77cKTqOgy6/ciGtI5UIErX0hwOOXU1P
        AqUis7nSHAFwTzRPnInozhUycVBkmxiQ7lYZCi90hWGjzgu7Yr4FkQ+3eNgwA2NQjvlYZapA9INec
        AC3QOWsrL1tp/dukoNrL2PlpmUQpQoTqM5TmvM84S7GT5EJlIZSXk+JBmPsS2X7MjMTglNVFwcDTk
        +EQt/XeDXabK0Zf6SRi6TnTO+OFnhNhzI8+2UoUf4Hy47pfkURxZrLtzRqcmNYsZ9wF/BjDG55dxr
        tNVLoMIg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQt6p-0004cj-Gg; Fri, 09 Oct 2020 14:10:59 +0000
Date:   Fri, 9 Oct 2020 15:10:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, sfr@canb.auug.org.au, ziy@nvidia.com,
        alexander.h.duyck@linux.intel.com, osalvador@suse.de,
        steven.price@arm.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page-flags: Remove unused __[Set|Clear]PagePrivate
Message-ID: <20201009141059.GU20115@casper.infradead.org>
References: <20201009135914.64826-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009135914.64826-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:59:14AM -0400, Miaohe Lin wrote:
> They are unused anymore.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
