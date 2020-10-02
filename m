Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42327280D60
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 08:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgJBGPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 02:15:16 -0400
Received: from verein.lst.de ([213.95.11.211]:51160 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgJBGPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 02:15:16 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7979568BEB; Fri,  2 Oct 2020 08:15:13 +0200 (CEST)
Date:   Fri, 2 Oct 2020 08:15:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compat: move strut compat_iovec out of #ifdef
 CONFIG_COMPAT
Message-ID: <20201002061512.GA9230@lst.de>
References: <20200928161414.642727-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928161414.642727-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping?  This is needed to unbreak the work.iov_iter branch that is in
for-next.

On Mon, Sep 28, 2020 at 06:14:14PM +0200, Christoph Hellwig wrote:
> This avoid annoying ifdefs in iov_iter.c
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> This fixes a build failure with the import_iovec / compat_import_iovec
> unification.
> 
>  include/linux/compat.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 80b9b8cc1cd405..3e3d2beafed312 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -91,6 +91,11 @@
>  	static inline long __do_compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
>  #endif /* COMPAT_SYSCALL_DEFINEx */
>  
> +struct compat_iovec {
> +	compat_uptr_t	iov_base;
> +	compat_size_t	iov_len;
> +};
> +
>  #ifdef CONFIG_COMPAT
>  
>  #ifndef compat_user_stack_pointer
> @@ -248,11 +253,6 @@ typedef struct compat_siginfo {
>  	} _sifields;
>  } compat_siginfo_t;
>  
> -struct compat_iovec {
> -	compat_uptr_t	iov_base;
> -	compat_size_t	iov_len;
> -};
> -
>  struct compat_rlimit {
>  	compat_ulong_t	rlim_cur;
>  	compat_ulong_t	rlim_max;
> -- 
> 2.28.0
---end quoted text---
