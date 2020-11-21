Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356CA2BBCB2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 04:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKUDiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 22:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgKUDiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 22:38:14 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FA8C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:38:13 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 92so7671682otd.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 19:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l7hc1HlYFf6JH4NXyv3Pj9whwOskfPzzd3TWVpR6m6E=;
        b=oIA/PxpWOYoEYGdA6XqOqU3xN7WxOm2IqrNVjN+N6UKHO6+sdlGUExX4sSfiuzL4m7
         GYMxGcGoGDbiRXYuj/0DC9Zl1kv0AE9csq6LEkP8YmV8Mp2AeS0JZsk33ZvwpIGqKAj+
         kGXjviC82qTZ+E1VNf9AHsPXKSU6gxKD/O2AyDkmkRQ3UaaVHTXPxcMgbVXpoALhYoWj
         YStEYZVKX/Gjf3cEcACqLgQhiIJ0DDdIDa+UhvaNtQd3yx+M9BvSk1l4bNPB2blU/Y7x
         +YkBu8oabC5xUNXlAd7rMBPICIrT0TDDufn8BEyQ/XCTTvIKmKeMXslCinss7gjFyMNf
         XkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l7hc1HlYFf6JH4NXyv3Pj9whwOskfPzzd3TWVpR6m6E=;
        b=fmTcoXN/Jt+V1+Ppc09Q0IYTw5ZxxHIZ11P9i/xXTuwZbOY8osQsqMmxj10o5Yv/W1
         fXNAWFXNIfo2QpRcUo99k0RWdC2ykzOKsrdZ2Hy1+QxADxLTcz5qKa+a1Zj6H4FvcPa3
         pdaCPSXNUAzTrzmG3czmjbsDBqmKhGxyE16uMN5ACE33zCy/g4o51jOIosG19/gi+4tP
         ecCEnJZipZi4BDAny1HniMtn5sQwxgMT4XHbJPatYvSerQGKdLYbR4s1X3790sot++0w
         C0selPsKqIpU/tDl52TbyVf54hXZiPniq102KV/c88ydZS/7ycTMItei1nMIkks+VpGW
         srfg==
X-Gm-Message-State: AOAM532WNPlf6UzApIBFP+J/+hMiYhgKuy/RIMncgkH1/zldnyiCJAvT
        P9Yu3JW3WFt83sfOrbJfe0SccQ==
X-Google-Smtp-Source: ABdhPJweblholREjeMlmQlXN5V2dtCpEbRmwV75t5defnTB2dZKHyQvFrcBCL/yNR3TTrIzFEl1T4w==
X-Received: by 2002:a9d:7c98:: with SMTP id q24mr14666681otn.147.1605929893199;
        Fri, 20 Nov 2020 19:38:13 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id x9sm2402926otk.9.2020.11.20.19.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 19:38:12 -0800 (PST)
Date:   Fri, 20 Nov 2020 21:38:10 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Suman Anna <s-anna@ti.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-remoteproc@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] remoteproc: Introduce deny_sysfs_ops flag
Message-ID: <20201121033810.GG9177@builder.lan>
References: <20201121030156.22857-1-s-anna@ti.com>
 <20201121030156.22857-3-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121030156.22857-3-s-anna@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20 Nov 21:01 CST 2020, Suman Anna wrote:

> The remoteproc framework provides sysfs interfaces for changing
> the firmware name and for starting/stopping a remote processor
> through the sysfs files 'state' and 'firmware'. The 'recovery'
> sysfs file can also be used similarly to control the error recovery
> state machine of a remoteproc. These interfaces are currently
> allowed irrespective of how the remoteprocs were booted (like
> remoteproc self auto-boot, remoteproc client-driven boot etc).
> These interfaces can adversely affect a remoteproc and its clients
> especially when a remoteproc is being controlled by a remoteproc
> client driver(s). Also, not all remoteproc drivers may want to
> support the sysfs interfaces by default.
> 
> Add support to deny the sysfs state/firmware/recovery change by
> introducing a state flag 'deny_sysfs_ops' that the individual
> remoteproc drivers can set based on their usage needs. The default
> behavior is to allow the sysfs operations as before.
> 

This makes sense, but can't we implement attribute_group->is_visible to
simply hide these entries from userspace instead of leaving them
"broken"?

Regards,
Bjorn

> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2: revised to account for the 'recovery' sysfs file as well, patch
>     description updated accordingly
> v1: https://patchwork.kernel.org/project/linux-remoteproc/patch/20180915003725.17549-5-s-anna@ti.com/
> 
>  drivers/remoteproc/remoteproc_sysfs.c | 12 ++++++++++++
>  include/linux/remoteproc.h            |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
> index bd2950a246c9..3fd18a71c188 100644
> --- a/drivers/remoteproc/remoteproc_sysfs.c
> +++ b/drivers/remoteproc/remoteproc_sysfs.c
> @@ -49,6 +49,10 @@ static ssize_t recovery_store(struct device *dev,
>  {
>  	struct rproc *rproc = to_rproc(dev);
>  
> +	/* restrict sysfs operations if not allowed by remoteproc drivers */
> +	if (rproc->deny_sysfs_ops)
> +		return -EPERM;
> +
>  	if (sysfs_streq(buf, "enabled")) {
>  		/* change the flag and begin the recovery process if needed */
>  		rproc->recovery_disabled = false;
> @@ -158,6 +162,10 @@ static ssize_t firmware_store(struct device *dev,
>  	char *p;
>  	int err, len = count;
>  
> +	/* restrict sysfs operations if not allowed by remoteproc drivers */
> +	if (rproc->deny_sysfs_ops)
> +		return -EPERM;
> +
>  	err = mutex_lock_interruptible(&rproc->lock);
>  	if (err) {
>  		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
> @@ -225,6 +233,10 @@ static ssize_t state_store(struct device *dev,
>  	struct rproc *rproc = to_rproc(dev);
>  	int ret = 0;
>  
> +	/* restrict sysfs operations if not allowed by remoteproc drivers */
> +	if (rproc->deny_sysfs_ops)
> +		return -EPERM;
> +
>  	if (sysfs_streq(buf, "start")) {
>  		if (rproc->state == RPROC_RUNNING)
>  			return -EBUSY;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 3fa3ba6498e8..dbc3767f7d0e 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -508,6 +508,7 @@ struct rproc_dump_segment {
>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>   * @auto_boot: flag to indicate if remote processor should be auto-started
>   * @autonomous: true if an external entity has booted the remote processor
> + * @deny_sysfs_ops: flag to not permit sysfs operations on state, firmware and recovery
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
>   * @char_dev: character device of the rproc
> @@ -545,6 +546,7 @@ struct rproc {
>  	bool has_iommu;
>  	bool auto_boot;
>  	bool autonomous;
> +	bool deny_sysfs_ops;
>  	struct list_head dump_segments;
>  	int nb_vdev;
>  	u8 elf_class;
> -- 
> 2.28.0
> 
