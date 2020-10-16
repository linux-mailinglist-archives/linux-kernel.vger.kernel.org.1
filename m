Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2129628FD9B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 07:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgJPFSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 01:18:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732271AbgJPFSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 01:18:01 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 509112076A;
        Fri, 16 Oct 2020 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602825480;
        bh=YjcNRl2JJ7nRWiWDl8pgRAuyZ8xzW4GHIYnOBeGWgoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ED4Q/aIx8sWIy6vJvxv75ipYACkPFEDD6yFe8SHUvAE0Rl7I+JfSBR6xrzGDO84gD
         lJjIUbQRyjeleUE9mhriQlKWdh93kOFiuJitxoYgYSPCpDVhpL/bzitxdOW9q8GKPP
         umNAmAARe0ra+S9zHxb4D0J+qVas6Z/xuGVPBoW0=
Date:   Fri, 16 Oct 2020 07:17:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     kiransuren@osuosl.org, kirank.suren@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: android: ashmem: changed struct file_operations
 to const file_operations
Message-ID: <20201016051757.GA463503@kroah.com>
References: <20201016051111.1947-1-kirank.suren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016051111.1947-1-kirank.suren@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:11:11AM -0400, kiransuren@osuosl.org wrote:
> From: kiransuren <kirank.suren@gmail.com>

This does not match your signed-off-by line :(

> 
> Fixed a coding style issue.

What issue?  Always be specific.

> 
> Signed-off-by: Kiran Surendran <kirank.suren@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 10b4be1f3e78..f2b67c4fe8d2 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const file_operations vmfile_fops;

Why did you not test-build your patch before sending it out?

Don't you think that is a big rude?

Please be more careful.

greg k-h
