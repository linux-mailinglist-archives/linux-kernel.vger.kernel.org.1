Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D3223119F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbgG1SZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 14:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbgG1SZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 14:25:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5646220714;
        Tue, 28 Jul 2020 18:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595960727;
        bh=qp1ca15nlchOHHWpb0GDZ73wbp+5RJCEQgUj8cnylfQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ff0DX65e31G0m+5Hgz2THK4PAsZcNMAcPSBMJ4drm6k/yNHzucgxwUjxzJ2zUtGfF
         BRdS7iGEG4jO6FwIPpqa/CSzQJihlZ9IkEtyAr9GwODy4o6JPtkpuVPgQeyaB3eZsd
         sth0X63UplVmflYZb88E+Ca9IDr+HDobPgpo7qMU=
Date:   Tue, 28 Jul 2020 20:25:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ashmem: used const keyword
Message-ID: <20200728182519.GA328787@kroah.com>
References: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728175935.2130-1-dhiraj.sharma0024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 11:29:35PM +0530, Dhiraj Sharma wrote:
> I ran checkpatch.pl script which reported a warning to use const keyword
> on line 370.Therefore I made this change.
> 
> Signed-off-by: Dhiraj Sharma <dhiraj.sharma0024@gmail.com>
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

You have now submitted two patches that you obviously never even built,
which is the first step in kernel development :(

Please be more careful next time.

greg k-h
