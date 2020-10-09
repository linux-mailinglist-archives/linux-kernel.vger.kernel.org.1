Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF12897C4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391316AbgJIUE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389246AbgJITwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 15:52:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E954C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 12:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3w99N6+9a+EbmOW5LL0tNVo1+ztrfFsJxS97E0AtHkg=; b=srX1rnlJywyeztvtZs/R0w0raM
        7zJ9mpAiLcexFIr4M8ngodadItgDKC3j4s0U5FcC8ng02egWin6zWH8EsqWjgPvvqtT8iZLrNxnc4
        OVWSEwR8ziHByszYrZ4Hi3aa5ri+BKsNUs6XvMhD4T5khiepp+g2IRGACb35LnH52QVsw8H0j5gSz
        3zsnaK2DR/ne11/nQrzAwxvLDAACeH3rx9Xz5nHhro3NJrdn8Q6F4udn8JC0LEWD1Qjy3HN9QeNYF
        1n8SF5x8dCYxWNM5BjJ+OCIkAugitOS9OFw/ib/5o86W8cZY0ennql0MeWYRaT5sW//wXcwkOqOAT
        FekOLjkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQyQt-0001VM-5u; Fri, 09 Oct 2020 19:52:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C828307985;
        Fri,  9 Oct 2020 21:51:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A0FD20AEA645; Fri,  9 Oct 2020 21:51:57 +0200 (CEST)
Date:   Fri, 9 Oct 2020 21:51:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     johannes@sipsolutions.net, gregkh@linuxfoundation.org,
        rafael@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
Message-ID: <20201009195156.GC1073957@hirez.programming.kicks-ass.net>
References: <cover.1602209970.git.skhan@linuxfoundation.org>
 <9eee4448ec53e3a875e6785fa63bcda211e09d23.1602209970.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eee4448ec53e3a875e6785fa63bcda211e09d23.1602209970.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:55:59AM -0600, Shuah Khan wrote:
> counter_atomic* is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic* variables wrap around to INT_MIN when it overflows
> and should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> devcd_count is used to track dev_coredumpm device count and used in
> device name string. It doesn't guard object lifetimes, device usage
> counts, device open counts, and pm states. There is very little chance
> of this counter overflowing. Convert it to use counter_atomic32.
> 
> This conversion doesn't change the overflow wrap around behavior.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/base/devcoredump.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/devcoredump.c b/drivers/base/devcoredump.c
> index e42d0b514384..59bc48ee44af 100644
> --- a/drivers/base/devcoredump.c
> +++ b/drivers/base/devcoredump.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/fs.h>
>  #include <linux/workqueue.h>
> +#include <linux/counters.h>
>  
>  static struct class devcd_class;
>  
> @@ -255,7 +256,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  				   void *data, size_t datalen),
>  		   void (*free)(void *data))
>  {
> -	static atomic_t devcd_count = ATOMIC_INIT(0);
> +	static struct counter_atomic32 devcd_count = COUNTER_ATOMIC_INIT(0);
>  	struct devcd_entry *devcd;
>  	struct device *existing;
>  
> @@ -286,7 +287,7 @@ void dev_coredumpm(struct device *dev, struct module *owner,
>  	device_initialize(&devcd->devcd_dev);
>  
>  	dev_set_name(&devcd->devcd_dev, "devcd%d",
> -		     atomic_inc_return(&devcd_count));
> +		     counter_atomic32_inc_return(&devcd_count));
>  	devcd->devcd_dev.class = &devcd_class;
>  
>  	if (device_add(&devcd->devcd_dev))

This is like the absolute prime example of pointless wrappery. This is
change for change's sake. This is absolute bullshit.
