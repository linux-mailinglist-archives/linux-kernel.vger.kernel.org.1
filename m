Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F792F1842
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388759AbhAKO1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbhAKO06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:26:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAD3C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o17so38006654lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Wa64N9rKhiG4UX9+YL6rV9eAtcd0ImwLw/TptbB5+Q=;
        b=qNsmEhZyVZLbqgWDWINYkkfG9Cmi5BiqsV1Al4c3KyHP5k0etJm8k0HJ8TCn7wjroU
         leBlRiSBoub4EqHQgUmU1bCMGKDNFDpuZecOM0wyk0mgkcBZulabztQ6gO6cpU6q/a06
         zXpj5X5jQ2xA5mToEoM39yWBN0RB3+75gDLYohCcySvfiRT1j7KAKVrqeS0AapV+Px8M
         F0pFCYT+BZ5BgAan9q0RQYoXkpv3EAXnr2xQXqicBkjkllVoTw7dhsEBR5PGNc7GhxBn
         MWWnzEPStM8WgMyniRU41it68RQCCLbo91MXzBowZZbYiBb8ZUwgH019Mo7NFi2bWJgy
         McZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Wa64N9rKhiG4UX9+YL6rV9eAtcd0ImwLw/TptbB5+Q=;
        b=ootNf1cuF+XmbgVeKMsjgwPKvTJrYQDGKIcgtIapBvIWmjkJozIEFlsN8OwrxddXWH
         OfCa7h4R9KGCpMqbcvigTn8/Nar/QNxma0edHV+VT7kcLRBZ53SDMxZpILHlaGChsa6x
         zWRl3aIECMuHPtMCvM7DovnoyIPXIywQAt79vYTj+kLHkgpu/u2JOB+Xwj9XijzPiVqu
         qyFcgmEgd763y2VPwUNv4QHUhgIIDG/9774zQwZhEgW6Sc56Z+fjOYhRAYvxntP8TuyI
         U3VQH7l/YEReL44VfEpQ6Jjoigaz3St1ExCE2Puaep1nkQ3aGCq2F1j0CEcWCo3rKwag
         0Cbg==
X-Gm-Message-State: AOAM530a4tTt2TcRNI/RH0g7klAMbviXVWpEBE4yWbZ9qRP4FFr7sxY5
        ko6ZAnz5I8vJ9/w7Fk/+eBoAqQ==
X-Google-Smtp-Source: ABdhPJyxuUfU2jBl8PcZXYeP9AlpPuGom3UdW8sC6/coPQEifEFV7KfYWvsRIYVhoy6xkPhja+Nlbg==
X-Received: by 2002:ac2:4463:: with SMTP id y3mr6964845lfl.94.1610375176210;
        Mon, 11 Jan 2021 06:26:16 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b31sm640363ljf.38.2021.01.11.06.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:26:15 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 927C1102238; Mon, 11 Jan 2021 17:26:20 +0300 (+03)
Date:   Mon, 11 Jan 2021 17:26:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: Re: [PATCH v2 1/3] mm: Cleanup faultaround and finish_fault()
 codepaths
Message-ID: <20210111142620.ylv3ccrsubef62mi@box>
References: <20210108171517.5290-1-will@kernel.org>
 <20210108171517.5290-2-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108171517.5290-2-will@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 05:15:15PM +0000, Will Deacon wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> alloc_set_pte() has two users with different requirements: in the
> faultaround code, it called from an atomic context and PTE page table
> has to be preallocated. finish_fault() can sleep and allocate page table
> as needed.
> 
> PTL locking rules are also strange, hard to follow and overkill for
> finish_fault().
> 
> Let's untangle the mess. alloc_set_pte() has gone now. All locking is
> explicit.
> 
> The price is some code duplication to handle huge pages in faultaround
> path, but it should be fine, having overall improvement in readability.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  fs/xfs/xfs_file.c       |   6 +-
>  include/linux/mm.h      |  12 ++-
>  include/linux/pgtable.h |  11 +++
>  mm/filemap.c            | 177 ++++++++++++++++++++++++++---------
>  mm/memory.c             | 199 ++++++++++++----------------------------
>  5 files changed, 213 insertions(+), 192 deletions(-)
> 
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index 5b0f93f73837..111fe73bb8a7 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -1319,17 +1319,19 @@ xfs_filemap_pfn_mkwrite(
>  	return __xfs_filemap_fault(vmf, PE_SIZE_PTE, true);
>  }
>  
> -static void
> +static vm_fault_t
>  xfs_filemap_map_pages(
>  	struct vm_fault		*vmf,
>  	pgoff_t			start_pgoff,
>  	pgoff_t			end_pgoff)
>  {
>  	struct inode		*inode = file_inode(vmf->vma->vm_file);
> +	vm_fault_t ret;
>  
>  	xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> -	filemap_map_pages(vmf, start_pgoff, end_pgoff);
> +	ret = filemap_map_pages(vmf, start_pgoff, end_pgoff);
>  	xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
> +	return ret;
>  }
>  
>  static const struct vm_operations_struct xfs_file_vm_ops = {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ecdf8a8cd6ae..801dd99f733c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -542,8 +542,8 @@ struct vm_fault {
>  					 * is not NULL, otherwise pmd.
>  					 */
>  	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
> -					 * vm_ops->map_pages() calls
> -					 * alloc_set_pte() from atomic context.
> +					 * vm_ops->map_pages() sets up a page
> +					 * table from from atomic context.
>  					 * do_fault_around() pre-allocates
>  					 * page table to avoid allocation from
>  					 * atomic context.

The typo Matthew has pointed out:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d3d4e307fa09..358fc8616d8b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -535,7 +535,7 @@ struct vm_fault {
 					 */
 	pgtable_t prealloc_pte;		/* Pre-allocated pte page table.
 					 * vm_ops->map_pages() sets up a page
-					 * table from from atomic context.
+					 * table from atomic context.
 					 * do_fault_around() pre-allocates
 					 * page table to avoid allocation from
 					 * atomic context.
-- 
 Kirill A. Shutemov
