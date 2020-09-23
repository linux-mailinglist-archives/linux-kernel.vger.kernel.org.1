Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519FB27565B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIWKaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgIWKaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:30:02 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 926FD23119;
        Wed, 23 Sep 2020 10:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600857002;
        bh=kDV7h/VYPS+RMSk792Z6m+XVk+KE1QdwhgIYZ5PeZRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haLpkgm/LlmPgpPpcdrFa2++gBaAEkKrCoB3T0EfP28jHRD6SJkgpCMptKsiYv4MB
         X2FY9p7SdpV4dMLTTDgg4BOvA5vqABTVH4I5e553tPaavF89TKm8F7ykmNvYHOsLc+
         myxl05rS2gUzdRy/nHOP1kKHhoDTqcKNjKvTwnaU=
Date:   Wed, 23 Sep 2020 12:30:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     rafael@kernel.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/11] drivers/base: convert deferred_trigger_count
 and probe_count to counter_atomic
Message-ID: <20200923103021.GG3154647@kroah.com>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
 <576d5405373295b147a876006df6842f31d64b8a.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <576d5405373295b147a876006df6842f31d64b8a.1600816121.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:43:32PM -0600, Shuah Khan wrote:
> counter_atomic is introduced to be used when a variable is used as
> a simple counter and doesn't guard object lifetimes. This clearly
> differentiates atomic_t usages that guard object lifetimes.
> 
> counter_atomic variables will wrap around to 0 when it overflows and
> should not be used to guard resource lifetimes, device usage and
> open counts that control state changes, and pm states.
> 
> deferred_trigger_count gets incremented and read. It doesn't guard
> object lifetimes, device usage counts, device open counts, and pm
> states. There is very little chance of this counter overflowing.
> Convert it to use counter_atomic.
> 
> This conversion doesn't change the oveflow wrap around behavior.
> 
> probe_count gets incremented, decremented, read. It doesn't guard
> object lifetimes, device usage counts, device open counts, and pm
> states. There is very little chance of this counter overflowing.
> This counter controls the wait for known devices to complete their
> probing, and probe_count == 0 ends the wait. Other than that it
> meets the other criteria to be converted. Convert it to use
> counter_atomic.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  drivers/base/dd.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 857b0a928e8d..f49fe45960ac 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -28,6 +28,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/pinctrl/devinfo.h>
>  #include <linux/slab.h>
> +#include <linux/counters.h>
>  
>  #include "base.h"
>  #include "power/power.h"
> @@ -54,7 +55,7 @@
>  static DEFINE_MUTEX(deferred_probe_mutex);
>  static LIST_HEAD(deferred_probe_pending_list);
>  static LIST_HEAD(deferred_probe_active_list);
> -static atomic_t deferred_trigger_count = ATOMIC_INIT(0);
> +static struct counter_atomic deferred_trigger_count = COUNTER_ATOMIC_INIT(0);
>  static struct dentry *deferred_devices;
>  static bool initcalls_done;
>  
> @@ -173,7 +174,7 @@ static void driver_deferred_probe_trigger(void)
>  	 * into the active list so they can be retried by the workqueue
>  	 */
>  	mutex_lock(&deferred_probe_mutex);
> -	atomic_inc(&deferred_trigger_count);
> +	counter_atomic_inc(&deferred_trigger_count);
>  	list_splice_tail_init(&deferred_probe_pending_list,
>  			      &deferred_probe_active_list);
>  	mutex_unlock(&deferred_probe_mutex);
> @@ -466,7 +467,7 @@ int device_bind_driver(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(device_bind_driver);
>  
> -static atomic_t probe_count = ATOMIC_INIT(0);
> +static struct counter_atomic probe_count = COUNTER_ATOMIC_INIT(0);
>  static DECLARE_WAIT_QUEUE_HEAD(probe_waitqueue);
>  
>  static void driver_deferred_probe_add_trigger(struct device *dev,
> @@ -474,7 +475,7 @@ static void driver_deferred_probe_add_trigger(struct device *dev,
>  {
>  	driver_deferred_probe_add(dev);
>  	/* Did a trigger occur while probing? Need to re-trigger if yes */
> -	if (local_trigger_count != atomic_read(&deferred_trigger_count))
> +	if (local_trigger_count != counter_atomic_read(&deferred_trigger_count))
>  		driver_deferred_probe_trigger();
>  }
>  
> @@ -493,7 +494,7 @@ static DEVICE_ATTR_RO(state_synced);
>  static int really_probe(struct device *dev, struct device_driver *drv)
>  {
>  	int ret = -EPROBE_DEFER;
> -	int local_trigger_count = atomic_read(&deferred_trigger_count);
> +	int local_trigger_count = counter_atomic_read(&deferred_trigger_count);
>  	bool test_remove = IS_ENABLED(CONFIG_DEBUG_TEST_DRIVER_REMOVE) &&
>  			   !drv->suppress_bind_attrs;
>  
> @@ -514,7 +515,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	if (ret)
>  		return ret;
>  
> -	atomic_inc(&probe_count);
> +	counter_atomic_inc(&probe_count);
>  	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
>  		 drv->bus->name, __func__, drv->name, dev_name(dev));
>  	if (!list_empty(&dev->devres_head)) {
> @@ -648,7 +649,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
>  	 */
>  	ret = 0;
>  done:
> -	atomic_dec(&probe_count);
> +	counter_atomic_dec(&probe_count);
>  	wake_up_all(&probe_waitqueue);
>  	return ret;
>  }
> @@ -678,7 +679,7 @@ static int really_probe_debug(struct device *dev, struct device_driver *drv)
>   */
>  int driver_probe_done(void)
>  {
> -	int local_probe_count = atomic_read(&probe_count);
> +	int local_probe_count = counter_atomic_read(&probe_count);
>  
>  	pr_debug("%s: probe_count = %d\n", __func__, local_probe_count);
>  	if (local_probe_count)
> @@ -699,7 +700,7 @@ void wait_for_device_probe(void)
>  	flush_work(&deferred_probe_work);
>  
>  	/* wait for the known devices to complete their probing */
> -	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
> +	wait_event(probe_waitqueue, counter_atomic_read(&probe_count) == 0);
>  	async_synchronize_full();
>  }
>  EXPORT_SYMBOL_GPL(wait_for_device_probe);
> -- 
> 2.25.1
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
