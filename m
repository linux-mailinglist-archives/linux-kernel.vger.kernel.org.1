Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC531CC718
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 08:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgEJGO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 02:14:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgEJGOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 02:14:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6ACE2082E;
        Sun, 10 May 2020 06:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589091265;
        bh=dhSX1koUXR01QNflrqzyeDk0HZwGZnOuulR+owPUVxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucm/1umG+61KjNyTKq2IX2ZBYcRg+6v/Mx/iyTwnFn9ufXLQC8aqrYWQiFPYuy7ap
         eUeKYsnKisIPlDOWh3qlbQuhDe39DkIeXMbpEWrZDcYHefB7xrrtgGL45LM5DaAhto
         tJN5JUcFYWgXPbSBWeJ9TDusCbJSFEB0MeuNI9FM=
Date:   Sun, 10 May 2020 08:14:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     linux@armlinux.org.uk, alexios.zavras@intel.com,
        tglx@linutronix.de, allison@lohutok.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arch/arm: use scnprintf() in l2x0_pmu_event_show()
Message-ID: <20200510061422.GA3375088@kroah.com>
References: <20200509083539.113156-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509083539.113156-1-chenzhou10@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 04:35:39PM +0800, Chen Zhou wrote:
> snprintf() returns the number of bytes that would be written,
> which may be greater than the the actual length to be written.
> 
> show() methods should return the number of bytes printed into the
> buffer. This is the return value of scnprintf().
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/arm/mm/cache-l2x0-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/cache-l2x0-pmu.c b/arch/arm/mm/cache-l2x0-pmu.c
> index 993fefdc167a..d20626451a2e 100644
> --- a/arch/arm/mm/cache-l2x0-pmu.c
> +++ b/arch/arm/mm/cache-l2x0-pmu.c
> @@ -343,7 +343,7 @@ static ssize_t l2x0_pmu_event_show(struct device *dev,
>  	struct l2x0_event_attribute *lattr;
>  
>  	lattr = container_of(attr, typeof(*lattr), attr);
> -	return snprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);
> +	return scnprintf(buf, PAGE_SIZE, "config=0x%x\n", lattr->config);

This should just be replaced with sprintf() as there's no way such a
string can go beyond PAGE_SIZE.

And the "config=" part could be dropped as well, but now userspace
probably requires it, that is sad.

thanks,

greg k-h
