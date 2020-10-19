Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59229260C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbgJSKuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:50:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:54554 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgJSKuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:50:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E6DDB2D8;
        Mon, 19 Oct 2020 10:50:36 +0000 (UTC)
Date:   Mon, 19 Oct 2020 12:50:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        linmiaohe@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] mm: mempolicy: fix potential pte_unmap_unlock pte error
Message-ID: <20201019105029.GA18953@linux>
References: <20201019074853.50856-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019074853.50856-1-luoshijie1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 03:48:53AM -0400, Shijie Luo wrote:
> When flags in queue_pages_pte_range don't have MPOL_MF_MOVE or MPOL_MF_MOVE_ALL
>  bits, code breaks and passing origin pte - 1 to pte_unmap_unlock seems like
> not a good idea.

I think the above is already explained below?

> queue_pages_pte_range can run in MPOL_MF_MOVE_ALL mode which doesn't migrate
> misplaced pages but returns with EIO when encountering such a page. Since
> commit a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when MPOL_MF_STRICT
>  is specified") and early break on the first pte in the range results in
> pte_unmap_unlock on an underflow pte. This can lead to lockups later on when
>  somebody  tries to lock the pte resp. page_table_lock again..
> 
> Fixes: a7f40cfe3b7a ("mm: mempolicy: make mbind() return -EIO when
> MPOL_MF_STRICT is specified")
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Anyway, LGTM:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE L3
