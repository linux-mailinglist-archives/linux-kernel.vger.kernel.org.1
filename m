Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFC2E3488
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 07:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbgL1Gfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 01:35:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgL1Gfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 01:35:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4886120715;
        Mon, 28 Dec 2020 06:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609137312;
        bh=tuuZcnd4yFMUkxjYB/o7BzJe7osRuH4BdWFrjJ43KxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PQHOtvte1kVQZgTZCfIWJRWo8MDb2BNoXlEnngQm4lTO/Qv4otduoNUoHBbT5TLwV
         btbQcE8ipZtb1ZPIM77wT80EHwdj4m80E1MahDAFtMtZsLvhHXLjtKP6HKk3mKFgMQ
         +XSYLs22K4qv/a1Nhv4R2Om9NMgUek4prfMF7Bq4=
Date:   Mon, 28 Dec 2020 07:35:07 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     jovin555 <jovin555@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ashmem: Declared file operation with
 const keyword
Message-ID: <X+l8m6Z7eD26gaUC@kroah.com>
References: <20201228051301.14983-1-jovin555@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228051301.14983-1-jovin555@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 12:13:00AM -0500, jovin555 wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: jovin555 <jovin555@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index c05a214191da..f9cfa15b785f 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  

Did you build your modified kernel with this change in it?

Always do so...

greg k-h
