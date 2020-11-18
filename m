Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5842B87A7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgKRW0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 17:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKRW0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 17:26:17 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC76C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:26:17 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 34so2301453pgp.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 14:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/ei20up2lfscrQesr+sFD5UNuMDQ0VaRFySN6eQPxNE=;
        b=YdBUcbcD4XTCFMdpqH5/xHyNxBUNZTYvqT01kQwtH3JmkXqtQ6E7JnNXrh0BOWELMV
         tkjpXscYHQxynFm0DVdJIdKzJujTlLmxUg3tyIYgiJDwWaem5M5cBOsXeBfECMUhsiEE
         HqJNlHC7uTQDaA8gQO0w1EPjqQNrj9ow49KA/t0hmRf2c+OH68nXOWuCcVwXCnuq1VYF
         KfI7kkxUfeUVHdHs0vYOcUK5BJFwblPWi4EcKX9ndnlZwON8uPz+RvZrXmmVIZ+Vucwb
         JJTRdl+6i1kKQx7oYoEBQHRGcijEwJqxfexlPv0t6ey4IBtG7MgZYStfxMnkMvK2zKsG
         goRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/ei20up2lfscrQesr+sFD5UNuMDQ0VaRFySN6eQPxNE=;
        b=tMxPsljh3ou0YZwfoGshBQXLCoT/J5+neJumuBTTetkeeA0CrGsiHvrmLu2syiSOGu
         UlIc6o6I2ML+7Hhbq/S3hVCQe1Pg7A+4jggKqZ0txuoQIhLiA1tqUAqQL/cGz6xRL60/
         KWUuTHSOhZ/OOjO1H8TUCoiIYOCPktXzt00X4A/Svs/QLszMaX/D0un282hWtaExMe1t
         RQVL8KsaCA4DtLvNJN7UrWq3A7P/qIaXJItMsjfeCONO10zVhGM7uCSn4HclNYg6GsA+
         pD2xdqEs/zAJq9+rbAt/tFXTsZ4nxU16BUw2lNZLa2wlM116Ehlj7RZHdk7W/pafCwYt
         XSqw==
X-Gm-Message-State: AOAM530wCs7b+39wViAMBsvJ2Noo81cRQ/k4UvVjkXEfjUO4a7eojGTz
        HWKpKJKQZZr1cBsRD7rPOXgVtyjfZVgCOw==
X-Google-Smtp-Source: ABdhPJz/Tj/VnlCoc+pzDOA/mgoONTHwnYAQCGENHBF+RBCs3eb0qMJd/vnjBRid1d5P5Osw7YUnIg==
X-Received: by 2002:a17:90a:9504:: with SMTP id t4mr1206011pjo.82.1605738376643;
        Wed, 18 Nov 2020 14:26:16 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g6sm3807114pjd.3.2020.11.18.14.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 14:26:15 -0800 (PST)
Date:   Wed, 18 Nov 2020 15:26:14 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Rishabh Bhatnagar <rishabhb@codeaurora.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH v2 3/3] remoteproc: Add ftrace events to trace lifecycle
 of remoteprocs
Message-ID: <20201118222614.GA75192@xps15>
References: <1605563084-30385-1-git-send-email-rishabhb@codeaurora.org>
 <1605563084-30385-4-git-send-email-rishabhb@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605563084-30385-4-git-send-email-rishabhb@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 01:44:44PM -0800, Rishabh Bhatnagar wrote:
> Add trace events to trace bootup/shutdown/recovery of remote
> processors. These events are useful in analyzing the time
> spent in each step in the life cycle and can be used for
> performace analysis. Also these serve as standard checkpoints
> in debugging.
> 
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>  drivers/remoteproc/remoteproc_core.c | 19 +++++++-
>  include/trace/events/remoteproc.h    | 91 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 include/trace/events/remoteproc.h
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index dab2c0f..39da409 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -42,6 +42,9 @@
>  
>  #include "remoteproc_internal.h"
>  
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/remoteproc.h>
> +
>  #define HIGH_BITS_MASK 0xFFFFFFFF00000000ULL
>  
>  static DEFINE_MUTEX(rproc_list_mutex);
> @@ -1164,6 +1167,7 @@ static int rproc_prepare_subdevices(struct rproc *rproc)
>  	struct rproc_subdev *subdev;
>  	int ret;
>  
> +	trace_rproc_subdevices("Prepare subdevices", rproc->name);

