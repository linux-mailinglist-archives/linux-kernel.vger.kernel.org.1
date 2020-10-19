Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6B292664
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgJSLc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:32:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgJSLc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:32:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603107146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dvULZg4AeKJjYxg9g9jVt+W6saMphhmth4XQTkKQjd8=;
        b=h4IZtlhSh/78EtJvOyS2N4H//4eFnA+cMEYbE50pbZKptm1tzRraBX4dfvIRvTNo4bhAxv
        t9gN+5gFrIx1juHpiFPlwtMIb7r8hYccTn9yDNm820pAo4UZMptDWqPDyvG2zkWAQOGvW6
        ++VQfCbsSteKoSJScQNTy1kcSyVmVaI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F191ABA2;
        Mon, 19 Oct 2020 11:32:26 +0000 (UTC)
Date:   Mon, 19 Oct 2020 13:32:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Shijie Luo <luoshijie1@huawei.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: mempolicy: fix potential pte_unmap_unlock pte error
Message-ID: <20201019113224.GD27114@dhcp22.suse.cz>
References: <20201019074853.50856-1-luoshijie1@huawei.com>
 <20201019105029.GA18953@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019105029.GA18953@linux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-10-20 12:50:34, Oscar Salvador wrote:
> On Mon, Oct 19, 2020 at 03:48:53AM -0400, Shijie Luo wrote:
> > When flags in queue_pages_pte_range don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL
> >  bits, code breaks and passing origin pte - 1 to pte_unmap_unlock seems like
> > not a good idea.
> 
> I think the above is already explained below?

Yes

> > queue_pages_pte_range can run in MPOL_MF_MOVE_ALL mode which doesn't migrate
> > misplaced pages but returns with EIO when encountering such a page. Since
> > commit a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT
> >  is specified") and early break on the first pte in the range results in
> > pte_unmap_unlock on an underflow pte. This can lead to lockups later on when
> >  somebody  tries to lock the pte resp. page_table_lock again..
> > 
> > Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
> > MPOL_MF_STRICT is specified")

Cc: stable

is due as well. There are even security concerns and I wouldn't be
surprised if this gained a CVE.

> > Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> > Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Anyway, LGTM:
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
