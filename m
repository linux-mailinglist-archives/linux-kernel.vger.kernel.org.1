Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837A91D1224
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 14:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgEMMCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 08:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgEMMCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84732206CC;
        Wed, 13 May 2020 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589371341;
        bh=jve5K37fv5VsBx4Jio6QoqhRZJ/jnSw8nytBUhmeRPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+ibi98WB83LJ0UYWfadbixi4CEwz9KT3CjMNIIlAVJ7W1evjLTYNkavpzZaS11XC
         S+qWLdo+tfihive/D1EJTHZZS/0wiYSsbP6o4wxrgAdUZo2pRCx0yqF7D1zmBaPcFi
         RjQ7L0V0uM5WFDbhBJU6hism00lULVMmEKimQ6Vo=
Date:   Wed, 13 May 2020 14:02:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anmol <anmol.karan123@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: android: ashmem: Fixed a issue related to
 file_operations
Message-ID: <20200513120218.GA982037@kroah.com>
References: <20200513114116.26410-1-user@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513114116.26410-1-user@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:11:16PM +0530, Anmol wrote:
> From: Anmol <anmol.karan123@gmail.com>
> 
> Fixed a issue related to struct file_operations which should normally be const.
> 
> Signed-off-by: Anmol <anmol.karan123@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8044510d8ec6..fbb6ac9ba1ab 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;

Did you properly build this change?

Also, always use your full name for kernel changes, as the Documentation
states to.

thanks,

greg k-h
