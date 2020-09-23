Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D004F275669
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIWKdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgIWKdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:33:11 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 354C620C56;
        Wed, 23 Sep 2020 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600857190;
        bh=tDu/bueQEIu8tUkwU3KcerqhoftSCSirOxnPwcMZzG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMRde1F137DH11+D8mhy08ZcwtrqUBXgcmMejLqTUr20+F36bTVnHC3e1rp45oyIU
         w8IpMw9B7HgwhDkEFUWOfR2MOpBwRh6/me5zl4i9+Kj9RAi9GUXSEACKySBT49sZWf
         ofOVcNbkMBFxl7/VXcRTVk3bstKATPLCMijcKziY=
Date:   Wed, 23 Sep 2020 12:33:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     rafael@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 08/11] drivers/base/test/test_async_driver_probe:
 convert to use counter_atomic
Message-ID: <20200923103329.GI3154647@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <19fcc4c395c022e07ae7ce7c48fec2b09188f391.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fcc4c395c022e07ae7ce7c48fec2b09188f391.1600816121.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:43:37PM -0600, Shuah Khan wrote:
> counter_atomic is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> atomic_t variables used to count errors, warns, keep track of timeout,
> and async completion are counters.
> 
> Unsure overflow is a concern for timeout and async completion, and there
> are no checks for overflow to hold them to upper bounds. Overflow and
> wrap around doesn't impact errors, and warns.
> 
> Convert them to use counter_atomic.
> 
> This conversion doesn't change the oveflow wrap around behavior.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/base/test/test_async_driver_probe.c | 23 ++++++++++++---------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/base/test/test_async_driver_probe.c b/drivers/base/test/test_async_driver_probe.c
> index 3bb7beb127a9..def08cd03eb5 100644
> --- a/drivers/base/test/test_async_driver_probe.c
> +++ b/drivers/base/test/test_async_driver_probe.c
> @@ -14,11 +14,12 @@
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> +#include <linux/counters.h>
>  
>  #define TEST_PROBE_DELAY	(5 * 1000)	/* 5 sec */
>  #define TEST_PROBE_THRESHOLD	(TEST_PROBE_DELAY / 2)
>  
> -static atomic_t warnings, errors, timeout, async_completed;
> +static struct counter_atomic warnings, errors, timeout, async_completed;

Having 3 atomic variables here feels like something is not right and we
should switch the code over to using a single lock, and 3 variables.

But that's not the fault of your conversion, it looks fine.

It is interesting that this is digging up all sorts of "odd, why is this
code written like that???" issues with the conversion, which means it's
a good thing to do :)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
