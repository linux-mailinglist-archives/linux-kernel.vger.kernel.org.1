Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E6128CFC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgJMOFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:05:02 -0400
Received: from foss.arm.com ([217.140.110.172]:60502 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgJMOFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:05:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D03831B;
        Tue, 13 Oct 2020 07:05:01 -0700 (PDT)
Received: from bogus (unknown [10.57.16.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4702E3F66B;
        Tue, 13 Oct 2020 07:05:00 -0700 (PDT)
Date:   Tue, 13 Oct 2020 15:04:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix notifications locking
Message-ID: <20201013140457.GB23273@bogus>
References: <20201013133109.49821-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013133109.49821-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 02:31:09PM +0100, Cristian Marussi wrote:
> When a protocol registers its events the notification core takes care to
> re-scan the hashtable of pending event handlers and activate all the
> possibly existent handlers that refer to any of the events just registered
> by the new protocol; when a pending handler becomes active the core takes
> also care to ask the SCMI platform to enable the corresponding events'
> notifications in the SCMI firmware.
> 
> If, for whatever reason, the enable fails such invalid event handler must
> be finally removed and freed but it must be treated as an active handler
> like it has just become: ensure to use the scmi_put_active_handler() helper
> which handles properly the needed additional mutexing.
> 
> Failing to properly acquire all the needed mutexes exposes a race that
> leads to the following splat being observed:
> 
> [  212.840876] ------------[ cut here ]------------

Please drop the timestamp next time you have to copy backtrace, it is
useless in commit log.

> [  212.845569] refcount_t: underflow; use-after-free.
> [  212.850544] WARNING: CPU: 0 PID: 388 at lib/refcount.c:28 refcount_warn_saturate+0xf8/0x148
> [  212.858913] Modules linked in: dummy_scmi_consumer(-) scmi_perf [last unloaded: scmi_cpufreq]
> [  212.867478] CPU: 0 PID: 388 Comm: rmmod Tainted: G        W         5.9.0-rc1-00020-g9c4395e7867d-dirty #4
> [  212.877153] Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jun 30 2020
> [  212.887963] pstate: 40000005 (nZcv daif -PAN -UAO BTYPE=--)
> [  212.893554] pc : refcount_warn_saturate+0xf8/0x148
> [  212.898361] lr : refcount_warn_saturate+0xf8/0x148
> [  212.903160] sp : ffff80001298bc00
> [  212.906480] x29: ffff80001298bc00 x28: ffff00097470aac0
> [  212.911807] x27: 0000000000000000 x26: 0000000000000000
> [  212.917135] x25: ffff00097357fc80 x24: 0000000000000002
> [  212.922462] x23: ffff00097357fca8 x22: 0000000000000003
> [  212.927790] x21: ffff000974474688 x20: ffff000971e04f00
> [  212.933117] x19: 0000000000000001 x18: 0000000000000010
> [  212.938444] x17: 0000000000000000 x16: 0000000000000000
> [  212.943771] x15: ffffffffffffffff x14: ffff800012269948
> [  212.949098] x13: ffff80009298b947 x12: ffff80001298b94f
> [  212.954426] x11: 0001000000000000 x10: 0000000000000a10
> [  212.959753] x9 : ffff80001039fe88 x8 : ffff00097470b530
> [  212.965080] x7 : 00000000ffffffff x6 : ffff00097ef1b200
> [  212.970407] x5 : ffff00097ef1b200 x4 : 0000000000000000
> [  212.975734] x3 : ffff00097ef2a398 x2 : 0000000000000001
> [  212.981060] x1 : 4b16c3af5d721600 x0 : 0000000000000000

Also trim and remove all the above hex values. I will modify this time,
again they are of not much use.

> [  212.986388] Call trace:
> [  212.988847]  refcount_warn_saturate+0xf8/0x148
> [  212.993308]  scmi_put_handler_unlocked.isra.10+0x204/0x208
> [  212.998811]  scmi_put_handler+0x50/0xa0
> [  213.002659]  scmi_unregister_notifier+0x1bc/0x240
> [  213.007385]  scmi_notify_tester_remove+0x4c/0x68 [dummy_scmi_consumer]
> [  213.013931]  scmi_dev_remove+0x54/0x68
> [  213.017695]  device_release_driver_internal+0x114/0x1e8
> [  213.022934]  driver_detach+0x58/0xe8
> [  213.026520]  bus_remove_driver+0x88/0xe0
> [  213.030454]  driver_unregister+0x38/0x68
> [  213.034389]  scmi_driver_unregister+0x1c/0x28
> [  213.038763]  scmi_drv_exit+0x1c/0xae0 [dummy_scmi_consumer]
> [  213.044354]  __arm64_sys_delete_module+0x1a4/0x268
> [  213.049160]  el0_svc_common.constprop.3+0x94/0x178
> [  213.053963]  do_el0_svc+0x2c/0x98
> [  213.057290]  el0_sync_handler+0x148/0x1a8
> [  213.061310]  el0_sync+0x158/0x180
> [  213.064632] ---[ end trace 5bff2d25d5820911 ]---
> 
> Fixes: e7c215f358a35 ("firmware: arm_scmi: Add notification callbacks-registration")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> 
> Applied and tested on [1] on top of :
> 
> commit: 9724722fde8f ("firmware: arm_scmi: Add missing Rx size
> 		                      re-initialisation")
> 
> [1]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
> ---
> ---
>  drivers/firmware/arm_scmi/notify.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
> index 2754f9d01636..c24e427dce0d 100644
> --- a/drivers/firmware/arm_scmi/notify.c
> +++ b/drivers/firmware/arm_scmi/notify.c
> @@ -1403,15 +1403,21 @@ static void scmi_protocols_late_init(struct work_struct *work)
>  				"finalized PENDING handler - key:%X\n",
>  				hndl->key);
>  			ret = scmi_event_handler_enable_events(hndl);
> +			if (ret) {
> +				dev_dbg(ni->handle->dev,
> +					"purging INVALID handler - key:%X\n",
> +					hndl->key);
> +				scmi_put_active_handler(ni, hndl);
> +			}
>  		} else {
>  			ret = scmi_valid_pending_handler(ni, hndl);
> -		}
> -		if (ret) {
> -			dev_dbg(ni->handle->dev,
> -				"purging PENDING handler - key:%X\n",
> -				hndl->key);
> -			/* this hndl can be only a pending one */
> -			scmi_put_handler_unlocked(ni, hndl);
> +			if (ret) {
> +				dev_dbg(ni->handle->dev,
> +					"purging PENDING handler - key:%X\n",
> +					hndl->key);
> +				/* this hndl can be only a pending one */
> +				scmi_put_handler_unlocked(ni, hndl);
> +			}
>  		}
>  	}
>  	mutex_unlock(&ni->pending_mtx);
> -- 
> 2.17.1
> 

-- 
Regards,
Sudeep
