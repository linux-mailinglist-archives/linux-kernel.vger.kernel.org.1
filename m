Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36E2A0115
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgJ3JS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgJ3JS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:18:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50000C0613D7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:18:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id EE04D1F45AB3;
        Fri, 30 Oct 2020 09:18:53 +0000 (GMT)
Date:   Fri, 30 Oct 2020 10:18:50 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Don't corrupt the queue mutex on
 open/close
Message-ID: <20201030101850.3932c61b@collabora.com>
In-Reply-To: <20201029170047.30564-1-steven.price@arm.com>
References: <20201029170047.30564-1-steven.price@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Oct 2020 17:00:47 +0000
Steven Price <steven.price@arm.com> wrote:

> The mutex within the panfrost_queue_state should have the lifetime of
> the queue, however it was erroneously initialised/destroyed during
> panfrost_job_{open,close} which is called every time a client
> opens/closes the drm node.
> 
> Move the initialisation/destruction to panfrost_job_{init,fini} where it
> belongs.
> 

Queued to drm-misc-next.

Thanks,

Boris

> Fixes: 1a11a88cfd9a ("drm/panfrost: Fix job timeout handling")
> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index cfb431624eea..145ad37eda6a 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -595,6 +595,8 @@ int panfrost_job_init(struct panfrost_device *pfdev)
>  	}
>  
>  	for (j = 0; j < NUM_JOB_SLOTS; j++) {
> +		mutex_init(&js->queue[j].lock);
> +
>  		js->queue[j].fence_context = dma_fence_context_alloc(1);
>  
>  		ret = drm_sched_init(&js->queue[j].sched,
> @@ -625,8 +627,10 @@ void panfrost_job_fini(struct panfrost_device *pfdev)
>  
>  	job_write(pfdev, JOB_INT_MASK, 0);
>  
> -	for (j = 0; j < NUM_JOB_SLOTS; j++)
> +	for (j = 0; j < NUM_JOB_SLOTS; j++) {
>  		drm_sched_fini(&js->queue[j].sched);
> +		mutex_destroy(&js->queue[j].lock);
> +	}
>  
>  }
>  
> @@ -638,7 +642,6 @@ int panfrost_job_open(struct panfrost_file_priv *panfrost_priv)
>  	int ret, i;
>  
>  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
> -		mutex_init(&js->queue[i].lock);
>  		sched = &js->queue[i].sched;
>  		ret = drm_sched_entity_init(&panfrost_priv->sched_entity[i],
>  					    DRM_SCHED_PRIORITY_NORMAL, &sched,
> @@ -657,7 +660,6 @@ void panfrost_job_close(struct panfrost_file_priv *panfrost_priv)
>  
>  	for (i = 0; i < NUM_JOB_SLOTS; i++) {
>  		drm_sched_entity_destroy(&panfrost_priv->sched_entity[i]);
> -		mutex_destroy(&js->queue[i].lock);
>  		/* Ensure any timeouts relating to this client have completed */
>  		flush_delayed_work(&js->queue[i].sched.work_tdr);
>  	}