I wouldn't add this to the core - after a while they become part of the ABI and
we can't move things around.  I suppose they can stay in platform drivers but
even that is going against the general trend in the kernel community to avoid them at
all.  To me this should remain out of tree code but Bjorn will make the call.

Thanks,
Mathieu

>  	list_for_each_entry(subdev, &rproc->subdevs, node) {
>  		if (subdev->prepare) {
>  			ret = subdev->prepare(subdev);
> @@ -1188,6 +1192,7 @@ static int rproc_start_subdevices(struct rproc *rproc)
>  	struct rproc_subdev *subdev;
>  	int ret;
>  
> +	trace_rproc_subdevices("Start subdevices", rproc->name);
>  	list_for_each_entry(subdev, &rproc->subdevs, node) {
>  		if (subdev->start) {
>  			ret = subdev->start(subdev);
> @@ -1211,6 +1216,7 @@ static void rproc_stop_subdevices(struct rproc *rproc, bool crashed)
>  {
>  	struct rproc_subdev *subdev;
>  
> +	trace_rproc_subdevices("Stop subdevices", rproc->name);
>  	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>  		if (subdev->stop)
>  			subdev->stop(subdev, crashed);
> @@ -1221,6 +1227,7 @@ static void rproc_unprepare_subdevices(struct rproc *rproc)
>  {
>  	struct rproc_subdev *subdev;
>  
> +	trace_rproc_subdevices("Unprepare subdevices", rproc->name);
>  	list_for_each_entry_reverse(subdev, &rproc->subdevs, node) {
>  		if (subdev->unprepare)
>  			subdev->unprepare(subdev);
> @@ -1357,6 +1364,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  	struct device *dev = &rproc->dev;
>  	int ret;
>  
> +	trace_rproc_boot("loading firmware segments into memory", rproc->name);
>  	/* load the ELF segments to memory */
>  	ret = rproc_load_segments(rproc, fw);
>  	if (ret) {
> @@ -1385,6 +1393,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  		goto reset_table_ptr;
>  	}
>  
> +	trace_rproc_boot("starting remoteproc", rproc->name);
>  	/* power up the remote processor */
>  	ret = rproc->ops->start(rproc);
>  	if (ret) {
> @@ -1402,6 +1411,7 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>  
>  	rproc->state = RPROC_RUNNING;
>  
> +	trace_rproc_boot("remoteproc is up", rproc->name);
>  	dev_info(dev, "remote processor %s is now up\n", rproc->name);
>  
>  	return 0;
> @@ -1648,6 +1658,7 @@ static int rproc_stop(struct rproc *rproc, bool crashed)
>  	/* the installed resource table is no longer accessible */
>  	rproc->table_ptr = rproc->cached_table;
>  
> +	trace_rproc_shutdown("Stopping the remoteproc", rproc->name);
>  	/* power off the remote processor */
>  	ret = rproc->ops->stop(rproc);
>  	if (ret) {
> @@ -1697,6 +1708,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	if (rproc->state != RPROC_CRASHED)
>  		goto unlock_mutex;
>  
> +	trace_rproc_recovery("Recover remoteproc", rproc->name);
>  	dev_err(dev, "recovering %s\n", rproc->name);
>  
>  	ret = rproc_stop(rproc, true);
> @@ -1716,6 +1728,7 @@ int rproc_trigger_recovery(struct rproc *rproc)
>  	/* boot the remote processor up again */
>  	ret = rproc_start(rproc, firmware_p);
>  
> +	trace_rproc_recovery("Recovery completed", rproc->name);
>  	release_firmware(firmware_p);
>  
>  unlock_mutex:
> @@ -1796,6 +1809,7 @@ int rproc_boot(struct rproc *rproc)
>  	/* skip the boot or attach process if rproc is already powered up */
>  	if (atomic_inc_return(&rproc->power) > 1) {
>  		ret = 0;
> +		trace_rproc_boot("Incrementing ref count and exiting", rproc->name);
>  		goto unlock_mutex;
>  	}
>  
> @@ -1804,6 +1818,7 @@ int rproc_boot(struct rproc *rproc)
>  
>  		ret = rproc_actuate(rproc);
>  	} else {
> +		trace_rproc_boot("requesting firmware", rproc->name);
>  		dev_info(dev, "powering up %s\n", rproc->name);
>  
>  		/* load firmware */
> @@ -1858,8 +1873,10 @@ void rproc_shutdown(struct rproc *rproc)
>  	}
>  
>  	/* if the remote proc is still needed, bail out */
> -	if (!atomic_dec_and_test(&rproc->power))
> +	if (!atomic_dec_and_test(&rproc->power)) {
> +		trace_rproc_shutdown("Decrementing ref count and exiting", rproc->name);
>  		goto out;
> +	}
>  
>  	ret = rproc_stop(rproc, false);
>  	if (ret) {
> diff --git a/include/trace/events/remoteproc.h b/include/trace/events/remoteproc.h
> new file mode 100644
> index 0000000..341bf4b
> --- /dev/null
> +++ b/include/trace/events/remoteproc.h
> @@ -0,0 +1,91 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM remoteproc
> +
> +#if !defined(_TRACE_REMOTEPROC_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_REMOTEPROC_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(rproc_boot,
> +
> +	TP_PROTO(const char *event, const char *rproc_name),
> +
> +	TP_ARGS(event, rproc_name),
> +
> +	TP_STRUCT__entry(
> +		__string(event, event)
> +		__string(rproc_name, rproc_name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(event, event);
> +		__assign_str(rproc_name, rproc_name);
> +	),
> +
> +	TP_printk("rproc_boot: %s: %s", __get_str(rproc_name), __get_str(event))
> +);
> +
> +TRACE_EVENT(rproc_shutdown,
> +
> +	TP_PROTO(const char *event, const char *rproc_name),
> +
> +	TP_ARGS(event, rproc_name),
> +
> +	TP_STRUCT__entry(
> +		__string(event, event)
> +		__string(rproc_name, rproc_name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(event, event);
> +		__assign_str(rproc_name, rproc_name);
> +	),
> +
> +	TP_printk("rproc_shutdown: %s: %s", __get_str(rproc_name), __get_str(event))
> +);
> +
> +TRACE_EVENT(rproc_recovery,
> +
> +	TP_PROTO(const char *event, const char *rproc_name),
> +
> +	TP_ARGS(event, rproc_name),
> +
> +	TP_STRUCT__entry(
> +		__string(event, event)
> +		__string(rproc_name, rproc_name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(event, event);
> +		__assign_str(rproc_name, rproc_name);
> +	),
> +
> +	TP_printk("rproc_recovery: %s: %s", __get_str(rproc_name), __get_str(event))
> +);
> +
> +TRACE_EVENT(rproc_subdevices,
> +
> +	TP_PROTO(const char *event, const char *rproc_name),
> +
> +	TP_ARGS(event, rproc_name),
> +
> +	TP_STRUCT__entry(
> +		__string(event, event)
> +		__string(rproc_name, rproc_name)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(event, event);
> +		__assign_str(rproc_name, rproc_name);
> +	),
> +
> +	TP_printk("rproc_subdevices: %s: %s", __get_str(rproc_name), __get_str(event))
> +);
> +#endif
> +#include <trace/define_trace.h>
> +
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
