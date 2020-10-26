Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84862989E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768806AbgJZJ6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:58:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768801AbgJZJ5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:57:54 -0400
Received: from kernel.org (unknown [87.70.96.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C9D822202;
        Mon, 26 Oct 2020 09:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603706273;
        bh=wtdKbIZ2qTydFUtmnkADSICjasq+Dj2neVT/nOLvOb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jsdvoezVXrGHZKVZ+w54EEmVFcXiA9XurYdgbiz+v6Gsg8kZb8M8QESWk5luEoUZa
         rN5ZnhuyqRdn4qNSyx8BQwcWx6UaR0iV3czPt7Ib3rlB8dT6IaoxcPU/EtnW7mQIP3
         1kBPGNI+uH8gWF10JJXwEptRrVmzY9/AFXleI764=
Date:   Mon, 26 Oct 2020 11:57:45 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] mm: cleanup: remove unused tsk arg from
 __access_remote_vm
Message-ID: <20201026095745.GE1154158@kernel.org>
References: <20201026074137.4147787-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026074137.4147787-1-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:41:37AM -0700, John Hubbard wrote:
> Despite a comment that said that page fault accounting would be charged
> to whatever task_struct* was passed into __access_remote_vm(), the tsk
> argument was actually unused.
> 
> Delete both the comment, and the argument.

I'd also mention that making page fault accounting actually use this
task struct is quite a project, so there is no point to keep tsk
argument.

> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Oleg Nesterov <oleg@redhat.com>

FWIW:

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
> 
> Hi,
> 
> Just something that caught my eye when I was reviewing a semi-related
> patchset.
> 
> thanks,
> John Hubbard
> NVIDIA
> 
>  include/linux/mm.h |  4 ++--
>  kernel/ptrace.c    |  2 +-
>  mm/memory.c        | 11 +++++------
>  mm/nommu.c         |  8 ++++----
>  4 files changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index ef360fe70aaf..b3b85a5c5937 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1716,8 +1716,8 @@ extern int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
>  extern int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags);
> -extern int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
> -		unsigned long addr, void *buf, int len, unsigned int gup_flags);
> +extern int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
> +			      void *buf, int len, unsigned int gup_flags);
>  
>  long get_user_pages_remote(struct mm_struct *mm,
>  			    unsigned long start, unsigned long nr_pages,
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 43d6179508d6..fbbe32443b18 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -57,7 +57,7 @@ int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
>  		return 0;
>  	}
>  
> -	ret = __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
> +	ret = __access_remote_vm(mm, addr, buf, len, gup_flags);
>  	mmput(mm);
>  
>  	return ret;
> diff --git a/mm/memory.c b/mm/memory.c
> index c48f8df6e502..25b28bc251d5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4874,11 +4874,10 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
>  #endif
>  
>  /*
> - * Access another process' address space as given in mm.  If non-NULL, use the
> - * given task for page fault accounting.
> + * Access another process' address space as given in mm.
>   */
> -int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
> -		unsigned long addr, void *buf, int len, unsigned int gup_flags)
> +int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> +		       int len, unsigned int gup_flags)
>  {
>  	struct vm_area_struct *vma;
>  	void *old_buf = buf;
> @@ -4955,7 +4954,7 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags)
>  {
> -	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
> +	return __access_remote_vm(mm, addr, buf, len, gup_flags);
>  }
>  
>  /*
> @@ -4973,7 +4972,7 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
>  	if (!mm)
>  		return 0;
>  
> -	ret = __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
> +	ret = __access_remote_vm(mm, addr, buf, len, gup_flags);
>  
>  	mmput(mm);
>  
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 0faf39b32cdb..870fea12823e 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1675,8 +1675,8 @@ void filemap_map_pages(struct vm_fault *vmf,
>  }
>  EXPORT_SYMBOL(filemap_map_pages);
>  
> -int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
> -		unsigned long addr, void *buf, int len, unsigned int gup_flags)
> +int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> +		       int len, unsigned int gup_flags)
>  {
>  	struct vm_area_struct *vma;
>  	int write = gup_flags & FOLL_WRITE;
> @@ -1722,7 +1722,7 @@ int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  int access_remote_vm(struct mm_struct *mm, unsigned long addr,
>  		void *buf, int len, unsigned int gup_flags)
>  {
> -	return __access_remote_vm(NULL, mm, addr, buf, len, gup_flags);
> +	return __access_remote_vm(mm, addr, buf, len, gup_flags);
>  }
>  
>  /*
> @@ -1741,7 +1741,7 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
>  	if (!mm)
>  		return 0;
>  
> -	len = __access_remote_vm(tsk, mm, addr, buf, len, gup_flags);
> +	len = __access_remote_vm(mm, addr, buf, len, gup_flags);
>  
>  	mmput(mm);
>  	return len;
> 
> base-commit: 3650b228f83adda7e5ee532e2b90429c03f7b9ec
> -- 
> 2.29.0
> 
> 

-- 
Sincerely yours,
Mike.
