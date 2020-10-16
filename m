Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2928FD98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 07:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbgJPFQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbgJPFQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 01:16:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8711EC061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JOXeCK9Kxtfq4AH4ck/GKxNTnJOF7GQv5ZeoYVro91g=; b=Mb2ThDJKjCAGcN36qVAbwqsPoF
        pWDsDrEy/HFIjhvF/1jNQijps1rXMJ3CV+Ai2D9aCE73b20h/9M+HvhyKt4VJU+rpx+bC8j+y2c68
        rdDmS3CKaf7deWGsqwlWVoIOOqJ/2+8Yk3kW1peBzaTT6l/tHFas9s1tsCpik1NSYJO7mSp/ENoI+
        VcfRAIv8YZ0pReR6FZZQBe6hYztvZU7g69HI/AX7ftELgudiDobxt87rQmBZKvVK7x8QbY8tp+k/5
        iu242Dt9M3OTdJJtKhWl41rwruOAToRTUN/9oym8IY8U/nWYx/OYqvrCtcjVMino1BFeu5tYBTY9x
        9HWByYJg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTI6h-00051g-Uw; Fri, 16 Oct 2020 05:16:48 +0000
Subject: Re: [PATCH] Staging: android: ashmem: changed struct file_operations
 to const file_operations
To:     kiransuren@osuosl.org, kirank.suren@gmail.com,
        gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20201016051111.1947-1-kirank.suren@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f5804e0d-974d-36b2-3247-747187d1f135@infradead.org>
Date:   Thu, 15 Oct 2020 22:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016051111.1947-1-kirank.suren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/20 10:11 PM, kiransuren@osuosl.org wrote:
> From: kiransuren <kirank.suren@gmail.com>
> 
> Fixed a coding style issue.
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
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> 

Did you build/compile this change?  My brain syntax checker doesn't like it.

and what coding style issue?

-- 
~Randy

