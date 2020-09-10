Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1879D263E12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbgIJHIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730184AbgIJHD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:03:29 -0400
Received: from coco.lan (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC05020732;
        Thu, 10 Sep 2020 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599721408;
        bh=GHwpOYNmP2VBs3IsWSoD/Y47FY59xH8qEK8oIuyUzS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hRhDEOC5550ziCYEAcuP4EshnVG6QqVh9PKQniInln2swjwtInL7b3QkvvMqBTIL1
         flXt8lSPfCUUMsuzAVg8ShS5+kcG+6q4dGQF2gdwR5lOO0zqJxJIrF9Se4IFq3Yxxj
         O1q4S+RAHhbz3yTIACpn+9+ZjsuS+yfCoaanbxl8=
Date:   Thu, 10 Sep 2020 09:03:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <gregkh@linuxfoundation.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] staging: regulator: hi6421v600-regulator: Remove
 unused including <linux/version.h>
Message-ID: <20200910090325.133061db@coco.lan>
In-Reply-To: <20200910061756.40864-1-yuehaibing@huawei.com>
References: <20200910061756.40864-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 10 Sep 2020 14:17:56 +0800
YueHaibing <yuehaibing@huawei.com> escreveu:

> Remove including <linux/version.h> that don't need it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/staging/hikey9xx/hi6421v600-regulator.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
> index 82635ff54a74..614b03c9ddfb 100644
> --- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
> +++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
> @@ -36,7 +36,6 @@
>  #include <linux/spmi.h>
>  #include <linux/time.h>
>  #include <linux/uaccess.h>
> -#include <linux/version.h>
>  
>  #define rdev_dbg(rdev, fmt, arg...)	\
>  		 pr_debug("%s: %s: " fmt, (rdev)->desc->name, __func__, ##arg)



Thanks,
Mauro
