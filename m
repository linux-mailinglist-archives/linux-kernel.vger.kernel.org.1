Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4370A2E30F6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 12:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL0LkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 06:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgL0LkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 06:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4618217A0;
        Sun, 27 Dec 2020 11:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609069167;
        bh=Qj9NQfjZ7w7YKnQLJ5QEgDh45V/wmnPlZYN1lqvpVYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJVOLAqhLrp/Rlx3iWCsxxyNTwcb7I0Kms0gwFdnTlNvBqFf3SW0UdO096r1JCMmh
         7iUae2evmxtrHGm43fSaB9y68OOOnVvGBsrWXwNs3+53/VgGxCTMLof/h7Fe7T1s8k
         lBM9941zlVxcbyyYPLVpCbWeCqOhKhfLOzMoFN+8=
Date:   Sun, 27 Dec 2020 12:40:51 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Angshuman Sengupta <senguptaangshuman17@gmail.com>
Cc:     devel@driverdev.osuosl.org, Todd Kjos <tkjos@android.com>,
        linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] staging: android: ashmem: Fixed warning for structure
 declaration
Message-ID: <X+hywwrjTw/Yt0kB@kroah.com>
References: <20201227112645.256943-1-senguptaangshuman17@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227112645.256943-1-senguptaangshuman17@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 04:56:45PM +0530, Angshuman Sengupta wrote:
> Warning found by checkpatch.pl script.
> 
> Signed-off-by: Angshuman Sengupta <senguptaangshuman17@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 4789d36ddfd3..2cb665e0228c 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -376,7 +376,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  

Did you test build this change?  Why not?

thanks,

greg k-h
