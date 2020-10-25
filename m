Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790C3298514
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 01:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420745AbgJYX7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 19:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:32972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418940AbgJYX7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 19:59:49 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0085222C2;
        Sun, 25 Oct 2020 23:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603670388;
        bh=s5N81VOFO1h8dj2jSReD4M4MfMKhzgGKYPYRzQyMrfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yUEW/1sOitovk18LFxO2fWxTGCZ56ljsl7C4phIC3jUscOtuiKnuMcBrlRKApL/+M
         goox1RUv5y7qdWaLEVLuosjsLwrpiUwmnvjVeZjC+ztq6lLLVnn36tzOIDI0xLoSel
         z2QlvVzDtlBqf3K9sCW+Lc8A1++1UkyKf6k3cei8=
Date:   Sun, 25 Oct 2020 16:59:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/swap_state: Skip meaningless swap cache readahead
 when ra_info.win == 0
Message-Id: <20201025165948.bd4f59d127952b9979d5c61e@linux-foundation.org>
In-Reply-To: <20201009133059.58407-1-linmiaohe@huawei.com>
References: <20201009133059.58407-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Oct 2020 09:30:59 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:

> swap_ra_info() may leave ra_info untouched in non_swap_entry() case as page
> table lock is not held. In this case, we have ra_info.nr_pte == 0 and it is
> meaningless to continue with swap cache readahead. Skip such ops by init
> ra_info.win = 1.
> 
>
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -839,7 +839,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  	swp_entry_t entry;
>  	unsigned int i;
>  	bool page_allocated;
> -	struct vma_swap_readahead ra_info = {0,};
> +	struct vma_swap_readahead ra_info = {1,};
>  
>  	swap_ra_info(vmf, &ra_info);
>  	if (ra_info.win == 1)

Looks right.  But I think it would be better to fix this in
swap_ra_info() - make it more consistent in its return state.

Otherwise, let's modernify that struct initializer:

--- a/mm/swap_state.c~mm-swap_state-skip-meaningless-swap-cache-readahead-when-ra_infowin-==-0-fix
+++ a/mm/swap_state.c
@@ -839,7 +839,9 @@ static struct page *swap_vma_readahead(s
 	swp_entry_t entry;
 	unsigned int i;
 	bool page_allocated;
-	struct vma_swap_readahead ra_info = {1,};
+	struct vma_swap_readahead ra_info = {
+		.win = 1,
+	};
 
 	swap_ra_info(vmf, &ra_info);
 	if (ra_info.win == 1)
_

